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
      (如果我想用英语而不是汉语来写日记,谷歌译者可以帮助我).
       http://www.google.com/translate_t?langpair=zh|en 
    
--------------2007年3月31日--------------
  工具选择：
  Editplus ,Mathon ,DelphiGreen ,SqlserverGreen
  接下来，PythonGreen带有Docutils，sqlobject

--------------2007年3月31日--------------
 firefox 103M ，我的妈，换
--------------2007年3月31日--------------
  编写rst的配置

  1.Docutils：首先setup.py ,然后执行rst2html.py 来测试
  2. Editor : editplus 2.31 加上ctrl+1 的外部工具
	E:\setup\docutils-snapshot\docutils\tools\rst2html.py $(Filename)  $(Filename).html
  3. Python2.5 
   
--------------2007年3月31日--------------
针对editplus的情况，需要填写参数为:

--------------2007年3月31日--------------
  编写rst文件的环境：
  命令：c:\python25\python.exe
  参数：E:\setup\docutils-snapshot\docutils\tools\rst2html.py $(Filename).$(Ext) $(Filename).html
  路径：$(dir)
--------------2007年3月31日--------------
使用rst重新编写了 使用P4D "使用P4D 编写Python Extension ",不但是可以生产html，
最重要的是，理解了”为什么都是文本文件，别人写的就比较容易阅读，而我的比较乱？“

