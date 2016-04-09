#mysql swift guide


##基础命令


###mysql创建用户
（abc为用户，xxx为密码）

	grant all privileges on *.* to 'abc'@'localhost' identified by 'xxx'
	grant all privileges on *.* to 'abc'@'%' identified by 'xxx'

或者分步：

	创建用户
	CREATE USER 'username'@'hostname' IDENTIFIED BY 'password';
	
	设置权限：(xxx为密码)
	
	grant all privileges on *.* to 'abc'@'localhost' identified by 'xxx'
	grant all privileges on *.* to 'abc'@'%' identified by 'xxx'

连接和查询：

	mysql -u abc -p
	select * from mysql.user


##不同数据库区别关注
数据类型

分页属性：

	limit 3, 2
	
自动递增

	auto_increment	
	
日期

	select_date_format(now(), '%Y-%m-%d %H:%i:%s);
	
		

##命令

	create database mydata;
	user mydata;
	
	create table dept(deptno int primay key, dname varchar(14), loc varchar(13));
	
	create table emp(empno int primary key, ename varchar(10), job varchar(10), mgr int, hiradarte datetime, sal double, depto int, foreign key(deptono) references dept(deptno));
	
	insert into dept values (10, 'A', 'A');
	
##jdbc




		
	