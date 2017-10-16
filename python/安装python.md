title: centos安装python3.5
date: 2016-06-15 11:36:00
tags:
- python3
- centos

## centos安装python3.5

### 源码安装

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


### EPEL Repository

	$ sudo yum install epel-release
	$ sudo yum install python34

### pip:

	$ curl -O https://bootstrap.pypa.io/get-pip.py
	$ sudo /usr/bin/python3.4 get-pip.py		
### Software Collections (SCL)

	$ sudo yum install python33
	$ scl enable python33 bash

### 参考

* [How to install Python3 on CentOS](http://ask.xmodulo.com/install-python3-centos.html)	




## ubuntu 14.04 源码安装 python2.7

```shell
version=2.7.12
cd /tmp
wget https://www.python.org/ftp/python/$version/Python-$version.tgz
tar -xvf Python-$version.tgz
cd Python-$version
./configure --prefix=/usr/local/python/$version
make && make install && make clean

mv /usr/bin/python /usr/bin/python2.7.6
ln -sf /usr/local/python/$version/bin/python2.7 /usr/bin/python
ln -sf /usr/local/python/$version/bin/python2.7 /usr/bin/python2
```

安装 pip

```shell
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
python get-pip.py

```



## end