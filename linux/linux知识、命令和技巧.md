# linux知识、命令和技巧

## 统计文件夹下的总行数

	$ wc -l `find . -name *.c`
	$ find . -name "*.html" | xargs wc -l

其中，-l 参数是统计行数，find -name *.c 是查找当前目录（包含子目录）下所有的C文件，\` \` 是 shell 中的替换命令。

<http://www.cnblogs.com/wangkangluo1/archive/2012/05/26/2518855.html>


##查看硬盘使用情况
	df -lh
	
	查看文件夹占用大小
	du -sh /*
	查看当个文件夹
	du -sh /var
	du -sh /var/*
	du -h --max-depth=1 /var
	du -h /var
	
	查看文件大小
	ls -lAh /var/log
	
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

在一个session中新建窗口并切换

	新建： ctrl +b c
	切换： ctrl +b n(下一个) ctrl +b p(前一个)
	
离开：

	ctrl + b d 或者直接关闭终端，自动会以detached模式运行	
	

更多命令：

	crtl +b ?
	
	
	
* [tmux的使用方法和个性化配置](http://mingxinglai.com/cn/2012/09/tmux/)	

## vim配置

* [Vim配置](../software_usage/Vim.md)

## ssh配置

* [ssh配置](../ssh/ssh.md)

	
	