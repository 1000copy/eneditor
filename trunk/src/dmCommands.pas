
unit dmCommands;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, SynHighlighterSQL, SynHighlighterPas, SynEditHighlighter,
  SynHighlighterCpp, SynHighlighterXML, SynHighlighterHtml,uMRU;

type
  TCommandsDataModule = class(TDataModule)
    dlgFileOpen: TOpenDialog;
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
    SynPasSyn1: TSynPasSyn;
    SynSQLSyn1: TSynSQLSyn;
    dlgFileSave: TSaveDialog;
    SynXMLSyn1: TSynXMLSyn;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileSaveUpdate(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actFileSaveAsUpdate(Sender: TObject);
    procedure actFilePrintExecute(Sender: TObject);
    procedure actFilePrintUpdate(Sender: TObject);
    procedure actFileCloseExecute(Sender: TObject);
    procedure actFileCloseUpdate(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditCutUpdate(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditCopyUpdate(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actEditPasteUpdate(Sender: TObject);
    procedure actEditDeleteExecute(Sender: TObject);
    procedure actEditDeleteUpdate(Sender: TObject);
    procedure actEditSelectAllExecute(Sender: TObject);
    procedure actEditSelectAllUpdate(Sender: TObject);
    procedure actEditRedoExecute(Sender: TObject);
    procedure actEditRedoUpdate(Sender: TObject);
    procedure actEditUndoExecute(Sender: TObject);
    procedure actEditUndoUpdate(Sender: TObject);
    procedure actSearchFindExecute(Sender: TObject);
    procedure actSearchFindUpdate(Sender: TObject);
    procedure actSearchFindNextExecute(Sender: TObject);
    procedure actSearchFindNextUpdate(Sender: TObject);
    procedure actSearchFindPrevExecute(Sender: TObject);
    procedure actSearchFindPrevUpdate(Sender: TObject);
    procedure actSearchReplaceExecute(Sender: TObject);
    procedure actSearchReplaceUpdate(Sender: TObject);
  private
    fHighlighters: TStringList;
    fUntitledNumbers: TBits;
  public
    function GetHighlighterForFile(AFileName: string): TSynCustomHighlighter;
    function GetSaveFileName(var ANewName: string;
      AHighlighter: TSynCustomHighlighter): boolean;
    function GetUntitledNumber: integer;
    procedure ReleaseUntitledNumber(ANumber: integer);
  end;

var
  CommandsDataModule: TCommandsDataModule;

implementation

{$R *.DFM}

uses
  uHighlighterProcs, uEditAppIntfs, frmMain;


resourcestring
  SFilterAllFiles = 'Txt file|*.txt|All files|*.*|';

{ TCommandsDataModule }

procedure TCommandsDataModule.DataModuleCreate(Sender: TObject);
begin
  fHighlighters := TStringList.Create;
  GetHighlighters(Self, fHighlighters, FALSE);
  dlgFileOpen.Filter := SFilterAllFiles +GetHighlightersFilter(fHighlighters) ;
  //fMRUFiles := TStringList.Create;
end;

procedure TCommandsDataModule.DataModuleDestroy(Sender: TObject);
begin
  //fMRUFiles.Free;
  fHighlighters.Free;
  fUntitledNumbers.Free;
  CommandsDataModule := nil;
end;

// implementation

function TCommandsDataModule.GetHighlighterForFile(
  AFileName: string): TSynCustomHighlighter;
begin
  if AFileName <> '' then
    Result := GetHighlighterFromFileExt(fHighlighters, ExtractFileExt(AFileName))
  else
    Result := nil;
end;
function TCommandsDataModule.GetSaveFileName(var ANewName: string;
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
      Filter := SFilterAllFiles;
    if Execute then begin
      ANewName := FileName;
      Result := TRUE;
    end else
      Result := FALSE;
  end;
end;

function TCommandsDataModule.GetUntitledNumber: integer;
begin
  if fUntitledNumbers = nil then
    fUntitledNumbers := TBits.Create;
  Result := fUntitledNumbers.OpenBit;
  if Result = fUntitledNumbers.Size then
    fUntitledNumbers.Size := fUntitledNumbers.Size + 32;
  fUntitledNumbers[Result] := TRUE;
  Inc(Result);
end;

procedure TCommandsDataModule.ReleaseUntitledNumber(ANumber: integer);
begin
  Dec(ANumber);
  if (fUntitledNumbers <> nil) and (ANumber >= 0)
    and (ANumber < fUntitledNumbers.Size)
  then
    fUntitledNumbers[ANumber] := FALSE;
end;


procedure TCommandsDataModule.actFileSaveExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecSave;
end;

procedure TCommandsDataModule.actFileSaveUpdate(Sender: TObject);
begin
  actFileSave.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanSave;
end;

procedure TCommandsDataModule.actFileSaveAsExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecSaveAs;
end;

procedure TCommandsDataModule.actFileSaveAsUpdate(Sender: TObject);
begin
  actFileSaveAs.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanSaveAs;
end;

procedure TCommandsDataModule.actFilePrintExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecPrint;
end;

procedure TCommandsDataModule.actFilePrintUpdate(Sender: TObject);
begin
  actFilePrint.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanPrint;
end;

procedure TCommandsDataModule.actFileCloseExecute(Sender: TObject);
begin
  {
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecClose;
  }
  Gi_EditorFactory.CloseEditor;
  if self.pctrlMain.ActivePage = nil then
    Close ;

end;

procedure TCommandsDataModule.actFileCloseUpdate(Sender: TObject);
begin
  actFileClose.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanClose;
end;

procedure TCommandsDataModule.actEditCutExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecCut;
end;

procedure TCommandsDataModule.actEditCutUpdate(Sender: TObject);
begin
  actEditCut.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanCut;
end;

procedure TCommandsDataModule.actEditCopyExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecCopy;
end;

procedure TCommandsDataModule.actEditCopyUpdate(Sender: TObject);
begin
  actEditCopy.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanCopy;
end;

procedure TCommandsDataModule.actEditPasteExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecPaste;
end;

procedure TCommandsDataModule.actEditPasteUpdate(Sender: TObject);
begin
  actEditPaste.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanPaste;
end;

procedure TCommandsDataModule.actEditDeleteExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecDelete;
end;

procedure TCommandsDataModule.actEditDeleteUpdate(Sender: TObject);
begin
  actEditDelete.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanDelete;
end;

procedure TCommandsDataModule.actEditSelectAllExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecSelectAll;
end;

procedure TCommandsDataModule.actEditSelectAllUpdate(Sender: TObject);
begin
  actEditSelectAll.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanSelectAll;
end;

procedure TCommandsDataModule.actEditRedoExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecRedo;
end;

procedure TCommandsDataModule.actEditRedoUpdate(Sender: TObject);
begin
  actEditRedo.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanRedo;
end;

procedure TCommandsDataModule.actEditUndoExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecUndo;
end;

procedure TCommandsDataModule.actEditUndoUpdate(Sender: TObject);
begin
  actEditUndo.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanUndo;
end;

procedure TCommandsDataModule.actSearchFindExecute(Sender: TObject);
begin
  if GI_SearchCmds <> nil then
    GI_SearchCmds.ExecFind;
end;

procedure TCommandsDataModule.actSearchFindUpdate(Sender: TObject);
begin
  actSearchFind.Enabled := (GI_SearchCmds <> nil) and GI_SearchCmds.CanFind;
end;

procedure TCommandsDataModule.actSearchFindNextExecute(Sender: TObject);
begin
  if GI_SearchCmds <> nil then
    GI_SearchCmds.ExecFindNext;
end;

procedure TCommandsDataModule.actSearchFindNextUpdate(Sender: TObject);
begin
  actSearchFindNext.Enabled := (GI_SearchCmds <> nil)
    and GI_SearchCmds.CanFindNext;
end;

procedure TCommandsDataModule.actSearchFindPrevExecute(Sender: TObject);
begin
  if GI_SearchCmds <> nil then
    GI_SearchCmds.ExecFindPrev;
end;

procedure TCommandsDataModule.actSearchFindPrevUpdate(Sender: TObject);
begin
  actSearchFindPrev.Enabled := (GI_SearchCmds <> nil) and GI_SearchCmds.CanFindPrev;
end;

procedure TCommandsDataModule.actSearchReplaceExecute(Sender: TObject);
begin
  if GI_SearchCmds <> nil then
    GI_SearchCmds.ExecReplace;
end;

procedure TCommandsDataModule.actSearchReplaceUpdate(Sender: TObject);
begin
  actSearchReplace.Enabled := (GI_SearchCmds <> nil)
    and GI_SearchCmds.CanReplace;
end;

end.

 