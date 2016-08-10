# linux知识、命令和技巧

## 统计文件夹下的总行数

	$ wc -l `find . -name *.c`
	$ find . -name "*.html" | xargs wc -l

其中，-l 参数是统计行数，find -name *.c 是查找当前目录（包含子目录）下所有的C文件，\` \` 是 shell 中的替换命令。

<http://www.cnblogs.com/wangkangluo1/archive/2012/05/26/2518855.html>


## 查看硬盘使用情况
	df -lh
	
	查看文件夹占用大小
	du -sh /*
	查看当个文件夹
	du -sh /var
	du -sh /var/*
	du -h --max-depth=1 /var
	du -h -d 1 (功能同上)
	du -h /var
	
	查看文件大小
	ls -lAh /var/log
	
## crontab

crond是linux下用来周期性的执行某种任务或等待处理某些事件的一个守护进程

基本格式 : 

	*　　*　　*　　*　　*　　command 
	分　时　日　月　周　命令 
	f1 f2 f3 f4 f5 program 
	
* `*`表示每。比如: 当 f1 为 `*` 时表示每分钟都要执行 program
* `/`	表示每间隔。比如：当 f1 为 `*/n` 时表示每 `n` 分钟个时间间隔执行一次
* `-`表示区间。比如：当 f1 为 `a-b` 时表示从第 a 分钟到第 b 分钟这段时间内要执行
* `,`表示某个(些)特定值。比如：当 f1 为 `a, b, c,...` 时表示第 a, b, c,... 分钟要执行。

实例：

在 12 月内, 每天的早上 6 点到 12 点中，每隔3个小时执行一次 /usr/bin/backup : 

	0 6-12/3 * 12 * /usr/bin/backup 


使用方式 : 

	crontab file [-u user]-用指定的文件替代目前的crontab。 
	crontab [-u user]-用标准输入替代目前的crontab. 
	crontab -1[user]-列出用户目前的crontab. 
	crontab -e[user]-编辑用户目前的crontab. 
	crontab -d[user]-删除用户目前的crontab. 
	crontab -c dir- 指定crontab的目录。 
	
### crontab 问题

* 输出

	重定向 `stdout` 和 `stderr`:
		
		>> $HOME/log/file 2>&1
		
* 环境变量

	crontab会以用户的身份执行配置的命令，但是不会加载用户的环境变量，crontab会设置几个默认的环境变量，例如`SHELL`、`PATH`和`HOME`等，一定要注意PATH可不是用户自定义的PATH。

	我们往往会在`.bash_profile`文件中定义一些全局的环境变量，但是crontab执行时并不会加载这个文件，所以你在shell中正常执行的程序，放到crontab里就不行了，很可能就是因为找不到环境变量了。要解决这个问题只能是自己加载环境变量了，可以在shell脚本中添加`source $HOME/.bash_profile`，或者直接添加到`crontab`中。
	
		0 12 * * * source $HOME/.bash_profile && $HOME/path/to/script > $HOME/log/file 2>&1
		
* 路径

	在写脚本时往往会使用相对路径，但是在crontab执行脚本时，由于工作目录不同，就会出现找不到文件或者目录不存在的问题。

	解决方法是脚本中使用绝对路径或者在执行程序前切换工作目录，例如直接在crontab命令中切换工作目录
	
		0 12 * * * source $HOME/.bash_profile && cd $HOME/path/to/workdir && ./script > /HOME/log/file 2>&1	
		
* 编码

	Python程序中输出了一些中文（编码是utf-8），在shell中直接执行没有问题，但是crontab执行时出现了`UnicodeEncodeError`的错误
	
	解决方法：
	
	* 方法一：在程序中输出的字符串都加上`encode('utf-8')`
	* 方法二：在crontab中加上`PYTHONIOENCODING=utf-8`，将Python的stdout/stderr/stdin编码设置为utf-8
	
		
		
	
## 历史命令

终端输入`ctrl+r`，然后根据提示输入想要输入的命令，这时会自动查找历史命令，给出相关提示。

	
## screen工具的使用

进入使用：
	
	screen

或指定session名字 

	screen -S name


离开：

	ctrl + a d 或者直接关闭终端，自动会以detached模式运行

回来： 

	screen -ls 
	得到的结果后，从结果中获得screen的标示xxx, 然后执行： 
	screen -r xxx。
	
如果设置了session的名字name，可以直接使用

	screen -r name
	
如果想重新连接已经attach的session（这种情况往往会发生在短暂断网，该session会被原来的连接占用）：

	screee -x name

关闭： 

	ctrl +a k

清除死掉的窗口： 
	
	screen -wipe

常见启动screen执行操作

	screen -d -m
	screen -dmS sessionname abc sh-cmd

给session命名和重连

	screen -S session_name
	screen -r session_name	
	
在一个session中新建窗口并切换

	新建： ctrl +a c
	切换： ctrl +a n(下一个) ctrl +a p(前一个)

更多命令：

	crtl +a ?
	
> 类似工具tmux[使用tmux](http://www.wushxin.top/2016/03/28/%E4%BD%BF%E7%94%A8tmux.html)

## tmux工具的使用	

默认前缀：`ctrl + b`

	tmux new -s session
	tmux new -s session -d #在后台建立会话
	tmux ls #列出会话
	tmux attach -t session #进入某个会话
	tmux a -t session

在一个session中新建窗口并切换

	新建： ctrl +b c
	切换： ctrl +b n(下一个) ctrl +b p(前一个)
	
离开：

	ctrl + b d 或者直接关闭终端，自动会以detached模式运行	
	

更多命令：

	crtl +b ?
	
	
	
* [tmux的使用方法和个性化配置](http://mingxinglai.com/cn/2012/09/tmux/)	

## vim配置

* [Vim配置](../software_usage/vim.md)

## ssh配置

* [ssh配置](../ssh/ssh.md)

	
	