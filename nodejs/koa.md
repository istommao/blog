# koa

## koa简介
koa是下一代基于nodejs的modern web framework，会用到很多es高级特性，可以说无论从es学习还是web开发都有必要学习。

koa 是由 Express 原班人马打造的，致力于成为一个更小、更富有表现力、更健壮的 Web 框架。使用 koa 编写 web 应用，通过组合不同的 generator，可以免除重复繁琐的回调函数嵌套，并极大地提升错误处理的效率。koa 不在内核方法中绑定任何中间件，它仅仅提供了一个轻量优雅的函数库，使得编写 Web 应用变得得心应手。

## nodejs 4.x新特性

### classes

在ES6中声明一个class。

详见：<http://base-n.github.io/koa-generator-examples/node4/classes.html>
	
###  Generator

> Generator是ES6引入的实现异步操作的一种新方法，在Generator出现之前，不管哪种方法，异步操作都是使用回调函数来实现的。只从出现了Generator之后，开发人员可以使用同步调用的逻辑来实现异步操作，只要在需要等待的地方，使用yield语句即可

	
	function* helloworld(){
	    yield "Hello";
	    return "World!";
	}
	
	func = helloworld();
	func.next();//return { value: 'Hello', done: false }
	func.next();//return { value: 'World!', done: true }
	func.next();//return { value: '', done: true }
	
### arrow functions

### 块作用域

### template strings

### Promises

### Symbol
	
> 在ES5中，所有的属性名使用的都是标准的字符串，如果你想修改一个别人提供的对象，并且为这个对象增加一个方法的时候，你就要非常小心了，因为你可能选择了一个已经存在的方法的名字。因此在ES6中引入了Symbol这个类型，当你使用Symbol类型来定义类的属性或者方法名的时候，ES6将保证这个属性和方法名称是全局唯一的。

## kao基础

#### 详见
<http://koa.bootcss.com/>

### koa的Context（上下文）

Koa Context 将 node 的 request 和 response 对象封装在一个单独的对象里面，其为编写 web 应用和 API 提供了很多有用的方法。

这些操作在 HTTP 服务器开发中经常使用，因此其被添加在上下文这一层，而不是更高层框架中，因此将迫使中间件需要重新实现这些常用方法。

context 在每个 request 请求中被创建，在中间件中作为接收器(receiver)来引用，或者通过 this 标识符来引用：

	app.use(function *(){
	  this; // is the Context
	  this.request; // is a koa Request
	  this.response; // is a koa Response
	});
	
**对比express的中间件**

	app.use(function (req, res, next) {
	  return next();
	});

* express里的req和res是显式声明，看起来更清晰一些
* next处理是一样的，二者无差异

注释1： 此处的this 并不同于通常状态下的this 指向（即调用者）。在koa中 this 指向每一次的请求，在请求接受后初始化，在一次请求结束后被释放。

#### 详见

<http://koa.bootcss.com/#context>

### 请求(Request)

Koa Request 对象是对 node 的 request 进一步抽象和封装，提供了日常 HTTP 服务器开发中一些有用的功能。

	
#### 参考
<http://koa.bootcss.com/#request>
	

### 响应(Response)

Koa Response 对象是对 node 的 response 进一步抽象和封装，提供了日常 HTTP 服务器开发中一些有用的功能。

<http://koa.bootcss.com/#response>


## koa-generator

这里的generator是生成器的意思，用于生成项目骨架，express-generator就是一个比较好的例子，虽然比较精简，但结构清晰，足矣满足一般性的开发需求

鉴于很多人非常熟悉expressjs，这里假定大家也熟悉express-generator

**express-generator提供的功能**

* 生成项目骨架
* 约定目录结构（经典，精简，结构清晰）
* 支持css预处理器

**koa-generator提供的功能**

* 生成项目骨架
* 约定目录结构（和express-generator的结构一模一样）
* 支持css预处理器（暂未实行）

**2个生成器共同的项目骨架结构**

* app.js为入口
* bin/www为启动入口
* 支持static server，即public目录
* 支持routes路由目录
* 支持views视图目录
* 默认jade为模板引擎

koa-generator支持koa1.x和2.x，安装后，可以分别使用koa和koa2分别创建。

### 创建项目
(可以比较express-generator创建项目：[node-blog](https://github.com/zhuwei05/blog/blob/master/nodejs%2Fnode-blog.md))

安装koa-genarator

	npm install -g koa-generator
	
创建项目

	koa 1.x: koa projectName
	koa 2.x: koa2 blog-koa	
	
执行完后提示：

	install dependencies:
		$ cd blog-koa && npm install

	run the app:
		$ DEBUG=blog-koa:* npm start	
依照提示执行依赖的安装：

	cd blog-koa && npm install
	
	
执行：

	$ DEBUG=blog-koa:* npm start
	
	
访问：

	localhost:3000		
	
### 切换视图模板引擎
视图默认使用的是 jade 。如果想使用其他的视图

	$ koa 1.x/views-ejs -e

说明

	-e, --ejs add ejs engine support (defaults to jade)

koa-generator使用的是[koa-views](https://github.com/queckezz/koa-views)，支持所有[consolidate.js](https://github.com/tj/consolidate.js#supported-template-engines)支持模板引擎

	

## 参考

* [一起学koa](http://base-n.github.io/koa-generator-examples/)
* [koa wiki](https://github.com/koajs/koa/wiki)