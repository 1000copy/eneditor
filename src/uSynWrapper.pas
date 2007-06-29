unit uSynWrapper;

interface
uses
  SynEdit,classes,SynEditSearch,SynEditRegexSearch,
  Controls,uEditAppIntfs,ComCtrls;
type
   TenSynEdit = class(TSynEdit)
  private
    FUseRegexp: Boolean;
    FSearch: TSynEditSearch;
    FRegExpSearch : TSynEditRegexSearch;
    procedure SetUseRegexp(const Value: Boolean);
   public
     constructor Create(AOwner: TComponent); override;
     destructor Destroy ;override ;
     property UseRegexp : Boolean  read FUseRegexp write SetUseRegexp;
     function GetHLFilter :String ;
   end;

implementation

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
end;

destructor TenSynEdit.Destroy;
begin
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

end.
