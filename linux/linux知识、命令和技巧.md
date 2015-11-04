#linux知识、命令和技巧

##统计文件夹下的总行数

	$ wc -l `find . -name *.c`
	$ find . -name "*.html" | xargs wc -l

其中，-l 参数是统计行数，find -name *.c 是查找当前目录（包含子目录）下所有的C文件，` ` 是 shell 中的替换命令。

<http://www.cnblogs.com/wangkangluo1/archive/2012/05/26/2518855.html>
