title: SQL关联查询
date: 2016-08-04 09:13:00
tags:
- sql
- join

# mysql-join

在我们的日常工作中往往用到很多的查询方式，例如: `嵌套查询`，`关联查询`，`子查询`等等，就我而言，我感觉关联查询是最容易学习，和效率最高的。下面就我总结的关联查询如下:

## 关联查询

### 内连接

内连接（inner join或者join）只返回两个表中连接字段相等的行
	
	select * from 表1 inner join 表2 on 表1.字段号=表2.字段号
	
内连接连接三表的例子：

	select * from (表1 inner join 表2 on 表1.字段号=表2.字段号) inner join 表3 on 表1.字段号=表3.字段号
	
内连接四表的例子：
	
	select * from ((表1 inner join 表2 on 表1.字段号=表2.字段号）inner join 表3 on 表1.字段号=表3.字段号）inner join 表4 on 表1.字段号=表4.字段号
	
类似查询最好使用数字字段，其查询的字段必须是主键，自动增长类型。否则很难成功，内连接还可以增加where字句来缩小范围

### 左连接

左连接（left join）返回左表中所有记录和右表中连接字段相等的记录

左连接两表的例子：

	select * from 表1 left join 表2 on 表.字段号=表2.字段号;

左连接三表查询的例子：

	left join 表2 on 表1.字段号=表2.字段号 left join 表3 on 表2.字段号=表3.字段号

### 右连接

类似左连接

### 全连接

类似左连接

### 分组查询

group by的使用技巧：他的作用就是对相应的字段进行分组：

查询该学生的总体成绩的总分

	sql:  select t.stuName,SUM(t.score) as score from t_grade t  GROUP BY t.stuName

查询该学生最高的成绩

	select t.stuName,MAX(t.score) as score from t_grade t  GROUP BY t.stuName;
	
	

## 参考

* [SQL关联查询的使用技巧（各种 join）](http://www.cnblogs.com/fzstruggle/p/5735301.html)
* [关于 MySQL LEFT JOIN 你可能需要了解的三点](http://www.oschina.net/question/89964_65912?fromerr=qCNImfW4)