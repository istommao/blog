title: cowboy websocket
date: 2016-02-29 17:21:21
tags:
- cowboy
- websocket

-----


# cowboy实现websocket服务端

cowboy和ranch实现websocket的服务端，通过调用`cowboy:start_http`的完成。其流程如下：

![cowboy实现websocket](http://image17-c.poco.cn/mypoco/myphoto/20160229/16/17349718220160229165823019_640.jpg?1719x831_130)

代码example：参考cowboy的example中的[例子(cowboy1.0.x)](https://github.com/ninenines/cowboy)

稍作修改：


[demo](https://github.com/zhuwei05/erlang-demo/blob/6c518803a653c31bb2d61a03d6d089c83aeced40/cowboy_websocket_snippets.erl)



## 参考

* [cowboy_websocket_handler](http://ninenines.eu/docs/en/cowboy/1.0/manual/cowboy_websocket_handler/)
* [Handling Websocket connections](http://ninenines.eu/docs/en/cowboy/HEAD/guide/ws_handlers/)
* [cowboy之routing笔记](https://github.com/zhuwei05/blog/blob/master/erlang/cowboy%E4%B9%8Brouting%E7%AC%94%E8%AE%B0.md)
