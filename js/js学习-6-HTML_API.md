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








## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)