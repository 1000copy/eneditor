
{********************************************************************}
{                                                                    }
{                          XML Data Binding                          }
{                                                                    }
{         Generated on: 2007-5-27 ÏÂÎç 08:30:10                      }
{       Generated from: E:\codestock\eneditor\src\enEditorConf.xml   }
{   Settings stored in: E:\codestock\eneditor\src\enEditorConf.xdb   }
{                                                                    }
{********************************************************************}

unit uEditorConf;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLEnEditorType = interface;
  IXMLFontType = interface;
  IXMLToolsType = interface;
  IXMLToolType = interface;

{ IXMLEnEditorType }

  IXMLEnEditorType = interface(IXMLNode)
    ['{42FB0939-C853-4761-89DB-D6B66390EB89}']
    { Property Accessors }
    function Get_Font: IXMLFontType;
    function Get_Tools: IXMLToolsType;
    { Methods & Properties }
    property Font: IXMLFontType read Get_Font;
    property Tools: IXMLToolsType read Get_Tools;
  end;

{ IXMLFontType }

  IXMLFontType = interface(IXMLNode)
    ['{97929F81-2529-4E90-8971-EF82099D16E2}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Size: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_Size(Value: Integer);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Size: Integer read Get_Size write Set_Size;
  end;

{ IXMLToolsType }

  IXMLToolsType = interface(IXMLNodeCollection)
    ['{12C8B2C9-D848-419F-96E4-CEE9EE57693E}']
    { Property Accessors }
    function Get_Tool(Index: Integer): IXMLToolType;
    { Methods & Properties }
    function Add: IXMLToolType;
    function Insert(const Index: Integer): IXMLToolType;
    property Tool[Index: Integer]: IXMLToolType read Get_Tool; default;
  end;

{ IXMLToolType }

  IXMLToolType = interface(IXMLNode)
    ['{A8F0F6C6-12D6-48D3-B427-63F4C8A94B50}']
    { Property Accessors }
    function Get_Title: WideString;
    function Get_Cmd: WideString;
    function Get_Argument: WideString;
    procedure Set_Title(Value: WideString);
    procedure Set_Cmd(Value: WideString);
    procedure Set_Argument(Value: WideString);
    { Methods & Properties }
    property Title: WideString read Get_Title write Set_Title;
    property Cmd: WideString read Get_Cmd write Set_Cmd;
    property Argument: WideString read Get_Argument write Set_Argument;
  end;

{ Forward Decls }

  TXMLEnEditorType = class;
  TXMLFontType = class;
  TXMLToolsType = class;
  TXMLToolType = class;

{ TXMLEnEditorType }

  TXMLEnEditorType = class(TXMLNode, IXMLEnEditorType)
  protected
    { IXMLEnEditorType }
    function Get_Font: IXMLFontType;
    function Get_Tools: IXMLToolsType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFontType }

  TXMLFontType = class(TXMLNode, IXMLFontType)
  protected
    { IXMLFontType }
    function Get_Name: WideString;
    function Get_Size: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_Size(Value: Integer);
  end;

{ TXMLToolsType }

  TXMLToolsType = class(TXMLNodeCollection, IXMLToolsType)
  protected
    { IXMLToolsType }
    function Get_Tool(Index: Integer): IXMLToolType;
    function Add: IXMLToolType;
    function Insert(const Index: Integer): IXMLToolType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLToolType }

  TXMLToolType = class(TXMLNode, IXMLToolType)
  protected
    { IXMLToolType }
    function Get_Title: WideString;
    function Get_Cmd: WideString;
    function Get_Argument: WideString;
    procedure Set_Title(Value: WideString);
    procedure Set_Cmd(Value: WideString);
    procedure Set_Argument(Value: WideString);
  end;

{ Global Functions }

function GetenEditor(Doc: IXMLDocument): IXMLEnEditorType;
function LoadenEditor(const FileName: WideString): IXMLEnEditorType;
function NewenEditor: IXMLEnEditorType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetenEditor(Doc: IXMLDocument): IXMLEnEditorType;
begin
  Result := Doc.GetDocBinding('enEditor', TXMLEnEditorType, TargetNamespace) as IXMLEnEditorType;
end;

function LoadenEditor(const FileName: WideString): IXMLEnEditorType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('enEditor', TXMLEnEditorType, TargetNamespace) as IXMLEnEditorType;
end;

function NewenEditor: IXMLEnEditorType;
begin
  Result := NewXMLDocument.GetDocBinding('enEditor', TXMLEnEditorType, TargetNamespace) as IXMLEnEditorType;
end;

{ TXMLEnEditorType }

procedure TXMLEnEditorType.AfterConstruction;
begin
  RegisterChildNode('Font', TXMLFontType);
  RegisterChildNode('Tools', TXMLToolsType);
  inherited;
end;

function TXMLEnEditorType.Get_Font: IXMLFontType;
begin
  Result := ChildNodes['Font'] as IXMLFontType;
end;

function TXMLEnEditorType.Get_Tools: IXMLToolsType;
begin
  Result := ChildNodes['Tools'] as IXMLToolsType;
end;

{ TXMLFontType }

function TXMLFontType.Get_Name: WideString;
begin
  Result := ChildNodes['Name'].Text;
end;

procedure TXMLFontType.Set_Name(Value: WideString);
begin
  ChildNodes['Name'].NodeValue := Value;
end;

function TXMLFontType.Get_Size: Integer;
begin
  Result := ChildNodes['Size'].NodeValue;
end;

procedure TXMLFontType.Set_Size(Value: Integer);
begin
  ChildNodes['Size'].NodeValue := Value;
end;

{ TXMLToolsType }

procedure TXMLToolsType.AfterConstruction;
begin
  RegisterChildNode('Tool', TXMLToolType);
  ItemTag := 'Tool';
  ItemInterface := IXMLToolType;
  inherited;
end;

function TXMLToolsType.Get_Tool(Index: Integer): IXMLToolType;
begin
  Result := List[Index] as IXMLToolType;
end;

function TXMLToolsType.Add: IXMLToolType;
begin
  Result := AddItem(-1) as IXMLToolType;
end;

function TXMLToolsType.Insert(const Index: Integer): IXMLToolType;
begin
  Result := AddItem(Index) as IXMLToolType;
end;

{ TXMLToolType }

function TXMLToolType.Get_Title: WideString;
begin
  Result := AttributeNodes['title'].Text;
end;

procedure TXMLToolType.Set_Title(Value: WideString);
begin
  SetAttribute('title', Value);
end;

function TXMLToolType.Get_Cmd: WideString;
begin
  Result := AttributeNodes['cmd'].Text;
end;

procedure TXMLToolType.Set_Cmd(Value: WideString);
begin
  SetAttribute('cmd', Value);
end;

function TXMLToolType.Get_Argument: WideString;
begin
  Result := AttributeNodes['argument'].Text;
end;

procedure TXMLToolType.Set_Argument(Value: WideString);
begin
  SetAttribute('argument', Value);
end;

end.