title: python技巧
date: 2016-05-24 17:47:00
tags:
- python

# python技巧

## 项目构建

* virtualenv
* pip

安装virtualenv：

	pip install virtualenv
	
进入工程目录：

	virtualenv venv
	
启动：

	source venv/bin/active	
	
退出：

	deactive
	
### requirements文件

记录依赖的特定版本的包

	(venv) $ pip freeze > requirements.txt

根据requirements.txt重新构建：

	(venv) $ pip install -r requirements.txt