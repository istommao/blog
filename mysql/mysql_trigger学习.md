title: MySQL_TRIGGER学习
date: 2016-11-18 11:00:00
tags:
- mysql trigger

# MySQL_TRIGGER学习

参考：

* [mysql 利用触发器(Trigger)让代码更简单](http://blog.51yip.com/mysql/695.html)
* [CREATE TRIGGER Syntax](http://dev.mysql.com/doc/refman/5.7/en/create-trigger.html)

## 触发器语法

```
CREATE TRIGGER trigger_name trigger_time trigger_event
    ON tbl_name FOR EACH ROW trigger_stmt
```

* 触发程序是与表有关的命名数据库对象，当表上出现特定事件时，将激活该对象。
* 触发程序与命名为tbl_name的表相关。tbl_name必须引用永久性表。不能将触发程序与TEMPORARY表或视图关联起来。
* `trigger_time`是触发程序的动作时间。它可以是 `BEFORE` 或`AFTER`，以指明触发程序是在激活它的语句之前或之后触发。
* `trigger_event`指明了激活触发程序的语句的类型。

    trigger_event可以是下述值之一：
    * INSERT：将新行插入表时激活触发程序，例如，通过INSERT、LOAD DATA和REPLACE语句。
    * UPDATE：更改某一行时激活触发程序，例如，通过UPDATE语句。
    * DELETE：从表中删除某一行时激活触发程序，例如，通过DELETE和REPLACE语句。

* 请注意，`trigger_event`与以表操作方式激活触发程序的SQL语句并不很类似，这点很重要。例如，关于INSERT的BEFORE触发程序不仅能被INSERT语句激活，也能被LOAD DATA语句激活。
* 可能会造成混淆的例子之一是`INSERT INTO .. ON DUPLICATE UPDATE ...` 语法：BEFORE INSERT触发程序对于每一行将激活，后跟AFTER INSERT触发程序，或BEFORE UPDATE和AFTER UPDATE触发程序，具体情况取决于行上是否有重复键。
* 对于具有相同触发程序动作时间和事件的给定表，不能有两个触发程序。例如，对于某一表，不能有两个BEFORE UPDATE触发程序。但可以有1个BEFORE UPDATE触发程序和1个BEFORE INSERT触发程序，或1个BEFORE UPDATE触发程序和1个AFTER UPDATE触发程序。
* `trigger_stmt`是当触发程序激活时执行的语句。如果你打算执行多个语句，可使用BEGIN ... END复合语句结构。这样，就能使用存储子程序中允许的相同语句

创建一个触发器，名为：`updatename`

```
delimiter ||      //mysql 默认结束符号是分号，当你在写触发器或者存储过程时有分号出现，会中止转而执行  
drop trigger if exists updatename||    //删除同名的触发器，  
create trigger updatename after update on user for each row   //建立触发器，  
begin  
//old,new都是代表当前操作的记录行，你把它当成表名，也行;  
if new.name!=old.name then   //当表中用户名称发生变化时,执行  
update comment set comment.name=new.name where comment.u_id=old.id;  
end if;  
end||  
```


### 触发器的优点

1. 触发器的"自动性"

    对程序员来说，触发器是看不到的，但是他的确做事情了，如果不用触发器的话，你更新了user表的name字段时，你还要写代码去更新其他表里面的冗余字段，我举例子，只是一张表，如果是几张表都有冗余字段呢，你的代码是不是要写很多呢，看上去是不是很不爽呢。

2. 触发器的数据完整性

    触发器有回滚性，举个例子，我发现我很喜欢举子，就是你要更新五张表的数据，不会出现更新了二个张表，而另外三张表没有更新。
但是如果是用php代码去写的话，就有可能出现这种情况的，比如你更新了二张表的数据，这个时候，数据库挂掉了。你就郁闷了，有的更新了，有的没更新。这样页面显示不一致了，变有bug了。



### 举例

表：`user` 和 `user_count`

user:

```
CREATE TABLE `user` (
`id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(255)
) ENGINE=InnoDB DEFAUTL CHARSET=utf8;
```

user_count:

```
CREATE TABLE `user_count` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`count` int(11),
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAUTL CHARSET=utf8;
```

trigger:

```
delimiter ||
drop trigger if exists update_count ||
create trigger update_count after insert on user for each row
begin
update user_count set user_count.count = user_count.count + 1 where id = 1;
end ||
delimiter ;
```

查看 trigger：

    show triggers;
    
    
    



