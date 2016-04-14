title: js学习(5)-BOM
date: 2016-04-13 23:56:05
tags:
- js

# js学习(5)-BOM
---
没有系统学习过js，觉得基础太薄弱了，参考阮一峰老师的[JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)，希望可以提高自己js的基础。

# 6. BOM
------

# 浏览器的JavaScript引擎

## 浏览器的组成

浏览器的核心是两部分：渲染引擎和JavaScript解释器（又称JavaScript引擎）。

渲染引擎的主要作用是，将网页从代码”渲染“为用户视觉上可以感知的平面文档。不同的浏览器有不同的渲染引擎。

渲染引擎处理网页，通常分成四个阶段。

* 解析代码：HTML代码解析为DOM，CSS代码解析为CSSOM（CSS Object Model）
* 对象合成：将DOM和CSSOM合成一棵渲染树（render tree）
* 布局：计算出渲染树的布局（layout）
* 绘制：将渲染树绘制到屏幕


JavaScript引擎的主要作用是，读取网页中的JavaScript代码，对其处理后运行


## JavaScript代码嵌入网页的方法

* 直接添加代码块

	通过`<script>`标签

	`<script>`标签有一个type属性，用来指定脚本类型。`text/javascript`或`application/javascript`

* 加载外部脚本

	`script`标签也可以指定加载外部的脚本文件

* 行内代码

	HTML语言允许在某些元素的`事件属性`和`a`元素的`href`属性中，直接写入JavaScript。
	
		<div onclick="alert('Hello')"></div>

		<a href="javascript:alert('Hello')"></a>


	
## defer属性

为了解决脚本文件下载阻塞网页渲染的问题，一个方法是加入defer属性。

	<script src="1.js" defer></script>
	<script src="2.js" defer></script>

defer属性的作用是，告诉浏览器，等到DOM加载完成后，再执行指定脚本。

## async属性

解决“阻塞效应”的另一个方法是加入async属性。

	<script src="1.js" async></script>
	<script src="2.js" async></script>

async属性的作用是，使用另一个进程下载脚本，下载时不会阻塞渲染。

一般来说，如果脚本之间没有依赖关系，就使用async属性，如果脚本之间有依赖关系，就使用defer属性。如果同时使用async和defer属性，后者不起作用，浏览器行为由async属性决定。

## 重流和重绘

渲染树转换为网页布局，称为“布局流”（flow）；布局显示到页面的这个过程，称为“绘制”（paint）。它们都具有阻塞效应，并且会耗费很多时间和计算资源。

页面生成以后，脚本操作和样式表操作，都会触发重流（reflow）和重绘（repaint）。

重流和重绘并不一定一起发生，重流必然导致重绘，重绘不一定需要重流。

作为开发者，应该尽量设法降低重绘的次数和成本。

下面是一些优化技巧。

* 读取DOM或者写入DOM，尽量写在一起，不要混杂
* 缓存DOM信息
* 不要一项一项地改变样式，而是使用CSS class一次性改变样式
* 使用document fragment操作DOM
* 动画时使用absolute定位或fixed定位，这样可以减少对其他元素的影响
* 只在必要时才显示元素
* 使用`window.requestAnimationFrame()`，因为它可以把代码推迟到下一次重流时执行，而不是立即要求页面重流
* 使用虚拟DOM（virtual DOM）库

## 脚本的动态嵌入

除了用静态的`script`标签，还可以动态嵌入`script`标签

这种方法的好处是，动态生成的script标签不会阻塞页面渲染，也就不会造成浏览器假死。但是问题在于，这种方法无法保证脚本的执行顺序，哪个脚本文件先下载完成，就先执行哪个。



## 加载使用的协议

如果不指定协议，浏览器默认采用HTTP协议下载

## JavaScript虚拟机

## 单线程模型

### 含义

首先，明确一个观念：JavaScript只在一个线程上运行，不代表JavaScript引擎只有一个线程。事实上，JavaScript引擎有多个线程，其中单个脚本只能在一个线程上运行，其他线程都是在后台配合。JavaScript脚本在一个线程里运行。这意味着，一次只能运行一个任务，其他任务都必须在后面排队等待。

JavaScript之所以采用单线程，而不是多线程，跟历史有关系。JavaScript从诞生起就是单线程，原因是不想让浏览器变得太复杂，因为多线程需要共享资源、且有可能修改彼此的运行结果，对于一种网页脚本语言来说，这就太复杂了。

为了利用多核CPU的计算能力，HTML5提出Web Worker标准，允许JavaScript脚本创建多个线程，但是子线程完全受主线程控制，且不得操作DOM。所以，这个新标准并没有改变JavaScript单线程的本质。

### 消息队列

JavaScript运行时，除了一根运行线程，系统还提供一个消息队列（message queue），里面是各种需要当前程序处理的消息。新的消息进入队列的时候，会自动排在队列的尾端。

运行线程只要发现消息队列不为空，就会取出排在第一位的那个消息，执行它对应的回调函数。等到执行完，再取出排在第二位的消息，不断循环，直到消息队列变空为止。

每条消息与一个回调函数相联系，也就是说，程序只要收到这条消息，就会执行对应的函数。另一方面，进入消息队列的消息，必须有对应的回调函数。否则这个消息就会遗失，不会进入消息队列。

另一种情况是setTimeout会在指定时间向消息队列添加一条消息。如果消息队列之中，此时没有其他消息，这条消息会立即得到处理；否则，这条消息会不得不等到其他消息处理完，才会得到处理。因此，setTimeout指定的执行时间，只是一个最早可能发生的时间，并不能保证一定会在那个时间发生。

一旦当前执行栈空了，消息队列就会取出排在第一位的那条消息，传入程序。程序开始执行对应的回调函数，等到执行完，再处理下一条消息。

### Event Loop

所谓`Event Loop`，指的是一种内部循环，用来一轮又一轮地处理消息队列之中的消息，即执行对应的回调函数。Wikipedia的定义是：“Event Loop是一个程序结构，用于等待和发送消息和事件（a programming construct that waits for and dispatches events or messages in a program）”。可以就把Event Loop理解成动态更新的消息队列本身。

所有任务可以分成两种，一种是同步任务（synchronous），另一种是异步任务（asynchronous）。同步任务指的是，在JavaScript执行进程上排队执行的任务，只有前一个任务执行完毕，才能执行后一个任务；异步任务指的是，不进入JavaScript执行进程、而进入“任务队列”（task queue）的任务，只有“任务队列”通知主进程，某个异步任务可以执行了，该任务（采用回调函数的形式）才会进入JavaScript进程执行。

也就是说，虽然JavaScript只有一根进程用来执行，但是并行的还有其他进程（比如，处理定时器的进程、处理用户输入的进程、处理网络通信的进程等等）。这些进程通过向任务队列添加任务，实现与JavaScript进程通信。

> 每当遇到I/O的时候，主线程就让Event Loop线程去通知相应的I/O程序，然后接着往后运行，所以不存在红色的等待时间。等到I/O程序完成操作，Event Loop线程再把结果返回主线程。主线程就调用事先设定的回调函数，完成整个任务。

















## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)