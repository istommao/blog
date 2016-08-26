title: mysql数据类型
date: 2016-08-26 12:25:00
tags:
- mysql
- data type

# mysql数据类型

### numeric

|data type| storage required|
|:--:|:--:|
|TINYINT	|1 byte|
|SMALLINT	|2 bytes
|MEDIUMINT	|3 bytes
|INT, INTEGER|	4 bytes
|BIGINT	|8 bytes
|FLOAT(p)|	4 bytes if 0 <= p <= 24, 8 bytes if 25 <= p <= 53
|FLOAT	|4 bytes
|DOUBLE [PRECISION], REAL|	8 bytes
|DECIMAL(M,D), NUMERIC(M,D)	|Varies; see following discussion
|BIT(M)	|approximately (M+7)/8 bytes


### string

|data type| storage required|
|:--:|:--:|
|CHAR(M)|M × w bytes, 0 <= M <= 255, where w is the number of bytes required for the maximum-length character in the character set. See Section 15.8.3, “Physical Row Structure of InnoDB Tables” for information about CHAR data type storage requirements for InnoDB tables.
|BINARY(M)|BINARYM bytes, 0 <= M <= 255
|VARCHAR(M), VARBINARY(M)|VARBINARYL + 1 bytes if column values require 0 − 255 bytes, L + 2 bytes if values may require more than 255 bytes
|TINYBLOB, TINYTEXT|L + 1 bytes, where L < 28
|BLOB, TEXT|L + 2 bytes, where L < 216
|MEDIUMBLOB, MEDIUMTEXT|L + 3 bytes, where L < 224
|LONGBLOB, LONGTEXT|L + 4 bytes, where L < 232
|ENUM('value1','value2',...)...|1 or 2 bytes, depending on the number of enumeration values (65,535 values maximum)
|SET('value1','value2',...)...|1, 2, 3, 4, or 8 bytes, depending on the number of set members (64 members maximum)

### 时间

|Data Type	|Storage Required Before MySQL 5.6.4	|Storage Required as of MySQL 5.6.4
|:--:|:--:|:--:|
|YEAR|1 byte|1 byte
|DATE|3 bytes|3 bytes
|TIME|3 bytes|3 bytes + fractional seconds storage
|DATETIME|8 bytes|5 bytes + fractional seconds storage
|TIMESTAMP|4 bytes|4 bytes + fractional seconds storage



## 参考

* [data type storage-requirements](http://dev.mysql.com/doc/refman/5.7/en/storage-requirements.html)