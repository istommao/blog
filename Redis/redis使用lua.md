title: redis使用lua
date: 2017-01-18 17:56:00
tags:
- redis
- lua

# redis使用lua

* [Lua: 给 Redis 用户的入门指导](https://www.oschina.net/translate/intro-to-lua-for-redis-programmers)
* [Lua 脚本](http://redisbook.readthedocs.io/en/latest/feature/scripting.html)

命令行：


EVAL:

```
redis> EVAL "return 'hello world'" 0

```

EVALSHA

```
redis> SCRIPT LOAD "return 'dlrow olleh'"
"d569c48906b1f4fca0469ba4eee89149b5148092"

redis> EVALSHA d569c48906b1f4fca0469ba4eee89149b5148092 0
"dlrow olleh"
```

脚本：

格式： `redis-cli[ -h host][ -p port] --eval [script.lua][ KEY1[ KEY2[ ...]]][ , ARGV1[ ARGV2[ ...]]]`

```
redis-cli -h 127.0.0.1 -p 6379 --eval hello.lua 0

或者：

redis-cli EVAL "$(cat hello.lua)" 0
```

通过 SHA:

```
redis-cli SCRIPT LOAD "return 'hello world'"
或者：
redis-cli EVAL "$(cat hello.lua)" 
redis-cli EVALSHA 5332031c6b470dc5a0dd9b4bf2030dea6d65de91 0
```
