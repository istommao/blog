title: centos安装python3.5
date: 2016-06-15 11:36:00
tags:
- python3
- centos

# centos安装python3.5

## 源码安装

[python版本下载](https://www.python.org/ftp/python/)

下载和安装：

	$ curl -O https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz
	$ tar xf Python-3.5.0.tgz
	$ cd Python-3.5.0
	$ ./configure
	$ make
	$ sudo make install
		
	
查看：

	$ python3 --version	
	
p.s.: 如果安装过程出错，可能解决方法：

	$ sudo yum install yum-utils
	$ sudo yum-builddep python

	
## EPEL Repository

	$ sudo yum install epel-release
	$ sudo yum install python34
	
pip:

	$ curl -O https://bootstrap.pypa.io/get-pip.py
	$ sudo /usr/bin/python3.4 get-pip.py		
## Software Collections (SCL)

	$ sudo yum install python33
	$ scl enable python33 bash
	
## 参考

* [How to install Python3 on CentOS](http://ask.xmodulo.com/install-python3-centos.html)	
	
	