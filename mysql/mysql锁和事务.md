title: mysql锁和事务
date: 2016-06-22 23:55:00
tags:
- mysql
- transaction
- lock

# mysql锁和事务


## 查看锁日志

* http://825635381.iteye.com/blog/2339503

### 查看日志：

	show engine innodb status \G; 
	
找到`“LATEST DETECTED DEADLOCK”` 进行分析。 


### 查看进程状态

通过此命令可以查看哪些sql在等待锁：

	show processlist;

### 查看锁状态

获取锁定次数、锁定造成其他线程等待次数，以及锁定等待时间信息

	show status like '%lock%'
	
还可以通过检查`table_locks_waited`和`table_locks_immediate`状态变量来分析系统上的表锁定争夺，当`Table_locks_waited`与`Table_locks_immediate`的**比值**较大，则说明我们的表锁造成的阻塞比较严重，可能需要调整Query语句，或者更改存储引擎，亦或者需要调整业务逻辑。
	
	show status like 'Table%'
	
	
	
	
	


## 参考

* [MySQL中的行级锁,表级锁,页级锁](http://www.hollischuang.com/archives/914)