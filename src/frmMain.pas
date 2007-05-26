
unit frmMain;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ActnList, uEditAppIntfs, ComCtrls,uMRU,SynEditHighlighter,uHighlighterProcs;

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
    pctrlMain: TPageControl;
    FontDialog1: TFontDialog;
    miViewFont: TMenuItem;
    mRecentFolders: TMenuItem;
    actRecentFiles: TAction;
    actRecentFolders: TAction;
    actlMain: TActionList;
    actFileSave: TAction;
    actFileSaveAs: TAction;
    actFileClose: TAction;
    actFilePrint: TAction;
    actEditCut: TAction;
    actEditCopy: TAction;
    actEditPaste: TAction;
    actEditDelete: TAction;
    actEditUndo: TAction;
    actEditRedo: TAction;
    actEditSelectAll: TAction;
    actSearchFind: TAction;
    actSearchFindNext: TAction;
    actSearchFindPrev: TAction;
    actSearchReplace: TAction;
    dlgFileSave: TSaveDialog;
    dlgFileOpen: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFileNewExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actViewStatusbarUpdate(Sender: TObject);
    procedure actViewStatusbarExecute(Sender: TObject);
    procedure OnOpenMRUFile(Sender: TObject; const FileName: String);
    procedure actUpdateStatusBarPanelsUpdate(Sender: TObject);
    procedure actFileCloseAllExecute(Sender: TObject);
    procedure Close2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pctrlMainChange(Sender: TObject);
    procedure miViewFontClick(Sender: TObject);
    procedure OnOpenMRUFolders(Sender: TObject; const AFileName: String);
    procedure mFileClick(Sender: TObject);
  public
    function GetSaveFileName(var ANewName: string;
      AHighlighter: TSynCustomHighlighter): boolean;

  published
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditCopyUpdate(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditCutUpdate(Sender: TObject);
    procedure actEditDeleteExecute(Sender: TObject);
    procedure actEditDeleteUpdate(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actEditPasteUpdate(Sender: TObject);
    procedure actEditRedoExecute(Sender: TObject);
    procedure actEditRedoUpdate(Sender: TObject);
    procedure actEditSelectAllExecute(Sender: TObject);
    procedure actEditSelectAllUpdate(Sender: TObject);
    procedure actEditUndoExecute(Sender: TObject);
    procedure actEditUndoUpdate(Sender: TObject);
    procedure actFileCloseExecute(Sender: TObject);
    procedure actFileCloseUpdate(Sender: TObject);
    procedure actFilePrintExecute(Sender: TObject);
    procedure actFilePrintUpdate(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actFileSaveAsUpdate(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileSaveUpdate(Sender: TObject);
    procedure actSearchFindExecute(Sender: TObject);
    procedure actSearchFindNextExecute(Sender: TObject);
    procedure actSearchFindNextUpdate(Sender: TObject);
    procedure actSearchFindPrevExecute(Sender: TObject);
    procedure actSearchFindPrevUpdate(Sender: TObject);
    procedure actSearchFindUpdate(Sender: TObject);
    procedure actSearchReplaceExecute(Sender: TObject);
    procedure actSearchReplaceUpdate(Sender: TObject);

  protected
    function CanCloseAll: boolean;
    function CmdLineOpenFiles(AMultipleFiles: boolean): boolean;
    //procedure DoOpenFile(AFileName: string);
  end;
var
  MainForm : TMainForm ;
implementation

{$R *.DFM}

uses
  uEditorConf,IniFiles, frmEditor, uHighlighters;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  GI_EditorFactory := TEditorFactory.Create;
  Highlighters := THighlighters.Create;
  dlgFileOpen.Filter :=  Highlighters.GetFilters ;
  CmdLineOpenFiles(TRUE);
  if Self.pctrlMain.ActivePage = nil then
   GI_EditorFactory.DoOpenFile('',Self.pctrlMain);
  Left := 100 ;Top :=100 ;Height := 600 ;Width  := 800 ;
  //GI_EditorFactory.SetFont(FEditorConf.Font.Name,FEditorConf.Font.size);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Assert(GI_EditorFactory <> nil );
  GI_EditorFactory.CloseAll;
  GI_EditorFactory := nil ;
  Highlighters.Free;
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
      GI_EditorFactory.DoOpenFile(ParamStr(i),Self.pctrlMain);

    Result := TRUE;
  end else
    Result := FALSE;
end;

// action handler methods


procedure TMainForm.actFileNewExecute(Sender: TObject);
begin
  GI_EditorFactory.DoOpenFile('',Self.pctrlMain);
end;

procedure TMainForm.actFileOpenExecute(Sender: TObject);
begin
  with dlgFileOpen do begin
    if Execute then
      GI_EditorFactory.DoOpenFile(FileName,self.pctrlMain);
  end;
end;

procedure TMainForm.actFileCloseAllExecute(Sender: TObject);
begin
  if (GI_EditorFactory.CanCloseAll) then begin
    GI_EditorFactory.CloseAll ;
    Close ;
  end;
end;



procedure TMainForm.actFileExitExecute(Sender: TObject);
begin
  Close;
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
  GI_EditorFactory.DoOpenFile(FileName,self.pctrlMain);
end;

procedure TMainForm.OnOpenMRUFolders(Sender: TObject; const AFileName: String);
var
  i: integer;
  s: string;
begin
  with dlgFileOpen do begin
      dlgFileOpen.InitialDir := AFileName ;
    if Execute then
      GI_EditorFactory.DoOpenFile(FileName,self.pctrlMain);
  end;
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
  Assert(GI_EditorFactory <> nil );
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


procedure TMainForm.mFileClick(Sender: TObject);
begin
  GI_EditorFactory.AskEnable ;
end;

procedure TMainForm.actFileSaveExecute(Sender: TObject);
begin
    GI_FileCmds.ExecSave;
end;

procedure TMainForm.actFileSaveUpdate(Sender: TObject);
begin
  actFileSave.Enabled := GI_FileCmds.CanSave;
end;

procedure TMainForm.actFileSaveAsExecute(Sender: TObject);
begin
    GI_FileCmds.ExecSaveAs;
end;

procedure TMainForm.actFileSaveAsUpdate(Sender: TObject);
begin
  actFileSaveAs.Enabled := GI_FileCmds.CanSaveAs;
end;

procedure TMainForm.actFilePrintExecute(Sender: TObject);
begin
  GI_FileCmds.ExecPrint;
end;

procedure TMainForm.actFilePrintUpdate(Sender: TObject);
begin
  actFilePrint.Enabled := GI_FileCmds.CanPrint;
end;

procedure TMainForm.actFileCloseExecute(Sender: TObject);
begin
  Gi_EditorFactory.CloseEditor;
  if MainForm.pctrlMain.ActivePage = nil then
    MainForm.Close ;
end;

procedure TMainForm.actFileCloseUpdate(Sender: TObject);
begin
  actFileClose.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanClose;
end;

procedure TMainForm.actEditCutExecute(Sender: TObject);
begin
  GI_EditCmds.ExecCut;
end;

procedure TMainForm.actEditCutUpdate(Sender: TObject);
begin
  actEditCut.Enabled := GI_EditCmds.CanCut;
end;

procedure TMainForm.actEditCopyExecute(Sender: TObject);
begin
  GI_EditCmds.ExecCopy;
end;

procedure TMainForm.actEditCopyUpdate(Sender: TObject);
begin
  actEditCopy.Enabled := GI_EditCmds.CanCopy;
end;

procedure TMainForm.actEditPasteExecute(Sender: TObject);
begin
  GI_EditCmds.ExecPaste;
end;

procedure TMainForm.actEditPasteUpdate(Sender: TObject);
begin
  actEditPaste.Enabled := GI_EditCmds.CanPaste;
end;

procedure TMainForm.actEditDeleteExecute(Sender: TObject);
begin
  GI_EditCmds.ExecDelete;
end;

procedure TMainForm.actEditDeleteUpdate(Sender: TObject);
begin
  actEditDelete.Enabled := GI_EditCmds.CanDelete;
end;

procedure TMainForm.actEditSelectAllExecute(Sender: TObject);
begin
  GI_EditCmds.ExecSelectAll;
end;

procedure TMainForm.actEditSelectAllUpdate(Sender: TObject);
begin
  actEditSelectAll.Enabled := GI_EditCmds.CanSelectAll;
end;

procedure TMainForm.actEditRedoExecute(Sender: TObject);
begin
  GI_EditCmds.ExecRedo;
end;

procedure TMainForm.actEditRedoUpdate(Sender: TObject);
begin
  actEditRedo.Enabled := GI_EditCmds.CanRedo;
end;

procedure TMainForm.actEditUndoExecute(Sender: TObject);
begin
  GI_EditCmds.ExecUndo;
end;

procedure TMainForm.actEditUndoUpdate(Sender: TObject);
begin
  actEditUndo.Enabled := GI_EditCmds.CanUndo;
end;

procedure TMainForm.actSearchFindExecute(Sender: TObject);
begin
  GI_SearchCmds.ExecFind;
end;

procedure TMainForm.actSearchFindUpdate(Sender: TObject);
begin
  actSearchFind.Enabled := GI_SearchCmds.CanFind;
end;

procedure TMainForm.actSearchFindNextExecute(Sender: TObject);
begin
    GI_SearchCmds.ExecFindNext;
end;

procedure TMainForm.actSearchFindNextUpdate(Sender: TObject);
begin
  actSearchFindNext.Enabled := GI_SearchCmds.CanFindNext;
end;

procedure TMainForm.actSearchFindPrevExecute(Sender: TObject);
begin
  GI_SearchCmds.ExecFindPrev;
end;

procedure TMainForm.actSearchFindPrevUpdate(Sender: TObject);
begin
  actSearchFindPrev.Enabled := GI_SearchCmds.CanFindPrev;
end;

procedure TMainForm.actSearchReplaceExecute(Sender: TObject);
begin
    GI_SearchCmds.ExecReplace;
end;

procedure TMainForm.actSearchReplaceUpdate(Sender: TObject);
begin
  actSearchReplace.Enabled := GI_SearchCmds.CanReplace;
end;

function TMainForm.GetSaveFileName(var ANewName: string;
  AHighlighter: TSynCustomHighlighter): boolean;
begin
  with dlgFileSave do begin
    if ANewName <> '' then begin
      InitialDir := ExtractFileDir(ANewName);
      FileName := ExtractFileName(ANewName);
    end else begin
      InitialDir := '';
      FileName := '';
    end;
    if AHighlighter <> nil then
      Filter := AHighlighter.DefaultFilter
    else
      Filter := Highlighters.GetFilters;
    if Execute then begin
      ANewName := FileName;
      Result := TRUE;
    end else
      Result := FALSE;
  end;
end;
end.

