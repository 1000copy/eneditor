unit uConfig;

interface
uses XMLDoc ,XMLIntf,
    classes,SysUtils
    ,enEditorConf,Windows;
type
  TenFont = class
  private
    FSize: Integer;
    FName: String;
    procedure SetName(const Value: String);
    procedure SetSize(const Value: Integer);
  published
    property Name :String  read FName write SetName;
    property Size: Integer read FSize write SetSize;
  end;
  TenTool = class
  private
    FArgument: String;
    FTitle: String;
    FInitDir: String;
    FCmd: String;
    FExt: String;
    procedure SetArgument(const Value: String);
    procedure SetCmd(const Value: String);
    procedure SetInitDir(const Value: String);
    procedure SetTitle(const Value: String);
    procedure SetExt(const Value: String);
  published
    property Title :String  read FTitle write SetTitle;
    property Cmd :String  read FCmd write SetCmd;
    property Argument :String  read FArgument write SetArgument;
    property InitDir :String  read FInitDir write SetInitDir;
    property Ext :String   read FExt write SetExt;
    function RunTool :Boolean;
  end;

  TenToolList = class(TList)
    function GetByIndex(I:Integer):TenTool ;
    procedure RunTool ;
  end;
  TenConfig =class
  private
    FFont: TenFont;
    FTools: TenToolList;
    FFilename: string;
    procedure SetFont(const Value: TenFont);
    procedure SetTools(const Value: TenToolList);
    procedure SetFilename(const Value: string);
  public
    property Font : TenFont  read FFont write SetFont;
    property  Tools : TenToolList read FTools write SetTools;
    property  Filename : string  read FFilename write SetFilename;
    procedure Open ;virtual ;abstract ;
    procedure Save ;virtual ;abstract ;
  end;
  TenXMLConfig =class (TenConfig)
  private
    FXMLDoc : TXMLDocument ;
    FXmlEnConfig : IXMLEnEditorType ;
  public
    constructor Create;reintroduce ;
    destructor Destroy; override; 
    procedure Open ;override ;
    procedure Save ;override ;
  end;

  TenConfigFactory =class
  public
    class function MakeInstance(FileName : string) : TenConfig ;
  end;
  

implementation

{ TenToolList }
uses uEditAppIntfs;
function TenToolList.GetByIndex(I: Integer): TenTool;
begin
  Result := TenTool(Get(I));
end;

function TenTool.RunTool :Boolean;
var
  argu ,a : String ;
  sl : TStringList ;
  ext : string ;
begin
  sl := TStringList.Create ;
  try
    ext := ExtractFileExt(GI_ActiveEditor.GetFileName) ;
    if FExt[1] <> '.' then
      Result := SameText(ext, '.'+FExt)
    else
      Result := SameText(ext, FExt);
    if Result then begin
      argu :=  StringReplace(FArgument,'$FileName$',GI_ActiveEditor.GetFileName +' ',[rfReplaceAll, rfIgnoreCase]);
      a := Cmd + ' ' +argu ;
      sl.Add(a);
      sl.Add('Pause');
      sl.SaveToFile('a.bat');
      WinExec('a.bat',1) ;
    end;
  finally
    sl.Free ;
    //DeleteFile('a.bat');
  end;
end;
procedure TenToolList.RunTool;
var
  i : Integer ;
begin
  for i := 0 to self.Count - 1 do
    if GetByIndex(i).RunTool then
      Break ;
end;

{ TenConfig }


procedure TenConfig.SetFilename(const Value: string);
begin
  FFilename := Value;
end;

procedure TenConfig.SetFont(const Value: TenFont);
begin
  FFont := Value;
end;

procedure TenConfig.SetTools(const Value: TenToolList);
begin
  FTools := Value;
end;

{ TenFont }

procedure TenFont.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TenFont.SetSize(const Value: Integer);
begin
  FSize := Value;
end;

{ TenTool }


procedure TenTool.SetArgument(const Value: String);
begin
  FArgument := Value;
end;

procedure TenTool.SetCmd(const Value: String);
begin
  FCmd := Value;
end;

procedure TenTool.SetExt(const Value: String);
begin
  FExt := Value;
end;

procedure TenTool.SetInitDir(const Value: String);
begin
  FInitDir := Value;
end;

procedure TenTool.SetTitle(const Value: String);
begin
  FTitle := Value;
end;

{ TenXMLConfig }

constructor TenXMLConfig.Create;
begin
  FXMLDoc := TXMLDocument.Create(nil);
  FXMLDoc.Options := FXMLDoc.Options + [doAutoSave];
  // Must be a absolute directory ,otherwise will report
  // error when Shell click a text file !
  FFont:= TenFont.Create;
  FTools :=  TenToolList.Create ;
end;

destructor TenXMLConfig.Destroy;
var
  i : Integer ;
begin
  FXMLDoc.Free ;
  FFont.Free ;
  for I := 0 to FTools.Count -1 do
    FTools.GetByIndex(I).Free ;
  FTools.Free ;
  inherited;
end;

procedure TenXMLConfig.Open;
var
  i : Integer ;
  Tool : TenTool ;
begin
  inherited;
  FXMLDoc.FileName := ExtractFilePath(ParamStr(0))+ FFilename;
  FXMLDoc.Active := True ;
  //FEditorConf := LoadenEditor(ConfFile);
  FXmlEnConfig := GetenEditor (FXMLDoc);
  FFont.Name := FXmlEnConfig.Font.Name ;
  FFont.Size  := FXmlEnConfig.Font.Size ;
  for i := 0 to FXmlEnConfig.Tools.Count -1 do begin
     Tool := TenTool.Create ;
     Tool.Title := FXmlEnConfig.Tools[i].Title ;
     Tool.Cmd := FXmlEnConfig.Tools[i].cmd;
     Tool.Argument := FXmlEnConfig.Tools[i].Argument;
     Tool.InitDir := FXmlEnConfig.Tools[i].InitDir ;
     Tool.Ext := FXmlEnConfig.Tools[i].ext ;
     FTools.Add(Tool);
  end;
end;

procedure TenXMLConfig.Save;
var
  i : Integer ;
  Tool : TenTool ;
begin
  inherited;
  FXmlEnConfig.Font.Name := FFont.Name ;
  FXmlEnConfig.Font.Size := FFont.Size ;
  for i := 0 to FXmlEnConfig.Tools.Count -1 do begin
     Tool := FTools.GetByIndex(I);
     FXmlEnConfig.Tools[i].Title := Tool.Title ;
     FXmlEnConfig.Tools[i].cmd := Tool.Cmd;
     FXmlEnConfig.Tools[i].Argument := Tool.Argument;
     FXmlEnConfig.Tools[i].InitDir := Tool.InitDir ;
     FXmlEnConfig.Tools[i].Ext := Tool.Ext ;
  end;

  FXmlEnConfig.OwnerDocument.SaveToFile(FFilename);
end;

{ TenConfigFactory }

class function TenConfigFactory.MakeInstance(FileName: string): TenConfig;
begin
  Result := TenXmlconfig.Create ;
  Result.Filename := FileName ;
  Result.Open ;
end;

end.
