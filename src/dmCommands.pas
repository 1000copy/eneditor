
unit dmCommands;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, SynHighlighterSQL, SynHighlighterPas, SynEditHighlighter,
  SynHighlighterCpp, SynHighlighterXML, SynHighlighterHtml,uMRU;

type
  THighlighters = class (TComponent)
  private
    SynPasSyn1: TSynPasSyn;
    SynSQLSyn1: TSynSQLSyn;
    SynXMLSyn1: TSynXMLSyn;
    fHighlighters: TStringList;
  public
    constructor Create ;reintroduce ;
    destructor Destroy ;override ;
    function GetHighlighterForFile(AFileName: string): TSynCustomHighlighter;
    function GetFilters : String ;
  end;

var
  Highlighters: THighlighters;

implementation

uses
  uHighlighterProcs, uEditAppIntfs, frmMain;



{ TCommandsDataModule }

constructor Highlighters.Create;
begin
  inherited Create(nil);
  SynPasSyn1 := TSynPasSyn.Create(Self);
  SynSQLSyn1:= TSynSQLSyn.Create(Self);
  SynXMLSyn1:= TSynXMLSyn.Create(Self);

  fHighlighters := TStringList.Create;
  GetHighlighters( Self,fHighlighters, FALSE);
end;


// implementation


destructor Highlighters.Destroy;
begin
  fHighlighters.Free;
  CommandsDataModule := nil;

  inherited;
end;

function Highlighters.GetFilters: String;
begin
  Result := 'Txt file|*.txt|All files|*.*|Pas|*.pas|sql|*.sql|xml|*.xml'
end;

function Highlighters.GetHighlighterForFile(
  AFileName: string): TSynCustomHighlighter;
begin
  if AFileName <> '' then
    Result := GetHighlighterFromFileExt(fHighlighters, ExtractFileExt(AFileName))
  else
    Result := nil;
end;

end.

