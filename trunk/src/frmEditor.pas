{lcjun 's something}
unit frmEditor;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  uEditAppIntfs, uAction,ActnList,
  ComCtrls ,uMRU,uEditorConf,uHLs,
  Dialogs,fuTools, uSynWrapper,XMLDoc,XMLIntf;

type
  TEditor = class;

  TEditorForm = class(TForm)
    pmnuEditor: TPopupMenu;
    lmiEditCut: TMenuItem;
    lmiEditCopy: TMenuItem;
    lmiEditPaste: TMenuItem;
    lmiEditDelete: TMenuItem;
    N1: TMenuItem;
    lmiEditSelectAll: TMenuItem;
    lmiEditUndo: TMenuItem;
    lmiEditRedo: TMenuItem;
    N2: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure SynEditorChange(Sender: TObject);
//    procedure SynEditorEnter(Sender: TObject);
//    procedure SynEditorExit(Sender: TObject);
//    procedure SynEditorReplaceText(Sender: TObject; const ASearch,
//      AReplace: String; Line, Column: Integer;
//      var Action: TSynReplaceAction);
//    procedure SynEditorStatusChange(Sender: TObject;
//      Changes: TSynStatusChanges);
    procedure FormCreate(Sender: TObject);
  private
    fEditor: TEditor;
    SynEditor : TenSynEdit ;
    fSearchFromCaret: boolean;
    procedure GetCoord(const Line, Column: Integer; var APos: TPoint;
      var EditRect: TRect);
  private                     
    function DoAskSaveChanges: boolean;
    procedure DoAssignInterfacePointer(AActive: boolean);
    function DoSave: boolean;
    function DoSaveFile: boolean;
    function DoSaveAs: boolean;
    procedure DoSearchReplaceText(AReplace: boolean; ABackwards: boolean);
    procedure DoUpdateCaption;
    procedure DoUpdateHighlighter;
    procedure ShowSearchReplaceDialog(AReplace: boolean);
  public
    procedure DoActivate;
    property EditorIntf: TEditor read fEditor ;
    constructor Create(AOwner :TComponent);override ;
  end;

  TEditor = class(TInterfacedObject, IEditor, IEditCommands, IFileCommands,
    ISearchCommands)
  private
    // IEditor implementation
    procedure Activate;
    function AskSaveChanges: boolean;
    procedure Close;
    function GetCaretPos: TPoint;
    function GetEditorState: string;
    function GetFileName: string;
    function GetFileTitle: string;
    function GetModified: boolean;
    procedure OpenFile(AFileName: string);
    // IEditCommands implementation
    function CanCopy: boolean;
    function CanCut: boolean;
    function IEditCommands.CanDelete = CanCut;
    function CanPaste: boolean;
    function CanRedo: boolean;
    function CanSelectAll: boolean;
    function CanUndo: boolean;
    procedure ExecCopy;
    procedure ExecCut;
    procedure ExecDelete;
    procedure ExecPaste;
    procedure ExecRedo;
    procedure ExecSelectAll;
    procedure ExecUndo;
    // IFileCommands implementation
    function CanClose: boolean;
    function CanPrint: boolean;
    function CanSave: boolean;
    function CanSaveAs: boolean;
    procedure IFileCommands.ExecClose = Close;
    procedure ExecPrint;
    procedure ExecSave;
    procedure ExecSaveAs;
    // ISearchCommands implementation
    function CanFind: boolean;
    function CanFindNext: boolean;
    function ISearchCommands.CanFindPrev = CanFindNext;
    function CanReplace: boolean;
    procedure ExecFind;
    procedure ExecFindNext;
    procedure ExecFindPrev;
    procedure ExecReplace;
  private
    fFileName: string;
    fForm: TEditorForm;
    fHasSelection: boolean;
    fIsEmpty: boolean;
    fIsReadOnly: boolean;
    fModified: boolean;
    fUntitledNumber: integer;
    constructor Create(AForm: TEditorForm);
    procedure DoSetFileName(AFileName: string);
    procedure SetFont(Font :TFont);overload ;
    procedure SetFont(FontName : String;FontSize :Integer);overload ;
    function  GetUntitledNumber : Integer ;
    function  GetStrings: TStrings ;
    procedure SetHasSelection (B : Boolean );
    procedure SetIsReadOnly (B : Boolean );
    procedure SetModified (B : Boolean );
  end;
const
  WM_DELETETHIS  =  WM_USER + 42;

type
  TEditorTabSheet = class(TTabSheet)
  private
    FForm : TEditorForm;
    procedure WMDeleteThis(var Msg: TMessage);
      message WM_DELETETHIS;
    function GetEditIntf: IEditor;
  public
    constructor Create (AOwner: TComponent);override;
    property LForm : TEditorForm read FForm ;
    property EditIntf : IEditor  read GetEditIntf ;
    procedure SetFont(FontName:string;FontSize : Integer );
    procedure OpenFile(AFilename:String);

  end;
{ TEditorFactory }

type
  TEditorFactory = class(TInterfacedObject, IEditorFactory)
  private
    fMRU : TadpMRU ;
    fMRUFolders : TadpMRU ;
    FEditorConf : IXMLEnEditorType ;
    FFont : TFont ;
    FPageControl : TPageControl ;
    FXMLDoc : TXMLDocument ;
    fEditors: TInterfaceList;
    fUntitledNumbers: TBits;
    mRecentFiles,mRecentFolders : TMenuItem ;
    function CanCloseAll: boolean;
    procedure CloseAll;
    function GetEditorCount: integer;
    function GetEditor(Index: integer): IEditor;
    procedure RemoveEditor(AEditor: IEditor);
    function GetUntitledNumber: integer;
    procedure ReleaseUntitledNumber(ANumber: integer);
    procedure InitMenu;
    procedure OnOpenMRUFile(Sender: TObject; const FileName: String);
    procedure OnOpenMRUFolders(Sender: TObject; const AFileName: String);
    //function GetSaveFileName(var ANewName: string;AHighlighter: TSynCustomHighlighter): boolean;
    function GetSaveFileName(var ANewName: string;DefaultFilters :String): boolean;
    procedure CloseEditor ;
    procedure SetFont(Font :TFont);overload;
    procedure AddMRU(Filename : String);
    procedure RemoveMRU(Filename : String);
    function GetMRU (I:Integer): String;
    procedure SetFont(FontName : String;FontSize :Integer);overload ;
    function GetFont:TFont;
    procedure DoOpenFile(AFileName: string);
    procedure AskEnable ;
    function GetEditConf :IXMLEnEditorType;
    procedure RunToolsConf ;
  public
    constructor Create (APageControl:TPageControl);
    destructor Destroy; override;
  end;
  
implementation

uses frmMain, dlgConfirmReplace,dlgSearchText,dlgReplaceText;

{$R *.DFM}



var
  gbSearchBackwards: boolean;
  gbSearchCaseSensitive: boolean;
  gbSearchFromCaret: boolean;
  gbSearchSelectionOnly: boolean;
  gbSearchTextAtCaret: boolean;
  gbSearchWholeWords: boolean;
  gbSearchRegexp: boolean;

  gsSearchText: string;
  gsSearchTextHistory: string;
  gsReplaceText: string;
  gsReplaceTextHistory: string;

resourcestring
  SInsert = 'Insert';
  SOverwrite = 'Overwrite';
  SReadOnly = 'Read Only';
  SNonameFileTitle = 'Untitled';
  SEditorCaption = 'Editor';

  SAskSaveChanges = 'The text in the "%s" file has changed.'#13#10#13#10 +
                    'Do you want to save the modifications?';

{ TEditor }

constructor TEditor.Create(AForm: TEditorForm);
begin
  Assert(AForm <> nil);
  inherited Create;
  fForm := AForm;
  fUntitledNumber := -1;
end;

procedure TEditor.Activate;
begin
  if fForm <> nil then
    fForm.DoActivate;
end;

function TEditor.AskSaveChanges: boolean;
begin
  if fForm <> nil then
    Result := fForm.DoAskSaveChanges
  else
    Result := TRUE;
end;

function TEditor.CanClose: boolean;
begin
  Result := fForm <> nil;
end;

procedure TEditor.Close;
var
  fUntitledNumber : Integer ;
  FileName :String;
begin
  if fForm <> nil then begin
    FileName := GetFileName ;
    if (FileName <> '') then
        GI_EditorFactory.AddMRU(FileName)
    else begin
      fUntitledNumber := GetUntitledNumber ;
      if fUntitledNumber <> -1 then
        GI_EditorFactory.ReleaseUntitledNumber(fUntitledNumber);
    end;
    fForm.Close;
  end;
end;

procedure TEditor.DoSetFileName(AFileName: string);
begin
  if AFileName <> fFileName then begin
    fFileName := AFileName;
    if fUntitledNumber <> -1 then begin
      GI_EditorFactory.ReleaseUntitledNumber(fUntitledNumber);
      fUntitledNumber := -1;
    end;
  end;
end;

function TEditor.GetCaretPos: TPoint;
begin
  if fForm <> nil then
    Result := TPoint(fForm.SynEditor.CaretXY)
  else
    Result := Point(-1, -1);
end;

function TEditor.GetEditorState: string;
begin
  if fForm <> nil then begin
    if fForm.SynEditor.ReadOnly then
      Result := SReadOnly
    else if fForm.SynEditor.InsertMode then
      Result := SInsert
    else
      Result := SOverwrite;
  end else
    Result := '';
end;

function TEditor.GetFileName: string;
begin
  Result := fFileName;
end;

function TEditor.GetFileTitle: string;
begin
  if fFileName <> '' then
    Result := ExtractFileName(fFileName)
  else begin
    Result := SNonameFileTitle + IntToStr(fUntitledNumber);
  end;
end;

function TEditor.GetModified: boolean;
begin
  if fForm <> nil then
    Result := fForm.SynEditor.Modified
  else
    Result := FALSE;
end;

procedure TEditor.OpenFile(AFileName: string);
begin

  fFileName := AFileName;
  if fForm <> nil then begin
    if (AFileName <> '') and FileExists(AFileName) then
      fForm.SynEditor.Lines.LoadFromFile(AFileName)
    else
      fForm.SynEditor.Lines.Clear;
    if fUntitledNumber = -1 then
      fUntitledNumber := GI_EditorFactory.GetUntitledNumber;
    fForm.DoUpdateCaption;
    fForm.DoUpdateHighlighter;
  end;
end;

// IEditCommands implementation

function TEditor.CanCopy: boolean;
begin
  Result := (fForm <> nil) and fHasSelection;
end;

function TEditor.CanCut: boolean;
begin
  Result := (fForm <> nil) and fHasSelection and not fIsReadOnly;
end;

function TEditor.CanPaste: boolean;
begin
  Result := (fForm <> nil) and fForm.SynEditor.CanPaste;
end;

function TEditor.CanRedo: boolean;
begin
  Result := (fForm <> nil) and fForm.SynEditor.CanRedo;
end;

function TEditor.CanSelectAll: boolean;
begin
  Result := fForm <> nil;
end;

function TEditor.CanUndo: boolean;
begin
  Result := (fForm <> nil) and fForm.SynEditor.CanUndo;
end;

procedure TEditor.ExecCopy;
begin
  if fForm <> nil then
    fForm.SynEditor.CopyToClipboard;
end;

procedure TEditor.ExecCut;
begin
  if fForm <> nil then
    fForm.SynEditor.CutToClipboard;
end;

procedure TEditor.ExecDelete;
begin
  if fForm <> nil then
    fForm.SynEditor.SelText := '';
end;

procedure TEditor.ExecPaste;
begin
  if fForm <> nil then
    fForm.SynEditor.PasteFromClipboard;
end;

procedure TEditor.ExecRedo;
begin
  if fForm <> nil then
    fForm.SynEditor.Redo;
end;

procedure TEditor.ExecSelectAll;
begin
  if fForm <> nil then
    fForm.SynEditor.SelectAll;
end;

procedure TEditor.ExecUndo;
begin
  if fForm <> nil then
    fForm.SynEditor.Undo;
end;

// IFileCommands implementation

function TEditor.CanPrint: boolean;
begin
  Result := FALSE;
end;

function TEditor.CanSave: boolean;
begin
  Result := (fForm <> nil) and (fModified or (fFileName = ''));
end;

function TEditor.CanSaveAs: boolean;
begin
  Result := fForm <> nil;
end;

procedure TEditor.ExecPrint;
begin
  if fForm <> nil then
// TODO
end;

procedure TEditor.ExecSave;
begin
  if fForm <> nil then begin
    if fFileName <> '' then
      fForm.DoSave
    else
      fForm.DoSaveAs
  end;
end;

procedure TEditor.ExecSaveAs;
begin
  if fForm <> nil then
    fForm.DoSaveAs;
end;

// ISearchCommands implementation

function TEditor.CanFind: boolean;
begin
  Result := (fForm <> nil) and not fIsEmpty;
end;

function TEditor.CanFindNext: boolean;
begin
  Result := (fForm <> nil) and not fIsEmpty and (gsSearchText <> '');
end;

function TEditor.CanReplace: boolean;
begin
  Result := (fForm <> nil) and not fIsReadOnly and not fIsEmpty;
end;

procedure TEditor.ExecFind;
begin
  if fForm <> nil then
    fForm.ShowSearchReplaceDialog(FALSE);
end;

procedure TEditor.ExecFindNext;
begin
  if fForm <> nil then
    fForm.DoSearchReplaceText(FALSE, FALSE);
end;

procedure TEditor.ExecFindPrev;
begin
  if fForm <> nil then
    fForm.DoSearchReplaceText(FALSE, TRUE);
end;

procedure TEditor.ExecReplace;
begin
  if fForm <> nil then
    fForm.ShowSearchReplaceDialog(TRUE);
end;

procedure TEditor.SetFont(Font: TFont);
begin
  fForm.SynEditor.Font.Assign(Font);
end;

procedure TEditorFactory.SetFont(FontName: String; FontSize: Integer);
var
  Font : TFont ;
begin
  Font := TFont.Create ;
  try
    Font.Name := FontName ;
    Font.Size := FontSize ;
    SetFont(Font);
  finally
    Font.Free ;
  end;
end;

procedure TEditor.SetFont(FontName: String; FontSize: Integer);
var
  Font : TFont ;
begin
  Font := TFont.Create ;
  try
    Font.Name := FontName ;
    Font.Size := FontSize ;
    SetFont(Font);
  finally
    Font.Free ;
  end;
end;

function TEditor.GetUntitledNumber: Integer;
begin
  Result := Self.fUntitledNumber ;
end;

function TEditor.GetStrings: TStrings;
begin
  Result := Self.fForm.SynEditor.Lines ;
end;

procedure TEditor.SetHasSelection(B: Boolean);
begin
  fHasSelection := B ;
end;

procedure TEditor.SetIsReadOnly(B: Boolean);
begin
  fIsReadOnly := B ;
end;

procedure TEditor.SetModified(B: Boolean);
begin
  fModified := B ;
end;

{ TEditorTabSheet }


constructor TEditorTabSheet.Create(AOwner: TComponent);
begin
  inherited;
  PageControl := TPageControl(AOwner);
  FForm := TEditorForm.Create(Self);
  PageControl.ActivePage := Self;
  GI_ActiveEditor := EditIntf ;
end;

function TEditorTabSheet.GetEditIntf: IEditor;
begin
  Result := LForm.fEditor;
end;

procedure TEditorTabSheet.OpenFile(AFilename: String);
begin
  EditIntf.OpenFile(AFileName);
end;

procedure TEditorTabSheet.SetFont(FontName: string; FontSize: Integer);
begin
  EditIntf.SetFont(FontName,FontSize);
end;

procedure TEditorTabSheet.WMDeleteThis(var Msg: TMessage);
begin
  Free;
end;


const
  ConfFile = 'enEditorConf.xml';
procedure TEditorFactory.OnOpenMRUFile(Sender: TObject; const FileName: String);
var
  i: integer;
  s: string;
begin
  GI_EditorFactory.DoOpenFile(FileName);
end;

procedure TEditorFactory.OnOpenMRUFolders(Sender: TObject; const AFileName: String);
var
  i: integer;
  s: string;
  dlgFileOpen : TOpenDialog ;
begin
  dlgFileOpen := TOpenDialog.Create(nil) ;
  with dlgFileOpen do
  try
    InitialDir := AFileName ;
    Options := Options + [ofAllowMultiSelect];
    if Execute then
      for I := 0 to Files.Count -1 do
        GI_EditorFactory.DoOpenFile(Files.Strings[I]);
  finally
    dlgFileOpen.Free ;
  end;
end;
constructor TEditorFactory.Create (APageControl:TPageControl);
begin
  inherited Create ;
  Self.FPageControl := APageControl ;
  fEditors := TInterfaceList.Create;
  fMRU := TadpMRU.Create(nil) ;
//  fMRU.ParentMenuItem := mRecentFiles ;
  fMRu.OnClick := OnOpenMRUFile ;
  fMRU.RegistryPath:='\software\lcjun\enEditor\mru';

  fMRUFolders := TadpMRU.Create(nil) ;
//  fMRUFolders.ParentMenuItem := mRecentFolders ;
  fMRUFolders.OnClick := OnOpenMRUFolders ;
  fMRUFolders.RegistryPath:='\software\lcjun\enEditor\mruFolders';
  InitMenu ;
  FXMLDoc := TXMLDocument.Create(nil);
  FXMLDoc.Options := FXMLDoc.Options + [doAutoSave];
  // Must be a absolute directory ,otherwise will report
  // error when Shell click a text file !
  FXMLDoc.FileName := ExtractFilePath(ParamStr(0))+ ConfFile;
  FXMLDoc.Active := True ;
  //FEditorConf := LoadenEditor(ConfFile);
  FEditorConf := GetenEditor (FXMLDoc);
  FFont := TFont.Create ;
  FFont.Name := FEditorConf.Font.Name ;
  FFont.Size := FEditorConf.Font.Size ;
  //FEditorConf.Tools.Tool[0].Title
  HLs := THLs.Create;

end;
//function TEditorFactory.GetSaveFileName(var ANewName: string;
//  AHighlighter: TSynCustomHighlighter): boolean;
function TEditorFactory.GetSaveFileName(var ANewName: string;DefaultFilters :String): boolean;
var
   dlgFileSave :TSaveDialog ;
begin
  dlgFileSave :=TSaveDialog.Create(nil);
  dlgFileSave.Filter :=  HLs.GetFilters ;
  with dlgFileSave do
  try
    if ANewName <> '' then begin
      InitialDir := ExtractFileDir(ANewName);
      FileName := ExtractFileName(ANewName);
    end else begin
      InitialDir := '';
      FileName := '';
    end;
    //if AHighlighter <> nil then
    if DefaultFilters <> '' then
      Filter := DefaultFilters
    else
      Filter := HLs.GetFilters;
    if Execute then begin
      ANewName := FileName;
      Result := TRUE;
    end else
      Result := FALSE;
  finally
    dlgFileSave.Free ;
  end;
end;
procedure TEditorFactory.InitMenu;
var
  mTools,mHelp,mFile,mView,mEdit,mi : TMenuItem ;
  acFile ,ac: TAction ;
  MainMenu : TMainMenu ;
begin 
  acFile := TacFile.Create(MainForm) ;
  MainMenu := TMainMenu.Create(MainForm) ;
  mFile := TMenuItem.Create(MainMenu) ;
  // File Menu
  mFile.Action := acFile ;
  MainMenu.Items.add(mFile);
  // New
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action := TacFileNew.Create(MainForm) ;
  // Open
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action := TacFileOpen.Create(MainForm) ;
  // Recent Files
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action :=  TacFileRecentFiles.Create(MainForm) ;
  fMRU.ParentMenuItem := mi ;
  // Recent Folders
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action := TacFileRecentFolders.Create(MainForm) ;
  fMRUFolders.ParentMenuItem := mi ;
  // -
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Caption := '-';
  // Save
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action := TacFileSave.Create(MainForm) ;
  // Save as
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action := TacFileSaveAs.Create(MainForm) ;
  // Close
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action := TacFileClose.Create(MainForm) ;
  // Close All
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action := TacFileCloseAll.Create(MainForm) ;
  // -
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Caption := '-';
  // Print
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action := TacFilePrint.Create(MainForm) ;
  // -
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Caption := '-';
  // Exit
  mi := TMenuItem.Create(MainMenu) ;
  mFile.add(mi);
  mi.Action := TacFileExit.Create(MainForm) ;
  // Edit Menu
  mEdit := TMenuItem.Create(MainMenu) ;
  mEdit.Caption := 'Edit';
  MainMenu.Items.add(mEdit);
  // Undo
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditUndo.Create(MainForm) ;
  // Redo
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditRedo.Create(MainForm) ;
  // -
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Caption :='-' ;
  // Cut
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditCut.Create(MainForm) ;
  // Copy
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditCopy.Create(MainForm) ;
  // Paste
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditPaste.Create(MainForm) ;
  // Delete
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditDelete.Create(MainForm) ;
  // Select all
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditSelectAll.Create(MainForm) ;
  // -
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Caption := '-' ;
  // Find
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditFind.Create(MainForm) ;
  // Findnext
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditFindNext.Create(MainForm) ;
  // Find Prev
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditFindPrevious.Create(MainForm) ;
  // Replace
  mi := TMenuItem.Create(MainMenu) ;
  mEdit.add(mi);
  mi.Action := TacEditReplace.Create(MainForm) ;
  // View Menu
  mView := TMenuItem.Create(MainMenu) ;
  mView.Caption := 'View';
  MainMenu.Items.add(mView);
  // Font
  mi := TMenuItem.Create(MainMenu) ;
  mView.add(mi);
  mi.Action := TacViewFont.Create(MainForm) ;
  // StatusBar
  mi := TMenuItem.Create(MainMenu) ;
  mView.add(mi);
  mi.Action := TacViewStatusBar.Create(MainForm) ;
  // Associate MainMenu
  // Tools
  mTools := TMenuItem.Create(MainMenu) ;
  mTools.Caption := 'Tools';
  MainMenu.Items.add(mTools);
  // Custom
  mi := TMenuItem.Create(MainMenu) ;
  mTools.add(mi);
  mi.Action := TacToolsConf.Create(MainForm) ;
  // TextFormattor
  mi := TMenuItem.Create(MainMenu) ;
  mTools.add(mi);
  mi.Action := TacToolsTextFormattor.Create(MainForm) ;
  // Help
  mHelp := TMenuItem.Create(MainMenu) ;
  mHelp.Action := TacOnlyUpdate.Create(MainForm) ;
  MainMenu.Items.add(mHelp);
  MainForm.Menu := MainMenu ;


end;
destructor TEditorFactory.Destroy;
begin
//  Because FXMLDoc cast to a IXMLDocument ,so here must not be released 
//  FXMLDoc.Free;
  FFont.Free ;
  fMRU.free ;
  fMRUFolders.Free ;
  fEditors.Free;
  inherited Destroy;
end;

function TEditorFactory.CanCloseAll: boolean;
var
  i: integer;
  LEditor: IEditor;
begin
  i := fEditors.Count - 1;
  while i >= 0 do begin
    LEditor := IEditor(fEditors[i]);
    if not LEditor.AskSaveChanges then begin
      Result := FALSE;
      exit;
    end;
    Dec(i);
  end;
  Result := TRUE;
end;

procedure TEditorFactory.CloseAll;
var
  i: integer;
begin
  i := fEditors.Count - 1;
  while i >= 0 do begin
    IEditor(fEditors[i]).Close;
    Dec(i);
  end;
end;




function TEditorFactory.GetEditorCount: integer;
begin
  Result := fEditors.Count;
end;

function TEditorFactory.GetEditor(Index: integer): IEditor;
begin
  Result := IEditor(fEditors[Index]);
end;

procedure TEditorFactory.RemoveEditor(AEditor: IEditor);
var
  i: integer;
begin
  i := fEditors.IndexOf(AEditor);
  if i > -1 then
    fEditors.Delete(i);
end;

{ TEditorForm }

procedure TEditorForm.FormActivate(Sender: TObject);
begin
  DoAssignInterfacePointer(TRUE);
end;

procedure TEditorForm.FormDeactivate(Sender: TObject);
begin
  DoAssignInterfacePointer(FALSE);
end;

procedure TEditorForm.FormShow(Sender: TObject);
begin
  DoUpdateCaption;
end;

procedure TEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SendMessage(Parent.Handle, WM_DELETETHIS, 0, 0);
  Action := caNone;
end;

procedure TEditorForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // need to prevent this from happening more than once (e.g. with MDI childs)
  if not (csDestroying in ComponentState) then
    CanClose := DoAskSaveChanges;
end;

procedure TEditorForm.FormDestroy(Sender: TObject);
var
  LEditor: IEditor;
begin
  LEditor := fEditor;
  Assert(fEditor <> nil);
  fEditor.fForm := nil;
  Assert(GI_EditorFactory <> nil);
  GI_EditorFactory.RemoveEditor(LEditor);
end;

procedure TEditorForm.SynEditorChange(Sender: TObject);
var
  Empty: boolean;
  i: integer;
begin
  Assert(fEditor <> nil);
  fEditor.fIsEmpty := SynEditor.IsEmpty ;
  DoUpdateCaption ;
end;

//procedure TEditorForm.SynEditorEnter(Sender: TObject);
//begin
//  DoAssignInterfacePointer(TRUE);
//end;
//
//procedure TEditorForm.SynEditorExit(Sender: TObject);
//begin
//  DoAssignInterfacePointer(FALSE);
//end;

procedure TEditorForm.GetCoord(const Line, Column: Integer;var APos: TPoint;var EditRect: TRect);
begin
  APos := SynEditor.GetScreenPos(Column, Line);
  EditRect := ClientRect;
  EditRect.TopLeft := ClientToScreen(EditRect.TopLeft);
  EditRect.BottomRight := ClientToScreen(EditRect.BottomRight);
end;
{
procedure TEditorForm.SynEditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  Assert(fEditor <> nil);
  if Changes * [scAll, scSelection] <> [] then
    fEditor.fHasSelection := SynEditor.SelAvail;
  if Changes * [scAll, scSelection] <> [] then
    fEditor.fIsReadOnly := SynEditor.ReadOnly;
  if Changes * [scAll, scModified] <> [] then
    fEditor.fModified := SynEditor.Modified;
end;
}
procedure TEditorForm.DoActivate;
var
  Sheet: TTabSheet;
  PCtrl: TPageControl;
begin
  if FormStyle = fsMDIChild then
    BringToFront
  else if Parent is TTabSheet then begin
    Sheet := TTabSheet(Parent);
    PCtrl := Sheet.PageControl;
    if PCtrl <> nil then
      PCtrl.ActivePage := Sheet;
    // 我认为这里不应该SetFocus  
    //SetFocus;
  end;
end;

function TEditorForm.DoAskSaveChanges: boolean;
const
  MBType = MB_YESNOCANCEL or MB_ICONQUESTION;
var
  s: string;
begin
  // this is necessary to prevent second confirmation when closing MDI childs
  if SynEditor.Modified then begin
    DoActivate;
    MessageBeep(MB_ICONQUESTION);
    Assert(fEditor <> nil);
    s := Format(SAskSaveChanges, [ExtractFileName(fEditor.GetFileTitle)]);
    case Application.MessageBox(PChar(s), PChar(Application.Title), MBType) of
      IDYes: Result := DoSave;
      IDNo: Result := TRUE;
    else
      Result := FALSE;
    end;
  end else
    Result := TRUE;
end;

procedure TEditorForm.DoAssignInterfacePointer(AActive: boolean);
begin
  if AActive then begin
    GI_ActiveEditor := fEditor;
    GI_EditCmds := fEditor;
    GI_FileCmds := fEditor;
    GI_SearchCmds := fEditor;
  end else begin
    if GI_ActiveEditor = IEditor(fEditor) then
      GI_ActiveEditor := nil;
    if GI_EditCmds = IEditCommands(fEditor) then
      GI_EditCmds := nil;
    if GI_FileCmds = IFileCommands(fEditor) then
      GI_FileCmds := nil;
    if GI_SearchCmds = ISearchCommands(fEditor) then
      GI_SearchCmds := nil;
  end;
end;

function TEditorForm.DoSave: boolean;
begin
  Assert(fEditor <> nil);
  if fEditor.fFileName <> '' then
    Result := DoSaveFile
  else
    Result := DoSaveAs;
end;

function TEditorForm.DoSaveFile: boolean;
begin
  Assert(fEditor <> nil);
  try
    SynEditor.Lines.SaveToFile(fEditor.fFileName);
    SynEditor.Modified := FALSE;
    Result := TRUE;
    DoUpdateCaption;
  except
    Application.HandleException(Self);
    Result := FALSE;
  end;
end;

function TEditorForm.DoSaveAs: boolean;
var
  NewName: string;
begin
  Assert(fEditor <> nil);
  NewName := fEditor.fFileName;
  if GI_EditorFactory.GetSaveFileName(NewName, SynEditor.DefaultFilter) then
  begin
    fEditor.DoSetFileName(NewName);
    DoUpdateCaption;
    DoUpdateHighlighter;
    Result := DoSaveFile;
  end else
    Result := FALSE;
end;

procedure TEditorForm.DoSearchReplaceText(AReplace: boolean;
  ABackwards: boolean);
begin
  if  0 = SynEditor.DoSearchReplace (
      gsSearchText, gsReplaceText,
      AReplace,ABackwards,
      gbSearchCaseSensitive,
      fSearchFromCaret,gbSearchSelectionOnly,
      gbSearchWholeWords,gbSearchRegexp) then
  begin
    MessageBeep(MB_ICONASTERISK);
    if ABackwards then
    // 等效 ：
    //if ssoBackwards in Options then
      SynEditor.BlockEnd := SynEditor.BlockBegin
    else
      SynEditor.BlockBegin := SynEditor.BlockEnd;
    SynEditor.CaretXY := SynEditor.BlockBegin;
  end;

  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

procedure TEditorForm.DoUpdateCaption;
begin
   Assert(fEditor <> nil);
   if fEditor.GetModified then
     (Parent as TTabSheet).Caption := '*'+fEditor.GetFileTitle
   else
     (Parent as TTabSheet).Caption := fEditor.GetFileTitle;
end;

procedure TEditorForm.DoUpdateHighlighter;
begin
  Assert(fEditor <> nil);
  if fEditor.fFileName <> '' then begin
    SynEditor.Highlighter := HLs.GetHighlighterForFile(
      fEditor.fFileName);
  end else
    SynEditor.Highlighter := nil;
end;

procedure TEditorForm.ShowSearchReplaceDialog(AReplace: boolean);
var
  dlg: TTextSearchDialog;
begin
  if AReplace then
    dlg := TTextReplaceDialog.Create(Self)
  else
    dlg := TTextSearchDialog.Create(Self);
  with dlg do try
    // assign search options
    SearchBackwards := gbSearchBackwards;
    SearchCaseSensitive := gbSearchCaseSensitive;
    SearchFromCursor := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    SearchRegularExpression := gbSearchRegexp ;
    // start with last search text
    SearchText := gsSearchText;
    if gbSearchTextAtCaret then begin
      // if something is selected search for that text
      if SynEditor.SelAvail and (SynEditor.BlockBegin.Line = SynEditor.BlockEnd.Line)
      then
        SearchText := SynEditor.SelText
      else
        SearchText := SynEditor.GetWordAtRowCol(SynEditor.CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    if AReplace then with dlg as TTextReplaceDialog do begin
      ReplaceText := gsReplaceText;
      ReplaceTextHistory := gsReplaceTextHistory;
    end;
    SearchWholeWords := gbSearchWholeWords;
    if ShowModal = mrOK then begin
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gsSearchText := SearchText;
      gsSearchTextHistory := SearchTextHistory;
      gbSearchRegexp := SearchRegularExpression ;
      if AReplace then with dlg as TTextReplaceDialog do begin
        gsReplaceText := ReplaceText;
        gsReplaceTextHistory := ReplaceTextHistory;
      end;
      fSearchFromCaret := gbSearchFromCaret;
      if gsSearchText <> '' then begin
        DoSearchReplaceText(AReplace, gbSearchBackwards);
        fSearchFromCaret := TRUE;
      end;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TEditorFactory.CloseEditor ;
var
  fUntitledNumber,i : Integer;
  FileName : String;
begin
  I := fEditors.IndexOf(GI_ActiveEditor);
  Assert(I > -1 );
  GI_ActiveEditor.Close;
  if I > 0 then
    GI_ActiveEditor := GetEditor(I -1 )
  else if I < GetEditorCount then
    GI_ActiveEditor := GetEditor(I);
  if  GI_ActiveEditor <> nil then
    GI_ActiveEditor.Activate
  else
    MainForm.Close ;
end;



procedure TEditorFactory.SetFont(Font: TFont);
var
 i : Integer ;
 Editor : IEditor ;
begin
  for I := 0 to GetEditorCount -1 do begin
    Editor := GetEditor(I) ;
    Editor.SetFont(Font);
  end;
  FEditorConf.Font.Name := Font.Name ;
  FEditorConf.Font.Size := Font.Size  ;
  FEditorConf.OwnerDocument.SaveToFile (ConfFile);
end;

procedure TEditorFactory.AddMRU(Filename: String);
begin
  fMRU.AddItem(FileName);
  fMRUFolders.AddItem(ExtractFilePath(FileName));
end;



procedure TEditorFactory.RemoveMRU(Filename: String);
begin
  fMRU.RemoveItem(FileName);
end;

function TEditorFactory.GetMRU (I:Integer): String;
begin
  Result := fMRU.GetItem(I);
end;

function TEditorFactory.GetFont: TFont;
begin
  Result := FFont ;
end;

procedure TEditorFactory.DoOpenFile(AFileName: string);
var
  i : integer ;
  Editor,ResultEditor : IEditor ;
  Sheet: TEditorTabSheet;
begin
  Assert(GI_EditorFactory <> nil);
  AFileName := ExpandFileName(AFileName);
  if AFileName <> '' then
    RemoveMRU(AFileName);
  if AFileName <>'' then begin
    for i := GetEditorCount - 1 downto 0 do begin
      Editor := GetEditor(i);
      if CompareText(Editor.GetFileName, AFileName) = 0 then begin
        ResultEditor := Editor ;
        Break ;
      end;
    end;
  end;
  if not Assigned(ResultEditor) then begin
      Sheet := TEditorTabSheet.Create(FPageControl);
      ResultEditor := Sheet.EditIntf ;
      Sheet.SetFont(FEditorConf.Font.Name,FEditorConf.Font.Size);
      Sheet.OpenFile(AFileName);
      Assert(ResultEditor <> nil );
      fEditors.Add(ResultEditor);
  end;
  ResultEditor.Activate ;
end;

function TEditorFactory.GetUntitledNumber: integer;
begin
  if fUntitledNumbers = nil then
    fUntitledNumbers := TBits.Create;
  Result := fUntitledNumbers.OpenBit;
  if Result = fUntitledNumbers.Size then
    fUntitledNumbers.Size := fUntitledNumbers.Size + 32;
  fUntitledNumbers[Result] := TRUE;
  Inc(Result);
end;

procedure TEditorFactory.ReleaseUntitledNumber(ANumber: integer);
begin
  Dec(ANumber);
  if (fUntitledNumbers <> nil) and (ANumber >= 0)
    and (ANumber < fUntitledNumbers.Size)
  then
    fUntitledNumbers[ANumber] := FALSE;
end;



procedure TEditorFactory.AskEnable;
begin
  fMRU.AskEnable ;
  fMRUFolders.AskEnable ;
end;

function TEditorFactory.GetEditConf: IXMLEnEditorType;
begin
  Result := Self.FEditorConf ;
end;

procedure TEditorFactory.RunToolsConf;
begin
  RunTools(Self.FEditorConf);
end;

procedure TEditorForm.FormCreate(Sender: TObject);
begin
  SynEditor := TenSynEdit.Create(self);
  SynEditor.OnAssignInterface := DoAssignInterfacePointer ;
  SynEditor.OnChange :=  SynEditorChange ;
  SynEditor.OnCalcCoord := GetCoord;
  SynEditor.PopupMenu := Self.pmnuEditor ;
end;

constructor TEditorForm.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := bsNone;
  Parent := TEditorTabSheet(AOwner);
  Align := alClient;
  Visible := TRUE;
  fEditor := TEditor.Create(Self);
end;

end.

