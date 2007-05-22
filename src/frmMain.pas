
unit frmMain;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ActnList, uEditAppIntfs, ComCtrls,uMRU;

type
  TMainForm = class(TForm)
    mnuMain: TMainMenu;
    mFile: TMenuItem;
    miFileExit: TMenuItem;
    miFileNew: TMenuItem;
    N1: TMenuItem;
    mEdit: TMenuItem;
    miFileOpen: TMenuItem;
    miFileSave: TMenuItem;
    miFileSaveAs: TMenuItem;
    miFileClose: TMenuItem;
    miEditUndo: TMenuItem;
    miEditRedo: TMenuItem;
    N2: TMenuItem;
    miEditCut: TMenuItem;
    miEditCopy: TMenuItem;
    miEditPaste: TMenuItem;
    miEditDelete: TMenuItem;
    miEditSelectAll: TMenuItem;
    N3: TMenuItem;
    miEditFind: TMenuItem;
    miEditFindNext: TMenuItem;
    miEditFindPrev: TMenuItem;
    miEditReplace: TMenuItem;
    StatusBar: TStatusBar;
    miViewStatusbar: TMenuItem;
    mView: TMenuItem;
    N4: TMenuItem;
    mRecentFiles: TMenuItem;
    N5: TMenuItem;
    miFilePrint: TMenuItem;
    actlStandard: TActionList;
    actFileNew: TAction;
    actFileOpen: TAction;
    actFileExit: TAction;
    actViewStatusbar: TAction;
    actUpdateStatusBarPanels: TAction;
    actFileCloseAll: TAction;
    miFileCloseAll: TMenuItem;
    Window2: TMenuItem;
    Close2: TMenuItem;
    pctrlMain: TPageControl;
    FontDialog1: TFontDialog;
    miViewFont: TMenuItem;
    mRecentFolders: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mFileClick(Sender: TObject);
    procedure actFileNewOrOpenUpdate(Sender: TObject);
    procedure actFileNewExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actViewStatusbarUpdate(Sender: TObject);
    procedure actViewStatusbarExecute(Sender: TObject);
    procedure OnOpenMRUFile(Sender: TObject; const FileName: String);
    procedure actUpdateStatusBarPanelsUpdate(Sender: TObject);
    procedure actFileCloseAllExecute(Sender: TObject);
    procedure actFileCloseAllUpdate(Sender: TObject);
    procedure Close2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pctrlMainChange(Sender: TObject);
    procedure miViewFontClick(Sender: TObject);
    procedure OnOpenMRUFolders(Sender: TObject; const FileName: String);
  private
  protected
    function CanCloseAll: boolean;
    function CmdLineOpenFiles(AMultipleFiles: boolean): boolean;
    function DoCreateEditor(AFileName: string): IEditor; virtual;
    procedure DoOpenFile(AFileName: string);
  end;
var
  MainForm : TMainForm ;
implementation

{$R *.DFM}

uses
  uEditorConf,IniFiles, dmCommands,frmEditor;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  GI_EditorFactory := TEditorFactory.Create;
  CommandsDataModule := TCommandsDataModule.Create(Self);
  CmdLineOpenFiles(TRUE);
  if Self.pctrlMain.ActivePage = nil then
   DoCreateEditor('');
  Left := 100 ;Top :=100 ;Height := 600 ;Width  := 800 ;
  //GI_EditorFactory.SetFont(FEditorConf.Font.Name,FEditorConf.Font.size);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if GI_EditorFactory <> nil then
    GI_EditorFactory.CloseAll;
  CommandsDataModule.Free;
  GI_EditorFactory := nil ;

end;

// implementation

function TMainForm.CanCloseAll: boolean;
begin
  Result := TRUE;
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
      DoOpenFile(ParamStr(i));
    Result := TRUE;
  end else
    Result := FALSE;
end;

function TMainForm.DoCreateEditor(AFileName: string): IEditor;
begin
  if GI_EditorFactory <> nil then
    Result := GI_EditorFactory.CreateTabSheet(pctrlMain)
  else
    Result := nil;
end;

procedure TMainForm.DoOpenFile(AFileName: string);
var
  i: integer;
  LEditor: IEditor;
begin
  AFileName := ExpandFileName(AFileName);
  if AFileName <> '' then begin
    GI_EditorFactory.RemoveMRU(AFileName);
    // activate the editor if already open
    Assert(GI_EditorFactory <> nil);
    for i := GI_EditorFactory.GetEditorCount - 1 downto 0 do begin
      LEditor := GI_EditorFactory.Editor[i];
      if CompareText(LEditor.GetFileName, AFileName) = 0 then begin
        LEditor.Activate;
        exit;
      end;
    end;
  end;
  // create a new editor, add it to the editor list, open the file
  LEditor := DoCreateEditor(AFileName);
  if LEditor <> nil then
    LEditor.OpenFile(AFileName);
end;


// action handler methods

procedure TMainForm.actFileNewOrOpenUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := GI_EditorFactory <> nil;
end;

procedure TMainForm.actFileNewExecute(Sender: TObject);
begin
  DoOpenFile('');
end;

procedure TMainForm.actFileOpenExecute(Sender: TObject);
begin
  with CommandsDataModule.dlgFileOpen do begin
    if Execute then
      DoOpenFile(FileName);
  end;
end;

procedure TMainForm.actFileCloseAllExecute(Sender: TObject);
begin
  if (GI_EditorFactory.CanCloseAll) then begin
    GI_EditorFactory.CloseAll ;
    Close ;
  end;
end;

procedure TMainForm.actFileCloseAllUpdate(Sender: TObject);
begin
  actFileCloseAll.Enabled := (GI_EditorFactory <> nil)
    and (GI_EditorFactory.GetEditorCount > 0);
end;

procedure TMainForm.actFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.mFileClick(Sender: TObject);
begin
  mRecentFiles.Enabled := GI_EditorFactory.GetMRUCount > 0;
end;

procedure TMainForm.actViewStatusbarUpdate(Sender: TObject);
begin
  actViewStatusbar.Checked := StatusBar.Visible;
end;

procedure TMainForm.actViewStatusbarExecute(Sender: TObject);
begin
  StatusBar.Visible := not StatusBar.Visible;
end;

procedure TMainForm.OnOpenMRUFile(Sender: TObject; const FileName: String);
var
  i: integer;
  s: string;
begin
  DoOpenFile(FileName);
end;

procedure TMainForm.OnOpenMRUFolders(Sender: TObject; const FileName: String);
var
  i: integer;
  s: string;
begin

  DoOpenFile(FileName);
end;

procedure TMainForm.actUpdateStatusBarPanelsUpdate(Sender: TObject);
resourcestring
  SModified = 'Modified';
var
  ptCaret: TPoint;
begin
  actUpdateStatusBarPanels.Enabled := TRUE;
  if GI_ActiveEditor <> nil then begin
    ptCaret := GI_ActiveEditor.GetCaretPos;
    if (ptCaret.X > 0) and (ptCaret.Y > 0) then
      StatusBar.Panels[0].Text := Format(' %6d:%3d ', [ptCaret.Y, ptCaret.X])
    else
      StatusBar.Panels[0].Text := '';
    if GI_ActiveEditor.GetModified then
      StatusBar.Panels[1].Text := SModified
    else
      StatusBar.Panels[1].Text := '';
    StatusBar.Panels[2].Text := GI_ActiveEditor.GetEditorState;
  end else begin
    StatusBar.Panels[0].Text := '';
    StatusBar.Panels[1].Text := '';
    StatusBar.Panels[2].Text := '';
  end;
end;

procedure TMainForm.Close2Click(Sender: TObject);
begin
  Gi_EditorFactory.CloseEditor;
  if self.pctrlMain.ActivePage = nil then
    Close ;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if GI_EditorFactory <> nil then
    CanClose := GI_EditorFactory.CanCloseAll;

end;

procedure TMainForm.pctrlMainChange(Sender: TObject);
begin
  GI_ActiveEditor := TEditorTabSheet(pctrlMain.ActivePage).EditIntf ;
end;

procedure TMainForm.miViewFontClick(Sender: TObject);
begin
  FontDialog1.Font.Assign(GI_EditorFactory.GetFont);
  if FontDialog1.Execute then begin
    GI_EditorFactory.SetFont(FontDialog1.Font);

  end;
end;

end.

