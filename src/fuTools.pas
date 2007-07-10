unit fuTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,StrUtils,uConfig;

type
  TfmTools = class(TForm)
    lst1: TListBox;
    btnExit: TButton;
    btnProp: TButton;
    btnNew: TButton;
    btnDel: TButton;
    btnRun: TButton;
    procedure btnPropClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
  private
    { Private declarations }
    //FEditorConf : IXMLEnEditorType ;
    FEditorConf : TenConfig;
    procedure Reload;
  public
    { Public declarations }
  end;


//procedure RunTools(AEditorConf : IXMLEnEditorType);
procedure RunTools(AEditorConf : Tenconfig);
implementation

{$R *.dfm}
uses fuToolProp ,uEditAppIntfs;

//procedure RunTools(AEditorConf : IXMLEnEditorType);
procedure RunTools(AEditorConf : Tenconfig);
var
  fm: TfmTools; i : Integer ;
begin
  fm := TfmTools.Create(nil);
  with fm do
  try
   FEditorConf := AEditorConf ;
   Reload;
   ShowModal ;
  finally
    Free ;
  end;
end;
procedure TfmTools.btnPropClick(Sender: TObject);
var i : integer ;
begin
  RunToolProp(FEditorConf,self.lst1.ItemIndex);
  Reload;
end;

procedure TfmTools.btnNewClick(Sender: TObject);
var i : integer ;
begin
  RunToolProp(FEditorConf,-1);
  Reload;

end;

procedure TfmTools.btnDelClick(Sender: TObject);
var i : integer ;
begin
  if self.lst1.ItemIndex > -1 then begin
    FEditorConf.Tools.Delete(self.lst1.ItemIndex);
    Reload ;
  end;
end;

procedure TfmTools.Reload;
var i : integer ;
begin
  lst1.Clear ;
  for i := 0 to FEditorConf.Tools.Count -1 do
   lst1.Items.Add(FEditorConf.Tools.getbyindex(i).Title );
end;
procedure TfmTools.btnExitClick(Sender: TObject);
begin
  Close ;
end;

procedure TfmTools.btnRunClick(Sender: TObject);
var
  xmlTool : TenTool ;
begin
  xmlTool := FEditorConf.Tools.GetByIndex(self.lst1.ItemIndex) ;
  xmlTool.RunTool ;
end;

end.
