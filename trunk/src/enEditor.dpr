{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: EditAppWorkbook.dpr, released 2000-09-08.

The Original Code is part of the EditAppDemos project, written by
Michael Hieke for the SynEdit component suite.
All Rights Reserved.

Contributors to the SynEdit project are listed in the Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: EditAppWorkbook.dpr,v 1.1 2000/09/16 07:34:43 mghie Exp $

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

Known Issues:
-------------------------------------------------------------------------------}

program enEditor;

uses
  Forms,
  frmMain in 'frmMain.pas' {MainForm},
  uEditAppIntfs in 'uEditAppIntfs.pas',
  frmEditor in 'frmEditor.pas' {EditorForm},
  uHighlighters in 'uHighlighters.pas' {CommandsDataModule: TDataModule},
  dlgConfirmReplace in 'dlgConfirmReplace.pas' {ConfirmReplaceDialog},
  dlgReplaceText in 'dlgReplaceText.pas',
  dlgSearchText in 'dlgSearchText.pas' {TextSearchDialog},
  uHighlighterProcs in 'uHighlighterProcs.pas',
  uMRU in 'uMRU.pas',
  uAction in 'uAction.pas',
  fuTools in 'fuTools.pas' {fmTools},
  uEditorConf in 'uEditorConf.pas',
  OKCANCL2 in 'C:\Program Files\Borland\Delphi7\ObjRepos\OKCANCL2.pas' {OKRightDlg},
  fuAbout in 'fuAbout.pas' {fmAbout};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.Run;
end.
