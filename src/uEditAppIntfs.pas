
unit uEditAppIntfs;

{$I SynEdit.inc}

interface

uses
  Windows, Classes, Forms, ComCtrls,Graphics,SynEditHighlighter,uConfig;//,uEditorConf;

type
  IEditor = interface
    procedure Activate;
    function AskSaveChanges: boolean;
    function CanClose: boolean;
    procedure CloseEditor;
    function GetCaretPos: TPoint;
    function GetEditorState: string;
    function GetFileName: string;
    function GetFileTitle: string;
    function GetModified: boolean;
    procedure OpenFile(AFileName: string);
    procedure SetFont(Font :TFont);overload ;
    procedure SetFont(FontName : String;FontSize :Integer);overload ;
    function  GetUntitledNumber : Integer ;
    function  GetStrings: TStrings ;
    procedure SetHasSelection (B : Boolean );
    procedure SetIsReadOnly (B : Boolean );
    procedure SetModified (B : Boolean );
    procedure SetBookmark(I : Integer  );
    procedure GotoBookmark(I : Integer  );
    // Editcmd
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
    //File cmd
    function FileCanClose: boolean;
    function CanPrint: boolean;
    function CanSave: boolean;
    function CanSaveAs: boolean;
    procedure ExecClose;
    procedure ExecPrint;
    procedure ExecSave;
    procedure ExecSaveAs;
    // search
    function CanFind: boolean;
    function CanFindNext: boolean;
    function CanFindPrev: boolean;
    function CanReplace: boolean;
    procedure ExecFind;
    procedure ExecFindNext;
    procedure ExecFindPrev;
    procedure ExecReplace;
  end;
IEditorFactory = interface
    procedure AddMRU(Filename : String);
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
    procedure DoOpenFile(AFileName: string);
    function Init: boolean;
    function GetUntitledNumber: integer;
    procedure ReleaseUntitledNumber(ANumber: integer);
    procedure AskEnable ;
    //function GetSaveFileName(var ANewName: string;AHighlighter: TSynCustomHighlighter): boolean;
    function GetSaveFileName(var ANewName: string;DefaultFilters :String): boolean;
    //function GetEditConf :IXMLEnEditorType;
    function GetEditConf :TenConfig;
    procedure RunToolsConf ;
  end;

var
  GI_EditorFactory: IEditorFactory;

  GI_ActiveEditor: IEditor;
{
  GI_EditCmds: IEditor;
  GI_FileCmds: IEditor;
  GI_SearchCmds: IEditor;
}
implementation

end.


