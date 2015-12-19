#nodejs+socketiok开发聊天室

##Express

Express 是一个基于 Node.js 平台的极简、灵活的 web 应用开发框架，它提供一系列强大的特性，帮助你创建各种 Web 和移动设备应用。

###安装
安装Express并将其保存到依赖列表中：
	
	$ npm install --save express
	
如果只是临时安装 Express，不想将它添加到依赖列表中，只需略去 --save 参数即可：

	$ npm install express	
	
###helloworld

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
	
###路由	

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



###express生成器

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
	
	
	
###express托管静态文件

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


##npm

		npm init 命令为你的应用创建一个 package.json 文件。 

##socketio

	$ npm install --save socket.io
	
##chat应用

###配置

####指定目录为：chat, 新建package.json

	{
	  "name": "realtime-server",
	  "version": "0.0.1",
	  "description": "my first realtime server",
	  "dependencies": {}
	}	
	
####安装express 和 socket.io

	npm install --save express
	npm install --save socket.io
	
安装成功后，应该可以看到工作目录下生成了一个名为node_modules的文件夹，里面分别是express和socket.io

###编写服务端代码

	var app = require('express')();
	var http = require('http').Server(app);
	var io = require('socket.io')(http);
	app.get('/', function(req, res){
		res.send('<h1>Welcome Realtime Server</h1>');
	});
	http.listen(3000, function(){
		console.log('listening on *:3000');
	});
	
运行node index.js，如果一切顺利，你应该会看到返回的listening on *:3000字样，这说明服务已经成功搭建了。此时浏览器中打开http://localhost:3000应该可以看到正常的欢迎页面。	
###nginx配置

如果你想要让服务运行在线上服务器，并且可以通过域名访问的话，可以使用Nginx做代理，在nginx.conf中添加如下配置，然后将域名（比如：realtime.plhwin.com）解析到服务器IP即可：

	server
	{
	  listen       80;
	  server_name  realtime.plhwin.com;
	  location / {
	    proxy_pass http://127.0.0.1:3000;
	  }
	}			

完成以上步骤，http://realtime.plhwin.com:3000的后端服务就正常搭建了。


	

##参考

[使用Node.js+Socket.IO搭建WebSocket实时应用](http://www.plhwin.com/2014/05/28/nodejs-socketio/)

