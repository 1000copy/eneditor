
unit frmMain;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ActnList, uEditAppIntfs, ComCtrls,uMRU,SynEditHighlighter,uAction;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    pctrlMain: TPageControl;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pctrlMainChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    //hmutex : THandle ;
    procedure OnBroadcase(inText: string ; inData : double ; inKey :integer) ;
  public
    function SendToWin(Str:String ;WindowName:string):Boolean;
    procedure Mymessage(var t: TWmCopyData);message wm_copydata;
  protected
    function CmdLineOpenFiles(AMultipleFiles: boolean): boolean;

  end;
var
  MainForm : TMainForm ;

implementation



{$R *.DFM}

uses
  uEditorConf,IniFiles, frmEditor, uHLs;

{ TMainForm }
procedure TMainForm.Mymessage(var t: TWmCopyData);
begin
  ShowMessage(StrPas(t.CopyDataStruct^.lpData));
  GI_EditorFactory.DoOpenFile(StrPas(t.CopyDataStruct^.lpData));
end;
function TMainForm.SendToWin(Str:String ;WindowName:string):Boolean;
var
  ds: TCopyDataStruct;
  Hd : THandle;
begin
  ds.cbData := Length (Str) + 1;
  GetMem (ds.lpData, ds.cbData ); //为传递的数据区分配内存
  try
    StrCopy (ds.lpData, PChar (Str));
    Hd := FindWindow (nil, PChar(WindowName));
    if Hd > 0 then begin
      SendMessage (Hd, WM_COPYDATA, Handle,
                   Cardinal(@ds)) ;// 发送WM_COPYDATA消息
      Result := True;
    end
    else
      Result := False ;
  finally
    FreeMem (ds.lpData); //释放资源
  end;
end;
procedure TMainForm.FormCreate(Sender: TObject);
begin
  //InitMenu ;
  GI_EditorFactory := TEditorFactory.Create(Self.pctrlMain);

  CmdLineOpenFiles(TRUE);
  if Self.pctrlMain.ActivePage = nil then
   GI_EditorFactory.DoOpenFile('');
  Self.WindowState :=   wsMaximized ;
  //Left := 100 ;Top :=100 ;Height := 600 ;Width  := 800 ;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Assert(GI_EditorFactory <> nil );
  GI_EditorFactory.CloseAll;
  GI_EditorFactory := nil ;
  HLs.Free;
end;


function TMainForm.CmdLineOpenFiles(AMultipleFiles: boolean): boolean;
var
  i, Cnt: integer;
begin
  Cnt := ParamCount;
  if Cnt > 0 then begin
    if not AMultipleFiles and (Cnt > 1) then
      Cnt := 1;
    for i := 1 to Cnt do
      GI_EditorFactory.DoOpenFile(ParamStr(i));

    Result := TRUE;
  end else
    Result := FALSE;
end;


procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Assert(GI_EditorFactory <> nil );
  CanClose := GI_EditorFactory.CanCloseAll;
  //releasemutex(hmutex);
end;

procedure TMainForm.pctrlMainChange(Sender: TObject);
begin
  GI_ActiveEditor := TEditorTabSheet(pctrlMain.ActivePage).EditIntf ;
end;



procedure TMainForm.OnBroadcase(inText: string; inData: double;
  inKey: integer);
begin
  GI_EditorFactory.DoOpenFile(inText);
end;

procedure TMainForm.FormActivate(Sender: TObject);
var
  ret : Integer ;
begin
  {
  hmutex:=CreateMutex(nil,false,'enEditor');
  ret:=GetLastError ;
  if   ret = Error_Already_Exists   then begin
    // 现在通过CopyData 总是不对，好像FindWindows找到的Window不是真正要的。
    ShowMessage('enEditor 已经运行！');
    Application.Terminate ;
  end;
  Caption := 'enEditor';
  }
end;

end.

