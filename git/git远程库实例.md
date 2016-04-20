# git远程库实例
====

## 实例1：搭建自己的git远程库

### 在远端服务器

#### 创建git库

	cd /home/zhuwei5e/my_repo
	git init (git init --bare)

#### 编辑.gitignore文件

编辑这个可以忽略很多不需要添加到版本库中的文件，当然如果不想忽略任何文件，不需要进行这一步骤。

[参见的gitignore模板](https://github.com/github/gitignore)

e.g.

	vim .gitignore
	
	*.class
	
	# Mobile Tools for Java (J2ME)
	.mtj.tmp/
	
	# Package Files #
	*.jar
	*.war
	*.ear
	
	# virtual machine crash logs, see http://www.java.com/en/download/help/error_hotspot.xml
	hs_err_pid*


#### 向仓库提交自己的代码
	touch helloword.java
	git add .
	git commit -a -m "java program hello word"
	git stauts

#### 添加一个远程仓库,并将本地的master分支跟踪到远程分支

	git remote add origin ssh://root@192.168.1.11/home/zhuwei5e/my_repo/.git
	git push origin master

p.s. 上面的192.168.1.11地址是远端服务器的的IP 。

现在git仓库已经是一个远程仓库了。测试：

	git remote show origin
	
===
	
### 在自己的本地电脑上：

#### clone开发机上的kazoo代码

git clone ssh://root@192.168.1.11/home/zhuwei5e/my_repo/.git
git pull origin master

#### 本地修改代码后可以push到远端仓库，也可以从远端仓库pull下来

	git push
	git pull

=====

### 可能会遇到的问题

#### 初始化远端库的时候，使用的命令：git --init

在push的时候，可能会出现错误，这时：

在remote端，设置git的配置文件（.git/config），在其中添加如下内容： 
	
	[receive]
	denyCurrentBranch = false

这样就可以通过git push提交自己的稳定更新，要想在push后在remote端看到更新的效果，执行：
	
	git reset --hard


## 实例2：使用上游仓库创建自己的远程仓库

使用2600hz的kazoo的镜像库
### 在本地，复制 2600hz/kazoo 镜像库
	git clone --mirror https://github.com/2600hz/kazoo.git
	
### 在服务器，生成自己的远程裸仓库
服务器IP:192.168.1.11

	mkdir -p /opt/repo
	cd /opt/repo
	git init --bare	kazoo.git
 
### 在本地kazoo镜像库，添加上游源和自己的远程库源
	cd kazoo.git
	# 添加上游源和自己的远程库源
	git remote rename origin upstream
	git remote add origin ssh://root@192.168.1.11/opt/repo/kazoo.git
 
### 将镜像仓库推送到 git stash
	git push --all origin
	git push --tags origin
 
### 上游代码同步: 在本地kazoo.git镜像库定期执行以下操作进行同步并推送到git stash
	git fetch --prune upstream
	git push --all origin
	git push --tags origin
	
## 实例3：多个远程库，多个开发者

本地mac用于coding，而且本地环境不能运行程序，需要在服务器上编译运行，同时代码在公司git仓库。通过在服务器建一个新远程库，然后将本地coding的代码push到服务端远程库，这样在服务器运行程序的pull服务器上的远程库，编译运行，调试通过之后，最后将本地通过的代码push到公司的git库上。

步骤：

1. 在服务器设置空仓库

		mkdir -p /opt/repo
		cd /opt/repo
		git init --bare example.git
 
2. 在本地mac从公司git库clone，同时更改上游源，并添加服务器的空仓库为新的origin源

		mkdir src
		cd src
		git clone ssh://git@example.com/example.git
		git remote rename origin upstream
		git remote add origin ssh://root@192.168.1.11/opt/repo/example.git
		git push origin master
	
3. 在服务器编译运行目录拉去服务器端的仓库

		mkdir -p /opt/src
		cd /opt/src
		git clone root@192.168.1.11/opt/repo/example.git
		

## 实例4 本地仓库上传到远程仓库

	cd existing-project
	git init
	git add --all
	git commit -m "Initial Commit"
	git remote add origin git@{your_github_repo}.git
	git push origin master

* [git将本地仓库上传到远程仓库](http://blog.csdn.net/w13770269691/article/details/38704941)
* [将在本地创建的Git仓库push到Git@OSC](http://my.oschina.net/flan/blog/162189)




	

