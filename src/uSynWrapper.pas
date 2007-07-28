unit uSynWrapper;

interface
uses
  Forms,SynEdit,classes,SynEditSearch,SynEditRegexSearch,Dialogs,
  Controls,uEditAppIntfs,ComCtrls,Types,SynEditHighlighter,SynEditTypes,dlgConfirmReplace;
type
  TGetCoord = procedure (const Line, Column: Integer;var APos: TPoint;var EditRect: TRect) of object ;
  TDoAssignInterfacePointer = procedure (AActive: boolean) of object;
type
   TenSynEdit = class(TSynEdit)
  private
    FUseRegexp: Boolean;
    FSearch: TSynEditSearch;
    FRegExpSearch : TSynEditRegexSearch;
    FOnCalcCoord: TGetCoord;
    FOnAssignInterfacePointer: TDoAssignInterfacePointer;
    FIsEmpty: Boolean;
    procedure DoDropFiles(Sender: TObject; X, Y: integer; AFiles: TStrings);
    procedure SetUseRegexp(const Value: Boolean);
    function GetDefaultFilter: string;
    procedure SetOnCalcCoord(const Value: TGetCoord);
    procedure SynEditorStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure SynEditorReplaceText(Sender: TObject; const ASearch,
      AReplace: String; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure SetOnAssignInterfacePointer(
      const Value: TDoAssignInterfacePointer);
    function GetIsEmpty: Boolean;
    procedure SetIsEmpty(const Value: Boolean);
   public
    procedure SynEditorEnter(Sender: TObject);
    procedure SynEditorExit(Sender: TObject);
     constructor Create(AOwner: TComponent); override;
     destructor Destroy ;override ;
     property UseRegexp : Boolean  read FUseRegexp write SetUseRegexp;
     function GetHLFilter :String ;
     function GetScreenPos(const Column, Line:Integer): TPoint;
     function DoSearchReplace(const ASearchText, AReplaceText:String ;
      AReplace,ABackwards,gbSearchCaseSensitive,
      fSearchFromCaret,gbSearchSelectionOnly,
      gbSearchWholeWords,gbSearchRegexp:Boolean):Integer;
     property  DefaultFilter:string  read GetDefaultFilter;
     property OnCalcCoord : TGetCoord  read FOnCalcCoord write SetOnCalcCoord;
     property OnAssignInterface : TDoAssignInterfacePointer  read FOnAssignInterfacePointer write SetOnAssignInterfacePointer;
     property IsEmpty :Boolean  read GetIsEmpty ;
   end;

implementation

function TenSynEdit.GetScreenPos(const Column, Line:Integer): TPoint;
begin
  Result := ClientToScreen(
      RowColumnToPixels(
        BufferToDisplayPos(
          BufferCoord(Column, Line) ) ) );
end;

constructor TenSynEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TWinControl(AOwner) ;
  //TWinControl(AOwner).InsertControl(Self);
  Self.Align := alClient ;
  FSearch:= TSynEditSearch.Create(Self);
  FRegExpSearch:= TSynEditRegexSearch.Create(Self);
  // 2007-6-29
  // 下面这句话可以编译的，当然最后并没有创建对象。花费了一个晚上的时间，因为SynEdit报错 AV ，被牵着走了很久】
  // FRegExpSearch:= TSynEditRegexSearch(nil);
  SearchEngine := FSearch;
  //  SynEditor.OnStatusChange := SynEditor.SynEditorStatusChange;
  OnReplaceText :=  SynEditorReplaceText;
  OnStatusChange := SynEditorStatusChange;
  OnEnter :=  SynEditorEnter ;
  OnExit :=  SynEditorExit ;
  OnDropFiles := DoDropFiles ;
  Options := Options +[eoTabIndent,eoDropFiles];
  WantTabs := True;
end;

destructor TenSynEdit.Destroy;
begin
  // 解决：Alt+F4退出时会报AV错误。
  FOnAssignInterfacePointer (False);
  // end 解决
  FSearch.Free ;
  FRegExpSearch.Free ;
  inherited;
end;

function TenSynEdit.GetHLFilter: String;
begin
  if Assigned(Highlighter) then
    Result := Highlighter.DefaultFilter 
  else
    Result := '';
end;

procedure TenSynEdit.SetUseRegexp(const Value: Boolean);
begin
  FUseRegexp := Value;
  if Value then
    SearchEngine := FRegExpSearch
  else
    SearchEngine := FSearch;
end;

function TenSynEdit.DoSearchReplace(const ASearchText,
  AReplaceText: String; AReplace, ABackwards, gbSearchCaseSensitive,
  fSearchFromCaret, gbSearchSelectionOnly, gbSearchWholeWords,
  gbSearchRegexp: Boolean): Integer;
var
  Options: TSynSearchOptions;  
begin
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if not fSearchFromCaret then
    Include(Options, ssoEntireScope);
  if gbSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then
    Include(Options, ssoWholeWord);
  UseRegexp := gbSearchRegexp ;
  Result := SearchReplace(ASearchText, AReplaceText, Options) ;
end;

function TenSynEdit.GetDefaultFilter: string;
begin
  if Assigned(Highlighter) then
    Result := Highlighter.DefaultFilter
  else
    Result := '' ;
end;

procedure TenSynEdit.SetOnCalcCoord(const Value: TGetCoord);
begin
  FOnCalcCoord := Value;
end;
procedure TenSynEdit.SynEditorReplaceText(Sender: TObject; const ASearch,
  AReplace: String; Line, Column: Integer; var Action: TSynReplaceAction);
var
  APos: TPoint;
  EditRect: TRect;
begin
  if ASearch = AReplace then
    Action := raSkip
  else begin
    FOnCalcCoord(Line, Column,APos,EditRect);
    if ConfirmReplaceDialog = nil then
      ConfirmReplaceDialog := TConfirmReplaceDialog.Create(Application);
    ConfirmReplaceDialog.PrepareShow(EditRect, APos.X, APos.Y,
      APos.Y + LineHeight, ASearch);
    case ConfirmReplaceDialog.ShowModal of
      mrYes: Action := raReplace;
      mrYesToAll: Action := raReplaceAll;
      mrNo: Action := raSkip;
      else Action := raCancel;
    end;
  end;
end;
procedure TenSynEdit.SynEditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
var
  fEditor : IEditor ;
begin    
  fEditor := GI_ActiveEditor ;
  Assert(fEditor <> nil);
  if Changes * [scAll, scSelection] <> [] then
    fEditor.SetHasSelection( SelAvail);
  if Changes * [scAll, scSelection] <> [] then
    fEditor.SetIsReadOnly(ReadOnly);
  if Changes * [scAll, scModified] <> [] then
    fEditor.SetModified (Modified);
end;

procedure TenSynEdit.SetOnAssignInterfacePointer(
  const Value: TDoAssignInterfacePointer);
begin
  FOnAssignInterfacePointer := Value;
end;
procedure TenSynEdit.SynEditorEnter(Sender: TObject);
begin
  FOnAssignInterfacePointer(TRUE);
end;

procedure TenSynEdit.SynEditorExit(Sender: TObject);
begin
  FOnAssignInterfacePointer(FALSE);
end;

procedure TenSynEdit.SetIsEmpty(const Value: Boolean);
begin
  FIsEmpty := Value;
end;

function TenSynEdit.GetIsEmpty: Boolean;
var
  i : Integer ;
begin
  Result := TRUE;
  for i := Lines.Count - 1 downto 0 do
    if Lines[i] <> '' then begin
      Result := FALSE;
      break;
    end;
end;

procedure TenSynEdit.DoDropFiles(Sender: TObject; X, Y: integer;
  AFiles: TStrings);
var
  i : Integer ;
begin
   for i := 0 to AFiles.Count -1 do
    GI_EditorFactory.DoOpenFile(AFiles.Strings[I]);
end;

end.
