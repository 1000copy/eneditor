unit fuAbout;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms;

type
  TfmAbout = class(TForm)
    Button1: TButton;
    mmo1: TMemo;
    procedure FormClick(Sender: TObject);
  end;

var
  fmAbout: TfmAbout;

implementation

{$R *.DFM}
uses Registry,ShlObj;
procedure RegisterFileType(ExtName:String; AppName:String) ;
var
  reg:TRegistry;
begin
  reg := TRegistry.Create;
  try
   reg.RootKey:=HKEY_CLASSES_ROOT;
   reg.OpenKey('.' + ExtName, True) ;
   reg.WriteString('', ExtName + 'file') ;
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
procedure TfmAbout.FormClick(Sender: TObject);
begin
   //
   RegisterFileType('txt',ParamStr(0));
end;

end.
