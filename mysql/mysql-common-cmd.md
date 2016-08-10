title: mysql 常见操作
date: 2016-07-28 11:44:00
tags:
- mysql

# mysql 常见操作

## 查看用户权限

	show grants;
	show grants for 'root'
	select * from mysql.user;
	select * from information_schema.user_privileges;
	
### 权限设置


	grant all privileges on database.table to 'user'@'host' identified by 'password';
	flush privileges;	
	
	mysql> CREATE USER 'migration'@'%' IDENTIFIED BY 'migration@20160810';
	mysql> GRANT ALL PRIVILEGES ON *.* TO 'migration'@'%';

## 查看表结构

	desc tablename;
	
## 设置只读

将MySQL设置为只读状态的命令：

	# mysql -uroot -p
	mysql> show global variables like "%read_only%";
	mysql> flush tables with read lock;
	mysql> set global read_only=1;
	mysql> show global variables like "%read_only%";


将MySQL从只读设置为读写状态的命令：

	mysql> unlock tables;
	mysql> set global read_only=0;
	
* 参考：[mysql只读模式的设置方法与实验](http://blog.csdn.net/yumushui/article/details/41645469)	

 