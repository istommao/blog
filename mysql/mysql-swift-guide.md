# mysql swift guide


## 基础命令


### mysql创建用户

（abc为用户，xxx为密码）

	grant all privileges on *.* to 'abc'@'localhost' identified by 'xxx';
	grant all privileges on *.* to 'abc'@'%' identified by 'xxx';
	FLUSH PRIVILEGES;

或者分步：

	创建用户
	CREATE USER 'username'@'hostname' IDENTIFIED BY 'password';
	
	设置权限：(xxx为密码)
	
	grant all privileges on *.* to 'abc'@'localhost' identified by 'xxx';
	grant all privileges on *.* to 'abc'@'%' identified by 'xxx';
	
	FLUSH PRIVILEGES;

连接和查询：

	mysql -u abc -p
	
	select host,user,password from mysql.user where user='abc';
	select * from mysql.user
	
	
### 更改密码

* [MySQL 修改用户密码及重置root密码](http://blog.csdn.net/leshami/article/details/39805839)

#### 重置root帐户密码（忘记root密码）

(以mac为例, mysql 5.7为例：mysql数据库下已经没有password这个字段了，`password`字段改成了
`authentication_string`)

停止mysql

	mysql.server stop
	
使用--skip-grant-tables选项跳过授权表验证

	mysqld --skip-grant-tables --user=mysql & 
	
查询和更改：

	select user,host,password from mysql.user where user='root'; 
	update mysql.user set password=password('root') where user='root'; 
	
**p.s.**
	
* 如果提示不存在`password`，将其更改为：`authentication_string`

* 如果是mysql5.7，应该使用命令：

		alter mysql.user 'root'@'localhost' IDENTIFIED BY 'root'

退出mysqld：

	找到对应mysql的进程，将其kill掉
	ps -ef | grep mysqld
	kill xxx
	
重新mysql

	mysql.server start
	
登录

	mysql -uroot -p	
	
	


	
			
		
	


	

	
	
### 导入导出

在 `mysqldump` 命令中指定数据库名及数据表

导出整个数据库的数据

	mysqldump -u root -p database_name > database_dump.txt
	
需要备份所有数据库，可以使用以下命令

	mysqldump -u root -p --all-databases > database_dump.txt


导出SQL格式的数据到指定文件

	mysqldump -u root -p database_name table_name > dump.txt	
	
需要将备份的数据库导入到MySQL服务器中，可以使用以下命令，使用以下命令你需要确认数据库已经创建：

	mysql -u root -p database_name < dump.txt
	
	
你也可以使用以下命令将导出的数据直接导入到远程的服务器上，但请确保两台服务器是相通的，是可以相互访问的：

	// 使用了管道来将导出的数据导入到指定的远程主机上
	mysqldump -u root -p database_name | mysql -h other-host.com database_name		

实例：

	导出数据库
	mysqldump -h host  --default-character-set=utf8 --hex-blob --opt --routines --triggers --events --master-data  --single-transaction -P3306 -u username -p password  -B dbname > dbname.sql
	


## 不同数据库区别关注
数据类型

分页属性：

	limit 3, 2
	
自动递增

	auto_increment	
	
日期

	select_date_format(now(), '%Y-%m-%d %H:%i:%s);
	
		

## 命令

	create database mydata;
	user mydata;
	
	create table dept(deptno int primay key, dname varchar(14), loc varchar(13));
	
	create table emp(empno int primary key, ename varchar(10), job varchar(10), mgr int, hiradarte datetime, sal double, depto int, foreign key(deptono) references dept(deptno));
	
	insert into dept values (10, 'A', 'A');
	
## jdbc



## 参考

* [菜鸟教程](http://www.runoob.com/)
		
	