
unit uEditAppIntfs;

{$I SynEdit.inc}

interface

uses
  Windows, Classes, Forms, ComCtrls,Graphics;

type
  IEditor = interface
    procedure Activate;
    function AskSaveChanges: boolean;
    function CanClose: boolean;
    procedure Close;
    function GetCaretPos: TPoint;
    function GetEditorState: string;
    function GetFileName: string;
    function GetFileTitle: string;
    function GetModified: boolean;
    procedure OpenFile(AFileName: string);
    procedure SetFont(Font :TFont);overload ;
  end;

  IEditorFactory = interface
    function CanCloseAll: boolean;
    procedure CloseAll;
    function GetEditorCount: integer;
    function GetEditor(Index: integer): IEditor;
    procedure RemoveEditor(AEditor: IEditor);
    property Editor[Index: integer]: IEditor read GetEditor;
    procedure CloseEditor ;
    function GetFont:TFont;
    procedure SetFont(Font :TFont);overload ;
    procedure SetFont(FontName : String;FontSize :Integer);overload ;
    procedure DoOpenFile(AFileName: string;pctrlMain:TPageControl);
    procedure AddMRU(Filename : String);
    procedure RemoveMRU(Filename : String);
    function GetMRUCount:Integer;
    function GetMRU (I:Integer): String; 
  end;

  IEditCommands = interface
    function CanCopy: boolean;
    function CanCut: boolean;
    function CanDelete: boolean;
    function CanPaste: boolean;
    function CanRedo: boolean;
    function CanSelectAll: boolean;
    function CanUndo: boolean;
    procedure ExecCopy;
    procedure ExecCut;
    procedure ExecDelete;
    procedure ExecPaste;
    procedure ExecRedo;
    procedure ExecSelectAll;
    procedure ExecUndo;
  end;

  IFileCommands = interface
    function CanClose: boolean;
    function CanPrint: boolean;
    function CanSave: boolean;
    function CanSaveAs: boolean;
    procedure ExecClose;
    procedure ExecPrint;
    procedure ExecSave;
    procedure ExecSaveAs;
  end;

  ISearchCommands = interface
    function CanFind: boolean;
    function CanFindNext: boolean;
    function CanFindPrev: boolean;
    function CanReplace: boolean;
    procedure ExecFind;
    procedure ExecFindNext;
    procedure ExecFindPrev;
    procedure ExecReplace;
  end;

var
  GI_EditorFactory: IEditorFactory;

  GI_ActiveEditor: IEditor;

  GI_EditCmds: IEditCommands;
  GI_FileCmds: IFileCommands;
  GI_SearchCmds: ISearchCommands;

implementation

end.


