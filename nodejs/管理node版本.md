title: 管理node版本
date: 2016-03-31 18:17:20
tags:
- node
- n
- nvm

# 管理node版本

首先，根据系统不同，有对应更新方法，比如`mac`，可以使用

	sudo brew install node
	sudo brew upgrade node
	
其他系统类型:

	yum install node  // centos
	apt-get install node // ubuntu

## n

n是Node的一个模块，作者是[TJ Holowaychuk](https://github.com/visionmedia)（鼎鼎大名的[Express](http://expressjs.com/)框架作者），就像它的名字一样，它的理念就是简单

	sudo npm install -g n
	
直接输入`n`后输出当前已经安装的node版本以及正在使用的版本（前面有一个`o`）

	n
	
你要安装其他的版本（比如0.11.12）

	n 0.11.12
	
安装最新的版本

	$ n latest
安装稳定版本
	
	$ n stable

删除某个版本

	$ n rm 0.10.1 

以指定的版本来执行脚本		

	$ n use 0.10.21 some.js
	
## nvm

[nvm](https://github.com/creationix/nvm)全称Node Version Manager，它与n的实现方式不同，其是通过shell脚本实现的。

安装方式有两种：

	$ curl https://raw.github.com/creationix/nvm/v0.4.0/install.sh | sh
或者

	$ wget -qO- https://raw.github.com/creationix/nvm/v0.4.0/install.sh | sh

以上脚本会把nvm库clone到~/.nvm，然后会在`~/.bash_profile`, `~/.zshrc`或`~/.profile`末尾添加source，安装完成之后，你可以用以下命令来安装node

	$ nvm install 0.10
	
使用指定的版本

	$ nvm use 0.10

查看当前已经安装的版本

	$ nvm ls
	.nvm
	->  v0.10.24

查看正在使用的版本		
		
	$ nvm current
	v0.10.24
	
以指定版本执行脚本

	$ nvm run 0.10.24 myApp.js
卸载nvm

	$ rm -rf ~/.nvm	

## 参考

* [利用n和nvm管理Node的版本](http://weizhifeng.net/node-version-management-via-n-and-nvm.html)

