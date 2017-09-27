title: redis命令
date: 2016-10-10 00:02
tags:
- res

# redis命令

* [redis.io](http://redis.io/)
* [redis命令手册](http://www.redis.net.cn/order/)

## 字符串(string)命令

* `SET KEY_NAME VALUE`: set china 13bil
* `GET KEY_NAME`: get china
* `GETRANGE KEY_NAME start end`: getrange china 0 3
* `MSET key1 value1 key2 value2 .. keyN valueN `: mset a 1 b 2 c 3
* `MGET KEY1 KEY2 .. KEYN`: mget a b c
* `SETEX KEY_NAME TIMEOUT VALUE`: setex mykey 60 redis
* `SETNX KEY_NAME VALUE`: 只有在 key 不存在时设置 key 的值, 如, setnx d 4
* `MSETNX key1 value1 key2 value2 .. keyN valueN`: 同`SETNX`
* `INCR KEY_NAME`: 将 key 中储存的数字值增一，如果 key 不存在，那么 key 的值会先被初始化为 0 ，然后再执行 INCR 操作。如， incr e
* `INCRBY KEY_NAME INCR_AMOUNT`: incrby e 10
* `INCRBYFLOAT KEY_NAME INCR_AMOUNT`
* `DECR KEY_NAME`
* `DECRBY KEY_NAME DECREMENT_AMOUNT`


## 键(key)命令

* `KEYS PATTERN`: 如, keys *
* `EXISTS KEY_NAME`: exists e
* `Expire KEY_NAME TIME_IN_SECONDS`: expire f 120
* `TTL KEY_NAME`: ttl f
* `PERSIST KEY_NAME`: persist f
* `RENAME OLD_KEY_NAME NEW_KEY_NAME`: rename f ff
* `DEL KEY_NAME`: del ff
* `TYPE KEY_NAME`: type d


## 哈希(Hash) 命令

* `HSET KEY_NAME FIELD VALUE`: HSET myhash field1 "foo"
* `HGET KEY_NAME FIELD_NAME`: HGET myhash field1
* `HGETALL KEY_NAME`: HGETALL myhash
* `HMSET KEY_NAME FIELD1 VALUE1 ...FIELDN VALUEN`: HSET myhash field1 "foo" field2 "bar"
* `HMGET KEY_NAME FIELD1...FIELDN`: HMGET myhash field1 field2 nofield
* `HKEYS KEY_NAME FIELD_NAME INCR_BY_NUMBER`: HKEYS myhash
* `HVALS KEY_NAME FIELD VALUE`: HVALS myhash
* `HSETNX KEY_NAME FIELD VALUE`: HSETNX myhash field1 "foo"
* `HEXISTS KEY_NAME FIELD_NAME`: HEXISTS myhash field1
* `HLEN KEY_NAME`: HLEN myhash
* `HINCRBY KEY_NAME FIELD_NAME INCR_BY_NUMBER` and `HINCRBYFLOAT KEY_NAME FIELD_NAME INCR_BY_NUMBER`: HINCRBY myhash field 1
* `HDEL KEY_NAME FIELD1.. FIELDN`: HDEL myhash field1


## 列表(List)

* `LPUSH KEY_NAME VALUE1.. VALUEN` 和 `LPUSHX KEY_NAME VALUE1.. VALUEN`: LPUSH list1 "foo" "bar"
* `RPUSH KEY_NAME VALUE1..VALUEN` 和 `RPUSHX KEY_NAME VALUE1..VALUEN`
* `LRANGE KEY_NAME START END`:  LRANGE list1 0 -1
* `LINDEX KEY_NAME INDEX_POSITION`
* `LSET KEY_NAME INDEX VALUE`
* `LLEN KEY_NAME`
* `LPOP KEY_NAME ` 和 `RPOP KEY_NAME`
* `LREM KEY_NAME COUNT VALUE`: LREM mylist -2 "hello"
* `RPOPLPUSH SOURCE_KEY_NAME DESTINATION_KEY_NAME`
* `LTRIM KEY_NAME START STOP`
* `BLPOP LIST1 LIST2 .. LISTN TIMEOUT`
* `BRPOP LIST1 LIST2 .. LISTN TIMEOUT`


## 集合(Set)

* `SADD KEY_NAME VALUE1..VALUEN`: SADD myset "hello" "world"
* `SMEMBERS KEY VALUE`: SMEMBERS myset
* `SREM KEY MEMBER1..MEMBERN`: SREM myset "hello"
* `SCARD KEY_NAME`: 集合长度，SCARD myset
* `SISMEMBER KEY VALUE`: SISMEMBER myset "world"
* `SPOP KEY`: 随机移除集合中的一个元素
* `SRANDMEMBER KEY [count]`: SRANDMEMBER myset
* `SSCAN KEY [MATCH pattern] [COUNT count]`： sscan myset1 0 match h*
* `SDIFF FIRST_KEY OTHER_KEY1..OTHER_KEYN `  和 `SDIFFSTORE DESTINATION_KEY KEY1..KEYN `
* `SINTER KEY KEY1..KEYN ` 和 `SINTERSTORE DESTINATION_KEY KEY KEY1..KEYN `
* `SUNION KEY KEY1..KEYN` 和 `SUNIONSTORE DESTINATION KEY KEY1..KEYN`


## 有序集合(sorted set)

* `ZADD KEY_NAME SCORE1 VALUE1.. SCOREN VALUEN`: ZADD myset 2 "world" 3 "bar"
* `ZRANGE key start stop [WITHSCORES]`: ZRANGE myzset 0 -1 WITHSCORES
* `ZCARD KEY_NAME`: ZCARD myzset
* `ZCOUNT key min max`: ZCOUNT myzset 1 3
* `ZRANK key member`: ZRANK salary tom
* `ZREM key member`: ZREM page_rank google.com, ZREM page_rank baidu.com bing.com
* `ZSCORE key member`: ZSCORE salary peter  
* `ZSCAN key cursor [MATCH pattern] [COUNT count]`
* `ZINCRBY key increment member`: ZINCRBY myzset 2 "hello"
* `ZRANGEBYSCORE key min max [WITHSCORES] [LIMIT offset count]`: ZRANGEBYSCORE zset (5 (10, 结果集是5 < score < 10


## 维护

 ```
动态设置内存:

> config set maxmemory 2G

 ```

### 查看信息

```
info
info memory
```



















​	
