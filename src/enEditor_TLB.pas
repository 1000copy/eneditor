unit enEditor_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 2007-7-10 ÏÂÎç 08:39:44 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\codestock\eneditor\src\enEditor.tlb (1)
// LIBID: {8E9C76D5-68EF-437B-A657-BE224F2423E1}
// LCID: 0
// Helpfile: 
// HelpString: enEditor Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  enEditorMajorVersion = 1;
  enEditorMinorVersion = 0;

  LIBID_enEditor: TGUID = '{8E9C76D5-68EF-437B-A657-BE224F2423E1}';

  IID_ICoEditor: TGUID = '{0E88B428-2FC5-41FD-AF35-F0D8BB8978DE}';
  CLASS_CoEditor: TGUID = '{BD3FE75F-0F41-47A9-8197-07922F8E8F32}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICoEditor = interface;
  ICoEditorDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CoEditor = ICoEditor;


// *********************************************************************//
// Interface: ICoEditor
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0E88B428-2FC5-41FD-AF35-F0D8BB8978DE}
// *********************************************************************//
  ICoEditor = interface(IDispatch)
    ['{0E88B428-2FC5-41FD-AF35-F0D8BB8978DE}']
    procedure OpenEditor(const FileName: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  ICoEditorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0E88B428-2FC5-41FD-AF35-F0D8BB8978DE}
// *********************************************************************//
  ICoEditorDisp = dispinterface
    ['{0E88B428-2FC5-41FD-AF35-F0D8BB8978DE}']
    procedure OpenEditor(const FileName: WideString); dispid 201;
  end;

// *********************************************************************//
// The Class CoCoEditor provides a Create and CreateRemote method to          
// create instances of the default interface ICoEditor exposed by              
// the CoClass CoEditor. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCoEditor = class
    class function Create: ICoEditor;
    class function CreateRemote(const MachineName: string): ICoEditor;
  end;

implementation

uses ComObj;

class function CoCoEditor.Create: ICoEditor;
begin
  Result := CreateComObject(CLASS_CoEditor) as ICoEditor;
end;

class function CoCoEditor.CreateRemote(const MachineName: string): ICoEditor;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CoEditor) as ICoEditor;
end;

end.
