title: find命令
date: 2017-09-04 12:04
tags:
- linux
- find

# find命令

#### 按文件名查找

```
find . -name '*.jpg' print
find . -iname ...
find . -regex ...
```

#### 按文件从属关系查找

```shell
find . -user/group/nouser/nogroup ...
```



#### 按文件类型查询

```shell
find . -type f/d/b/c/l/s/p ...
```



#### 按文件大小查找

```shell
find . -size [+-]1<b/c/w/M/G> -print
```

#### 按时间查找

```shell
find . -mtime [+-]1 -print
find . -atime/ctime
find . [-not] -newer file
```



#### 组合条件查询

```shell
# 与或非：-a, -o, -not
find . -name '*.gif' -a -perm 644       #查找当前目录及子目录下格式为gif且权限为644的文件/文件夹
find . -name '*.gif' -o -name '*.jpg'   #查找当前目录及子目录下格式为gif或jpg的文件/文件夹

```





# 参考

* [linux find](http://blog.csdn.net/xktxoo/article/details/77823520)



