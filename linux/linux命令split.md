title: linux命令split
date: 2017-01-24 09:59:00
tags:
- linux
- split

# linux命令split

* <http://man.linuxde.net/split>

`split`命令可以将一个大文件分割成很多个小文件，有时需要将文件分割成更小的片段，比如为提高可读性，生成日志等。

* -b：值为每一输出档案的大小，单位为 byte。 
* -C：每一输出档中，单行的最大 byte 数。 
* -d：使用数字作为后缀。 
* -l：值为每一输出档的列数大小。

实例：

生成一个大小为 100KB 的测试文件:

	dd if=/dev/null bs=100k count=1 of=data.file
	
将 100KB 数据分割为 10KB 的小文件:

	split -b 10k data.file 
	
分割成多个带字母后缀的文件，如果想用数字后缀可以使用 `-d`，同时可以使用 `-a length` 指定后缀长度:

	split -b 10k data.file -d -a 3
	
指定前缀:

	split -b 10k data.file -d -a 3 split_file
	
指定行数 `-l`:

	split -l 10 data.file

指定后缀:

	split -b 10k data.file split_file

	for file in split_file*
	do
	    mv "$file" "$file.txt"
	done
