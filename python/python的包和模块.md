title: python的包和模块
date: 2016-06-01 22:52:00
tags:
- python
- module
- package

# python的包和模块

## 简介

首先包就是在文件夹中新建文件`__init__.py`，该文件可以为空，也可以含代码

1. 在同一目录下

		`-- src
		    |-- mod1.py
		    `-- test1.py
		    
	若在程序test1.py中导入模块mod1, 则直接使用`import mod1`或`from mod1 import *`;	 

2. 在父（祖辈）目录，需要新建`__init__.py`

		`-- src
		    |-- mod1.py
		    |-- mod2
		    |   `-- mod2.py
		    |   `-- __init__.py 
		    `-- test1.py
		    
    * 若在程序test1.py中导入模块mod2, 需要在mod2文件夹中建立空文件`__init__.py`文件(也可以在该文件中自定义输出模块接口); 
    * 然后使用 `from mod2.mod2 import *` 或`import mod2.mod2`
    * 如果在`__init__.py`文件中自定义了输出接口，比如`from . import mod2`，那么在test1.py中可以利用该输出接口导入：`from mod2 import *`或`import mod2`
    
    
3. 主程序导入上层目录中模块或其他目录(平级)下的模块
		
		`-- src
		    |-- mod1.py
		    |-- mod2
		    |   `-- mod2.py
		    |   `-- __init__.py
		    |-- sub
		    |   `-- test2.py
		    `-- test1.py


	* 首先被导入的目录需要同`(2)`中所述一样，先新建`__init__.py`文件
	* 然后在`test2.py`程序中加入
	
			import sys
			sys.path.append("..")
			import mod1
			import mod2.mod2
	* 最后进入程序所在目录，执行`python test1.py`或`python test2.py`
	
	
4. 从`(3)`可以看出，导入模块关键是能够根据`sys.path`环境变量的值，找到具体模块的路径	

	  
  
    



## 参考

* [python 在不同层级目录import 模块的方法](http://blog.csdn.net/hansel/article/details/8975663)
* [python中package机制的两种实现方式](http://www.cnblogs.com/phinecos/archive/2010/05/07/1730027.html)