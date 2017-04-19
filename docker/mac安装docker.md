title: mac安装docker
date: 2016-09-30 17:49:00
tags:
- mac
- osx
- docker

# mac安装docker

## 安装docker

下载安装：[docker for mac](https://docs.docker.com/docker-for-mac/)

## 下载images

获取进行命令：

	docker pull {image name}

打开终端执行：

	~ sudo docker pull alpine
	~ sudo docker pull ubuntu

	~ docker images
	REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
	ubuntu              latest              c73a085dc378        3 days ago          127.1 MB
	alpine              latest              ee4603260daa        6 days ago          4.803 MB
	

启动：

	docker run -ti -h dev --net=host -v ~/mygit/docker:/root/workspace -w /root ubuntu /bin/bash
	
把本地目录 `~/mygit/docker` 映射到容器 `/root/workspace` 目录

## 自定义images

上面命令登录docker后，在docker中执行如下操作：

### 更改软件源

修改成阿里云源，加快安装软件的速度

	cp /etc/apt/sources.list /etc/apt/sources.list.bak #备份
	vim /etc/apt/sources.list
	apt-get update #更新列表
	
阿里云源：

	deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
	deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
	deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
	deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse
	deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
	deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
	deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
	deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
	deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse
	deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
	
	
### 基本工具安装

	apt-get install vim curl git wget
	apt-get install gcc gdb binutils make git dstat sysstat htop curl wget
	apt-get install libjpeg-dev
	apt-get install net-tools
	apt-get install libffi-dev
	apt-get install bzip2
	apt-get install libssl-dev
	apt-get install sqlite3 libsqlite3-dev
	
[oh my zsh](https://github.com/robbyrussell/oh-my-zsh):

	apt-get install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


### 配置开发环境

根据自己平时开发使用的环境，配置对应的环境即可。

比如我常用python开发，这里以配置python开发环境为例（其他开发环境的设置也是类似的）：

#### python开发环境

[pyenv](https://github.com/yyuu/pyenv) 安装

	curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash


在 ~/.bashrc 中添加

	export PATH="/root/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"	
查看可安装的版本

	$ pyenv install --list

安装指定版本

	$ pyenv install 3.5.2 -v

更新数据库

	$ pyenv rehash

查看当前已安装的python版本

	$ pyenv versions
	
设置全局的python版本

	$ pyenv global 3.5.2
	$ pyenv versions
	
安装virtualenv

	$ pyenv global system  切换到系统python
	$ pip install virtualenv
	

#### 数据库

	$ apt-get install redis-server mysql-server
	

### 保存images

打开mac终端：

	~ docker ps

	CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
	4d94c565ec09        ubuntu              "/bin/bash"         2 hours ago         Up 2 hours                              compassionate_pike

把 image 中 4d94c565ec09 这个字段记住

	docker commit 4d94c565ec09 develop:base  #进行保存

此时执行 `~ docker images` 会发现多出刚刚保存的一项：

	REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
	develop             base                94e9a63fdf85        47 seconds ago      1.051 GB
	ubuntu              latest              c73a085dc378        3 days ago          127.1 MB
	alpine              latest              ee4603260daa        6 days ago          4.803 MB
	
说明我们保存的镜像成功了。

以后用下面的命令就可以登录我们自己的镜像了：

	docker run -ti -h dev --net=host -v ~/mygit/docker:/root/workspace -w /root develop:base /bin/bash
	
	
### 本地运行镜像进行开发

首先 build 镜像：

	docker build -t dev:i18n .
	or
	docker build -t dev:i18n -f scripts/Dockerfile .
	
然后通过 `交互模式` 运行，并将源码和对应的依赖挂载到镜像指定位置：

	docker run -it -p 8080:8080 -v /存储在本地的依赖路径/data:/opt/data -v /本地源码路径/src/dev-i18n:/workspace dev:i18n bash
	
最后，容器运行后，在 bash 中执行要运行的程序即可。

## 参考

* [使用docker搭建开发环境](http://opslinux.com/2016/09/28/%E4%BD%BF%E7%94%A8docker%E6%90%AD%E5%BB%BA%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83/)

