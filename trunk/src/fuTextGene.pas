unit fuTextGene;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfmTextGene = class(TForm)
    PageControl1: TPageControl;
    ts3: TTabSheet;
    ts4: TTabSheet;
    edtRows: TEdit;
    lbl3: TLabel;
    Label1: TLabel;
    edtSep: TEdit;
    edtColumns: TEdit;
    Label2: TLabel;
    lstColumnList: TListBox;
    ts5: TTabSheet;
    mmo1: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    lbl2: TLabel;
    edtBegin: TEdit;
    edtStep: TEdit;
    chkFixLen: TCheckBox;
    edtString: TEdit;
    lbl1: TLabel;
    Label3: TLabel;
    cbbColumnType: TComboBox;
    Label6: TLabel;
    Label8: TLabel;
    edtFixLen: TEdit;
    btn1: TButton;
    Button1: TButton;
    procedure PageControl1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lstColumnListClick(Sender: TObject);
    procedure edtStringExit(Sender: TObject);
    procedure cbbColumnTypeChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure ShowByType(Visible: Boolean);
    { Private declarations }
  public
    { Public declarations }
    procedure ClearObjects ;

  end;

var
  fmTextGene: TfmTextGene;
type
  TColumnType = (ctSimple,ctSequence);
  TColumnDef = class
  private
    FIsFixLen: Boolean;
    FSequenceBegin: Integer;
    FSequenceStep: Integer;
    FFillerStr: String;
    FStr: String;
    FColumnType: TColumnType;
    FFixLen: Integer;
    procedure SetColumnType(const Value: TColumnType);
    procedure SetFillerStr(const Value: String);
    procedure SetIsFixLen(const Value: Boolean);
    procedure SetSequenceBegin(const Value: Integer);
    procedure SetSequenceStep(const Value: Integer);
    procedure SetStr(const Value: String);
    procedure SetFixLen(const Value: Integer);
  published
    property ColumnType : TColumnType  read FColumnType write SetColumnType;
    property Str : String read FStr write SetStr;
    property SequenceBegin :Integer  read FSequenceBegin write SetSequenceBegin;
    property SequenceStep :Integer  read FSequenceStep write SetSequenceStep;
    property FillerStr : String  read FFillerStr write SetFillerStr;
    property IsFixLen : Boolean  read FIsFixLen write SetIsFixLen;
    property FixLen :Integer   read FFixLen write SetFixLen;
  end;
function GetTextGene : String ;
implementation

{$R *.dfm}
function GetTextGene : String ;
begin
  fmTextGene := TfmTextGene.Create(nil);
  if mrOK = fmTextGene.ShowModal then
    Result := fmTextGene.mmo1.Text
  else
    Result := '';
end;
procedure TfmTextGene.ClearObjects;
var
  i : Integer;
begin
  for I := 0 to self.lstColumnList.Count -1 do begin
    if Assigned(self.lstColumnList.Items.Objects[I]) then
      lstColumnList.Items.Objects[I].Free ;
  end;
  self.lstColumnList.Clear ;
end;

procedure TfmTextGene.PageControl1Change(Sender: TObject);
var
  i,c,r : Integer;
  ColumnDef : TColumnDef ;
begin
  if Self.PageControl1.ActivePageIndex = 1 then begin
    c := StrToInt(edtColumns.text);
    if c = lstColumnList.Count then Exit ;
    ClearObjects ;                        
    for i := 0 to c -1 do begin
      ColumnDef := TColumnDef.Create ;
      ColumnDef.ColumnType := ctSimple ;
      ColumnDef.Str := '';
      self.lstColumnList.Items.AddObject('ап'+ IntToStr(i),TColumnDef.Create);
    end;
  end;
end;

{ TColumnDef }

procedure TColumnDef.SetColumnType(const Value: TColumnType);
begin
  FColumnType := Value;
end;

procedure TColumnDef.SetFillerStr(const Value: String);
begin
  FFillerStr := Value;
end;

procedure TColumnDef.SetFixLen(const Value: Integer);
begin
  FFixLen := Value;
end;

procedure TColumnDef.SetIsFixLen(const Value: Boolean);
begin
  FIsFixLen := Value;
end;

procedure TColumnDef.SetSequenceBegin(const Value: Integer);
begin
  FSequenceBegin := Value;
end;

procedure TColumnDef.SetSequenceStep(const Value: Integer);
begin
  FSequenceStep := Value;
end;

procedure TColumnDef.SetStr(const Value: String);
begin
  FStr := Value;
end;

procedure TfmTextGene.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClearObjects ;
end;

procedure TfmTextGene.lstColumnListClick(Sender: TObject);
var
  ColumnDef : TColumnDef ;
begin
  if lstColumnList.ItemIndex >=0 then begin
    ColumnDef := TColumnDef(lstColumnList.Items.Objects[lstColumnList.ItemIndex]) ;
    edtString.Text := ColumnDef.Str ;
    if ColumnDef.ColumnType = ctSimple then begin
      cbbColumnType.ItemIndex := 0;
      ShowByType(False);
   end
    else begin
      cbbColumnType.ItemIndex := 1 ;
      edtBegin.Text := IntToStr(ColumnDef.SequenceBegin);
      edtStep.Text := IntToStr(ColumnDef.SequenceStep);
      edtBegin.Text := IntToStr(ColumnDef.SequenceBegin);
      chkFixLen.Checked := ColumnDef.IsFixLen ;
      edtFixLen.Text := IntToStr(ColumnDef.FixLen);
      ShowByType(True);
    end;
  end;
end;

procedure TfmTextGene.edtStringExit(Sender: TObject);
var
  ColumnDef : TColumnDef ;
begin
  if lstColumnList.ItemIndex >=0 then begin
    ColumnDef := TColumnDef(lstColumnList.Items.Objects[lstColumnList.ItemIndex]) ;
    ColumnDef.Str := edtString.Text ;
    if ColumnDef.ColumnType = ctSequence then begin
      ColumnDef.SequenceBegin := StrToInt(edtBegin.Text);
      ColumnDef.SequenceStep := StrToInt(edtStep.Text);
      ColumnDef.SequenceBegin := StrToInt(edtBegin.Text);
      ColumnDef.IsFixLen := chkFixLen.Checked ;
      ColumnDef.FixLen := StrToInt(edtFixLen.Text);
    end;
  end;
end;

procedure TfmTextGene.cbbColumnTypeChange(Sender: TObject);
var
  ColumnDef : TColumnDef ;
begin
  if lstColumnList.ItemIndex >=0 then begin
    ColumnDef := TColumnDef(lstColumnList.Items.Objects[lstColumnList.ItemIndex]) ;
    if cbbColumnType.ItemIndex = 0 then
      ColumnDef.ColumnType := ctSimple
    else
      ColumnDef.ColumnType := ctSequence ;
    ShowByType(cbbColumnType.ItemIndex = 1);
    ColumnDef.Str := edtString.Text ;
    if ColumnDef.ColumnType = ctSequence then begin      
      ColumnDef.SequenceBegin := StrToInt(edtBegin.Text);
      ColumnDef.SequenceStep := StrToInt(edtStep.Text);
      ColumnDef.SequenceBegin := StrToInt(edtBegin.Text);
      ColumnDef.IsFixLen := chkFixLen.Checked ;
      ColumnDef.FixLen := StrToInt(edtFixLen.Text);
    end;
  end;
end;

procedure TfmTextGene.ShowByType(Visible :Boolean );
  begin
      edtBegin.Visible := Visible ;
      edtStep.Visible := Visible ;
      edtBegin.Visible :=  Visible ;
      chkFixLen.Visible :=  Visible ;
      edtFixLen.Visible :=  Visible ;
  end;
procedure TfmTextGene.btn1Click(Sender: TObject);
var
  i ,j: Integer;
  ColumnDef : TColumnDef ;
  Line ,Item:String ;
begin
  Self.mmo1.Clear ;
  for j := 0 to StrtoInt(self.edtRows.Text) -1 do begin
    Line := '';
    for I := 0 to self.lstColumnList.Count -1 do begin
      if Assigned(self.lstColumnList.Items.Objects[I]) then begin
        ColumnDef := TColumnDef(lstColumnList.Items.Objects[I]) ;
        if ColumnDef.ColumnType =ctsimple then
          Item := ColumnDef.Str
        else begin
          Item := ColumnDef.Str + IntToStr(ColumnDef.SequenceBegin + j * ColumnDef.SequenceStep) ;
          if ColumnDef.IsFixLen then
            Item := Copy(Item,Length(Item)-ColumnDef.FixLen+1,Length(Item));
        end;
        Line := Line + Item + edtSep.Text
      end;
    end;
    Self.mmo1.Lines.Add(Line);
  end;
  ModalResult := mrOk ;
end;
procedure TfmTextGene.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
