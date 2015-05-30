#MySQL学习
======

#什么是数据库
====
数据库（Database）是按照数据结构来组织、存储和管理数据的仓库，

每个数据库都有一个或多个不同的API用于创建，访问，管理，搜索和复制所保存的数据。

我们也可以将数据存储在文件中，但是在文件中读写数据速度相对较慢。

所以，现在我们使用关系型数据库管理系统（RDBMS）来存储和管理的大数据量。所谓的关系型数据库，是建立在关系模型基础上的数据库，借助于集合代数等数学概念和方法来处理数据库中的数据。

RDBMS即关系数据库管理系统(Relational Database Management System)的特点：

1. 数据以表格的形式出现
2. 每行为各种记录名称
3. 每列为记录名称所对应的数据域
4. 许多的行和列组成一张表单
5. 若干的表单组成database


#RDBMS 术语
====
在我们开始学习MySQL 数据库前，让我们先了解下RDBMS的一些术语：

* 数据库: 数据库是一些关联表的集合。.
* 数据表: 表是数据的矩阵。在一个数据库中的表看起来像一个简单的电子表格。
* 列: 一列(数据元素) 包含了相同的数据, 例如邮政编码的数据。
* 行：一行（=元组，或记录）是一组相关的数据，例如一条用户订阅的数据。
* 冗余：存储两倍数据，冗余可以使系统速度更快。
* 主键：主键是唯一的。一个数据表中只能包含一个主键。你可以使用主键来查询数据。
* 外键：外键用于关联两个表。
* 复合键：复合键（组合键）将多个列作为一个索引键，一般用于复合索引。
* 索引：使用索引可快速访问数据库表中的特定信息。索引是对数据库表中一列或多列的值进行排序的一种结构。类似于书籍的目录。
* 参照完整性: 参照的完整性要求关系中不允许引用不存在的实体。与实体完整性是关系模型必须满足的完整性约束条件，目的是保证数据的一致性。

#Mysql数据库
=======
MySQL是一个关系型数据库管理系统，由瑞典MySQL AB公司开发，目前属于Oracle公司。MySQL是一种关联数据库管理系统，关联数据库将数据保存在不同的表中，而不是将所有数据放在一个大仓库内，这样就增加了速度并提高了灵活性。

* Mysql是开源的，所以你不需要支付额外的费用。
* Mysql支持大型的数据库。可以处理拥有上千万条记录的大型数据库。
* MySQL使用标准的SQL数据语言形式。
* Mysql可以允许于多个系统上，并且支持多种语言。这些编程语言包括C、C++、Python、Java、Perl、PHP、Eiffel、Ruby和Tcl等。
* Mysql对PHP有很好的支持，PHP是目前最流行的Web开发语言。
* MySQL支持大型数据库，支持5000万条记录的数据仓库，32位系统表文件最大可支持4GB，64位系统支持最大的表文件为8TB。
* Mysql是可以定制的，采用了GPL协议，你可以修改源码来开发自己的Mysql系统。


#MySQL安装
=====
Mysql安装成功后，默认的root用户密码为空，你可以使用以下命令来创建root用户的密码：

```
mysqladmin -u root password "new_password";
```

以通过以下命令来连接到Mysql服务器：

```
mysql -u root -p
```
#MySQL管理
===
##启动及关闭 MySQL 服务器
首先，我们需要通过以下命令来检查MySQL服务器是否启动：

```
ps -ef | grep mysqld
```

如果MySql已经启动，以上命令将输出mysql进程列表， 如果mysql未启动，你可以使用以下命令来启动mysql服务器:

```
root@host# cd /usr/bin
./safe_mysqld &
```
如果你想关闭目前运行的 MySQL 服务器, 你可以执行以下命令:

```
root@host# cd /usr/bin
./mysqladmin -u root -p shutdown
```
##MySQL 用户设置

```
mysql> INSERT INTO user 
          (host, user, password, 
           select_priv, insert_priv, update_priv) 
           VALUES ('localhost', 'guest', 
           PASSWORD('guest123'), 'Y', 'Y', 'Y');
        
mysql> FLUSH PRIVILEGES;
           
```

##管理MySQL的命令
以下列出了使用Mysql数据库过程中常用的命令：

* USE 数据库名 :选择要操作的Mysql数据库，使用该命令后所有Mysql命令都只针对该数据库。
* SHOW DATABASES: 列出 MySQL 数据库管理系统的数据库列表。
* SHOW TABLES: 显示指定数据库的所有表，使用该命令前需要使用 use 命令来选择要操作的数据库。
* SHOW COLUMNS FROM 数据表: 显示数据表的属性，属性类型，主键信息 ，是否为 NULL，默认值等其他信息。
* SHOW INDEX FROM 数据表: 显示数据表的详细索引信息，包括PRIMARY KEY（主键）。
* SHOW TABLE STATUS LIKE 数据表\G: 该命令将输出Mysql数据库管理系统的性能及统计信息。


#MySQL常用语法

##命令行操作：

    登陆：
    mysql -u root -p
    退出：
    exit
    创建数据库：
    mysqladmin -u root -p create TUTORIALS
    删除数据库：
    mysqladmin -u root -p drop TUTORIALS
    选择数据库：
    use TUTORIALS;
    创建数据表：
    CREATE TABLE table_name (column_name column_type);
	 e.g:
	 mysql> CREATE TABLE tutorials_tbl(
   		-> tutorial_id INT NOT NULL AUTO_INCREMENT,
   		-> tutorial_title VARCHAR(100) NOT NULL,
   		-> tutorial_author VARCHAR(40) NOT NULL,
   		-> submission_date DATE,
   		-> PRIMARY KEY ( tutorial_id )
   		-> );
   	删除数据表：
   	DROP TABLE table_name ;
   	插入数据：
   	INSERT INTO table_name ( field1, field2,...fieldN )
                       VALUES
                       ( value1, value2,...valueN );
    e.g.
    mysql> INSERT INTO tutorials_tbl 
     ->(tutorial_title, tutorial_author, submission_date)
     ->VALUES
     ->("Learn PHP", "John Poul", NOW());
    查询数据：
    SELECT field1, field2,...fieldN table_name1, table_name2...
[WHERE Clause]
[OFFSET M ][LIMIT N]

##PHP操作
PHP对MySQL有专用的接口进行处理。

#MySQL数据类型
MySQL中定义数据字段的类型对你数据库的优化是非常重要的。

MySQL支持多种类型，大致可以分为三类：数值、日期/时间和字符串(字符)类型。

##数值类型
MySQL支持所有标准SQL数值数据类型。

这些类型包括严格数值数据类型(INTEGER、SMALLINT、DECIMAL和NUMERIC)，以及近似数值数据类型(FLOAT、REAL和DOUBLE PRECISION)。

关键字INT是INTEGER的同义词，关键字DEC是DECIMAL的同义词。

BIT数据类型保存位字段值，并且支持MyISAM、MEMORY、InnoDB和BDB表。

作为SQL标准的扩展，MySQL也支持整数类型TINYINT、MEDIUMINT和BIGINT。
    

##日期和时间类型
表示时间值的日期和时间类型为DATETIME、DATE、TIMESTAMP、TIME和YEAR。

每个时间类型有一个有效值范围和一个"零"值，当指定不合法的MySQL不能表示的值时使用"零"值。    

##字符串类型
字符串类型指CHAR、VARCHAR、BINARY、VARBINARY、BLOB、TEXT、ENUM和SET。

CHAR和VARCHAR类型类似，但它们保存和检索的方式不同。它们的最大长度和是否尾部空格被保留等方面也不同。在存储或检索过程中不进行大小写转换。

BINARY和VARBINARY类类似于CHAR和VARCHAR，不同的是它们包含二进制字符串而不要非二进制字符串。也就是说，它们包含字节字符串而不是字符字符串。这说明它们没有字符集，并且排序和比较基于列值字节的数值值。

BLOB是一个二进制大对象，可以容纳可变数量的数据。有4种BLOB类型：TINYBLOB、BLOB、MEDIUMBLOB和LONGBLOB。它们只是可容纳值的最大长度不同。

有4种TEXT类型：TINYTEXT、TEXT、MEDIUMTEXT和LONGTEXT。这些对应4种BLOB类型，有相同的最大长度和存储需求。

##MySQL where 子句

我们知道从MySQL表中使用SQL SELECT 语句来读取数据。

如需有条件地从表中选取数据，可将 WHERE 子句添加到 SELECT 语句中。

语法

以下是SQL SELECT 语句使用 WHERE 子句从数据表中读取数据的通用语法：

	SELECT field1, field2,...fieldN FROM table_name1, table_name2...
	[WHERE condition1 [AND [OR]] condition2.....
	e.g.
	SELECT * from tutorials_tbl WHERE tutorial_author='Sanjay';

* 查询语句中你可以使用一个或者多个表，表之间使用逗号(,)分割，并使用WHERE语句来设定查询条件。
* 你可以在WHERE子句中指定任何条件。
* 你可以使用AND或者OR指定一个或多个条件。
* WHERE子句也可以运用于SQL的 DELETE 或者 UPDATE 命令。
* WHERE 子句类似于程序语言中的if条件，根据 MySQL 表中的字段值来读取指定的数据。

##MySQL UPDATE 查询

如果我们需要修改或更新MySQL中的数据，我们可以使用 SQL UPDATE 命令来操作。.

语法

以下是 UPDATE 命令修改 MySQL 数据表数据的通用SQL语法：

	UPDATE table_name SET field1=new-value1, field2=new-value2
	[WHERE Clause]
	e.g.
	UPDATE tutorials_tbl 
    -> SET tutorial_title='Learning JAVA' 
    -> WHERE tutorial_id=3;

* 你可以同时更新一个或多个字段。
* 你可以在 WHERE 子句中指定任何条件。
* 你可以在一个单独表中同时更新数据。
* 当你需要更新数据表中指定行的数据时 WHERE 子句是非常有用的。

##MySQL DELETE 语句

你可以使用 SQL 的 DELETE FROM 命令来删除 MySQL 数据表中的记录。

你可以在mysql>命令提示符或PHP脚本中执行该命令。

语法

以下是SQL DELETE 语句从MySQL数据表中删除数据的通用语法：

	DELETE FROM table_name [WHERE Clause]
	e.g.
	DELETE FROM tutorials_tbl WHERE tutorial_id=3;


* 如果没有指定 WHERE 子句，MySQL表中的所有记录将被删除。
* 你可以在 WHERE 子句中指定任何条件
* 您可以在单个表中一次性删除记录。
* 当你想删除数据表中指定的记录时 WHERE 子句是非常有用的。


##MySQL LIKE 子句

我们知道在MySQL中使用 SQL SELECT 命令来读取数据， 同时我们可以在 SELECT 语句中使用 WHERE 子句来获取指定的记录。

WHERE 子句中可以使用等号 (=) 来设定获取数据的条件，如 "tutorial_author = 'Sanjay'"。

但是有时候我们需要获取 tutorial_author 字段含有 "jay" 字符的所有记录，这时我们就需要在 WHERE 子句中使用 SQL LIKE 子句。

SQL LIKE 子句中使用百分号(%)字符来表示任意字符，类似于UNIX或正则表达式中的星号 (*)。

如果没有使用百分号(%), LIKE 子句与等号（=）的效果是一样的。

语法

以下是SQL SELECT 语句使用 LIKE 子句从数据表中读取数据的通用语法：

	SELECT field1, field2,...fieldN table_name1, table_name2...
	WHERE field1 LIKE condition1 [AND [OR]] filed2 = 'somevalue'
	e.g.
	SELECT * from tutorials_tbl 
    -> WHERE tutorial_author LIKE '%jay';
* 你可以在WHERE子句中指定任何条件。
* 你可以在WHERE子句中使用LIKE子句。
* 你可以使用LIKE子句代替等号(=)。
* LIKE 通常与 % 一同使用，类似于一个元字符的搜索。
* 你可以使用AND或者OR指定一个或多个条件。
* 你可以在 DELETE 或 UPDATE 命令中使用 WHERE...LIKE 子句来指定条件。


##MySQL 排序

我们知道从MySQL表中使用SQL SELECT 语句来读取数据。

如果我们需要对读取的数据进行排序，我们就可以使用MySQL的 ORDER BY 子句来设定你想按哪个字段哪中方式来进行排序，再返回搜索结果。

语法

以下是SQL SELECT 语句使用 ORDER BY 子句将查询数据排序后再返回数据：

	SELECT field1, field2,...fieldN table_name1, table_name2...
	ORDER BY field1, [field2...] [ASC [DESC]]
	e.g.
	SELECT * from tutorials_tbl ORDER BY tutorial_author ASC
	
* 你可以使用任何字段来作为排序的条件，从而返回排序后的查询结果。
* 你可以设定多个字段来排序。
* 你可以使用 ASC 或 DESC 关键字来设置查询结果是按升序或降序排列。 默认情况下，它是按升排列。
* 你可以添加 WHERE...LIKE 子句来设置条件。


##Mysql Join的使用

经常需要从多个数据表中读取数据。就需要学会如何使用MySQL 的 JOIN 在两个或多个表中查询数据。

你可以在SELECT, UPDATE 和 DELETE 语句中使用Mysql 的 join 来联合多表查询。

	e.g.
	SELECT a.tutorial_id, a.tutorial_author, b.tutorial_count
    -> FROM tutorials_tbl a, tcount_tbl b
    -> WHERE a.tutorial_author = b.tutorial_author;
    

##MySQL NULL 值处理

我们已经知道MySQL使用 SQL SELECT 命令及 WHERE 子句来读取数据表中的数据,但是当提供的查询条件字段为 NULL 时，该命令可能就无法正常工作。

为了处理这种情况，MySQL提供了三大运算符:

* IS NULL: 当列的值是NULL,此运算符返回true。
* IS NOT NULL: 当列的值不为NULL, 运算符返回true。
* <=>: 比较操作符（不同于=运算符），当比较的的两个值为NULL时返回true。

关于 NULL 的条件比较运算是比较特殊的。你不能使用 = NULL 或 != NULL 在列中查找 NULL 值 。

在MySQL中，NULL值与任何其它值的比较（即使是NULL）永远返回false，即 NULL = NULL 返回false 。

MySQL中处理NULL使用IS NULL和IS NOT NULL运算符    

	e.g.
	SELECT * FROM tcount_tbl 
    -> WHERE tutorial_count IS NULL;
    
##MySQL 正则表达式

在前面的章节我们已经了解到MySQL可以通过 LIKE ...% 来进行模糊匹配。

MySQL 同样也支持其他正则表达式的匹配， MySQL中使用 REGEXP 操作符来进行正则表达式匹配。

##MySQL 事务

MySQL 事务主要用于处理操作量大，复杂度高的数据。比如说，在人员管理系统中，你删除一个人员，你即需要删除人员的基本资料，也要删除和该人员相关的信息，如信箱，文章等等，这样，这些数据库操作语句就构成一个事务！

* 在MySQL中只有使用了Innodb数据库引擎的数据库或表才支持事务
* 事务处理可以用来维护数据库的完整性，保证成批的SQL语句要么全部执行，要么全部不执行
* 事务用来管理insert,update,delete语句

一般来说，事务是必须满足4个条件（ACID）： Atomicity（原子性）、Consistency（稳定性）、Isolation（隔离性）、Durability（可靠性）

1. 事务的原子性：一组事务，要么成功；要么撤回。
2. 稳定性 ： 有非法数据（外键约束之类），事务撤回。
3. 隔离性：事务独立运行。一个事务处理后的结果，影响了其他事务，那么其他事务会撤回。事务的100%隔离，需要牺牲速度。
4. 可靠性：软、硬件崩溃后，InnoDB数据表驱动会利用日志文件重构修改。可靠性和高速度不可兼得， innodb_flush_log_at_trx_commit选项 决定什么时候吧事务保存到日志里。
    

##MySQL ALTER命令

当我们需要修改数据表名或者修改数据表字段时，就需要使用到MySQL ALTER命令。

###删除，添加或修改表字段
如下命令使用了 ALTER 命令及 DROP 子句来删除以上创建表的 i 字段：

	mysql> ALTER TABLE testalter_tbl  DROP i;

如果数据表中只剩余一个字段则无法使用DROP来删除字段。

MySQL 中使用 ADD 子句来想数据表中添加列，如下实例在表 testalter_tbl 中添加 i 字段，并定义数据类型:

	mysql> ALTER TABLE testalter_tbl ADD i INT;
执行以上命令后，i 字段会自动添加到数据表字段的末尾。

如果你需要指定新增字段的位置，可以使用MySQL提供的关键字 FIRST (设定位第一列)， AFTER 字段名（设定位于某个字段之后）。

尝试以下 ALTER TABLE 语句, 在执行成功后，使用 SHOW COLUMNS 查看表结构的变化：

	ALTER TABLE testalter_tbl DROP i;
	ALTER TABLE testalter_tbl ADD i INT FIRST;
	ALTER TABLE testalter_tbl DROP i;
	ALTER TABLE testalter_tbl ADD i INT AFTER c;
FIRST 和 AFTER 关键字只占用于 ADD 子句，所以如果你想重置数据表字段的位置就需要先使用 DROP 删除字段然后使用 ADD 来添加字段并设置位置。

修改字段类型及名称
如果需要修改字段类型及名称, 你可以在ALTER命令中使用 MODIFY 或 CHANGE 子句 。

例如，把字段 c 的类型从 CHAR(1) 改为 CHAR(10)，可以执行以下命令:

	mysql> ALTER TABLE testalter_tbl MODIFY c CHAR(10);
使用 CHANGE 子句, 语法有很大的不同。 在 CHANGE 关键字之后，紧跟着的是你要修改的字段名，然后指定新字段的类型及名称。尝试如下实例：

	mysql> ALTER TABLE testalter_tbl CHANGE i j BIGINT;
	mysql> ALTER TABLE testalter_tbl CHANGE j j INT;

ALTER TABLE 对 Null 值和默认值的影响
当你修改字段时，你可以指定是否包含只或者是否设置默认值。

以下实例，指定字段 j 为 NOT NULL 且默认值为100 。

	mysql> ALTER TABLE testalter_tbl 
    	-> MODIFY j BIGINT NOT NULL DEFAULT 100;
如果你不设置默认值，MySQL会自动设置该字段默认为 NULL。

修改字段默认值
你可以使用 ALTER 来修改字段的默认值，尝试以下实例：
	mysql> ALTER TABLE testalter_tbl ALTER i SET DEFAULT 1000;

你也可以使用 ALTER 命令及 DROP子句来删除字段的默认值，如下实例：
	mysql> ALTER TABLE testalter_tbl ALTER i DROP DEFAULT;


修改数据表类型，可以使用 ALTER 命令及 TYPE 子句来完成。尝试以下实例，我们将表 testalter_tbl 的类型修改为 MYISAM ：

注意：查看数据表类型可以使用 SHOW TABLE STATUS 语句。

	mysql> ALTER TABLE testalter_tbl TYPE = MYISAM;

修改表名
如果需要修改数据表的名称，可以在 ALTER TABLE 语句中使用 RENAME 子句来实现。

尝试以下实例将数据表 testalter_tbl 重命名为 alter_tbl：

	mysql> ALTER TABLE testalter_tbl RENAME TO alter_tbl;
	

##MySQL 索引

MySQL索引的建立对于MySQL的高效运行是很重要的，索引可以大大提高MySQL的检索速度。

索引分单列索引和组合索引。单列索引，即一个索引只包含单个列，一个表可以有多个单列索引，但这不是组合索引。组合索引，即一个索引包含多个列。

创建索引时，你需要确保该索引是应用在 SQL 查询语句的条件(一般作为 WHERE 子句的条件)。

实际上，索引也是一张表，该表保存了主键与索引字段，并指向实体表的记录。

上面都在说使用索引的好处，但过多的使用索引将会造成滥用。因此索引也会有它的缺点：虽然索引大大提高了查询速度，同时却会降低更新表的速度，如对表进行INSERT、UPDATE和DELETE。因为更新表时，MySQL不仅要保存数据，还要保存一下索引文件。

建立索引会占用磁盘空间的索引文件。

###普通索引
* 创建索引

这是最基本的索引，它没有任何限制。它有以下几种创建方式：

		CREATE INDEX indexName ON mytable(username(length)); 
如果是CHAR，VARCHAR类型，length可以小于字段实际长度；如果是BLOB和TEXT类型，必须指定 length。

* 修改表结构

        ALTER mytable ADD INDEX [indexName] ON (username(length)) 

* 创建表的时候直接指定

		CREATE TABLE mytable(  
 
			ID INT NOT NULL,   
 
			username VARCHAR(16) NOT NULL,  
 
			INDEX [indexName] (username(length))  
 
		);  
* 删除索引的语法

		DROP INDEX [indexName] ON mytable; 

###唯一索引
它与前面的普通索引类似，不同的就是：索引列的值必须唯一，但允许有空值。如果是组合索引，则列值的组合必须唯一。它有以下几种创建方式：

* 创建索引

		CREATE UNIQUE INDEX indexName ON mytable(username(length)) 
* 修改表结构

		ALTER mytable ADD UNIQUE [indexName] ON (username(length)) 
* 创建表的时候直接指定

		CREATE TABLE mytable(  
 
			ID INT NOT NULL,   
 
			username VARCHAR(16) NOT NULL,  
 
			UNIQUE [indexName] (username(length))  
 
		);  

###使用ALTER 命令添加和删除索引
有四种方式来添加数据表的索引：

* ALTER TABLE tbl_name ADD PRIMARY KEY (column_list): 该语句添加一个主键，这意味着索引值必须是唯一的，且不能为NULL。
* ALTER TABLE tbl_name ADD UNIQUE index_name (column_list): 这条语句创建索引的值必须是唯一的（除了NULL外，NULL可能会出现多次）。
* ALTER TABLE tbl_name ADD INDEX index_name (column_list): 添加普通索引，索引值可出现多次。
* ALTER TABLE tbl_name ADD FULLTEXT index_name (column_list):该语句指定了索引为 FULLTEXT ，用于全文索引。

		mysql> ALTER TABLE testalter_tbl ADD INDEX (c);

		mysql> ALTER TABLE testalter_tbl DROP INDEX (c);

###使用 ALTER 命令添加和删除主键
主键只能作用于一个列上，添加主键索引时，你需要确保该主键默认不为空（NOT NULL）。实例如下：

	mysql> ALTER TABLE testalter_tbl MODIFY i INT NOT NULL;
	mysql> ALTER TABLE testalter_tbl ADD PRIMARY KEY (i);
你也可以使用 ALTER 命令删除主键：

	mysql> ALTER TABLE testalter_tbl DROP PRIMARY KEY;
删除指定时只需指定PRIMARY KEY，但在删除索引时，你必须知道索引名。

###显示索引信息
你可以使用 SHOW INDEX 命令来列出表中的相关的索引信息。可以通过添加 \G 来格式化输出信息。


##MySQL 临时表

MySQL 临时表在我们需要保存一些临时数据时是非常有用的。临时表只在当前连接可见，当关闭连接时，Mysql会自动删除表并释放所有空间。

MySQL临时表只在当前连接可见，如果你使用PHP脚本来创建MySQL临时表，那没当PHP脚本执行完成后，该临时表也会自动销毁。

如果你使用了其他MySQL客户端程序连接MySQL数据库服务器来创建临时表，那么只有在关闭客户端程序时才会销毁临时表，当然你也可以手动销毁。

	mysql> CREATE TEMPORARY TABLE SalesSummary (
    -> product_name VARCHAR(50) NOT NULL
    -> , total_sales DECIMAL(12,2) NOT NULL DEFAULT 0.00
    -> , avg_unit_price DECIMAL(7,2) NOT NULL DEFAULT 0.00
    -> , total_units_sold INT UNSIGNED NOT NULL DEFAULT 0
	);

###删除MySQL 临时表
默认情况下，当你断开与数据库的连接后，临时表就会自动被销毁。当然你也可以在当前MySQL会话使用 DROP TABLE 命令来手动删除临时表。


##MySQL 复制表

如果我们需要完全的复制MySQL的数据表，包括表的结构，索引，默认值等。 如果仅仅使用CREATE TABLE ... SELECT 命令，是无法实现的。

本章节将为大家介绍如何完整的复制MySQL数据表，步骤如下：

使用 SHOW CREATE TABLE 命令获取创建数据表(CREATE TABLE) 语句，该语句包含了原数据表的结构，索引等。
复制以下命令显示的SQL语句，修改数据表名，并执行SQL语句，通过以上命令 将完全的复制数据表结构。
如果你想复制表的内容，你就可以使用 INSERT INTO ... SELECT 语句来实现。

步骤一：

获取数据表的完整结构。

	mysql> SHOW CREATE TABLE tutorials_tbl \G;
步骤二：

修改SQL语句的数据表名，并执行SQL语句。

	mysql> CREATE TABLE `clone_tbl` (
  		-> `tutorial_id` int(11) NOT NULL auto_increment,
  		-> `tutorial_title` varchar(100) NOT NULL default '',
  		-> `tutorial_author` varchar(40) NOT NULL default '',
  		-> `submission_date` date default NULL,
  		-> PRIMARY KEY  (`tutorial_id`),
  		-> UNIQUE KEY `AUTHOR_INDEX` (`tutorial_author`)
		-> ) TYPE=MyISAM;

步骤三：

执行完第二步骤后，你将在数据库中创建新的克隆表 clone_tbl。 如果你想拷贝数据表的数据你可以使用 INSERT INTO... SELECT 语句来实现。

	mysql> INSERT INTO clone_tbl (tutorial_id,
    ->                        tutorial_title,
    ->                        tutorial_author,
    ->                        submission_date)
    -> SELECT tutorial_id,tutorial_title,
    ->        tutorial_author,submission_date
    -> FROM tutorials_tbl;

执行以上步骤后，你将完整的复制表，包括表结构及表数据。

##MySQL 序列使用

MySQL序列是一组整数：1, 2, 3, ...，由于一张数据表只能有一个字段自增主键， 如果你想实现其他字段也实现自动增加，就可以使用MySQL序列来实现。

MySQL中最简单使用序列的方法就是使用 MySQL AUTO_INCREMENT 来定义列。

##MySQL 处理重复数据

有些 MySQL 数据表中可能存在重复的记录，有些情况我们允许重复数据的存在，但有时候我们也需要删除这些重复的数据。

本章节我们将为大家介绍如何防止数据表出现重复数据及如何删除数据表中的重复数据。

###防止表中出现重复数据
你可以在MySQL数据表中设置指定的字段为 PRIMARY KEY（主键） 或者 UNIQUE（唯一） 索引来保证数据的唯一性。

###统计重复数据
以下我们将统计表中 first_name 和 last_name的重复记录数：

	mysql> SELECT COUNT(*) as repetitions, last_name, first_name
    -> FROM person_tbl
    -> GROUP BY last_name, first_name
    -> HAVING repetitions > 1;
以上查询语句将返回 person_tbl 表中重复的记录数。 一般情况下，查询重复的值，请执行以下操作：

* 确定哪一列包含的值可能会重复。
* 在列选择列表使用COUNT(*)列出的那些列。
* 在GROUP BY子句中列出的列。
* HAVING子句设置重复数大于1。

###过滤重复数据
如果你需要读取不重复的数据可以在 SELECT 语句中使用 DISTINCT 关键字来过滤重复数据。


###删除重复数据
如果你想删除数据表中的重复数据，你可以使用以下的SQL语句：

	mysql> CREATE TABLE tmp SELECT last_name, first_name, sex
    	->                  FROM person_tbl;
    	->                  GROUP BY (last_name, first_name);
	mysql> DROP TABLE person_tbl;
	mysql> ALTER TABLE tmp RENAME TO person_tbl;
当然你也可以在数据表中添加 INDEX（索引） 和 PRIMAY KEY（主键）这种简单的方法来删除表中的重复记录。方法如下：

	mysql> ALTER IGNORE TABLE person_tbl
    	-> ADD PRIMARY KEY (last_name, first_name)

#MySQL 及 SQL 注入

如果您通过网页获取用户输入的数据并将其插入一个MySQL数据库，那么就有可能发生SQL注入安全的问题。

本章节将为大家介绍如何防止SQL注入，并通过脚本来过滤SQL中注入的字符。

所谓SQL注入，就是通过把SQL命令插入到Web表单递交或输入域名或页面请求的查询字符串，最终达到欺骗服务器执行恶意的SQL命令。

防止SQL注入，我们需要注意以下几个要点：

1. 永远不要信任用户的输入。对用户的输入进行校验，可以通过正则表达式，或限制长度；对单引号和 双"-"进行转换等。
2. 永远不要使用动态拼装sql，可以使用参数化的sql或者直接使用存储过程进行数据查询存取。
3. 永远不要使用管理员权限的数据库连接，为每个应用使用单独的权限有限的数据库连接。
4. 不要把机密信息直接存放，加密或者hash掉密码和敏感的信息。
5. 应用的异常信息应该给出尽可能少的提示，最好使用自定义的错误信息对原始错误信息进行包装
6. sql注入的检测方法一般采取辅助软件或网站平台来检测，软件一般采用sql注入检测工具jsky，网站平台就有亿思网站安全平台检测工具。MDCSOFT SCAN等。采用MDCSOFT-IPS可以有效的防御SQL注入，XSS攻击等。


#MySQL 导出数据

MySQL中你可以使用SELECT...INTO OUTFILE语句来简单的导出数据到文本文件上。

##使用 SELECT ... INTO OUTFILE 语句导出数据
以下实例中我们将数据表 tutorials_tbl 数据导出到 /tmp/tutorials.txt 文件中:

	mysql> SELECT * FROM tutorials_tbl 
   		-> INTO OUTFILE '/tmp/tutorials.txt';
SELECT ... INTO OUTFILE 语句有以下属性:

* LOAD DATA INFILE是SELECT ... INTO OUTFILE的逆操作，SELECT句法。为了将一个数据库的数据写入一个文件，使用SELECT ... INTO OUTFILE，为了将文件读回数据库，使用LOAD DATA INFILE。
* SELECT...INTO OUTFILE 'file_name'形式的SELECT可以把被选择的行写入一个文件中。该文件被创建到服务器主机上，因此您必须拥有FILE权限，才能使用此语法。
输出不能是一个已存在的文件。防止文件数据被篡改。
* 你需要有一个登陆服务器的账号来检索文件。否则 SELECT ... INTO OUTFILE 不会起任何作用。
* 在UNIX中，该文件被创建后是可读的，权限由MySQL服务器所拥有。这意味着，虽然你就可以读取该文件，但可能无法将其删除。

##导出表作为原始数据
mysqldump是mysql用于转存储数据库的实用程序。它主要产生一个SQL脚本，其中包含从头重新创建数据库所必需的命令CREATE TABLE INSERT等。

使用mysqldump导出数据需要使用 --tab 选项来指定导出文件指定的目录，该目标必须是可写的。
以下实例将数据表 tutorials_tbl 导出到 /tmp 目录中：

	$ mysqldump -u root -p --no-create-info \
            --tab=/tmp TUTORIALS tutorials_tbl

##将数据表及数据库拷贝至其他主机
如果你需要将数据拷贝至其他的 MySQL 服务器上, 你可以在 mysqldump 命令中指定数据库名及数据表。


#MySQL 导入数据简介

MySQL中可以使用两种简单的方式来导入MySQL导出的数据。

##使用 LOAD DATA 导入数据
MySQL 中提供了LOAD DATA INFILE语句来插入数据。 以下实例中将从当前目录中读取文件 dump.txt ，将该文件中的数据插入到当前数据库的 mytbl 表中。

	mysql> LOAD DATA LOCAL INFILE 'dump.txt' INTO TABLE mytbl;
　如果指定LOCAL关键词，则表明从客户主机上按路径读取文件。如果没有指定，则文件在服务器上按路径读取文件。


##使用 mysqlimport 导入数据
mysqlimport客户端提供了LOAD DATA INFILEQL语句的一个命令行接口。mysqlimport的大多数选项直接对应LOAD DATA INFILE子句。

从文件 dump.txt 中将数据导入到 mytbl 数据表中, 可以使用以下命令：

	$ mysqlimport -u root -p --local database_name dump.txt






