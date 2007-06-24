
unit uHLs;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList,
  // Highlighter Class
  SynEditHighlighter,
  SynHighlighterSQL, SynHighlighterPas,SynHighlighterRuby,
  SynHighlighterXML, SynHighlighterHtml,uMRU;

type
  THLs = class (TComponent)
  private
    SynPasSyn1: TSynPasSyn;
    SynSQLSyn1: TSynSQLSyn;
    SynXMLSyn1: TSynXMLSyn;
    SynRB: TSynRubySyn;
    HL: TStringList;
    function GetHighlighterFromFileExt(AHighlighters: TStringList;
      Extension: string): TSynCustomHighlighter;
    function GetHighlightersFilter(AHighlighters: TStringList): string;
    procedure GetHL(Arr : Array of TSynCustomHighlighter ;AppendToList: boolean);
  public
    constructor Create ;reintroduce ;
    destructor Destroy ;override ;
    function GetFilters : String ;
    function GetHighlighterForFile(AFileName: string): TSynCustomHighlighter;
  end;

var
  HLs: THLs;

implementation




{ TCommandsDataModule }
procedure THLs.GetHL(Arr : Array of TSynCustomHighlighter ;AppendToList: boolean);
var
  i: integer;
begin
  if not AppendToList then
    HL.Clear;
  for i := Low (Arr) to High (Arr) do begin
    if HL.IndexOf(Arr[i].GetLanguageName) = -1 then
      HL.AddObject(Arr[i].GetLanguageName, Arr[i]);
  end;
  HL.Sort;
end;

function THLs.GetHighlightersFilter(AHighlighters: TStringList): string;
var
  i: integer;
  Highlighter: TSynCustomHighlighter;
begin
  Result := '';
  if Assigned(AHighlighters) then
    for i := 0 to AHighlighters.Count - 1 do begin
      if not (AHighlighters.Objects[i] is TSynCustomHighlighter) then
        continue;
      Highlighter := TSynCustomHighlighter(AHighlighters.Objects[i]);
      if Highlighter.DefaultFilter = '' then
        continue;
      Result := Result + Highlighter.DefaultFilter;
      if Result[Length(Result)] <> '|' then
        Result := Result + '|';
    end;
end;

function THLs.GetHighlighterFromFileExt(AHighlighters: TStringList;
  Extension: string): TSynCustomHighlighter;
var
  ExtLen: integer;
  i, j: integer;
  Highlighter: TSynCustomHighlighter;
  Filter: string;
begin
  Extension := LowerCase(Extension);
  ExtLen := Length(Extension);
  if Assigned(AHighlighters) and (ExtLen > 0) then begin
    for i := 0 to AHighlighters.Count - 1 do begin
      if not (AHighlighters.Objects[i] is TSynCustomHighlighter) then
        continue;
      Highlighter := TSynCustomHighlighter(AHighlighters.Objects[i]);
      Filter := LowerCase(Highlighter.DefaultFilter);
      j := Pos('|', Filter);
      if j > 0 then begin
        Delete(Filter, 1, j);
        j := Pos(Extension, Filter);
        if (j > 0) and
           ((j + ExtLen > Length(Filter)) or (Filter[j + ExtLen] = ';'))
        then begin
          Result := Highlighter;
          exit;
        end;
      end;
    end;
  end;
  Result := nil;
end;

constructor THLs.Create;
begin
  inherited Create(nil);
  SynPasSyn1 := TSynPasSyn.Create(Self);
  SynSQLSyn1:= TSynSQLSyn.Create(Self);
  SynXMLSyn1:= TSynXMLSyn.Create(Self);
  SynRB:=  TSynRubySyn.Create(Self);
  HL := TStringList.Create;
  GetHL([SynPasSyn1,SynSQLSyn1,SynXMLSyn1,SynRB],FALSE);
end;


// implementation


destructor THLs.Destroy;
begin
  HL.Free;

  inherited;
end;

function THLs.GetFilters: String;
begin
  Result := 'TEXT|*.txt|'+
            'ALL|*.*|'+
            'PAS|*.pas|'+
            'SQL|*.sql|'+
            'XML|*.xml|'+
            'Ruby|*.rb|'
end;

function THLs.GetHighlighterForFile(
  AFileName: string): TSynCustomHighlighter;
begin
  if AFileName <> '' then
    Result := GetHighlighterFromFileExt(HL, ExtractFileExt(AFileName))
  else
    Result := nil;
end;

end.

