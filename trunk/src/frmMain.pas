
unit frmMain;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ActnList, uEditAppIntfs, ComCtrls,uMRU,SynEditHighlighter,uAction,
  ExtCtrls,SyncObjs;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    pctrlMain: TPageControl;
    mm1: TMainMenu;
    uu1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  protected

  end;
var
  MainForm : TMainForm ;

implementation



{$R *.DFM}

uses
  frmEditor;


procedure TMainForm.FormCreate(Sender: TObject);
begin
  //InitMenu ;
  GI_EditorFactory := TEditorFactory.Create(Self.pctrlMain);
  GI_EditorFactory.Init;
  Self.WindowState :=   wsMaximized ;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Assert(GI_EditorFactory <> nil );
  GI_EditorFactory.CloseAll;
  GI_EditorFactory := nil ;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Assert(GI_EditorFactory <> nil );
  CanClose := GI_EditorFactory.CanCloseAll;
end;



end.

