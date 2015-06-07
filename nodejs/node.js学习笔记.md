#Node.js学习笔记

#什么是Node.js
简单的说 Node.js 就是运行在服务端的 JavaScript。

Node.js 是一个基于Chrome JavaScript 运行时建立的一个平台。

Node.js是一个事件驱动I/O服务端JavaScript环境，基于Google的V8引擎，V8引擎执行Javascript的速度非常快，性能非常好。

#Node.js安装配置


#Node.js 创建HTTP服务器

如果我们使用PHP来编写后端的代码时，需要Apache 或者 Nginx 的HTTP 服务器，并配上 mod_php5 模块和php-cgi。

从这个角度看，整个"接收 HTTP 请求并提供 Web 页面"的需求根本不需 要 PHP 来处理。

不过对 Node.js 来说，概念完全不一样了。使用 Node.js 时，我们不仅仅 在实现一个应用，同时还实现了整个 HTTP 服务器。事实上，我们的 Web 应用以及对应的 Web 服务器基本上是一样的。

##基础的 HTTP 服务器
在你的项目的根目录下创建一个叫 server.js 的文件，并写入以下代码：
	
	var http = require('http');

	http.createServer(function (request, response) {
  		response.writeHead(200, {'Content-Type': 'text/plain'});
  		response.end('Hello World\n');
	}).listen(8888);

	console.log('Server running at http://127.0.0.1:8888/');
	
以上代码我们完成了一个可以工作的 HTTP 服务器。

使用 node命令 执行以上的代码：
	
	node server.js

接下来，打开浏览器访问 http://127.0.0.1:8888/，你会看到一个写着 "Hello World"的网页。

**分析Node.js 的 HTTP 服务器：**

* 第一行请求（require）Node.js 自带的 http 模块，并且把它赋值给 http 变量。
* 接下来我们调用 http 模块提供的函数： createServer 。这个函数会返回 一个对象，这个对象有一个叫做 listen 的方法，这个方法有一个数值参数， 指定这个 HTTP 服务器监听的端口号。

#Node.js模块系统

为了让Node.js的文件可以相互调用，Node.js提供了一个简单的模块系统。

模块是Node.js 应用程序的基本组成部分，文件和模块是一一对应的。换言之，一个 Node.js 文件就是一个模块，这个文件可能是JavaScript 代码、JSON 或者编译过的C/C++ 扩展。


##创建模块
在 Node.js 中，创建一个模块非常简单，如下我们创建一个 'main.js' 文件，代码如下:
	
	//main.js 
	var Hello = require('./hello'); 
	hello = new Hello(); 
	hello.setName('BYVoid'); 
	hello.sayHello(); 	


代码 require('./hello') 引入了当前目录下的hello.js文件（./ 为当前目录，node.js默认后缀为js）。

Node.js 提供了exports 和 require 两个对象，其中 exports 是模块公开的接口，require 用于从外部获取一个模块的接口，即所获取模块的 exports 对象。

###创建模块：

	//hello.js 
	function Hello() { 
		var name; 
		this.setName = function(thyName) { 
			name = thyName; 
		}; 
		this.sayHello = function() { 
			console.log('Hello ' + name); 
		}; 
	}; 
	module.exports = Hello;


##服务端的模块放在哪里
也许你已经注意到，我们已经在代码中使用了模块了。像这样：

	var http = require("http");
	...
	http.createServer(...);

Node.js中自带了一个叫做"http"的模块，我们在我们的代码中请求它并把返回值赋给一个本地变量。

这把我们的**本地变量变成了一个拥有所有 http 模块所提供的公共方法的对象**。


###Node.js 的 require方法中的文件查找策略如下：

由于Node.js中存在4类模块（原生模块和3种文件模块），尽管require方法极其简单，但是内部的加载却是十分复杂的，其加载优先级也各自不同。如下图所示：

![nodejs require](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/nodejs-require.jpg)

####从文件模块缓存中加载

尽管原生模块与文件模块的优先级不同，但是都不会优先于从文件模块的缓存中加载已经存在的模块。

####从原生模块加载

原生模块的优先级仅次于文件模块缓存的优先级。require方法在解析文件名之后，优先检查模块是否在原生模块列表中。以http模块为例，尽管在目录下存在一个http/http.js/http.node/http.json文件，require("http")都不会从这些文件中加载，而是从原生模块中加载。

原生模块也有一个缓存区，同样也是优先从缓存区加载。如果缓存区没有被加载过，则调用原生模块的加载方式进行加载和执行。

####从文件加载

当文件模块缓存中不存在，而且不是原生模块的时候，Node.js会解析require方法传入的参数，并从文件系统中加载实际的文件，加载过程中的包装和编译细节在前一节中已经介绍过，这里我们将详细描述查找文件模块的过程，其中，也有一些细节值得知晓。

require方法接受以下几种参数的传递：

* http、fs、path等，原生模块。
* ./mod或../mod，相对路径的文件模块。
* /pathtomodule/mod，绝对路径的文件模块。
* mod，非原生模块的文件模块。


#Node.js 事件

Node.js 所有的异步I/O 操作在完成时都会发送一个事件到事件队列。

Node.js里面的许多对象都会分发事件：一个net.Server对象会在每次有新连接时分发一个事件， 一个fs.readStream对象会在文件被打开的时候发出一个事件。 所有这些产生事件的对象都是 events.EventEmitter 的实例。 你可以通过require("events");来访问该模块。

**e.g. **
	
	//event.js 
	var EventEmitter = require('events').EventEmitter; 
	var event = new EventEmitter(); 
	event.on('some_event', function() { 
		console.log('some_event occured.'); 
	}); 
	setTimeout(function() { 
		event.emit('some_event'); 
	}, 1000); 


运行这段代码，1秒后控制台输出了 'some_event occured'。其原理是 event 对象 注册了事件 some_event 的一个监听器，然后我们通过 setTimeout 在1000毫秒以后向 event 对象发送事件 some_event，此时会调用some_event 的监听器。

##EventEmitter介绍
events 模块只提供了一个对象： events.EventEmitter。EventEmitter 的核心就 是事件发射与事件监听器功能的封装。

EventEmitter 的每个事件由一个事件名和若干个参 数组成，事件名是一个字符串，通常表达一定的语义。对于每个事件，EventEmitter 支持 若干个事件监听器。

当事件发射时，注册到这个事件的事件监听器被依次调用，事件参数作 为回调函数参数传递。


###EventEmitter常用的API

* EventEmitter.on(event, listener)、emitter.addListener(event, listener) 为指定事件注册一个监听器，接受一个字 符串 event 和一个回调函数 listener。
* EventEmitter.emit(event, [arg1], [arg2], [...]) 发射 event 事件，传 递若干可选参数到事件监听器的参数表。
* EventEmitter.once(event, listener) 为指定事件注册一个单次监听器，即 监听器最多只会触发一次，触发后立刻解除该监听器。
* EventEmitter.removeListener(event, listener) 移除指定事件的某个监听 器，listener 必须是该事件已经注册过的监听器。
* EventEmitter.removeAllListeners([event]) 移除所有事件的所有监听器， 如果指定 event，则移除指定事件的所有监听器。

##error 事件
EventEmitter 定义了一个特殊的事件 error，它包含了"错误"的语义，我们在遇到 异常的时候通常会发射 error 事件。

当 error 被发射时，EventEmitter 规定如果没有响 应的监听器，Node.js 会把它当作异常，退出程序并打印调用栈。

我们一般要为会发射 error 事件的对象设置监听器，避免遇到错误后整个程序崩溃。

##继承 EventEmitter
大多数时候我们不会直接使用 EventEmitter，而是在对象中继承它。包括 fs、net、 http 在内的，只要是支持事件响应的核心模块都是 EventEmitter 的子类。

为什么要这样做呢？原因有两点：

* 首先，具有某个实体功能的对象实现事件符合语义， 事件的监听和发射应该是一个对象的方法。

* 其次JavaScript 的对象机制是基于原型的，支持 部分多重继承，继承 EventEmitter 不会打乱对象原有的继承关系。


#Node.js 函数

在JavaScript中，一个函数可以作为另一个函数接收一个参数。我们可以先定义一个函数，然后传递，也可以在传递参数的地方直接定义函数。

Node.js中函数的使用与Javascript类似。

	function say(word) {
  		console.log(word);
	}

	function execute(someFunction, value) {
  		someFunction(value);
	}

	execute(say, "Hello");

以上代码中，我们把 say 函数作为execute函数的第一个变量进行了传递。这里返回的不是 say 的返回值，而是 say 本身！

这样一来， say 就变成了execute 中的本地变量 someFunction ，execute可以通过调用 someFunction() （带括号的形式）来使用 say 函数。


##匿名函数
我们可以把一个函数作为变量传递。但是我们不一定要绕这个"先定义，再传递"的圈子，我们可以直接在另一个函数的括号中定义和传递这个函数：

	function execute(someFunction, value) {
  		someFunction(value);
	}

	execute(function(word){ console.log(word) }, "Hello");

我们在 execute 接受第一个参数的地方直接定义了我们准备传递给 execute 的函数。

用这种方式，我们甚至不用给这个函数起名字，这也是为什么它被叫做匿名函数 。

#Node.js 全局对象

JavaScript 中有一个特殊的对象，称为全局对象（Global Object），它及其所有属性都可 以在程序的任何地方访问，即全局变量。

在浏览器JavaScript 中，通常window 是全局对象， 而Node.js 中的全局对象是 global，所有全局变量（除了 global 本身以外）都是 global 对象的属性。

我们在Node.js 中能够直接访问到对象通常都是 global 的属性，如 console、process 等


##全局对象与全局变量
global 最根本的作用是作为全局变量的宿主。按照ECMAScript 的定义，满足以下条 件的变量是全局变量：

* 在最外层定义的变量；
* 全局对象的属性；
* 隐式定义的变量（未定义直接赋值的变量）。

当你定义一个全局变量时，这个变量同时也会成为全局对象的属性，反之亦然。需要注 意的是，在Node.js 中你不可能在最外层定义变量，因为所有用户代码都是属于当前模块的， 而模块本身不是最外层上下文。

注意： 永远使用var 定义变量以避免引入全局变量，因为全局变量会污染 命名空间，提高代码的耦合风险。

###process
process 是一个全局变量，即 global 对象的属性。

它用于描述当前Node.js 进程状态 的对象，提供了一个与操作系统的简单接口。通常在你写本地命令行程序的时候，少不了要 和它打交道。下面将会介绍process 对象的一些最常用的成员方法。

* process.argv是命令行参数数组，第一个元素是 node，第二个元素是脚本文件名， 从第三个元素开始每个元素是一个运行参数。
* process.stdout是标准输出流，通常我们使用的 console.log() 向标准输出打印 字符，而 process.stdout.write() 函数提供了更底层的接口。
* process.stdin是标准输入流，初始时它是被暂停的，要想从标准输入读取数据， 你必须恢复流，并手动编写流的事件响应函数。
* process.nextTick(callback)的功能是为事件循环设置一项任务，Node.js 会在 下次事件循环调响应时调用 callback。



> Node.js 适合I/O 密集型的应用，而不是计算密集型的应用， 因为一个Node.js 进程只有一个线程，因此在任何时刻都只有一个事件在执行。

> 如果这个事 件占用大量的CPU 时间，执行事件循环中的下一个事件就需要等待很久，因此Node.js 的一 个编程原则就是尽量缩短每个事件的执行时间。process.nextTick() 提供了一个这样的 工具，可以把复杂的工作拆散，变成一个个较小的事件。


###console
console 用于提供控制台标准输出，它是由Internet Explorer 的JScript 引擎提供的调试 工具，后来逐渐成为浏览器的事实标准。

Node.js 沿用了这个标准，提供与习惯行为一致的 console 对象，用于向标准输出流（stdout）或标准错误流（stderr）输出字符。  console.log()：向标准输出流打印字符并以换行符结束。

console.log 接受若干 个参数，如果只有一个参数，则输出这个参数的字符串形式。如果有多个参数，则 以类似于C 语言 printf() 命令的格式输出。

	console.log('Hello world'); 
	console.log('byvoid%diovyb'); 
	console.log('byvoid%diovyb', 1991); 
运行的结果为：

	Hello world 
	byvoid%diovyb 
	byvoid1991iovyb 

* console.error()：与console.log() 用法相同，只是向标准错误流输出。
* console.trace()：向标准错误流输出当前的调用栈。


#Node.js 常用工具 util

util 是一个Node.js 核心模块，提供常用函数的集合，用于弥补核心JavaScript 的功能 过于精简的不足。

##util.inherits
util.inherits(constructor, superConstructor)是一个实现对象间原型继承 的函数。

JavaScript 的面向对象特性是基于原型的，与常见的基于类的不同。JavaScript 没有 提供对象继承的语言级别特性，而是通过原型复制来实现的。

##util.inspect
util.inspect(object,[showHidden],[depth],[colors])是一个将任意对象转换 为字符串的方法，通常用于调试和错误输出。它至少接受一个参数 object，即要转换的对象。

showHidden 是一个可选参数，如果值为 true，将会输出更多隐藏信息。

depth 表示最大递归的层数，如果对象很复杂，你可以指定层数以控制输出信息的多 少。如果不指定depth，默认会递归2层，指定为 null 表示将不限递归层数完整遍历对象。 如果color 值为 true，输出格式将会以ANSI 颜色编码，通常用于在终端显示更漂亮 的效果。

特别要指出的是，util.inspect 并不会简单地直接把对象转换为字符串，即使该对 象定义了toString 方法也不会调用。

##util.isArray(object)
如果给定的参数 "object" 是一个数组返回true，否则返回false。

##util.isRegExp(object)
如果给定的参数 "object" 是一个正则表达式返回true，否则返回false。

##util.isDate(object)
如果给定的参数 "object" 是一个日期返回true，否则返回false。

##util.isError(object)
如果给定的参数 "object" 是一个错误对象返回true，否则返回false。

#Node.js 文件系统

Node.js 文件系统封装在 fs 模块是中，它提供了文件的读取、写入、更名、删除、遍历目录、链接等POSIX 文件系统操作。

与其他模块不同的是，fs 模块中所有的操作都提供了异步的和 同步的两个版本，例如读取文件内容的函数有异步的 fs.readFile() 和同步的 fs.readFileSync()。

##fs.readFile
Node.js读取文件函数语法如下：

	fs.readFile(filename,[encoding],[callback(err,data)])
* filename（必选），表示要读取的文件名。
* encoding（可选），表示文件的字符编码。
* callback 是回调函数，用于接收文件的内容。

如果不指 定 encoding，则 callback 就是第二个参数。回调函数提供两个参数 err 和 data，err 表 示有没有错误发生，data 是文件内容。如果指定了 encoding，data 是一个解析后的字符 串，否则 data 将会是以 Buffer 形式表示的二进制数据。


##fs.readFileSync
fs.readFileSync(filename, [encoding])是 fs.readFile 同步的版本。它接受 的参数和 fs.readFile 相同，而读取到的文件内容会以函数返回值的形式返回。如果有错 误发生，fs 将会抛出异常，你需要使用 try 和 catch 捕捉并处理异常。

注意：与同步I/O 函数不同，Node.js 中异步函数大多没有返回值。


##s.open
fs.open(path, flags, [mode], [callback(err, fd)])是POSIX open 函数的 封装，与C 语言标准库中的 fopen 函数类似。它接受两个必选参数，path 为文件的路径， flags 可以是以下值。

* r ：以读取模式打开文件。
* r+ ：以读写模式打开文件。
* w ：以写入模式打开文件，如果文件不存在则创建。
* w+ ：以读写模式打开文件，如果文件不存在则创建。
* a ：以追加模式打开文件，如果文件不存在则创建。
* a+ ：以读取追加模式打开文件，如果文件不存在则创建

##fs.read
fs.read语法格式如下：

	fs.read(fd, buffer, offset, length, position, [callback(err, bytesRead, buffer)])

参数说明：

* fd: 读取数据并写入 buffer 指向的缓冲区对象。
* offset: 是buffer 的写入偏移量。
* length: 是要从文件中读取的字节数。
* position: 是文件读取的起始位置，如果 position 的值为 null，则会从当前文件指针的位置读取。
* callback:回调函数传递bytesRead 和 buffer，分别表示读取的字节数和缓冲区对象。


##fs 模块函数表
![fs api](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/nodejs-fs-api.png)

[更多fs的api](https://nodejs.org/api/fs.html)


#Node.js GET/POST请求

在很多场景中，我们的服务器都需要跟用户的浏览器打交道，如表单提交。

表单提交到服务器一般都使用GET/POST请求。

##获取GET请求内容
由于GET请求直接被嵌入在路径中，URL是完整的请求路径，包括了?后面的部分，因此你可以手动解析后面的内容作为GET请求的参数。

node.js中url模块中的parse函数提供了这个功能。

	var http = require('http');
	var url = require('url');
	var util = require('util');

	http.createServer(function(req, res){
   		res.writeHead(200, {'Content-Type': 'text/plain'});
    	res.end(util.inspect(url.parse(req.url, true)));
	}).listen(3000);



##获取POST请求内容
POST请求的内容全部的都在请求体中，http.ServerRequest并没有一个属性内容为请求体，原因是等待请求体传输可能是一件耗时的工作。

比如上传文件，而很多时候我们可能并不需要理会请求体的内容，恶意的POST请求会大大消耗服务器的资源，所有node.js默认是不会解析请求体的， 当你需要的时候，需要手动来做。

	var http = require('http');
	var querystring = require('querystring');
	var util = require('util');

	http.createServer(function(req, res){
    	var post = '';     //定义了一个post变量，用于暂存请求体的信息

    	req.on('data', function(chunk){    //通过req的data事件监听函数，每当接受到请求体的数据，就累加到post变量中
       	post += chunk;
    	});

    	req.on('end', function(){    //在end事件触发后，通过querystring.parse将post解析为真正的POST请求格式，然后向客户端返回。
        	post = querystring.parse(post);
        	res.end(util.inspect(post));
    	});
	}).listen(3000);


#NPM 使用介绍

NPM是随同NodeJS一起安装的包管理工具，能解决NodeJS代码部署上的很多问题，常见的使用场景有以下几种：

* 允许用户从NPM服务器下载别人编写的第三方包到本地使用。
* 允许用户从NPM服务器下载并安装别人编写的命令行程序到本地使用。
* 允许用户将自己编写的包或命令行程序上传到NPM服务器供别人使用。

由于新版的nodejs已经集成了npm，所以之前npm也一并安装好了。同样可以使用cmd命令行输入"npm -v"来测试是否成功安装。


##NPM 应用
NPM建立了一个NodeJS生态圈，NodeJS开发者和用户可以在里边互通有无。以下介绍NPM应用的三种场景：

###下载第三方包

可以使用以下命令来下载第三方包。

	npm install argv
	
以上命令默认下载最新版第三方包，如果想要下载指定版本的话，可以在包名后边加上@<version>。

###安装命令行程序

从NPM服务上下载安装一个命令行程序的方法与第三方包类似.

###发布代码

第一次使用NPM发布代码前需要注册一个账号。终端下运行npm adduser，之后按照提示做即可。

账号注册完成后，接着我们需要编辑package.json文件，加入NPM必需的字段。

##版本号
使用NPM下载和发布代码时都会接触到版本号。NPM使用语义版本号来管理代码，这里简单介绍一下。

语义版本号分为X.Y.Z三位，分别代表主版本号、次版本号和补丁版本号。当代码变更时，版本号按以下原则更新。

* 如果只是修复bug，需要更新Z位。
* 如果是新增了功能，但是向下兼容，需要更新Y位。
* 如果有大变动，向下不兼容，需要更新X位。

版本号有了这个保证后，在申明第三方包依赖时，除了可依赖于一个固定版本号外，还可依赖于某个范围的版本号。例如"argv": "0.0.x"表示依赖于0.0.x系列的最新版argv。


##NPM常用命令
NPM还提供了很多功能，package.json里也有很多其它有用的字段。

除了可以在npmjs.org/doc/查看官方文档外，这里再介绍一些NPM常用命令。

* NPM提供了很多命令，例如install和publish，使用npm help可查看所有命令。

* 使用npm help <command>可查看某条命令的详细帮助，例如npm help install。

* 在package.json所在目录下使用npm install . -g可先在本地安装当前命令行程序，可用于发布前的本地测试。

* 使用npm update <package>可以把当前目录下node_modules子目录里边的对应模块更新至最新版本。

* 使用npm update <package> -g可以把全局安装的对应命令行程序更新至最新版。

* 使用npm cache clear可以清空NPM本地缓存，用于对付使用相同版本号发布新版本代码的人。

* 使用npm unpublish <package>@<version>可以撤销发布自己发布过的某个版本代码。

		

#Node.js 路由

我们要为路由提供请求的URL和其他需要的GET及POST参数，随后路由需要根据这些数据来执行相应的代码。

因此，我们需要查看HTTP请求，从中提取出请求的URL以及GET/POST参数。这一功能应当属于路由还是服务器（甚至作为一个模块自身的功能）确实值得探讨，但这里暂定其为我们的HTTP服务器的功能。

我们需要的所有数据都会包含在request对象中，该对象作为onRequest()回调函数的第一个参数传递。但是为了解析这些数据，我们需要额外的Node.JS模块，它们分别是url和querystring模块。

**e.g. **

route.js

	function route(pathname) {
  		console.log("About to route a request for " + pathname);
	}

	exports.route = route;


server.js

	var http = require("http");
	var url = require("url");

	function start(route) {
  		function onRequest(request, response) {
    	var pathname = url.parse(request.url).pathname;
    	console.log("Request for " + pathname + " received.");

    	route(pathname);

    	response.writeHead(200, {"Content-Type": "text/plain"});
    	response.write("Hello World");
    	response.end();
  		}

  		http.createServer(onRequest).listen(8888);
  		console.log("Server has started.");
	}

	exports.start = start;


index.js，使得路由函数可以被注入到服务器中

	var server = require("./server");
	var router = require("./router");

	server.start(router.route);




































