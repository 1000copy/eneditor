--------------May 30, 2007 --------------
 None
--------------May 30, 2007 --------------
  9. Serial format file generator ,like SMS StockIO file 
 10. Find Replace 's Regexp   
--------------May 27, 2007 --------------
  6.DONE @ May 28,2007 
   tip user I can do as default editor of text 
  7. Shell integation : Edit by enEditor
  8. Script enhanced : May be lisp or PascalScript? more research on synedit need to pay   
--------------May 23, 2007 -------------- 
  3. DONE @May 27,2007   
    Refactor : Move dmCommands.ActionList to MainForm
  4. DONE @May 25,2007 
    Refactor : IEditorFactory so complex ! Remove the functions from it 
    procedure AddMRU(Filename : String);
    procedure RemoveMRU(Filename : String);
    function GetMRUCount:Integer;
    function GetMRU (I:Integer): String; 
  5. DONE @May 25,2007         
     Refactor : Merge IEdit.Close to IEditFactory.CloseEditor(FileName:String);  
--------------May 22, 2007 --------------
TASK
  1. DONE on May 23,2007 
     Refactor :replace menu item File-Close with Windows-close and remove the last .
     DoOpenFile implementation code should be placed inside IEditorFactory
  2. DONE on May 28,2007 
     Run Command 
     can run any  command with parameters
     can trap output of the command
     Manage tool list 

--------------May 22, 2007 --------------
TIPS : Now I have release source code of the eneditor into codehosting provided by google (http://code.google.com/p/eneditor)
  
TIPS : A man concerned Remobjects like me ,(http://code.google.com/p/kmframework/),so  He may be a intersting person :)
TIPS :If I want to use English instead of Chinese to write diaries, Google Translator can help me.
      (���������Ӣ������Ǻ�����д�ռ�,�ȸ����߿��԰�����).
       http://www.google.com/translate_t?langpair=zh|en 
    
--------------2007��3��31��--------------
  ����ѡ��
  Editplus ,Mathon ,DelphiGreen ,SqlserverGreen
  ��������PythonGreen����Docutils��sqlobject

--------------2007��3��31��--------------
 firefox 103M ���ҵ��裬��
--------------2007��3��31��--------------
  ��дrst������

  1.Docutils������setup.py ,Ȼ��ִ��rst2html.py ������
  2. Editor : editplus 2.31 ����ctrl+1 ���ⲿ����
	E:\setup\docutils-snapshot\docutils\tools\rst2html.py $(Filename)  $(Filename).html
  3. Python2.5 
   
--------------2007��3��31��--------------
���editplus���������Ҫ��д����Ϊ:

--------------2007��3��31��--------------
  ��дrst�ļ��Ļ�����
  ���c:\python25\python.exe
  ������E:\setup\docutils-snapshot\docutils\tools\rst2html.py $(Filename).$(Ext) $(Filename).html
  ·����$(dir)
--------------2007��3��31��--------------
ʹ��rst���±�д�� ʹ��P4D "ʹ��P4D ��дPython Extension ",�����ǿ�������html��
����Ҫ���ǣ�����ˡ�Ϊʲô�����ı��ļ�������д�ľͱȽ������Ķ������ҵıȽ��ң���

