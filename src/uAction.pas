unit uAction;

interface
uses
  SysUtils ,ActnList ,Classes,uEditAppIntfs,Menus,Dialogs,Forms,Windows,futools,fuAbout,uHLs,fuTextGene;
type
  TacBase = class(TAction)
  protected
    procedure Update(Sender: TObject);virtual ;
    procedure Execute(Sender: TObject);virtual ;
  public
  constructor Create(AOwner: TComponent); override;
  end;
  TacFile=class(TacBase)
  private
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileNew=class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileOpen=class(TacBase)
  protected
    dlgFileOpen: TOpenDialog;
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileRecentFiles=class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileRecentFolders=class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileSave =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileSaveAs =class(TacBase)
  private
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFilePrint =class(TacBase)
  private
    //FForm : TForm ;
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
    //function HandlesTarget(Target: TObject): Boolean;override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileExit =class(TacBase)
  private
    //FForm : TForm ;
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
    //function HandlesTarget(Target: TObject): Boolean;override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileClose =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileCloseAll =class(TacBase)
  private
    //FForm : TForm ;
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
    //function HandlesTarget(Target: TObject): Boolean;override ;
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacEditUndo =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacEditRedo =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacEditCut =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacEditCopy =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacEditPaste =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacEditDelete =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacEditSelectAll =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacEditFind =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacEditReplace =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacEditFindNext =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacEditFindPrevious =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewStatusBar =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewFont =class(TacBase)
  FontDialog1 : TFontDialog ;
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewSetBookmark =class(TacBase)
  protected
    FBookmarkIndex : Integer;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark =class(TacBase)
  protected
    FBookmarkIndex : Integer;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewSetBookmark1 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark1 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacViewSetBookmark2 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark2 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacViewSetBookmark3 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark3 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacViewSetBookmark4 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark4 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacViewSetBookmark5 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark5 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacViewSetBookmark6 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark6 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacViewSetBookmark7 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark7 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacViewSetBookmark8 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark8 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacViewSetBookmark9 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark9 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacViewSetBookmark0 =class(TacViewSetBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacViewGotoBookmark0 =class(TacViewGotoBookmark)
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacOnlyUpdate =class(TacBase)
  private
    fm : TfmAbout ;
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;

  TacToolsConf =class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacToolsTextFormattor=class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacToolsRunScript=class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
implementation
uses frmMain;
{ TacBase }


{ TacBase }

constructor TacBase.Create(AOwner: TComponent);
begin
  inherited;
  Self.OnExecute := Execute ;
  Self.OnUpdate := Update ;
end;

procedure TacBase.Execute(Sender: TObject);
begin

end;


procedure TacBase.Update(Sender: TObject);
begin

end;

{ TacFile }


constructor TacFile.Create(Owner: TComponent);
begin
  inherited;
  Caption  := 'File' ;
end;

procedure TacFile.Execute(Sender: TObject);
begin
  GI_EditorFactory.AskEnable ;
end;


procedure TacFile.Update(Sender: TObject);
begin

end;

{ TacFileNew }

constructor TacFileNew.Create(Owner: TComponent);
begin
  inherited;
  Self.ShortCut := Menus.ShortCut(Word('N'),[ssCtrl]);
  Caption :='New'
end;

procedure TacFileNew.Execute(Sender: TObject);
begin
  inherited;
  GI_EditorFactory.DoOpenFile('');
end;


procedure TacFileNew.Update(Sender: TObject);
begin
  inherited;

end;

{ TacFileOpen }

constructor TacFileOpen.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Open...' ;
  dlgFileOpen := TOpenDialog.Create(Self);
  dlgFileOpen.Options :=  [ofAllowMultiSelect] + dlgFileOpen.Options;
  dlgFileOpen.Filter := HLs.GetFilters ;
  ShortCut := Menus.ShortCut(Word('O'),[ssCtrl]);
end;

procedure TacFileOpen.Execute(Sender: TObject);
var
  i :Integer ;
begin
  inherited;
  with dlgFileOpen do
    if Execute then
      for I := 0 to Files.Count -1 do
        GI_EditorFactory.DoOpenFile(Files.Strings[I]);
end;

procedure TacFileOpen.Update(Sender: TObject);
begin
  inherited;

end;

{ TacFileRecentFiles }

constructor TacFileRecentFiles.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Recent Files';
end;

procedure TacFileRecentFiles.Execute(Sender: TObject);
begin
  inherited;

end;

procedure TacFileRecentFiles.Update(Sender: TObject);
begin
  inherited;

end;

{ TacFileRecentFolders }

constructor TacFileRecentFolders.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Recent Folders';
end;

procedure TacFileRecentFolders.Execute(Sender: TObject);
begin
  inherited;

end;

procedure TacFileRecentFolders.Update(Sender: TObject);
begin
  inherited;

end;

{ TacFileSave }

constructor TacFileSave.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Save';
  Self.ShortCut := Menus.ShortCut(Word('S'),[ssCtrl]);
end;

procedure TacFileSave.Execute(Sender: TObject);
begin
  inherited;
    GI_ActiveEditor.ExecSave;
end;



procedure TacFileSave.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanSave;
end;

{ TacFileCloseAll }

constructor TacFileCloseAll.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Close All';
end;

procedure TacFileCloseAll.Execute(Sender: TObject);
begin
  inherited;
  if (GI_EditorFactory.CanCloseAll) then begin
    GI_EditorFactory.CloseAll ;
    TForm(Owner).Close ;
  end;
end;


procedure TacFileCloseAll.Update(Sender: TObject);
begin
  inherited;

end;

{ TacFileClose }

constructor TacFileClose.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Close';
  ShortCut := Menus.ShortCut(Word('W'),[ssCtrl]);
end;

procedure TacFileClose.Execute(Sender: TObject);
begin
  inherited;
  GI_EditorFactory.CloseEditor ;
end;

procedure TacFileClose.Update(Sender: TObject);
begin
  inherited;

end;

{ TacFileExit }

constructor TacFileExit.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Exit';
end;

procedure TacFileExit.Execute(Sender: TObject);
begin
  inherited;
  TForm(Owner).Close;
end;

procedure TacFileExit.Update(Sender: TObject);
begin
  inherited;

end;

{ TacFilePrint }

constructor TacFilePrint.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Print';
end;

procedure TacFilePrint.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecPrint;
end;

procedure TacFilePrint.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanPrint ;
end;

{ TacFileSaveAs }

constructor TacFileSaveAs.Create(Owner: TComponent);
begin
  inherited;
  Caption:='Save As';
end;

procedure TacFileSaveAs.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecSaveAs;
end;

procedure TacFileSaveAs.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanSaveAS;
end;

{ TacEditUndo }

constructor TacEditUndo.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Undo';
  ShortCut := Menus.ShortCut(Word('Z'),[ssCtrl]);
end;

procedure TacEditUndo.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecUndo;
end;

procedure TacEditUndo.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanUndo ;
end;

{ TacEditRedo }

constructor TacEditRedo.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Redo';
end;

procedure TacEditRedo.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecRedo ;
end;

procedure TacEditRedo.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanRedo ;
end;

{ TacEditFindPrevious }

constructor TacEditFindPrevious.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Find Previous' ;
  Self.ShortCut := Menus.ShortCut(VK_F3,[ssshift]);
end;

procedure TacEditFindPrevious.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecFindPrev ;
end;

procedure TacEditFindPrevious.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanFindPrev ;
end;

{ TacEditCut }

constructor TacEditCut.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Cut';
  ShortCut := Menus.ShortCut(Word('X'),[ssCtrl]);
end;

procedure TacEditCut.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecCut ;
end;

procedure TacEditCut.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanCut ;
end;

{ TacEditCopy }

constructor TacEditCopy.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Copy';
  ShortCut := Menus.ShortCut(Word('C'),[ssCtrl]);

end;

procedure TacEditCopy.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecCopy ;
end;

procedure TacEditCopy.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanCopy ;
end;

{ TacEditPaste }

constructor TacEditPaste.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Paste';
  ShortCut := Menus.ShortCut(Word('V'),[ssCtrl]);

end;

procedure TacEditPaste.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecPaste ;
end;

procedure TacEditPaste.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanPaste ;
end;

{ TacEditDelete }

constructor TacEditDelete.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Delete';
  ShortCut := Menus.ShortCut(Word('X'),[ssCtrl]);

end;

procedure TacEditDelete.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecDelete ;
end;

procedure TacEditDelete.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanDelete;
end;

{ TacEditSelectAll }

constructor TacEditSelectAll.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Select all';
  ShortCut := Menus.ShortCut(Word('A'),[ssCtrl]);
end;

procedure TacEditSelectAll.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecSelectAll;
end;

procedure TacEditSelectAll.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanSelectAll ;
end;

{ TacEditFind }

constructor TacEditFind.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Find ...';
  ShortCut := Menus.ShortCut(Word('F'),[ssCtrl]);

end;

procedure TacEditFind.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecFind ;
end;

procedure TacEditFind.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanFind ;
end;

{ TacEditReplace }

constructor TacEditReplace.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Replace...';
end;

procedure TacEditReplace.Execute(Sender: TObject);
begin
  inherited;
   GI_ActiveEditor.ExecReplace;
end;

procedure TacEditReplace.Update(Sender: TObject);
begin
  inherited;
   Enabled := GI_ActiveEditor.CanReplace ;
end;

{ TacEditFindNext }

constructor TacEditFindNext.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Find Next';
  ShortCut := Menus.ShortCut(VK_F3,[]);
end;

procedure TacEditFindNext.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.ExecFindNext ;
end;

procedure TacEditFindNext.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_ActiveEditor.CanFindNext ;
end;

{ TacViewFont }

constructor TacViewFont.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Font';
  FontDialog1 := TFontDialog.Create(Self);
end;

procedure TacViewFont.Execute(Sender: TObject);
begin
  inherited;
  FontDialog1.Font.Assign(GI_EditorFactory.GetFont);
  if FontDialog1.Execute then begin
    GI_EditorFactory.SetFont(FontDialog1.Font);
  end;
end;

procedure TacViewFont.Update(Sender: TObject);
begin
  inherited;

end;

{ TacViewStatusBar }

constructor TacViewStatusBar.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Status Bar';
end;

procedure TacViewStatusBar.Execute(Sender: TObject);
begin
  inherited;
  MainForm.StatusBar.Visible := not MainForm.StatusBar.Visible;
end;

procedure TacViewStatusBar.Update(Sender: TObject);
begin
  inherited;
  Checked := MainForm.StatusBar.Visible;
end;

{ TacOnlyUpdate }

constructor TacOnlyUpdate.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Help';
end;

procedure TacOnlyUpdate.Execute(Sender: TObject);
begin
  inherited;
  fm := TfmAbout.Create(nil) ;
  try
    fm.ShowModal;
  finally
    fm.Free ;
  end;
end;

procedure TacOnlyUpdate.Update(Sender: TObject);
resourcestring
  SModified = 'Modified';
var
  ptCaret: TPoint;
begin
  inherited;
  with MainForm do begin
    //actUpdateStatusBarPanels.Enabled := TRUE;
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
end;

{ TacToolsConf }

constructor TacToolsConf.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Custom..' ;
end;

procedure TacToolsConf.Execute(Sender: TObject);
begin
  inherited;
  GI_EditorFactory.RunToolsConf ;
end;

procedure TacToolsConf.Update(Sender: TObject);
begin
  inherited;

end;

{ TacToolsTextFormattor }

constructor TacToolsTextFormattor.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Text Formattor';
end;

procedure TacToolsTextFormattor.Execute(Sender: TObject);
var
   t : String ;
begin
  inherited;
  t := GetTextGene ;
  if t <> '' then begin
    GI_EditorFactory.DoOpenFile('');
    GI_ActiveEditor.GetStrings.Text := t;
  end;
end;

procedure TacToolsTextFormattor.Update(Sender: TObject);
begin
  inherited;

end;

{ TacToolsRunScript }

constructor TacToolsRunScript.Create(Owner: TComponent);
begin
  inherited;
  Caption := 'Run Script';
  ShortCut := Menus.ShortCut(VK_F9,[]);
end;

procedure TacToolsRunScript.Execute(Sender: TObject);
begin
  inherited;
  ShowMessage(GI_ActiveEditor.GetFileName);
  GI_EditorFactory.GetEditConf.Tools.RunTool ;
end;

procedure TacToolsRunScript.Update(Sender: TObject);
begin
  inherited;

end;

{ TacViewGotoBookmark }

constructor TacViewGotoBookmark.Create(Owner: TComponent);
begin
  inherited;
  Caption := Format('GotoBookmark(%d)',[FBookmarkIndex]);
  //ShortCut := Menus.ShortCut(VK_F3,[]);
end;

procedure TacViewGotoBookmark.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.GotoBookmark(FBookmarkIndex);
end;


{ TacViewSetBookmark }

constructor TacViewSetBookmark.Create(Owner: TComponent);
begin
  inherited;
  Caption := Format('SetBookmark(%d)',[FBookmarkIndex]);
end;

procedure TacViewSetBookmark.Execute(Sender: TObject);
begin
  inherited;
  GI_ActiveEditor.SetBookmark(FBookmarkIndex);
end;


{ TacViewGotoBookmark1 }

constructor TacViewGotoBookmark1.Create(Owner: TComponent);
begin
  FBookmarkIndex := 1 ;
  inherited;

end;

{ TacViewSetBookmark1 }

constructor TacViewSetBookmark1.Create(Owner: TComponent);
begin
  FBookmarkIndex := 1 ;
  inherited;

end;


{ TacViewSetBookmark2 }

constructor TacViewSetBookmark2.Create(Owner: TComponent);
begin
  FBookmarkIndex := 2 ;
  inherited;

end;

{ TacViewGotoBookmark2 }

constructor TacViewGotoBookmark2.Create(Owner: TComponent);
begin
  FBookmarkIndex := 2 ;
  inherited;

end;

{ TacViewSetBookmark3 }

constructor TacViewSetBookmark3.Create(Owner: TComponent);
begin
  FBookmarkIndex := 3 ;
  inherited;

end;

{ TacViewGotoBookmark3 }

constructor TacViewGotoBookmark3.Create(Owner: TComponent);
begin
  FBookmarkIndex := 3 ;
  inherited;

end;

{ TacViewSetBookmark4 }

constructor TacViewSetBookmark4.Create(Owner: TComponent);
begin
  FBookmarkIndex := 4 ;
  inherited;

end;

{ TacViewGotoBookmark4 }

constructor TacViewGotoBookmark4.Create(Owner: TComponent);
begin
  FBookmarkIndex := 4;
  inherited;
 ;
end;

{ TacViewSetBookmark5 }

constructor TacViewSetBookmark5.Create(Owner: TComponent);
begin
  FBookmarkIndex := 5 ;
  inherited;
end;

{ TacViewGotoBookmark5 }

constructor TacViewGotoBookmark5.Create(Owner: TComponent);
begin
  FBookmarkIndex := 5 ;
  inherited;

end;

{ TacViewSetBookmark6 }

constructor TacViewSetBookmark6.Create(Owner: TComponent);
begin
  FBookmarkIndex := 6 ;
  inherited;
end;

{ TacViewGotoBookmark6 }

constructor TacViewGotoBookmark6.Create(Owner: TComponent);
begin
  FBookmarkIndex := 6;
  inherited;

end;

{ TacViewSetBookmark7 }

constructor TacViewSetBookmark7.Create(Owner: TComponent);
begin
  FBookmarkIndex := 7 ;
  inherited;
end;

{ TacViewGotoBookmark7 }

constructor TacViewGotoBookmark7.Create(Owner: TComponent);
begin
  FBookmarkIndex := 7 ;
  inherited;
end;

{ TacViewSetBookmark8 }

constructor TacViewSetBookmark8.Create(Owner: TComponent);
begin
  FBookmarkIndex := 8 ;
  inherited;
end;

{ TacViewGotoBookmark8 }

constructor TacViewGotoBookmark8.Create(Owner: TComponent);
begin
  FBookmarkIndex := 8 ;
  inherited;
end;

{ TacViewSetBookmark9 }

constructor TacViewSetBookmark9.Create(Owner: TComponent);
begin
  FBookmarkIndex := 9 ;
  inherited;
end;

{ TacViewGotoBookmark9 }

constructor TacViewGotoBookmark9.Create(Owner: TComponent);
begin
  FBookmarkIndex := 9 ;
  inherited;
end;

{ TacViewSetBookmark0 }

constructor TacViewSetBookmark0.Create(Owner: TComponent);
begin

  FBookmarkIndex := 0 ;
  inherited;
end;

{ TacViewGotoBookmark0 }

constructor TacViewGotoBookmark0.Create(Owner: TComponent);
begin
  FBookmarkIndex :=  0;
  inherited;
end;

end.
