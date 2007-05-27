unit fuTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uEditorConf;

type
  TfmTools = class(TForm)
    lst1: TListBox;
    btnExit: TButton;
    btnProp: TButton;
    btnNew: TButton;
    btnDel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


procedure RunTools(FEditorConf : IXMLEnEditorType);

implementation

{$R *.dfm}

procedure RunTools(FEditorConf : IXMLEnEditorType);
var
  fm: TfmTools; i : Integer ;
begin
  fm := TfmTools.Create(nil);
  try
  fm.lst1.Clear ;
  for i := 0 to FEditorConf.Tools.Count -1 do
    fm.lst1.Items.Add(FEditorConf.Tools.Tool[i].Title );
  fm.ShowModal ;
  finally
    fm.Free ;
  end;
end;
end.
