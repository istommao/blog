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
	show full processlist
	select * from information_schema.processlist where command != 'sleep';

### 查看锁状态

获取锁定次数、锁定造成其他线程等待次数，以及锁定等待时间信息

	show status like '%lock%'

还可以通过检查`table_locks_waited`和`table_locks_immediate`状态变量来分析系统上的表锁定争夺，当`Table_locks_waited`与`Table_locks_immediate`的**比值**较大，则说明我们的表锁造成的阻塞比较严重，可能需要调整Query语句，或者更改存储引擎，亦或者需要调整业务逻辑。
	
	show status like 'Table%'

### 关于锁的表

* <https://my.oschina.net/jiaoya/blog/92194>

在5.5中，information_schema 库中增加了三个关于锁的表（MEMORY引擎）；

* innodb_trx ## 当前运行的所有事务
* innodb_locks ## 当前出现的锁
* innodb_lock_waits ## 锁等待的对应关系

查询这几个表信息：


information_schema.innodb_locks:

	desc information_schema.innodb_locks;
	
	+-------------+---------------------+------+-----+---------+-------+
	| Field | Type | Null | Key | Default | Extra |
	+-------------+---------------------+------+-----+---------+-------+
	| lock_id | varchar(81) | NO | | | |#锁ID
	| lock_trx_id | varchar(18) | NO | | | |#拥有锁的事务ID
	| lock_mode | varchar(32) | NO | | | |#锁模式
	| lock_type | varchar(32) | NO | | | |#锁类型
	| lock_table | varchar(1024) | NO | | | |#被锁的表
	| lock_index | varchar(1024) | YES | | NULL | |#被锁的索引
	| lock_space | bigint(21) unsigned | YES | | NULL | |#被锁的表空间号
	| lock_page | bigint(21) unsigned | YES | | NULL | |#被锁的页号
	| lock_rec | bigint(21) unsigned | YES | | NULL | |#被锁的记录号
	| lock_data | varchar(8192) | YES | | NULL | |#被锁的数据
	+-------------+---------------------+------+-----+---------+-------+
	

information_schema.innodb\_lock\_waits:
information_schema.innodb\_lock\_waits:

	desc information_schema.innodb_lock_waits;
	+-------------------+-------------+------+-----+---------+-------+
	| Field | Type | Null | Key | Default | Extra |
	+-------------------+-------------+------+-----+---------+-------+
	| requesting_trx_id | varchar(18) | NO | | | |#请求锁的事务ID
	| requested_lock_id | varchar(81) | NO | | | |#请求锁的锁ID
	| blocking_trx_id | varchar(18) | NO | | | |#当前拥有锁的事务ID
	| blocking_lock_id | varchar(81) | NO | | | |#当前拥有锁的锁ID
	+-------------------+-------------+------+-----+---------+-------+

information_schema.innotdb\_trx:

	desc information_schema.innodb_trx;
	+----------------------------+---------------------+------+-----+---------------------+-------+
	| Field | Type | Null | Key | Default | Extra |
	+----------------------------+---------------------+------+-----+---------------------+-------+
	| trx_id | varchar(18) | NO | | | |#事务ID
	| trx_state | varchar(13) | NO | | | |#事务状态：
	| trx_started | datetime | NO | | 0000-00-00 00:00:00 | |#事务开始时间；
	| trx_requested_lock_id | varchar(81) | YES | | NULL | |#innodb_locks.lock_id
	| trx_wait_started | datetime | YES | | NULL | |#事务开始等待的时间
	| trx_weight | bigint(21) unsigned | NO | | 0 | |#
	| trx_mysql_thread_id | bigint(21) unsigned | NO | | 0 | |#事务线程ID
	| trx_query | varchar(1024) | YES | | NULL | |#具体SQL语句
	| trx_operation_state | varchar(64) | YES | | NULL | |#事务当前操作状态
	| trx_tables_in_use | bigint(21) unsigned | NO | | 0 | |#事务中有多少个表被使用
	| trx_tables_locked | bigint(21) unsigned | NO | | 0 | |#事务拥有多少个锁
	| trx_lock_structs | bigint(21) unsigned | NO | | 0 | |#
	| trx_lock_memory_bytes | bigint(21) unsigned | NO | | 0 | |#事务锁住的内存大小（B）
	| trx_rows_locked | bigint(21) unsigned | NO | | 0 | |#事务锁住的行数
	| trx_rows_modified | bigint(21) unsigned | NO | | 0 | |#事务更改的行数
	| trx_concurrency_tickets | bigint(21) unsigned | NO | | 0 | |#事务并发票数
	| trx_isolation_level | varchar(16) | NO | | | |#事务隔离级别
	| trx_unique_checks | int(1) | NO | | 0 | |#是否唯一性检查
	| trx_foreign_key_checks | int(1) | NO | | 0 | |#是否外键检查
	| trx_last_foreign_key_error | varchar(256) | YES | | NULL | |#最后的外键错误
	| trx_adaptive_hash_latched | int(1) | NO | | 0 | |#
	| trx_adaptive_hash_timeout | bigint(21) unsigned | NO | | 0 | |#
	+----------------------------+---------------------+------+-----+---------------------+-------+

select innotdb_trx:

	select * from information_schema.innodb_trx
	select * from information_schema.innodb_lock_waits;
	select * from information_schema.innodb_locks;
	
	

## 参考
## 参考

* [MySQL中的行级锁,表级锁,页级锁](http://www.hollischuang.com/archives/914)