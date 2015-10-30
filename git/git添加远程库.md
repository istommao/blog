#git添加远程库
====

##在远端服务器

###创建git库

	cd /home/zhuwei5e/my_repo
	git init (git init --bare)

###编辑.gitignore文件

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


###向仓库提交自己的代码
	touch helloword.java
	git add .
	git commit -a -m "java program hello word"
	git stauts

###添加一个远程仓库,并将本地的master分支跟踪到远程分支

	git remote add origin ssh://root@192.168.1.11/home/zhuwei5e/my_repo/.git
	git push origin master

p.s. 上面的192.168.1.11地址是远端服务器的的IP 。

现在git仓库已经是一个远程仓库了。测试：

	git remote show origin
	
===
	
##在自己的本地电脑上：

###clone开发机上的kazoo代码

git clone ssh://root@192.168.1.11/home/zhuwei5e/my_repo/.git
git pull origin master

###本地修改代码后可以push到远端仓库，也可以从远端仓库pull下来

	git push
	git pull

=====

##可能会遇到的问题

###初始化远端库的时候，使用的命令：git --init

在push的时候，可能会出现错误，这时：

在remote端，设置git的配置文件（.git/config），在其中添加如下内容： 
	
	[receive]
	denyCurrentBranch = false

这样就可以通过git push提交自己的稳定更新，要想在push后在remote端看到更新的效果，执行：
	
	git reset --hard




	

