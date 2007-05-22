
--------------2007年5月22日--------------
TODO: 
  1. Refactor 
     replace menu item File-Close with Windows-close and remove the last .
     DoOpenFile implementation code should be placed inside IEditorFactory
  2. Run Command 
     can run any  command with parameters
     can trap output of the command


TIPS : Now I have release source code of the eneditor into codehosting provided by google (http://code.google.com/p/eneditor)
  
TIPS : A man concerned Remobjects like me ,(http://code.google.com/p/kmframework/),so  He may be a intersting person :) 
    
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
使用rst重新编写了 使用P4D "使用P4D 编写Python Extension ",不但是可以生产html，最重要的是，理解了”为什么都是文本文件，别人写的就比较容易阅读，而我的比较乱？“

