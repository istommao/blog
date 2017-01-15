title: python调试
date: 2017-01-13 23:39:00
tags:
- python
- debug
- pdb

# ipdb

安装：

	pip install ipdb
	
使用：

* 第一种方法: 不用改变程序直接用ipdb单步执行Python程序
	
		python -m ipdb xxx.py
	
* 第二种是在程序里标记断点,进行调试:在需要断点的地方插入
	
		from ipdb import set_trace
		set_trace()
		
常用的命令:

* n(下一个)
* ENTER(重复上次命令)
* q(退出)
* p<变量>(打印变量)
* c(继续)
* l(查找当前位于哪里)
* s(进入子程序)
* r(运行直到子程序结束)
* !<python 命令>
* h(帮助)
	
	