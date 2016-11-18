title: mysql的count
date: 2016-11-17 17:06:00
tags:
- mysql
- count


# mysql的count

## select count(*)
* [optimize mysql count query](http://stackoverflow.com/questions/4400451/optimize-mysql-count-query)
* [Fast count(*) for InnoDB](http://mysqlha.blogspot.hk/2009/08/fast-count-for-innodb.html)
* [mysql-count-performance-on-very-big-tables](http://stackoverflow.com/questions/10976328/mysql-count-performance-on-very-big-tables)



引用 [mysql restrictions](http://dev.mysql.com/doc/refman/5.5/en/innodb-restrictions.html)

> InnoDB does not keep an internal count of rows in a table because concurrent transactions might “see” different numbers of rows at the same time. Consequently, SELECT COUNT(*) FROM t statements only count rows visible to the current transaction.

> To process a SELECT COUNT(*) FROM t statement, InnoDB scans an index of the table, which takes some time if the index is not entirely in the buffer pool. For a faster count, you can create a counter table and let your application update it according to the inserts and deletes it does. However, this method may not scale well in situations where thousands of concurrent transactions are initiating updates to the same counter table. If an approximate row count is sufficient, SHOW TABLE STATUS can be used.


### python专题

* [Why is SQLAlchemy count much slower than the raw query](http://stackoverflow.com/questions/14754994/why-is-sqlalchemy-count-much-slower-than-the-raw-query)
* [How to count rows with SELECT COUNT with SQLAlchemy](http://stackoverflow.com/questions/12941416/how-to-count-rows-with-select-count-with-sqlalchemy)
* [performance](http://docs.sqlalchemy.org/en/latest/faq/performance.html)



## insert,update增加的函数

* [Getting number of rows inserted for ON DUPLICATE KEY UPDATE](http://stackoverflow.com/questions/10925632/getting-number-of-rows-inserted-for-on-duplicate-key-update-multiple-insert)






