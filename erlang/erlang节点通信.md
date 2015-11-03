#erlang节点通信

其中一端称其为服务端，可以作为一个gen_server，然后再handle_info里处理其他节点通过`"!"`或`erlang:send`或者可以在服务端写个远过程调用函数，通过`rpc:call`来调用发送过来的。

例子可参考<http://blog.csdn.net/mycwq/article/details/40376269>