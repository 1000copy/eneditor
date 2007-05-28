
{********************************************************************}
{                                                                    }
{                          XML Data Binding                          }
{                                                                    }
{         Generated on: 2007-5-28 ÏÂÎç 10:37:10                      }
{       Generated from: E:\codestock\eneditor\src\enEditorConf.xml   }
{   Settings stored in: E:\codestock\eneditor\src\uEditorConf.xdb    }
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
    ['{3F736D51-7FD5-4CF9-B738-B4F9485D6763}']
    { Property Accessors }
    function Get_Font: IXMLFontType;
    function Get_Tools: IXMLToolsType;
    { Methods & Properties }
    property Font: IXMLFontType read Get_Font;
    property Tools: IXMLToolsType read Get_Tools;
  end;

{ IXMLFontType }

  IXMLFontType = interface(IXMLNode)
    ['{F97B58BC-6593-4E50-991C-FFB9618B6193}']
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
    ['{ECBB089D-DAF2-426C-8570-86BC0C45A854}']
    { Property Accessors }
    function Get_Tool(Index: Integer): IXMLToolType;
    { Methods & Properties }
    function Add: IXMLToolType;
    function Insert(const Index: Integer): IXMLToolType;
    property Tool[Index: Integer]: IXMLToolType read Get_Tool; default;
  end;

{ IXMLToolType }

  IXMLToolType = interface(IXMLNode)
    ['{A671820E-1C06-47A7-8DA6-E016E532B851}']
    { Property Accessors }
    function Get_Title: WideString;
    function Get_Cmd: WideString;
    function Get_Argument: WideString;
    function Get_Initdir: WideString;
    procedure Set_Title(Value: WideString);
    procedure Set_Cmd(Value: WideString);
    procedure Set_Argument(Value: WideString);
    procedure Set_Initdir(Value: WideString);
    { Methods & Properties }
    property Title: WideString read Get_Title write Set_Title;
    property Cmd: WideString read Get_Cmd write Set_Cmd;
    property Argument: WideString read Get_Argument write Set_Argument;
    property Initdir: WideString read Get_Initdir write Set_Initdir;
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
    function Get_Initdir: WideString;
    procedure Set_Title(Value: WideString);
    procedure Set_Cmd(Value: WideString);
    procedure Set_Argument(Value: WideString);
    procedure Set_Initdir(Value: WideString);
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

function TXMLToolType.Get_Initdir: WideString;
begin
  Result := AttributeNodes['initdir'].Text;
end;

procedure TXMLToolType.Set_Initdir(Value: WideString);
begin
  SetAttribute('initdir', Value);
end;

end.
