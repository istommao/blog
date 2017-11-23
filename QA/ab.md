# ab

## 介绍


apache ab（Apache Bench）性能测试工具，这是[apache]免费自带的性能测试工具，就在apache的bin目录下，它能模拟多个并发请求，也就是说它主要是用来测试你的apache每秒能处理多少请求的。

## 参数介绍

* -A auth-username:password
* -c concurrency
* -C cookie-name=value
* -i 执行HEAD请求，而不是GET
* -k 启用HTTP KeepAlive功能
* -p POST-file包含了需要POST的数据的文件.
* -t timelimit 测试所进行的最大秒数
* -T content-type POST数据所使用的Content-type头信息

  * application/x-www-form-urlencoded (默认值): 就是设置表单传输的编码,典型的post请求　
  * multipart/form-data: 用来指定传输数据的特殊类型的，主要就是我们上传的非文本的内容，比如图片,mp3，文件等等
  * text/plain . 是纯文本传输的意思

* -n requests

## examples

```
ab -n 6000 -c 3000 http://www.example.com/

每次并发3000个, 共发送 6000 个请求
```

```
ab -t 60 -c 100 -T "application/x-www-form-urlencoded" p p.txt http://192.168.0.10/hello.html
```

```
ab -c 1 -n 1 -T "multipart/form-data" -p ~/Downloads/pic/person.jpg http://www.example.com/
```



## 参考

* [ab docs](https://httpd.apache.org/docs/2.4/programs/ab.html)





​	  