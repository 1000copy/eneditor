unit fuAbout;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms;

type
  TfmAbout = class(TForm)
    Button1: TButton;
    mmo1: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  end;

var
  fmAbout: TfmAbout;

implementation

{$R *.DFM}
uses Registry,ShlObj;

procedure RegisterFileType(ExtName:String; AppName:String;IsOn : Boolean ) ;
var
  reg:TRegistry;
begin
  reg := TRegistry.Create;
  try
   reg.RootKey:=HKEY_CLASSES_ROOT;
   reg.OpenKey('.' + ExtName, True) ;
   // Do Register
   if IsOn then
    reg.WriteString('', ExtName + 'file') 
   else
   // Do Cancel !
    reg.WriteString('', '') ;
   reg.CloseKey;
   reg.CreateKey(ExtName + 'file') ;
   reg.OpenKey(ExtName + 'file\DefaultIcon', True) ;
   reg.WriteString('', AppName + ',0') ;
   reg.CloseKey;
   reg.OpenKey(ExtName + 'file\shell\open\command', True) ;
   reg.WriteString('',AppName+' "%1"') ;
   reg.CloseKey;
  finally
   reg.Free;
  end;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil) ;
end;
procedure TfmAbout.Button2Click(Sender: TObject);
begin
  RegisterFileType('txt',ParamStr(0),True);
  RegisterFileType('rb',ParamStr(0),True);
end;

procedure TfmAbout.btn1Click(Sender: TObject);
begin
  RegisterFileType('txt',ParamStr(0),False);
  RegisterFileType('rb',ParamStr(0),False);
end;

end.
