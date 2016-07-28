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

## 查看表结构

	desc tablename;