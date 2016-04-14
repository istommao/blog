title: js学习(6)-HTML网页的API
date: 2016-04-13 23:56:05
tags:
- js

# js学习(6)-HTML网页的API
---
没有系统学习过js，觉得基础太薄弱了，参考阮一峰老师的[JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)，希望可以提高自己js的基础。

# 7. HTML网页的API
------

# HTML网页元素

## image元素

### alt属性，src属性

alt属性返回image元素的HTML标签的alt属性值，src属性返回image元素的HTML标签的src属性值

### complete属性

complete属性返回一个布尔值，true表示当前图像属于浏览器支持的图形类型，并且加载完成，解码过程没有出错，否则就返回false。

### height属性，width属性

这两个属性返回image元素被浏览器渲染后的高度和宽度。

### naturalWidth属性，naturalHeight属性
这两个属性只读，表示image对象真实的宽度和高度

## audio元素，video元素

audio元素和video元素加载音频和视频时，以下事件按次序发生。

* loadstart：开始加载音频和视频。
* durationchange：音频和视频的duration属性（时长）发生变化时触发，即已经知道媒体文件的长度。如果没有指定音频和视频文件，duration属性等于NaN。如果播放流媒体文件，没有明确的结束时间，duration属性等于Inf（Infinity）。
* loadedmetadata：媒体文件的元数据加载完毕时触发，元数据包括duration（时长）、dimensions（大小，视频独有）和文字轨。
* loadeddata：媒体文件的第一帧加载完毕时触发，此时整个文件还没有加载完。
* progress：浏览器正在下载媒体文件，周期性触发。下载信息保存在元素的buffered属性中。
* canplay：浏览器准备好播放，即使只有几帧，readyState属性变为CAN_PLAY。
* canplaythrough：浏览器认为可以不缓冲（buffering）播放时触发，即当前下载速度保持不低于播放速度，readyState属性变为CAN_PLAY_THROUGH。

audio元素和video元素还支持以下事件:

*learning when using*


## iframe

iframe元素用于在网页之中，插入另一张网页。对于JavaScript来说，每一个iframe，构成一个单独的域，不同的域之间的变量是隔离的。

# Canvas API

## 概述

Canvas API（画布）用于在网页实时生成图像，并且可以操作图像内容，基本上它是一个可以用JavaScript操作的位图（bitmap）。

使用前，首先需要新建一个canvas网页元素。

	<canvas id="myCanvas" width="400" height="200">
	  您的浏览器不支持canvas！
	</canvas>
	
每个canvas元素都有一个对应的context对象（上下文对象），Canvas API定义在这个context对象上面，所以需要获取这个对象，方法是使用getContext方法。

## 绘图方法

## 图像处理方法

## 动画

## 像素处理


*learning when using*


# SVG 图像

SVG是“可缩放矢量图”（Scalable Vector Graphics）的缩写，是一种描述向量图形的XML格式的标记化语言。也就是说，SVG本质上是文本文件，格式采用XML，可以在浏览器中显示出矢量图像。由于结构是XML格式，使得它可以插入HTML文档，成为DOM的一部分，然后用JavaScript和CSS进行操作。

相比传统的图像文件格式（比如JPG和PNG），SVG图像的优势就是文件体积小，并且放大多少倍都不会失真，因此非常合适用于网页。

*learning when using*

# 表单

## 表单的验证

### HTML 5表单验证

所谓“表单验证”，指的是检查用户提供的数据是否符合要求，比如Email地址的格式。HTML 5原生支持表单验证，不需要JavaScript

*learning when using*

# 文件和二进制数据的操作

ECMAScript 5引入了Blob对象，允许直接操作二进制数据。

Blob对象是一个代表二进制数据的基本对象，在它的基础上，又衍生出一系列相关的API，用来操作文件。

* File对象：负责处理那些以文件形式存在的二进制数据，也就是操作本地文件；
* FileList对象：File对象的网页表单接口；
* FileReader对象：负责将二进制数据读入内存内容；
* URL对象：用于对二进制数据生成URL。

## Blob对象

Blob（Binary Large Object）对象代表了一段二进制数据，提供了一系列操作接口。其他操作二进制数据的API（比如File对象），都是建立在Blob对象基础上的，继承了它的属性和方法。

生成Blob对象有两种方法：一种是使用Blob构造函数，另一种是对现有的Blob对象使用slice方法切出一部分。

*learning when using*

# Web Worker

## 概述

JavaScript语言采用的是单线程模型，也就是说，所有任务排成一个队列，一次只能做一件事。随着电脑计算能力的增强，尤其是多核CPU的出现，这一点带来很大的不便，无法充分发挥JavaScript的潜力。

Web Worker的目的，就是为JavaScript创造多线程环境，允许主线程将一些任务分配给子线程。在主线程运行的同时，子线程在后台运行，两者互不干扰。等到子线程完成计算任务，再把结果返回给主线程。因此，每一个子线程就好像一个“工人”（worker），默默地完成自己的工作。这样做的好处是，一些高计算量或高延迟的工作，被worker线程负担了，所以主进程（通常是UI进程）就会很流畅，不会被阻塞或拖慢。

Worker线程分成好几种。

* 普通的Worker：只能与创造它们的主进程通信。
* Shared Worker：能被所有同源的进程获取（比如来自不同的浏览器窗口、iframe窗口和其他Shared worker），它们必须通过一个端口通信。
* ServiceWorker：实际上是一个在网络应用与浏览器或网络层之间的代理层。它可以拦截网络请求，使得离线访问成为可能。

Web Worker有以下几个特点：

* 同域限制。子线程加载的脚本文件，必须与主线程的脚本文件在同一个域。
* DOM限制。子线程所在的全局对象，与主进程不一样，它无法读取网页的DOM对象，即document、window、parent这些对象，子线程都无法得到。（但是，navigator对象和location对象可以获得。）
* 脚本限制。子线程无法读取网页的全局变量和函数，也不能执行alert和confirm方法，不过可以执行setInterval和setTimeout，以及使用XMLHttpRequest对象发出AJAX请求。
* 文件限制。子线程无法读取本地文件，即子线程无法打开本机的文件系统（`file://`），它所加载的脚本，必须来自网络。

## 主线程与子线程的数据通信

## 同页面的Web Worker

## 共享式的Web Worker

## Service Worker


*learning when using*


# SSE：服务器发送事件

## 概述

传统的网页都是浏览器向服务器“查询”数据，但是很多场合，最有效的方式是服务器向浏览器“发送”数据。比如，每当收到新的电子邮件，服务器就向浏览器发送一个“通知”，这要比浏览器按时向服务器查询（polling）更有效率。

`服务器发送事件（Server-Sent Events，简称SSE）`就是为了解决这个问题，而提出的一种新API，部署在`EventSource对象`上。

> 简单说，所谓SSE，就是浏览器向服务器发送一个HTTP请求，然后服务器不断单向地向浏览器推送“信息”（message）。这种信息在格式上很简单，就是“信息”加上前缀“data: ”，然后以“\n\n”结尾。

	data: 1394572346452


SSE与WebSocket有相似功能，都是用来建立浏览器与服务器之间的通信渠道。两者的区别在于：

* WebSocket是全双工通道，可以双向通信，功能更强；SSE是单向通道，只能服务器向浏览器端发送。
* WebSocket是一个新的协议，需要服务器端支持；SSE则是部署在HTTP协议之上的，现有的服务器软件都支持。
* SSE是一个轻量级协议，相对简单；WebSocket是一种较重的协议，相对复杂。
* SSE默认支持断线重连，WebSocket则需要额外部署。
* SSE支持自定义发送的数据类型。


## 客户端代码

*learning when using*

## 服务器代码

*learning when using*

# Page Visibility API

*learning when using*

PageVisibility API用于判断页面是否处于浏览器的当前窗口，即是否可见。

使用这个API，可以帮助开发者根据用户行为调整程序。比如，如果页面处于当前窗口，可以让程序每隔15秒向服务器请求数据；如果不处于当前窗口，则让程序每隔几分钟请求一次数据。

# Fullscreen API：全屏操作

*learning when using*

全屏API可以控制浏览器的全屏显示，让一个Element节点（以及子节点）占满用户的整个屏幕。目前各大浏览器的最新版本都支持这个API（包括IE11），但是使用的时候需要加上浏览器前缀。

# Web Speech

*learning when using*

## 概述

这个API用于浏览器接收语音输入。

它最早是由Google提出的，目的是让用户直接进行语音搜索，即对着麦克风说出你所要搜索的词，搜索结果就自动出现。Google首先部署的是input元素的speech属性（加上浏览器前缀x-webkit）。

	<input id="query" type="search" class="k-input k-textbox" x-webkit-speech speech />

加上这个属性以后，输入框的右端会出现了一个麦克风标志，点击该标志，就会跳出语音输入窗口。

由于这个操作过于简单，Google又在它的基础上提出了Web Speech API，使得JavaScript可以操作语音输入。

目前，只有Chrome浏览器支持该API。


# requestAnimationFrame

*learning when using*

## 概述


requestAnimationFrame是浏览器用于定时循环操作的一个接口，类似于setTimeout，主要用途是按帧对网页进行重绘。

设置这个API的目的是为了让各种网页动画效果（DOM动画、Canvas动画、SVG动画、WebGL动画）能够有一个统一的刷新机制，从而节省系统资源，提高系统性能，改善视觉效果。代码中使用这个API，就是告诉浏览器希望执行一个动画，让浏览器在下一个动画帧安排一次网页重绘。

requestAnimationFrame的优势，在于充分利用显示器的刷新机制，比较节省系统资源。显示器有固定的刷新频率（60Hz或75Hz），也就是说，每秒最多只能重绘60次或75次，requestAnimationFrame的基本思想就是与这个刷新频率保持同步，利用这个刷新频率进行页面重绘。此外，使用这个API，一旦页面不处于浏览器的当前标签，就会自动停止刷新。这就节省了CPU、GPU和电力。

不过有一点需要注意，requestAnimationFrame是在主线程上完成。这意味着，如果主线程非常繁忙，requestAnimationFrame的动画效果会大打折扣。

# WebSocket

## 概述

HTTP协议是一种无状态协议，服务器端本身不具有识别客户端的能力，必须借助外部机制，比如session和cookie，才能与特定客户端保持对话。这多多少少带来一些不便，尤其在服务器端与客户端需要持续交换数据的场合（比如网络聊天），更是如此。为了解决这个问题，HTML5提出了浏览器的`WebSocket API`

WebSocket的主要作用是，允许服务器端与客户端进行全双工（full-duplex）的通信。

WebSocket协议完全可以取代Ajax方法，用来向服务器端发送文本和二进制数据，而且还没有“同域限制”。

WebSocket不使用HTTP协议，而是使用自己的协议。浏览器发出的WebSocket请求类似于下面的样子：

	GET / HTTP/1.1
	Connection: Upgrade
	Upgrade: websocket
	Host: example.com
	Origin: null
	Sec-WebSocket-Key: sN9cRrP/n9NdMgdcy2VJFQ==
	Sec-WebSocket-Version: 13

上面的头信息显示，有一个HTTP头是Upgrade。HTTP1.1协议规定，`Upgrade`头信息表示将通信协议从HTTP/1.1转向该项所指定的协议。“`Connection: Upgrade`”就表示浏览器通知服务器，如果可以，就升级到webSocket协议。`Origin`用于验证浏览器域名是否在服务器许可的范围内。`Sec-WebSocket-Key`则是用于握手协议的密钥，是base64编码的16字节随机字符串。

服务器端的WebSocket回应则是

	HTTP/1.1 101 Switching Protocols
	Connection: Upgrade
	Upgrade: websocket
	Sec-WebSocket-Accept: fFBooB7FAkLlXgRSz0BT3v4hq5s=
	Sec-WebSocket-Origin: null
	Sec-WebSocket-Location: ws://example.com/

服务器端同样用“Connection: Upgrade”通知浏览器，需要改变协议。Sec-WebSocket-Accept是服务器在浏览器提供的Sec-WebSocket-Key字符串后面，添加“`258EAFA5-E914-47DA-95CA-C5AB0DC85B11`” 字符串，然后再取sha-1的hash值。浏览器将对这个值进行验证，以证明确实是目标服务器回应了webSocket请求。Sec-WebSocket-Location表示进行通信的WebSocket网址。

**完成握手以后，WebSocket协议就在TCP协议之上，开始传送数据**。

WebSocket协议需要服务器支持，目前比较流行的实现是基于`node.js`的`socket.io`

## 客户端

浏览器端对WebSocket协议的处理，无非就是三件事：

* 建立连接和断开连接
* 发送数据和接收数据
* 处理错误

### 建立连接和断开连接

	if(window.WebSocket != undefined) {
		var connection = new WebSocket('ws://localhost:1740');
	}

建立连接以后的WebSocket实例对象（即上面代码中的connection），有一个readyState属性，表示目前的状态，可以取4个值：

* 0： 正在连接
* 1： 连接成功
* 2： 正在关闭
* 3： 连接关闭

握手协议成功以后，readyState就从0变为1，并触发`open`事件，这时就可以向服务器发送信息了。我们可以指定open事件的回调函数。

	connection.onopen = wsOpen;

	function wsOpen (event) {
		console.log('Connected to: ' + event.currentTarget.URL);
	}

关闭WebSocket连接，会触发close事件。

	connection.onclose = wsClose;
	
	function wsClose () {
		console.log("Closed");
	}
	
	connection.close();

### 发送数据和接收数据

连接建立后，客户端通过`send`方法向服务器端发送数据

	connection.send(message);

除了发送字符串，也可以使用 Blob 或 ArrayBuffer 对象发送二进制数据

客户端收到服务器发送的数据，会触发`message`事件。可以通过定义message事件的回调函数，来处理服务端返回的数据。

	connection.onmessage = wsMessage;
	
	function wsMessage (event) {
		console.log(event.data);
	}

### 处理错误

如果出现错误，浏览器会触发WebSocket实例对象的`error`事件。

	connection.onerror = wsError;
	
	function wsError(event) {
		console.log("Error: " + event.data);
	}


## 服务器端

服务器端需要单独部署处理WebSocket的代码。


## Socket.io简介

`Socket.io`是目前最流行的WebSocket实现，包括服务器和客户端两个部分。它不仅简化了接口，使得操作更容易，而且对于那些不支持WebSocket的浏览器，会自动降为Ajax连接，最大限度地保证了兼容性。它的目标是统一通信机制，使得所有浏览器和移动设备都可以进行实时通信。

不管是服务器还是客户端，`socket.io`提供两个核心方法：`emit`方法用于发送消息，`on`方法用于监听对方发送的消息。


# WebRTC

*learning when using*

## 概述

WebRTC是“网络实时通信”（Web Real Time Communication）的缩写。它最初是为了解决浏览器上视频通话而提出的，即两个浏览器之间直接进行视频和音频的通信，不经过服务器。后来发展到除了音频和视频，还可以传输文字和其他数据。

Google是WebRTC的主要支持者和开发者，它最初在Gmail上推出了视频聊天，后来在2011年推出了Hangouts，语序在浏览器中打电话。它推动了WebRTC标准的确立。

WebRTC主要让浏览器具备三个作用。

* 获取音频和视频
* 进行音频和视频通信
* 进行任意数据的通信

WebRTC共分成三个API，分别对应上面三个作用。

* MediaStream （又称getUserMedia）
* RTCPeerConnection
* RTCDataChannel




## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)