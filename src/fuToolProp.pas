unit fuToolProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uEditorConf;

type
  TfrmToolProp = class(TForm)
    edtTitle: TEdit;
    edtCmd: TEdit;
    edtParams: TEdit;
    edtInitDir: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
    FCreateNew : Boolean;
    FEditorConf : IXMLEnEditorType ;
  public
    { Public declarations }
  end;

var
  frmToolProp: TfrmToolProp;
procedure RunToolProp(AEditorConf : IXMLEnEditorType;index : Integer );
implementation

{$R *.dfm}
procedure RunToolProp(AEditorConf : IXMLEnEditorType;index : Integer );
var
  fm: TfrmToolProp; i : Integer ;
  xmlTool : IXMLTooltype ;
begin
  fm := TfrmToolProp.Create(nil);
  try
    fm.FEditorConf := AEditorConf ;
    with fm,xmlTool do
    if Index > -1 then begin
      xmlTool := fm.FEditorConf.Tools.Tool[Index];
         edtTitle.Text := Title ;
         edtCmd.Text := Cmd ;
         edtParams.Text := Argument;
         edtInitDir.Text := InitDir;
    end else  begin
         edtTitle.Text := '';
         edtCmd.Text := '' ;
         edtParams.Text := '';
         edtInitDir.Text := '';
    end ;
    if MrOK = fm.ShowModal then begin
      if Index = -1 then
        xmlTool := fm.FEditorConf.Tools.Add ;
      with fm,xmlTool do
      begin
         Title := edtTitle.Text ;
         Cmd := edtCmd.Text ;
         Argument := edtParams.Text ;
         InitDir := edtInitDir.Text;
      end;
    end;
  finally
    fm.Free ;
  end;
end;
end.
