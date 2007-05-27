unit uAction;

interface
uses
  ActnList ,Classes,uEditAppIntfs,Menus,Dialogs,Forms,Windows;
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
  GI_EditorFactory.DoOpenFile('',MainForm.pctrlMain);
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
  ShortCut := Menus.ShortCut(Word('O'),[ssCtrl]);
end;

procedure TacFileOpen.Execute(Sender: TObject);
begin
  inherited;
  with dlgFileOpen do begin
    if Execute then
      GI_EditorFactory.DoOpenFile(FileName,MainForm.pctrlMain);
  end;
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
    GI_FileCmds.ExecSave;
end;



procedure TacFileSave.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_FileCmds.CanSave;
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
  GI_FileCmds.ExecPrint;
end;

procedure TacFilePrint.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_FileCmds.CanPrint ;
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
  GI_FileCmds.ExecSaveAs;
end;

procedure TacFileSaveAs.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_FileCmds.CanSaveAS;
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
  GI_EditCmds.ExecUndo;
end;

procedure TacEditUndo.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_EditCmds.CanUndo ;
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

end;

procedure TacEditRedo.Update(Sender: TObject);
begin
  inherited;

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

end;

procedure TacEditFindPrevious.Update(Sender: TObject);
begin
  inherited;

end;

{ TacEditCut }

constructor TacEditCut.Create(Owner: TComponent);
begin
  inherited;

end;

procedure TacEditCut.Execute(Sender: TObject);
begin
  inherited;

end;

procedure TacEditCut.Update(Sender: TObject);
begin
  inherited;
  Caption :='Cut';
  ShortCut := Menus.ShortCut(Word('X'),[ssCtrl]);
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

end;

procedure TacEditCopy.Update(Sender: TObject);
begin
  inherited;

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

end;

procedure TacEditPaste.Update(Sender: TObject);
begin
  inherited;

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
  GI_EditCmds.ExecDelete ;
end;

procedure TacEditDelete.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_EditCmds.CanDelete;
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
  GI_EditCmds.ExecSelectAll;
end;

procedure TacEditSelectAll.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_EditCmds.CanSelectAll ;
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
  GI_SearchCmds.ExecFind ;
end;

procedure TacEditFind.Update(Sender: TObject);
begin
  inherited;
  Enabled := GI_SearchCmds.CanFind ;
end;

{ TacEditReplace }

constructor TacEditReplace.Create(Owner: TComponent);
begin
  inherited;

end;

procedure TacEditReplace.Execute(Sender: TObject);
begin
  inherited;

end;

procedure TacEditReplace.Update(Sender: TObject);
begin
  inherited;

end;

{ TacEditFindNext }

constructor TacEditFindNext.Create(Owner: TComponent);
begin
  inherited;
  Caption :='Find Next';
  ShortCut := Menus.ShortCut(VK_F3,[ssShift]);
end;

procedure TacEditFindNext.Execute(Sender: TObject);
begin
  inherited;

end;

procedure TacEditFindNext.Update(Sender: TObject);
begin
  inherited;

end;

end.
