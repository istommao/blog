title: sqlite3简介
date: 2016-03-03 00:04:00
tags:
- sqlite
- Mac

----


# sqlite3简介
----

Mac电脑，打开`iTerm2`，进入需要创建sqlite数据库的路径，输入：


	cd ~
	sqlite3 my-dev.sqlite
	
## 命令

帮助

	sqlite> .help

显示表

	sqlite> .tables 	

创建表，直接写上sql语句

	sqlite> CREATE TABLE users (
		id INTEGER NOT NULL,
		email VARCHAR(64),
		username VARCHAR(64),
		password_hash VARCHAR(128),
		PRIMARY KEY (id),
	);
	
CRUD：直接写sql即可
		
查看表的shcema

	sqlite> .schema [表名]	
		
其他的一些命令通过`.help`查看		
	
