
{********************************************************************}
{                                                                    }
{                          XML Data Binding                          }
{                                                                    }
{         Generated on: 2007-4-6 22:20:52                            }
{       Generated from: E:\codestock\study\lsEdit\enEditorConf.xml   }
{   Settings stored in: E:\codestock\study\lsEdit\enEditorConf.xdb   }
{                                                                    }
{********************************************************************}

unit uEditorConf;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLEnEditorType = interface;
  IXMLFontType = interface;

{ IXMLEnEditorType }

  IXMLEnEditorType = interface(IXMLNode)
    ['{36C240AB-35B5-4EE6-ACEB-2CAF136A2EEC}']
    { Property Accessors }
    function Get_Font: IXMLFontType;
    { Methods & Properties }
    property Font: IXMLFontType read Get_Font;
  end;

{ IXMLFontType }

  IXMLFontType = interface(IXMLNode)
    ['{0895064A-E7FA-4533-B0B7-5E05E9AFE7BC}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Size: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_Size(Value: Integer);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Size: Integer read Get_Size write Set_Size;
  end;

{ Forward Decls }

  TXMLEnEditorType = class;
  TXMLFontType = class;

{ TXMLEnEditorType }

  TXMLEnEditorType = class(TXMLNode, IXMLEnEditorType)
  protected
    { IXMLEnEditorType }
    function Get_Font: IXMLFontType;
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
  inherited;
end;

function TXMLEnEditorType.Get_Font: IXMLFontType;
begin
  Result := ChildNodes['Font'] as IXMLFontType;
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

end.