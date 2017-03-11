title: mysql_example
date: 2017-02-09 13:39:00
tags:
- mysql
- example

# mysql_example

## ex1: group by sum 

表格：

    CREATE TABLE `pay_account_log` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `account_id` char(8) NOT NULL,
      `user_id` int(11) NOT NULL,
      `operation` enum('A','D') NOT NULL,
      `amount` int(11) DEFAULT NULL,
      `created_at` datetime DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `idx-created-at` (`created_at`) USING BTREE,
      KEY `idx-img-set` (`account_id`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=3197501 DEFAULT CHARSET=utf8;

group by date format: (`'%Y-%m-%d'`):

    select user_id, operation, sum(amount) as total, DATE_FORMAT(created_at, '%Y-%m-%d') as a_day from pay_account_log where user_id = '1630' group by user_id, operation, DATE_FORMAT(created_at, '%Y-%m-%d')
    select user_id, operation, sum(amount),YEAR(created_at), MONTH(created_at), DAY(created_at) from pay_account_log where user_id = '1630' group by user_id, operation, YEAR(created_at), MONTH(created_at), DAY(created_at);
    select user_id, operation, sum(amount), DATE(created_at) as d, HOUR(create_at) as h from pay_account_log where user_id = '1630' group by user_id, operation, d, h;
    
two rows subtract:

    select user_id, sum(case operation 
    when 'A' then  total
    when 'D' then -total
    END) as total
    from 
    (select user_id, operation, sum(amount) as total, DATE_FORMAT(created_at, '%Y-%m-%d') as a_day from pay_account_log where user_id = '1630' group by user_id, operation, DATE_FORMAT(created_at, '%Y-%m-%d')) as T group by user_id, a_day;