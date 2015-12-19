#Express

Express 是一个基于 Node.js 平台的极简、灵活的 web 应用开发框架，它提供一系列强大的特性，帮助你创建各种 Web 和移动设备应用。

##安装
安装Express并将其保存到依赖列表中：
	
	$ npm install --save express
	
如果只是临时安装 Express，不想将它添加到依赖列表中，只需略去 --save 参数即可：

	$ npm install express	
	
##helloworld

进入 myapp 目录，创建一个名为 app.js 的文件

	var express = require('express');
	var app = express();
	
	app.get('/', function (req, res) {
	  res.send('Hello World!');
	});
	
	var server = app.listen(3000, function () {
	  var host = server.address().address;
	  var port = server.address().port;
	
	  console.log('Example app listening at http://%s:%s', host, port);
	});	
	
	
上面的代码启动一个服务并监听从 3000 端口进入的所有连接请求。他将对所有 (/) URL 或 路由 返回 “Hello World!” 字符串。对于其他所有路径全部返回 404 Not Found。

req (请求) 和 res (响应) 与 Node 提供的对象完全一致，因此，你可以调用 req.pipe()、req.on('data', callback) 以及任何 Node 提供的方法。

启动此应用

	node app.js	
	
##路由	

路由（Routing）是由一个 URI（或者叫路径）和一个特定的 HTTP 方法（GET、POST 等）组成的，涉及到应用如何响应客户端对某个网站节点的访问。

每一个路由都可以有一个或者多个处理器函数，当匹配到路由时，这个/些函数将被执行。

> 路由的定义由如下结构组成：app.METHOD(PATH, HANDLER)。其中，app 是一个 express 实例；METHOD 是某个 HTTP 请求方式中的一个；PATH 是服务器端的路径；HANDLER 是当路由匹配到时需要执行的函数。

假定已经存在一个命名为 app 的 express 实例了，并且应用程序是运行状态:

	// 对网站首页的访问返回 "Hello World!" 字样
	app.get('/', function (req, res) {
	  res.send('Hello World!');
	});
	
	// 网站首页接受 POST 请求
	app.post('/', function (req, res) {
	  res.send('Got a POST request');
	});
	
	// /user 节点接受 PUT 请求
	app.put('/user', function (req, res) {
	  res.send('Got a PUT request at /user');
	});
	
	// /user 节点接受 DELETE 请求
	app.delete('/user', function (req, res) {
	  res.send('Got a DELETE request at /user');
	});	

###路由方法

Express 定义了如下和 HTTP 请求对应的路由方法：
	
	get, post, put, head, delete, options, trace, copy, lock, mkcol, move, purge, propfind, proppatch, unlock, report, mkactivity, checkout, merge, m-search, notify, subscribe, unsubscribe, patch, search, 和 connect
	
有些路由方法名不是合规的 JavaScript 变量名，此时使用括号记法，比如： 
	
	app['m-search']('/', function ...


app.all() 是一个特殊的路由方法，没有任何 HTTP 方法与其对应，它的作用是对于一个路径上的所有请求加载中间件。

###路由路径

路由路径和请求方法一起定义了请求的端点，它可以是字符串、字符串模式或者正则表达式。

Express 使用 path-to-regexp 匹配路由路径。

###路由句柄

可以为请求处理提供多个回调函数，其行为类似 中间件。唯一的区别是这些回调函数有可能调用 next('route') 方法而略过其他路由回调函数。可以利用该机制为路由定义前提条件，如果在现有路径上继续执行没有意义，则可将控制权交给剩下的路径。

路由句柄有多种形式，可以是一个函数、一个函数数组，或者是两者混合。

###响应方法

响应对象（res）的方法向客户端返回响应，终结请求响应的循环。

* res.download()
* res.end()
* res.json()
* res.jsonp
* res.redirect()
* res.render()
* res.send()
* res.sendFile()
* res.sendStatus()


###app.route()
可使用 app.route() 创建路由路径的链式路由句柄。由于路径在一个地方指定，这样做有助于创建模块化的路由，而且减少了代码冗余和拼写错误。


使用 app.route() 定义了链式路由句柄。

	app.route('/book')
	  .get(function(req, res) {
	    res.send('Get a random book');
	  })
	  .post(function(req, res) {
	    res.send('Add a book');
	  })
	  .put(function(req, res) {
	    res.send('Update the book');
	  });	
	  
###express.Router
可使用 express.Router 类创建模块化、可挂载的路由句柄。Router 实例是一个完整的中间件和路由系统，因此常称其为一个 “mini-app”。

##express生成器

安装

	$ npm install express-generator -g
	
选项
	
	$ express -h
	
创建myapp应用

	$ express myapp
	
安装依赖包

	$ cd myapp
	$ npm install

启动应用

	MacOS/Linux
	$ DEBUG=myapp npm start
	windows
	> set DEBUG=myapp & npm start
	
然后在浏览器中打开 http://localhost:3000/ 网址就可以看到这个应用了	
	
通过 Express 应用生成器创建的应用一般都有如下目录结构：

	.
	├── app.js
	├── bin
	│   └── www
	├── package.json
	├── public
	│   ├── images
	│   ├── javascripts
	│   └── stylesheets
	│       └── style.css
	├── routes
	│   ├── index.js
	│   └── users.js
	└── views
	    ├── error.jade
	    ├── index.jade
	    └── layout.jade
	
	7 directories, 9 files
	
	
	
##express托管静态文件

通过 Express 内置的 express.static 可以方便地托管静态文件，例如图片、CSS、JavaScript 文件等。

将静态资源文件所在的目录作为参数传递给 express.static 中间件就可以提供静态资源文件的访问了。例如，假设在 public 目录放置了图片、CSS 和 JavaScript 文件，你就可以：

	var express = require('express');
	var app = express();

	app.use(express.static('public'));
	
现在，public 目录下面的文件就可以访问了。

	http://localhost:3000/images/kitten.jpg
	http://localhost:3000/css/style.css
	http://localhost:3000/js/app.js
	http://localhost:3000/images/bg.png
	http://localhost:3000/hello.html
	
所有文件的路径都是相对于存放目录的，因此，存放静态文件的目录名不会出现在 URL 中。

			
如果你的静态资源存放在多个目录下面，你可以多次调用 express.static 中间件：

	app.use(express.static('public'));
	app.use(express.static('files'));
	
访问静态资源文件时，express.static 中间件会根据目录添加的顺序查找所需的文件。

如果你希望所有通过 express.static 访问的文件都存放在一个“虚拟（virtual）”目录（即目录根本不存在）下面，可以通过为静态资源目录指定一个挂载路径的方式来实现，如下所示：

	app.use('/static', express.static('public'));

可以通过带有 “/static” 前缀的地址来访问 public 目录下面的文件了：

	http://localhost:3000/static/images/kitten.jpg
	http://localhost:3000/static/css/style.css
	http://localhost:3000/static/js/app.js
	http://localhost:3000/static/images/bg.png
	http://localhost:3000/static/hello.html
	
	
##中间件

Express 是一个自身功能极简，完全是由路由和中间件构成一个的 web 开发框架：从本质上来说，一个 Express 应用就是在调用各种中间件。

中间件（Middleware） 是一个函数，它可以访问请求对象（request object (req)）, 响应对象（response object (res)）, 和 web 应用中处于请求-响应循环流程中的中间件，一般被命名为 next 的变量。

中间件的功能包括：

* 执行任何代码。
* 修改请求和响应对象。
* 终结请求-响应循环。
* 调用堆栈中的下一个中间件。

如果当前中间件没有终结请求-响应循环，则必须调用 next() 方法将控制权交给下一个中间件，否则请求就会挂起。

Express 应用可使用如下几种中间件：

* 应用级中间件
* 路由级中间件
* 错误处理中间件
* 内置中间件
* 第三方中间件

###应用级中间件
应用级中间件绑定到 app 对象 使用 app.use() 和 app.METHOD()， 其中， METHOD 是需要处理的 HTTP 请求的方法，例如 GET, PUT, POST 等等，全部小写。

	var app = express();
	
	// 没有挂载路径的中间件，应用的每个请求都会执行该中间件
	app.use(function (req, res, next) {
	  console.log('Time:', Date.now());
	  next();
	});
	
	// 挂载至 /user/:id 的中间件，任何指向 /user/:id 的请求都会执行它
	app.use('/user/:id', function (req, res, next) {
	  console.log('Request Type:', req.method);
	  next();
	});
	
	// 路由和句柄函数(中间件系统)，处理指向 /user/:id 的 GET 请求
	app.get('/user/:id', function (req, res, next) {
	  res.send('USER');
	});
	
###路由级中间件
路由级中间件和应用级中间件一样，只是它绑定的对象为 express.Router()

	var router = express.Router();
	
路由级使用 router.use() 或 router.VERB() 加载。

上述在应用级创建的中间件系统，可通过如下代码改写为路由级：

	var app = express();
	var router = express.Router();
	
	// 没有挂载路径的中间件，通过该路由的每个请求都会执行该中间件
	router.use(function (req, res, next) {
	  console.log('Time:', Date.now());
	  next();
	});
	
	// 一个中间件栈，显示任何指向 /user/:id 的 HTTP 请求的信息
	router.use('/user/:id', function(req, res, next) {
	  console.log('Request URL:', req.originalUrl);
	  next();
	}, function (req, res, next) {
	  console.log('Request Type:', req.method);
	  next();
	});
	
	// 一个中间件栈，处理指向 /user/:id 的 GET 请求
	router.get('/user/:id', function (req, res, next) {
	  // 如果 user id 为 0, 跳到下一个路由
	  if (req.params.id == 0) next('route');
	  // 负责将控制权交给栈中下一个中间件
	  else next(); //
	}, function (req, res, next) {
	  // 渲染常规页面
	  res.render('regular');
	});
	
	// 处理 /user/:id， 渲染一个特殊页面
	router.get('/user/:id', function (req, res, next) {
	  console.log(req.params.id);
	  res.render('special');
	});		
	
	// 将路由挂载至应用
	app.use('/', router);	

###错误处理中间件
错误处理中间件有 4 个参数，定义错误处理中间件时必须使用这 4 个参数。即使不需要 next 对象，也必须在签名中声明它，否则中间件会被识别为一个常规中间件，不能处理错误。

错误处理中间件和其他中间件定义类似，只是要使用 4 个参数，而不是 3 个，其签名如下： (err, req, res, next)。

	app.use(function(err, req, res, next) {
	  console.error(err.stack);
	  res.status(500).send('Something broke!');
	});
	
###内置中间件
从 4.x 版本开始，, Express 已经不再依赖 Connect 了。除了 express.static, Express 以前内置的中间件现在已经全部单独作为模块安装使用了。请参考 中间件列表。

	express.static(root, [options])

express.static 是 Express 唯一内置的中间件。它基于 serve-static，负责在 Express 应用中提托管静态资源。

参数 root 指提供静态资源的根目录。

可选参数options具有特定的一些属性	
	
使用了 express.static 中间件，其中的 options 对象经过了精心的设计:

	var options = {
	  dotfiles: 'ignore',
	  etag: false,
	  extensions: ['htm', 'html'],
	  index: false,
	  maxAge: '1d',
	  redirect: false,
	  setHeaders: function (res, path, stat) {
	    res.set('x-timestamp', Date.now());
	  }
	}
	
	app.use(express.static('public', options));	

###第三方中间件

过使用第三方中间件从而为 Express 应用增加更多功能。

安装所需功能的 node 模块，并在应用中加载，可以在应用级加载，也可以在路由级加载。

下面的例子安装并加载了一个解析 cookie 的中间件： cookie-parser

	$ npm install cookie-parser
	
	var express = require('express');
	var app = express();
	var cookieParser = require('cookie-parser');
	
	// 加载用于解析 cookie 的中间件
	app.use(cookieParser());	

[第三方中间件](http://www.expressjs.com.cn/resources/middleware.html)

##在 Express 中使用模板引擎

需要在应用中进行如下设置才能让 Express 渲染模板文件：

* views, 放模板文件的目录，比如： app.set('views', './views')
* view engine, 模板引擎，比如： app.set('view engine', 'jade')

然后安装相应的模板引擎 npm 软件包。

	$ npm install jade --save
	
<http://www.expressjs.com.cn/guide/using-template-engines.html>	


##错误处理

##调试 Express

在启动应用时，设置 DEBUG 环境变量为 express:*，可以查看 Express 中用到的所有内部日志。

	$ DEBUG=express:* node index.js

在 Windows 系统里，使用如下的命令。

	> set DEBUG=express:* & node index.js

##集成数据库

为 Express 应用添加连接数据库的能力，只需要加载相应数据库的 Node.js 驱动即可。这里将会简要介绍如何为 Express 应用添加和使用一些常用的数据库 Node 模块。

* Cassandra
* CouchDB
* LevelDB
* MySQL
* MongoDB
* Neo4j
* PostgreSQL
* Redis
* SQLite
* ElasticSearch

<http://www.expressjs.com.cn/guide/database-integration.html>


##参考

<http://www.expressjs.com.cn/>