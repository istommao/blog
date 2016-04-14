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

# 定时器

## setTimeout()

setTimeout函数用来指定某个函数或某段代码，在多少毫秒之后执行。它返回一个整数，表示定时器的编号，以后可以用来取消这个定时器

	var timerId = setTimeout(func|code, delay)
	
除了前两个参数，setTimeout还允许添加更多的参数。它们将被传入推迟执行的函数（回调函数）。

如果setTimeout有两个参数，不支持更多的参数。这时有三种解决方法。第一种是在一个匿名函数里面，让回调函数带参数运行，再把匿名函数输入setTimeout。第二种解决方法是使用bind方法，把多余的参数绑定在回调函数上面。第三种解决方法是自定义setTimeout，使用apply方法将参数输入回调函数。


> setTimeout还有一个需要注意的地方：如果被setTimeout推迟执行的回调函数是某个对象的方法，那么该方法中的this关键字将指向全局环境，而不是定义时所在的那个对象。

为了防止出现这个问题，一种解决方法是将回调函数放在函数中执行

	setTimeout(function() {
	 		callback();
	}, 1000);

另一种解决方法是，使用bind方法，将绑定sayHi绑定在user上面。

	setTimeout(callck.bind(param), 1000);

HTML 5标准规定，setTimeout的最短时间间隔是4毫秒。为了节电，对于那些不处于当前窗口的页面，浏览器会将时间间隔扩大到1000毫秒。另外，如果笔记本电脑处于电池供电状态，Chrome和IE 9以上的版本，会将时间间隔切换到系统定时器，大约是15.6毫秒。

## setInterval()

setInterval函数的用法与setTimeout完全一致，区别仅仅在于setInterval指定某个任务每隔一段时间就执行一次，也就是无限次的定时执行。

setInterval指定的是“开始执行”之间的间隔，并不考虑每次任务执行本身所消耗的时间。

为了确保两次执行之间有固定的间隔，可以不用setInterval，而是每次执行结束后，使用setTimeout指定下一次执行的具体时间。

根据这种思路，可以自己部署一个函数，实现间隔时间确定的setInterval的效果。

	function interval(func, wait){
	  var interv = function(){
	    func.call(null);
	    setTimeout(interv, wait);
	  };
	
	  setTimeout(interv, wait);
	}
	
	interval(function(){
	  console.log(2);
	},1000);

## clearTimeout()，clearInterval()

setTimeout和setInterval函数，都返回一个表示计数器编号的整数值，将该整数传入clearTimeout和clearInterval函数，就可以取消对应的定时器。

setTimeout和setInterval返回的整数值是连续的，也就是说，第二个setTimeout方法返回的整数值，将比第一个的整数值大1。利用这一点，可以写一个函数，取消当前所有的setTimeout。

clearTimeout实际应用的例子。

`debounce（防抖动）方法`，用来返回一个新函数。只有当两次触发之间的时间间隔大于事先设定的值，这个新函数才会运行实际的任务。

利用setTimeout和clearTimeout，可以实现debounce方法。该方法用于防止某个函数在短时间内被密集调用，具体来说，debounce方法返回一个新版的该函数，这个新版函数调用后，只有在指定时间内没有新的调用，才会执行，否则就重新计时。

	function debounce(fn, delay){
	  var timer = null; // 声明计时器
	  return function(){
	    var context = this;
	    var args = arguments;
	    clearTimeout(timer);
	    timer = setTimeout(function(){
	      fn.apply(context, args);
	    }, delay);
	  };
	}
	
	// 用法示例
	var todoChanges = _.debounce(batchLog, 1000);
	Object.observe(models.todo, todoChanges);

现实中，最好不要设置太多个setTimeout和setInterval，它们耗费CPU。比较理想的做法是，将要推迟执行的代码都放在一个函数里，然后只对这个函数使用setTimeout或setInterval。

## 运行机制

setTimeout和setInterval的运行机制是，将指定的代码移出本次执行，等到下一轮Event Loop时，再检查是否到了指定时间。如果到了，就执行对应的代码；如果不到，就等到再下一轮Event Loop时重新判断。这意味着，setTimeout指定的代码，必须等到本次执行的所有代码都执行完，才会执行。

每一轮Event Loop时，都会将“任务队列”中需要执行的任务，一次执行完。setTimeout和setInterval都是把任务添加到“任务队列”的尾部。因此，它们实际上要等到当前脚本的所有同步任务执行完，然后再等到本次Event Loop的“任务队列”的所有任务执行完，才会开始执行。由于前面的任务到底需要多少时间执行完，是不确定的，所以没有办法保证，setTimeout和setInterval指定的任务，一定会按照预定时间执行。

## setTimeout(f,0)

setTimeout的作用是将代码推迟到指定时间执行，如果指定时间为0，即setTimeout(f, 0)，那么会立刻执行吗？

答案是`不会。`因为上一段说过，必须要等到当前脚本的同步任务和“任务队列”中已有的事件，全部处理完以后，才会执行setTimeout指定的任务。也就是说，*setTimeout的真正作用是，在“消息队列”的现有消息的后面再添加一个消息，规定在指定时间执行某段代码。*setTimeout添加的事件，会在下一次Event Loop执行。

即使消息队列是空的，0毫秒实际上也是达不到的。根据HTML 5标准，setTimeOut推迟执行的时间，最少是4毫秒。如果小于这个值，会被自动增加到4。这是为了防止多个setTimeout(f, 0)语句连续执行，造成性能问题。

另一方面，浏览器内部使用32位带符号的整数，来储存推迟执行的时间。这意味着setTimeout最多只能推迟执行2147483647毫秒（24.8天），超过这个时间会发生溢出，导致回调函数将在当前任务队列结束后立即执行，即等同于setTimeout(f, 0)的效果。


### 应用

setTimeout(f,0)有几个非常重要的用途。它的一大应用是，可以调整事件的发生顺序。

由于setTimeout(f,0)实际上意味着，将任务放到浏览器最早可得的空闲时段执行，所以那些计算量大、耗时长的任务，常常会被放到几个小部分，分别放到setTimeout(f,0)里面执行。


## 正常任务与微任务

正常情况下，JavaScript的任务是同步执行的，即执行完前一个任务，然后执行后一个任务。只有遇到异步任务的情况下，才会执行顺序才会改变。

这时，需要区分两种任务：正常任务（task）与微任务（microtask）。它们的区别在于，“正常任务”在下一轮Event Loop执行，“微任务”在本轮Event Loop的所有任务结束后执行。

	console.log(1);
	
	setTimeout(function() {
	  console.log(2);
	}, 0);
	
	Promise.resolve().then(function() {
	  console.log(3);
	}).then(function() {
	  console.log(4);
	});
	
	console.log(5);
	
	// 1
	// 5
	// 3
	// 4
	// 2

除了setTimeout，正常任务还包括各种事件（比如鼠标单击事件）的回调函数。除了Promise，微任务还包括mutation observer的回调函数。

# window对象

## 概述

JavaScript的所有对象都存在于一个运行环境之中，这个运行环境本身也是对象，称为“顶层对象”。这就是说，JavaScript的所有对象，都是“顶层对象”的下属。不同的运行环境有不同的“顶层对象”，在浏览器环境中，这个顶层对象就是`window`对象（w为小写）。

*所有浏览器环境的全局变量，都是window对象的属性*。

## window对象的属性

* window.name属性

	用于设置当前浏览器窗口的名字。它有一个特点，就是浏览器刷新后，该属性保持不变。所以，可以把值存放在该属性内，然后跨页面、甚至跨域名使用。当然，这个值有可能被其他网站的页面改写。

* window.innerHeight属性，window.innerWidth属性

	返回网页的CSS布局占据的浏览器窗口的高度和宽度，单位为像素。
	很显然，当用户放大网页的时候（比如将网页从100%的大小放大为200%），这两个属性会变小。

	注意，这两个属性值包括滚动条的高度和宽度。

* window.pageXOffset属性，window.pageYOffset属性

	window.pageXOffset属性返回页面的水平滚动距离，window.pageYOffset属性返回页面的垂直滚动距离。这两个属性的单位为像素。

* iframe元素

	window.frames返回一个类似数组的对象，成员为页面内的所有框架，包括frame元素和iframe元素。需要注意的是，window.frames的每个成员对应的是框架内的窗口（即框架的window对象），获取每个框架的DOM树，需要使用window.frames[0].document。
	
	iframe元素遵守同源政策，只有当父页面与框架页面来自同一个域名，两者之间才可以用脚本通信，否则只有使用window.postMessage方法。

	在iframe框架内部，使用window.parent指向父页面。

### navigator对象

Window对象的navigator属性，指向一个包含浏览器相关信息的对象。

* navigator.userAgent属性返回浏览器的User-Agent字符串，用来标示浏览器的种类。
* navigator.plugins属性返回一个类似数组的对象，成员是浏览器安装的插件

### screen对象

screen对象包含了显示设备的信息。

## window对象的方法

### URL的编码/解码方法

* decodeURI()
* decodeURIComponent()
* encodeURI()
* encodeURIComponent()


### window.getComputedStyle方法

getComputedStyle方法接受一个HTML元素作为参数，返回一个包含该HTML元素的最终样式信息的对象。详见《DOM》一章的CSS章节。

### window.matchMedia方法

window.matchMedia方法用来检查CSS的mediaQuery语句。详见《DOM》一章的CSS章节。

## window对象的事件

### window.onerror

并不是所有的错误，都会触发JavaScript的error事件（即让JavaScript报错），只限于以下三类事件。

* JavaScript语言错误 
* JavaScript脚本文件不存在
* 图像文件不存在

以下两类事件不会触发JavaScript的error事件。

* CSS文件不存在
* iframe文件不存在

## alert()，prompt()，confirm()

alert()、prompt()、confirm()都是浏览器用来与用户互动的方法。它们会弹出不同的对话框，要求用户做出回应。这三个方法弹出的对话框，都是浏览器统一规定的式样，是无法定制的。

# history对象

## 概述

浏览器窗口有一个history对象，用来保存浏览历史。

history对象提供了一系列方法，允许在浏览历史之间移动。

* back()：移动到上一个访问页面，等同于浏览器的后退键。
* forward()：移动到下一个访问页面，等同于浏览器的前进键。
* go()：接受一个整数作为参数，移动到该整数指定的页面，比如go(1)相当于forward()，go(-1)相当于back()。

	history.go(0);相当于刷新当前页面。


## history.pushState()，history.replaceState()

HTML5为history对象添加了两个新方法，history.pushState() 和 history.replaceState()，用来在浏览历史中添加和修改记录。

## history.state属性

history.state属性保存当前页面的state对象。

## popstate事件

每当同一个文档的浏览历史（即history对象）出现变化时，就会触发popstate事件。需要注意的是，仅仅调用pushState方法或replaceState方法 ，并不会触发该事件，只有用户点击浏览器倒退按钮和前进按钮，或者使用JavaScript调用back、forward、go方法时才会触发。另外，该事件只针对同一个文档，如果浏览历史的切换，导致加载不同的文档，该事件也不会触发。

## URLSearchParams API

URLSearchParams API用于处理URL之中的查询字符串，即问号之后的部分。

URLSearchParams有以下方法，用来操作某个参数。

* has()：返回一个布尔值，表示是否具有某个参数
* get（）：返回指定参数的第一个值
* getAll()：返回一个数组，成员是指定参数的所有值
* set()：设置指定参数
* delete()：删除指定参数
* append()：在查询字符串之中，追加一个键值对
* toString()：返回整个查询字符串

URLSearchParams还有三个方法，用来遍历所有参数。

* key()：遍历所有参数名
* values()：遍历所有参数值
* entries()：遍历所有参数的键值对

上面三个方法返回的都是Iterator对象。

# Coookie

## 概述

Cookie是服务器保存在览器的一小段文本信息。浏览器每次向服务器发出请求，就会自动附上这段信息。

`document.cookie`属性返回当前网页的Cookie

* 该属性是可写的，但是一次只能写入一个Cookie
* 写入并不是覆盖，而是添加

浏览器向服务器发送Cookie的时候，是一行将所有Cookie全部发送。

	GET /sample_page.html HTTP/1.1
	Host: www.example.org
	Cookie: cookie_name1=cookie_value1; cookie_name2=cookie_value2
	Accept: */*

上面的头信息中，`Cookie`字段是浏览器向服务器发送的Cookie。

服务器告诉浏览器需要储存Cookie的时候，则是分行指定。

	HTTP/1.0 200 OK
	Content-type: text/html
	Set-Cookie: cookie_name1=cookie_value1
	Set-Cookie: cookie_name2=cookie_value2; expires=Sun, 16 Jul 3567 06:23:41 GMT

上面的头信息中，`Set-Cookie`字段是服务器写入浏览器的Cookie，一行一个。

## Cookie的属性

除了Cookie本身的内容，还有一些可选的属性也是可以写入的，它们都必须以分号开头。

	Set-Cookie: value[; expires=date][; domain=domain][; path=path][; secure]
	
* value属性

	value属性是必需的，它是一个键值对，用于指定Cookie的值。	
* expires属性

	expires属性用于指定Cookie过期时间。它的格式采用Date.toUTCString()的格式	

* domain属性

	domain属性指定Cookie所在的域名，比如example.com或.example.com（这种写法将对所有子域名生效）、subdomain.example.com。

* path属性

	path属性用来指定路径，必须是绝对路径（比如/、/mydir），如果未指定，默认为请求该Cookie的网页路径。

* secure

	secure属性用来指定Cookie只能在加密协议HTTPS下发送到服务器。

* max-age
		
	max-age属性用来指定Cookie有效期

* HttpOnly

	HttpOnly属性用于设置该Cookie不能被JavaScript读取

以上属性可以同时设置一个或多个，也没有次序的要求。如果服务器想改变一个早先设置的Cookie，必须同时满足四个条件：**Cookie的key、domain、path和secure都匹配**。也就是说，如果原始的Cookie是用如下的Set-Cookie设置的。

	Set-Cookie: key1=value1; domain=example.com; path=/blog

改变上面这个cookie的值，就必须使用同样的Set-Cookie。

	Set-Cookie: key1=value2; domain=example.com; path=/blog

只要有一个属性不同，就会生成一个全新的Cookie，而不是替换掉原来那个Cookie。

## Cookie的限制

浏览器对Cookie数量的限制，规定不一样。

由于Cookie可能存在数量限制，有时为了规避限制，可以将cookie设置成下面的形式。

	name=a=b&c=d&e=f&g=h

上面代码实际上是设置了一个Cookie，但是这个Cookie内部使用`&`符号，设置了多部分的内容。因此，读取这个Cookie的时候，就要自行解析，得到多个键值对。这样就规避了cookie的数量限制。

## 同源政策

浏览器的同源政策规定，两个网址只要域名相同和端口相同，就可以共享Cookie。	

## HTTP-Only Cookie
设置cookie的时候，如果服务器加上了HTTPOnly属性，则这个Cookie无法被JavaScript读取（即document.cookie不会返回这个Cookie的值），只用于向服务器发送。

	Set-Cookie: key=value; HttpOnly

上面的这个Cookie将无法用JavaScript获取。进行AJAX操作时，XMLHttpRequest对象也无法包括这个Cookie。这主要是为了防止`XSS`攻击盗取Cookie。	 




















## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)