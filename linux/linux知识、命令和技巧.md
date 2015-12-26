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