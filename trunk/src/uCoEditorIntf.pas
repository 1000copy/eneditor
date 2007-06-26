unit uCoEditorIntf;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, enEditor_TLB, StdVcl;

type
  TCoEditor = class(TAutoObject, ICoEditor)
  protected
    procedure OpenEditor(const FileName: WideString); safecall;

  end;

implementation

uses ComServ,uEditAppIntfs;

procedure TCoEditor.OpenEditor(const FileName: WideString);
begin
  GI_EditorFactory.DoOpenFile(FileName);
end;

initialization
  TAutoObjectFactory.Create(ComServer, TCoEditor, Class_CoEditor,
    ciMultiInstance, tmApartment);
end.
