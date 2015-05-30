#socket.io学习
======
#1. 什么是socket.io
socket.io是一个为实时应用提供跨平台的实时通信库。
它的名字源于它使用了浏览器支持并采用的HTML5 Websocket标准。由于并不是所有库都支持Websocket。所以它支持一些列降级：

* Websocket
* Adobe® Flash® Socket
* AJAX long polling
* AJAX multipart streaming
* Forever Iframe
* JSONP Polling


在大部分情境下，你都能通过这些功能选择与浏览器保持类似长连接的功能。

#2. socket.io使用
* 安装：npm install socket.io

#3. example
简单客户端例子

```
<html>
    <head>
        <!-- <script src="/socket.io/socket.io.js"></script> -->
        <script src="js/socket.io.min.js"></script>
    </head>
    <body>
        <script>
            var socket = io.connect('http://localhost');
            socket.on('news', function (data) {
                console.log(data);
                socket.emit('my other event', { my: 'data' });
            });
        </script>
    </body>
</html>
```

简单服务器例子

```
var io = require('socket.io').listen(80);

io.sockets.on('connection', function (socket) {
  socket.emit('news', { hello: 'world' });
  socket.on('my other event', function (data) {
    console.log(data);
  });
});
```
代码分析：

客户端通过connect发送connection事件，服务器通过io.sockets.on监听到connection事件，建立连接。然后服务器发送事件news(emit函数)，并调用on函数监听事件"my other event"。另一方面，客户端在connect之后，调用on函数监听事件"news"，收到news事件后在调用emit函数发送新事件"my other event"。

#4. 核心函数emit和on
socket.io比较核心的函数就是`emit`和`on`。

* `emit` 用来发射一个事件或者说触发一个事件，第一个参数为事件名，第二个参数为要发送的数据，第三个参数为回调函数（一般省略，如需对方接受到信息后立即得到确认时，则需要用到回调函数）。
*  `on` 用来监听一个 emit 发射的事件，第一个参数为要监听的事件名，第二个参数为一个匿名函数用来接收对方发来的数据，该匿名函数的第一个参数为接收的数据，若有第二个参数，则为要返回的函数。

socket.io 提供了三种默认的事件（客户端和服务器都有）：connect 、message 、disconnect 。当与对方建立连接后自动触发connect事件，当收到对方发来的数据后触发message事件（通常由 socket.send()触发），当对方关闭连接后触发disconnect事件。

此外，socket.io还支持自定义事件，比如上面的例子就自定义了"news"和"my other event"事件，这样就可以根据需求设计各种事件。

**需要注意的是，在服务器端区分以下三种情况**：

* socket.emit() ：向建立该连接的客户端广播
* socket.broadcast.emit() ：向除去建立该连接的客户端的所有客户端广播
* io.sockets.emit() ：向所有客户端广播，等同于上面两个的和


#5. 常见API接口


#6. 深入学习
