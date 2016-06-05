title: nodejs之libuv
date: 2016-06-05 20:51:00
tags:
- nodejs
- libuv

# nodejs之libuv

libuv当初主要就是为Node.js开发的，提供跨平台的事件驱动异步I/O能力，当然现在肯定不仅限于Node.js使用。

libuv的[Design overview](https://raw.githubusercontent.com/zhuwei05/blog-resources/master/libuv.png)。

![libuv-arch](https://github.com/zhuwei05/blog-resources/blob/master/libuv.png)

从架构图上看，libuv是对多个平台上的事件驱动异步I/O库进行了封装，如Linux下的epoll、FreeBSD下的kqueue、Solaris下的event ports、Windows下的IOCP。

![loop_interator](https://raw.githubusercontent.com/zhuwei05/blog-resources/master/nodejs-loop_iterator.png)


> libuv其实就是把各种`handle`和`io_watcher`放到事件循环里，然后每一次循环都去检查一下是否有他们关心的事件需要处理，有则调用相应的`callback`，没有则继续循环。要想弄清楚Node.js之异步那些事，我们需要关心的是，Node.js如何运行事件循环，何时把handle和io_watcher放入事件循环，以及如何调用相应的callback。






## 参考

* [Node.js之异步那些事](http://www.jianshu.com/p/59d8ba0b60ed)