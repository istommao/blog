title: grep命令
date: 2016-09-28 12:04
tags:
- linux
- grep

# grep命令

## grep file text

	grep -rl "string" /path
	grep -Hrn 'search term' path/to/files
	grep -nrI 'search term' .
	grep -inrI 'search term' .
	grep -nrI --exclude-dir=tests --exclude="*.tag*" "pattern" .

* r: 递归；l: 打印匹配的文件名；H: 打印文件名；n:打印行号
* I: 忽略二进制文件
* F: 将‘search term’作为文本，非正则表达式
* i: 大小写
* --exclude-dir=: 排除目录
* --exlucde/--include=: 排除 pattern

## 统计grep结果的行数

	grep -c "search term" filename
	grep "search term" filename | wc -l
	



	