#redis学习笔记
=====

本文主要记录自己的redis学习笔记整理，大部分内容摘录来自: 李子骅. “Redis入门指南”。

官网：<http://redis.io/>

Redis中文：<http://www.redis.cn/>

##简介
Redis是一个开源的高性能键值对数据库。它通过提供多种键值数据类型来适应不同场景下的存储需求，并借助许多高层级的接口使其可以胜任如缓存、队列系统等不同的角色。

Redis是REmote DIctionary Server（远程字典服务器）的缩写，它以字典结构存储数据，并允许其他应用通过TCP协议读写字典中的内容。同大多数脚本语言中的字典一样，Redis字典中的键值除了可以是字符串，还可以是其他数据类型。到目前为止Redis支持的键值数据类型如下：

* 字符串类型
* 散列类型
* 列表类型
* 集合类型
* 有序集合类型

这种字典形式的存储结构与常见的MySQL 等关系数据库的二维表形式的存储结构有很大的差异。

###redis和memecached

在性能上Redis是是单线程模型，而Memcached支持多线程，所以在多核服务器上后者的性能更高一些。然而，前面已经介绍过，Redis的性能已经足够优异，在绝大部分场合下其性能都不会成为瓶颈。

使用时应该关心的是二者在功能上的区别，如果需要用到高级的数据类型或是持久化等功能，Redis将会是Memcached很好的替代。

###命令的返回值

1. 状态回复: 状态回复直接显示状态信息
2. 错误回复: 命令不存在或命令格式有错误等情况时Redis会返回错误回复（error reply）。错误回复以(error)开头，并在后面跟上错误信息。
3. 整数回复: 整数回复（integer reply）以(integer)开头，并在后面跟上整数数据
4. 字符串回复: 字符串回复（bulk reply）是最常见的一种回复类型，当请求一个字符串类型键的键值或一个其他类型键中的某个元素时就会得到一个字符串回复。
5. 多行字符串回复: 当请求一个非字符串类型键的元素列表时就会收到多行字符串回复。

###多数据库

一个Redis实例提供了多个用来存储数据的字典，客户端可以指定将数据存储在哪个字典中。每个数据库对外都是以一个从0开始的递增数字命名，Redis默认支持16个数据库，可以通过配置参数databases来修改这一数字。

##命令

###字符串类型

####赋值与取值

	SET key value
	GET key

####递增/减数字

字符串类型可以存储任何形式的字符串，当存储的字符串是整数形式时，让键值递增。

	INCR key
	DECR key
	
**实践：该方法可以作为统计一些，比如页面访问值**

**键的命名习惯：对象类型:对象ID:对象属性，比如user:1:friends**

####其他常用命令
递增/减指定值：

	INCRBY key increment
	DESCBY key increment
	
增加指定浮点数

	INCRBYFLOAT key increment
	
键值尾部追加

	APPEND key value

获取键值字符串长度

	STRLEN key	
			
同时获取和设置多个键值

	MGET key [key...]
	MSET key value [key value...]
	
位操作

	GETBIT key offset
	SETBIT key offset value
	BITCOUNT key [start]	[end]
	BITOP operation destkey key [key...]
	
* offset从左到右，但是每个位又是从低到高;
* operation的值有：AND、OR、XOR、NOT	

**使用位操作可以紧凑的存储一些bool值，比如用户的性别，节省空间且操作都是O(1)**

####实践

* 前面讲到的用来存储页面或文章之类的访问量
* 存储文章数据


###散列类型

散列类型的键值也是一中字典结构，所以散列的命令和其他的命令有所区别。

散列的键值包含字段(field)和字段值，且字段只能是字符串，所以散列类型不能嵌套其他数据类型。除了散列类型，其他类型也不支持嵌套

统一个散列类型的键，最多有2^32-1个字段。

散列类型适合存储对象，使用对象类别和ID构成键名，使用字段表示对象的属性，而字段值则存储属性值。比如：car:2 name audi

####赋值和取值

	HSET key field value
	HGET key field
	HMSET key field value [field value...]
	HMGET key field [field...]
	HGETALL key
	
HSET不区分插入和更新操作。

**Redis基本遵循对应的数据类型只能使用对应的命令进行操作，否则会报错**。

**例外SET命令可以覆盖已有的键，而不管原来的键是什么类型**

####字段是否存在

	HEXISTS key field
	
不存在时对其进行赋值

	HSETNX key field value
	
####增加字段值

	HINCRBY key field increment
			
####删除字段

	HDEL key field [field...]
	
####获取字段名和字段值、字段数量

	HKEYS key
	HVALS key		
	HLEN key
	
####实践

* 存储文章数据: HMSET post:$postID title $title author $autho...
* 存储文章缩略名： HSET slug.to.id slug postID	
	
###列表类型

列表类型（list）可以存储一个有序的字符串列表，常用的操作是向列表两端添加元素。

列表类型内部是使用**双向链表（double linked list）实现**的，所以向列表两端添加元素的时间复杂度为0(1)，获取越接近两端的元素速度就越快。

列表类型的键容纳的元素最多为2^32-1，和散列类型的字段数是一致的。

####增加元素，弹出元素

	LPUSH key value [value...]
	RPUSH key value [value...]
	
	LPOP key
	RPOP key
	
**由于PUSH和POP只针对List，所以有左右，其他List的命令都不带左右之分的，都是通过索引值为正或负进行从左到右，或者从右到左。**
	
####获得列表中元素个数

	LLEN key
	
####获得列表片段

	LRANGE key start stop
	
LRANGE是列表类型最常用的命令之一。

LRANGE命令在取得列表片段的同时不会像LPOP一样删除该片段，另外LRANGE命令与很多语言中用来截取数组片段的方法slice有一点区别是LRANGE返回的值包含最右边的元素。

LRANGE命令在取得列表片段的同时不会像LPOP一样删除该片段，另外LRANGE命令与很多语言中用来截取数组片段的方法slice有一点区别是LRANGE返回的值包含最右边的元素。

LRANGE支持负索引，所以从另一方面反应为什么没有不区分左和右，因为不需要了，使用负索引就可以实现。

####删除列表指定的值

	LREM key count value

根据count值不同，执行方法不同：

* count>0, 从左边删除前count个元素
* count<0, 从右边删除前|count|个元素，所以命令也不区分左和右的
* count=0, 删除所有值为value的元素	
	
####其他的一些命令

获得/设定指定索引的元素值

	LINDEX key index
	LSET key index value
	
	同样的index为负数，表示从右边开始计算

保留列表指定片段

	LTRIM key start end
	
	通常可以结合LPUSH来限制列表中元素的数量

列表中插入元素

	LINSERT key BEFORE|AFTER pivot value
	
将元素从一个列表转到另一个列表

	RPOPLPUSH source destination

####实践

* 存储文章的评论： LPUSH post:$postID:comments serializedComment

###集合类型

一个集合类型的键可以存储至多2^32-1个字符串。

集合类型常用操作：向集合添加、删除元素，判断集合中是否存在某个元素。

集合类型在Redis内部使用值为空的散列表(hash table)实现，故集合操作为O(1).

多个集合之间还可以进行并集、交集和差集运算。

####增加/删除元素

	SADD key member [member...]
	SREM key member [member...]
	
####获取集合中所有元素

	SMEMBERS key
	
####判断元素是否在集合中

	SISMEMBER key member
	
####集合间运算

	SDIFF key [key...]
	SINTER key [key...]
	SUNION key [key...]
	
####获得集合中元素个数

	SCARD key

####进行集合运算并存储结果

	SDIFFSTORE destination key [key...]
	SINTERSTORE destination	 key [key...]
	SUNIONSTORE destination key [key...]
	
####随机获得集合中的元素

	SRANDMEMBER key [count]

####从集合中弹出元素

	SPOP key	
		
	
####实践

* 存储文章标签： SADD post:$postID:tags redis db
* 通过标签搜索文章


###有序集合类型

有序集合类型使用散列表和跳跃表实现，所以即使读取中间部分的数据也很快。

####增加元素

	ZADD key score member [score member...]
	
+inf和-inf表示正无穷和负无穷。
	
####获得元素的分数

	ZSCORE key member
	
####获得排名在某个范围的元素列表

	ZRANGE key start stop [WITHSOCRES]	ZREVRANGE key start stop [WITHSCORES]
	
和LRANGE类似，索引从0开始，可以取负数，负数表示从后向前查找。时间复杂度为O(logn + m)

####获得分数在某个范围的元素

	ZRANGEBYSCORE key min max [WITHSCORES] [LIMIT offset count]
	ZREVRANGEBYSCORE key min max [WITHSCORES] [LIMIT offset count]
	
LIMIT offset count和SQL语句类似，在查找基础上向后偏移offset个，并只去count个。

####增加某个元素的分数

	ZINCRBY key increment member
	
####获得集合中元素数量

	ZCARD key
	
####获得指定分数范围内的元素个数

	ZCOUNT key min max
	
####删除一个或多个元素

	ZREM key member [member...]
	
####按照排名范围删除元素

	ZREMRANGEBYRANK key start stop
	
####按照分数范围删除元素

	ZREMRANGEBYSCORE key min max'
	
####获得元素排名

	ZRANK key member
	ZREVRANK key member
	
####计算有序集合元素

	ZINTERSTORE destination numkeys key [key...] [WEIGHTS weight [weight...]] [AGREGATE SUM|MIN|MAX]
							
####实践

* 对文章按照点击率排序	 


##其他功能

###事务

###生存时间

	设置时间：EXPIRE key seconds
	查看剩余时间：TTL key
	清除设置：PERSIST key

###排序命令SORT

####BY参数

####GET参数

####STORE参数

###消息队列：RPOP和BRPOP

###发布/订阅模式
	
	PUBLISH channel message
	SUBSCRIBE channel
	UNSUBSCRIBE|PSUBSCRIBE|PUNSCRIBE
	
还可指定订阅规则，规则支持glob风格通配符格式。

###管道

##Redis客户端接口

###PHP:Predis和phpredis

###Ruby: redis-rb

###node.js: node_redis

##脚本

##管理

###持久化

####RDB


###AOF

###复制replicatoin

####主从备份

####读写分离

###安全

####可信的环境

####数据库密码

####命名命令

###通信协议

####简单协议

####统一请求协议



		



	
	
	
					
			
	
			
	
	





		











	

		











