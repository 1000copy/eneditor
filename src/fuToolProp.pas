unit fuToolProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uConfig;

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
    //FEditorConf : IXMLEnEditorType ;
    FEditorConf : TenConfig;
  public
    { Public declarations }
  end;

var
  frmToolProp: TfrmToolProp;
//procedure RunToolProp(AEditorConf : IXMLEnEditorType;index : Integer );
procedure RunToolProp(AEditorConf : Tenconfig;index : Integer );
implementation

{$R *.dfm}
//procedure RunToolProp(AEditorConf : IXMLEnEditorType;index : Integer );
procedure RunToolProp(AEditorConf : Tenconfig;index : Integer );
var
  fm: TfrmToolProp; i : Integer ;
  xmlTool : TenTool ;
begin
  fm := TfrmToolProp.Create(nil);
  try
    fm.FEditorConf := AEditorConf ;
    with fm,xmlTool do
    if Index > -1 then begin
         xmlTool :=  fm.FEditorConf.Tools.GetByIndex(Index);
         edtTitle.Text := Title ;
         edtCmd.Text := Cmd ;
         edtParams.Text := Argument;
         edtInitDir.Text := InitDir;
         //fm.FEditorConf.Tools.Add(xmlTool);
    end else  begin
         edtTitle.Text := '';
         edtCmd.Text := '' ;
         edtParams.Text := '';
         edtInitDir.Text := '';
    end ;
    if MrOK = fm.ShowModal then begin
      if Index = -1 then begin
        xmlTool := TenTool.Create ;
        fm.FEditorConf.Tools.Add(xmlTool);
      end;
      with fm,xmlTool do
      begin
         Title := edtTitle.Text ;
         Cmd := edtCmd.Text ;
         Argument := edtParams.Text ;
         InitDir := edtInitDir.Text;
      end;
      AEditorConf.Save ;
    end;
  finally
    fm.Free ;
  end;
end;
end.
