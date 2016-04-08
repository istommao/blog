title: Nodejs应用场景
date: 2016-04-08 17:24:22
tags:
- nodejs

# Nodejs应用场景

Node.js的应用场景

1) 适合

* JSON APIs——构建一个Rest/JSON API服务，Node.js可以充分发挥其非阻塞IO模型以及JavaScript对JSON的功能支持(如JSON.stringfy函数)
* 单页面、多Ajax请求应用——如Gmail，前端有大量的异步请求，需要服务后端有极高的响应速度
* 基于Node.js开发Unix命令行工具——Node.js可以大量生产子进程，并以流的方式输出，这使得它非常适合做Unix命令行工具
* 流式数据——传统的Web应用，通常会将HTTP请求和响应看成是原子事件。而Node.js会充分利用流式数据这个特点，构建非常酷的应用。如实时文件上传系统transloadit
* 准实时应用系统——如聊天系统、微博系统，但Javascript是有垃圾回收机制的，这就意味着，系统的响应时间是不平滑的(GC垃圾回收会导致系统这一时刻停止工作)。如果想要构建硬实时应用系统，Erlang是个不错的选择

2) 不适合

* CPU使用率较重、IO使用率较轻的应用——如视频编码、人工智能等，Node.js的优势无法发挥
* 简单Web应用——此类应用的特点是，流量低、物理架构简单，Node.js无法提供像Ruby的Rails或者Python的Django这样强大的框架
* NoSQL + Node.js——如果仅仅是为了追求时髦，且自己对这两门技术还未深入理解的情况下，不要冒险将业务系统搭建在这两个漂亮的名词上，建议使用MySQL之类的传统数据库

## 参考

* [Flexi传授如何说服自己的老板采用Node.js](http://www.infoq.com/cn/news/2012/05/suggest-boss-nodejs)



