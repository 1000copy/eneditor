
unit frmMain;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ActnList, uEditAppIntfs, ComCtrls,uMRU,SynEditHighlighter,uAction,
  ExtCtrls,SyncObjs;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    pctrlMain: TPageControl;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pctrlMainChange(Sender: TObject);
  protected
    function CmdLineOpenFiles(AMultipleFiles: boolean): boolean;
  end;
var
  MainForm : TMainForm ;

implementation



{$R *.DFM}

uses
  frmEditor;


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
end;

procedure TMainForm.pctrlMainChange(Sender: TObject);
begin
  GI_ActiveEditor := TEditorTabSheet(pctrlMain.ActivePage).EditIntf ;
end;


end.

