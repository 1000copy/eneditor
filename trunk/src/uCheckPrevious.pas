unit uCheckPrevious;

interface
{
1000copy comment :
Code from : http://delphi.about.com/library/code/ncaa100703a.htm
}

uses Windows, SysUtils,Messages,classes,Dialogs,SyncObjs;

function IsRunning(const AppHandle : THandle;RestoreIt : Boolean=True) : boolean;

implementation

type
  PInstanceInfo = ^TInstanceInfo;
  TInstanceInfo = packed record
    PreviousHandle : THandle;
  end;

var
  MappingHandle: THandle;
  InstanceInfo: PInstanceInfo;
  MappingName : string;

  RemoveMe : boolean = True;

function IsRunning(const AppHandle : THandle;RestoreIt : Boolean=True) : boolean;
var
  sl :TStringList;
  tempfile :string ;
  cs : TCriticalSection ;
begin
  Result := True;

  MappingName :=StringReplace(ParamStr(0),'\','',[rfReplaceAll, rfIgnoreCase]);

  MappingHandle := CreateFileMapping($FFFFFFFF,
                                     nil,
                                     PAGE_READWRITE,
                                     0,
                                     SizeOf(TInstanceInfo),
                                     PChar(MappingName));

  if MappingHandle <> 0 then begin // File Mapped 
    if GetLastError = ERROR_ALREADY_EXISTS then //already runing
    begin
      MappingHandle := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, PChar(MappingName));
      if MappingHandle <> 0 then
      begin
        InstanceInfo := MapViewOfFile(MappingHandle,
                                      FILE_MAP_ALL_ACCESS,
                                      0,
                                      0,
                                      SizeOf(TInstanceInfo));

        RemoveMe := False;
        if RestoreIt and IsIconic(InstanceInfo^.PreviousHandle) then
          ShowWindow(InstanceInfo^.PreviousHandle, SW_RESTORE);
        SetForegroundWindow(InstanceInfo^.PreviousHandle);
      end;
    end
    else begin
      InstanceInfo := MapViewOfFile(MappingHandle,
                                    FILE_MAP_ALL_ACCESS,
                                    0,
                                    0,
                                    SizeOf(TInstanceInfo));

      InstanceInfo^.PreviousHandle := AppHandle;
      Result := False;
    end;
  end else
    RaiseLastOSError
end;

initialization

finalization
  //remove one instance
  if RemoveMe then
  begin
    MappingHandle := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, PChar(MappingName));
    if MappingHandle <> 0 then
    begin
      InstanceInfo := MapViewOfFile(MappingHandle,
                                  FILE_MAP_ALL_ACCESS,
                                  0,
                                  0,
                                  SizeOf(TInstanceInfo));
    end
    else
      RaiseLastOSError;
  end;

  if Assigned(InstanceInfo) then UnmapViewOfFile(InstanceInfo);
  if MappingHandle <> 0 then CloseHandle(MappingHandle);
end.
