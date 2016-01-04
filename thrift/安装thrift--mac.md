#安装thrift--mac

## 自动安装

最简单的是用homebrew进行安装

	安装homebrew 在终端输入
	
		ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	
	安装thrift   
		brew install thrift

----

## 手动安装

## 下载安装包

	http://thrift.apache.org/
	
## 安装bison

在mac上bison的版本可能低于2.5，thrift要求2.5

### 查看bison版本

	bison -V
	
参考stackflow
	
	http://stackoverflow.com/questions/31805431/how-to-install-bison-on-mac-osx	
	
### 安装bison（brew）

如果没有安装brew，在终端输入

	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	
安装bison
	
	brew tap homebrew/dupes && brew install bison

这是查看bison，版本依然没有变化

	brew unlink bison
	brew link bison
	brew link bison --force
	source ~/.bash_profile 
	bison -V
	
## 安装thrift

	./configure --prefix=/usr/local/ --with-boost=/usr/local/lib --with-libevent=/usr/local/lib --without-ruby --without-python --without-perl --without-php
	
	sudo make install
	
查看版本

	thrift -version
	
		
			

	
	
		