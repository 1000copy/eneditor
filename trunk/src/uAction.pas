unit uAction;

interface
uses
  ActnList ,Classes,uEditAppIntfs,Menus;
type
  TacBase = class(TAction)
  protected
    procedure Update(Sender: TObject);virtual ;
    procedure Execute(Sender: TObject);virtual ;
  public
  constructor Create(AOwner: TComponent); override;
  end;
  TacFile=class(TacBase)
  private
    function GetCaption: String;
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
  TacFileNew=class(TacBase)
  protected
    procedure Update(Sender: TObject);override ;
    procedure Execute(Sender: TObject);override ;
  public
    constructor Create(Owner : TComponent);override;
  end;
implementation
uses frmMain;
{ TacBase }


{ TacBase }

constructor TacBase.Create(AOwner: TComponent);
begin
  inherited;
  Self.OnExecute := Execute ;
  Self.OnUpdate := Update ;
end;

procedure TacBase.Execute(Sender: TObject);
begin

end;


procedure TacBase.Update(Sender: TObject);
begin

end;

{ TacFile }


constructor TacFile.Create(Owner: TComponent);
begin
  inherited;
  Caption  := 'File' ;
end;

procedure TacFile.Execute(Sender: TObject);
begin
  GI_EditorFactory.AskEnable ;
end;


procedure TacFile.Update(Sender: TObject);
begin

end;

{ TacFileNew }

constructor TacFileNew.Create(Owner: TComponent);
begin
  inherited;
  Self.ShortCut := Menus.ShortCut(Word('T'),[ssCtrl]);
  Caption :='New'
end;

procedure TacFileNew.Execute(Sender: TObject);
begin
  inherited;
  GI_EditorFactory.DoOpenFile('',MainForm.pctrlMain);
end;


procedure TacFileNew.Update(Sender: TObject);
begin
  inherited;

end;

end.
