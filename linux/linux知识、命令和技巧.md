#linux知识、命令和技巧

##统计文件夹下的总行数

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
	
	
##screen工具的使用

进入使用：
	
	screen

或指定名字 

	screen -S name


离开：

	ctrl + a d 或者直接关闭终端，自动会以detached模式运行

回来： 

	screen -ls 
	得到的结果后，从结果中获得screen的标示xxx, 然后执行： 
	screen -r xxx。
	
如果设置了name，可以直接使用

	screen -r name

关闭： 

	ctral +a k

清除死掉的窗口： 
	
	screen -wipe

常见启动screen执行操作

	screen -d -m
	screen -dmS sessionname abc sh-cmd

给session命名和重连

	screen -S session_name
	screen -r session_name	