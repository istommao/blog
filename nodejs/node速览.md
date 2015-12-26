#node速览

node使用javascript语言。


##js简介

##node的模块http实现helloworld

##node模块fs实现读取文件

	var fs = require('fs');
	fs.readFile('file.txt', 'UTF-8', function(err, data){
		if (err) {
			console.log(err);
		} else {
			console.log(data);
		}
		
	});
	console.log('test');
	
##node模块events模块
普通事件
	
	声明事件对象
	var EventEmitter = require('events').EventEmitter;
	var event = new EventEmitter();
	注册事件
	event.on('some_event', function(){
		console.log('自定义事件');
	});		
	
	setTimeout(function(){
		event.emit('some event');
	}, 1000);
	
事件循环机制

	程序由事件循环开始到事件循环结束，所有逻辑都是事件的回调

##模块和包

模块和包区别是透明的，常常不做区分。

###模块：
**模块和文件意义对应，一个nodejs文件就是一个模块，这个文件可以是js代码，json编译过的c++扩展**

模块创建：

	提供exports和require两个对象，exports是模块公开的接口，require用于从外部获取一个模块的接口，即获取exports对象。
	
require只加载

若想封装：

	在js文件定义一个function hello() {...}
	然后通过module.exports = hello;
	在其他文件引入: require('hello')	var he = new hello();


###包：
**在模块基础上更深一步抽象，类似与C/C++的函数库或java类库**

创建一个包

	commonJS规范包具备特征：
	* package.json必须在包的顶层目录下
		{
			'main': './lib/package.js'
		}
		
		属性
			name： 包名字
			description：描述
			version：版本
			keywords：关键字数据，通常用于搜索
			maintainers：维护者数组，每个元素要包含name，email，web可选字段
			contributors: 贡献者数组，格式与maintainers相同
			bugs：提交bug的地址
			licenses：许可证数组，每个元素包含type和url字段
			repositories：仓库托管地址数组，每个元素包含type，url和path字段
			dependencies：包的依赖，一个关联数组，由包名和版本号组成
	* 二进制代码在bin目录下
	* js代码应该lib目录下
	* 文档应该在doc目录下
	* 单元测试在test目录下
	
	
##包管理器

	npm [install/i] [package_name]
	
	全局模式：
		npm install -g package-name
		
		npm install -g supervisor
		
	卸载包
		npm uninstall 包名 [-g]
		
	查看当前所有包
		npm list
		
	初始包,生成规范的package.json文件
		npm init
	
	npm默认从npmjs.org搜索和下载包，将包安装到当前目录的node_modules

本地模式和全局模式

	本地模式不会安装到PATH环境, 只是将包安装到node_modules子目录下，其中bin目录没有包含在PATH环境变量中，不能直接在命令行调用。
	
	使用全局模式安装的恶报并不能直接在js文件中通过require获得，因为require不会搜索/usr/local/lib/node_modules
	
	一般来说：包作为工程运行时，就使用本地模式获取，当要作为命令行运行就使用全局模式安装
	
包的发布	

	确保符合commonjs标准的package.json
	npm publish
	
	npm unpublish
	
##全局对象和全局变量

###全局对象
在js中，window是全局属性，而Node中全局对象是global

global最根本作用是作为全局变量的宿主。成为全局变量条件：

	1. 最外层定义的变量
	2. 全局对象的属性
	3. 隐式定义的变量	
	
####process

描述node进程状态对象，提供与操作系统的简单接口，通常与本地命令行使用

1. process.argv是命令行参数数组
2. process.stdout标准输出流, process.stdout.write方法
3. process.stdin标准输入流, process.stdin.resume方法
4. process.nextTick(callback)为事件循环设置任务。node会在下次事件循环响应是调用。node适合io密集型。
5. process的其他方法：nodejs.org/api

####console

1. console.log()
2. console.error()
3. console.trace()


##util和事件EventEmitter

###util全局变量

	var util = require('util');
	

* util.inherits(constructor, superConstuctor)

	实现对象间原型继承的函数
	
* util.inspect(obj, [showHidden], [depth], [colors])

	将任意对象转换为字符串的方法，常用于调试和错误输出

* 其他：查api文档		

###事件驱动events

* 事件发射器

	events模块只提供一个对象。events.EventEmitter就是事件发射和事件监听器功能的封装
	
		var events = require('events');
		// 实例化对象
		var emitter = new events.EventEmitter();
		注册监听事件 
		emitter.on('someEvent', function(arg1, arg2){
			console.log('Listener1', arg1, arg2);
		});
		emitter.on('someEvent', function(arg1, arg2){
			console.log('Listener2', arg1, arg2);
		})
		// 触发事件
		emitter.emit('someEvent', 'abc', 123);


* 常用方法: 参考api文档

	* on
	* emit
	* once
	* removeListener
	* removeAllListener
	
* error事件

	在node中定义一个特殊事件，它包含错误定义，在遇到异常的时候会发射error事件，当error事件被发射时，由于没有相应的监听器，程序会崩溃。可以增加对error事件的监听器
	
* 继承EventEmitter

	大多时候不直接使用EventEmitter，而是在对象中继承它，包括fs, net, http在内。
	
	1. 具有某个实体功能的对象实现事件的符合语义，事件的监听和发射应该是一个对象的发放
	2. js的对象机制基于原型，支持部分多重继承，继承EventEmitter不会打乱对象原有继承关系
	
##fs模块

fs模块中所有的操作都提供了异步和同步. 链接POSIX文件系统操作

	var fs = require('fs');

* fs.readFile(filename, [encoding], [callback(err, data)])
* fs.readFileSync(filename, [encoding])

	添加try...catch

* fs.open(path, flags, [mode], [callback(err, fd)])
* fs.read(fd, buffer, offset, length, position, [callback(err, bytesRead, buffer)])

		
* 其他函数

参考api文档

	var fs=require('fs');
	fs.open('content.txt','r',function(err,fd){
		if(err){
			console.log(err);
			return;
		}
	
		var buf=new Buffer(8);
		fs.read(fd,buf,0,8,null,function(err,bytesRead,buffer){
			if(err){
				console.log(err);
				return;
			}		
			console.log('bytesRead   '+bytesRead);
			console.log(buffer);
		});
	})


	
##http模块

node的http模块封装了一个搞笑的http服务器和一个建议的http客户端。

http.server是一个基于事件的http服务器，内部有c++实现。接口由js封装。

http.request则是一个http客户端工具。

###http服务器

http.Server实现的，提供了一套封装级别很低的api，仅仅是流控制和简单的解析，所有高层功能都需要通过它的接口。
	
	var http = require('http');
	// 创建服务
	http.createServer(function(req, res){
		// 响应头
		res.writeHead(200, {'Content-type': 'text/html'});
		// 响应内容
		res.write('<h1>node</h1>');
		// 结束响应
		res.end('<p>test</p>');
	}).listen(3000); // 监听端口

	
####http.Server事件

	http.Server是一个基于事件的HTTP服务器，所有请求都封装到独立事件，开发者只要对它的事件编写相应函数可实现http服务器的所有功能。
	
	它继承EventEmitter，提供事件：
	
		request：当客户端请求到来时，该事件被处罚，提供req和res参数，分别是http.ServerReqeust和http.ServerResponse的实例，表示请求和响应信息。
		connection: 当tcp连接建立时，该事件被触发，提供一个参数socket，为net。Socket的实例（底层协议对象）
		close：当服务器关闭时，该事件被触发
		
		checkContinue, upgade, clientError事件
	
	request事件，可以用简单方法createServer(requsetListenr), 不需要调用on('request', function(req, res))	
		
####http.ServerRequest

	http请求分为请求头和请求体。提供3个事件控制请求体传输
	
	* data： 当请求体到达，该事件被触发，该事件只有一个参数chunk，表示接收到的数据
	* end：当请求数据传输完成是，改时间被触发，此后不再有数据
	* close：用户当前请求结束是，该事件被触发，不同于end，用户强行终止传输，该事件也会触发
	* complete：请求是否完成
	
			httpVersion：协议版本
			method：	请求方法
			url：
			headers：
			tailers：
			connection：当前http连接的套接字
			socket：connection别名
			client：client属性别名
			
* 获取get请求内容

	get请求直接签入在路径中。通过url模块的parse解析
	
		var http=require('http');
		var urls=require('url');
		var util=require('util');
		
		http.createServer(function(req,res){
			res.writeHead(200,{'Content-Type':'text/plain'});
					res.end(util.inspect(urls.parse(req.url,true)));
		}).listen(3000);
	
* 获取post请求内容

	post请求内容全部都在请求体。
	
		var http=require('http');
		var querystring=require('querystring');
		var util=require('util');
		http.createServer(function(req,res){
			var post='';
			
			req.on('data',function(chunk){
				post+=chunk;
			});
			req.on('end',function(){
				// 解析成json对象
				post=querystring.parse(post);
	
				res.end(util.inspect(post));
			});
		}).listen(3000);	
		
		
####http.ServerRespone

	决定用于最终能得到的结果。主要3个函数：
	
	* response.writeHead(statusCode, [Headers])
		
		headers是一个类似关联数组的对象
	* response.write(data, [encoding])	* response.end([data], [encoding])
		该函数必须被调用，结束响应。	

###http客户端

http.request和http.get向http服务器发送请求

####http.request()

	http.request(options, callback)
	
	options是一个类似关联数组对象，常见参数
		host:域名，IP
		port：端口
		method：请求方式
		path：根路径
		headers：关联数组对象，请求体内容
	callback，作为http.ClientResponse的实例
	
	
	var http = require('http')
	var querystring = require('querystring')
	
	// 启动服务
	http.createServer(function(req, res){
		console.log('server');
		var post = '';
		req.on('data', function(chunk){
			post += chunk;
		});
		
		req.on('end', function(){
			post = querystring.parse(post);
			res.end(post.name);
		});
		
	}).listen(3000);
	
	// 客户端请求
	
	var contents = querystring.stringify({
		name: 'abc',
		age: 21,
		address: 'beijing'
	});
	var options = {
		host: 'localhost',
		path: '/',
		port: 3000,
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Content-Length': contents.length
		}
	};
	
	var req = http.request(options, function(res){
		res.setEncoding('utf-8');
		res.on('data', function(data){
			console.log('后台返回数据')
			console.log(data);
		})
	});
	req.write(contents);
	// 请求结束
	req.end();
			
####http.get()

http.get(options, callback)是一个简化的http.request。唯一区别在http.get自动将请求方法设为GET请求，同时不需要手动调用end。

	http.get({
		'host': 'localhost',
		path: '/user?name=abc&age=21',
		port: 3000},
	fuction(res) {
			res.setEncoding('utf-8');
			res.on('data', function(data){
				console.log(data)
			})
	});
	
####http.ClientRuest

该对象由http.request或http.get返回的对象，表示一个已经产生而且正在请求的http，它提供了response事件，即http。

提供的函数：

* request.abort()终止正在发送的请求
* request.setTimeout(timeout, [callback])设置请求超时事件
* request.setNoDelay, request.setSocketKeepAlive
* api文档

####http.ClientResponse

类似http.ServerResponse相似，提供三个事件，data,end和close，分辨在数据到达，传输结束和连接结束时触发，其中data事件传递一个参数chunk，表示接收到的数据。	
属性: 请求结果

	statusCode
	httpVersion
	headers
	trailers
	
函数

	response.setEncoding: 接受data事件，设置默认编码，数据以encoding编码
	response.pause(): 暂停接受数据和发送事件
	response.resume(): 暂停功能的恢复
	
##Express框架

http模块仅仅是一个HTTP服务器内核的封装。

Express的功能：

* 路由控制
* 模板解析支持
* 动态视图
* 用户会话
* CSRF保护
* 静态文件服务
* 错误控制器
* 访问日志
* 缓存
* 插件支持

###使用express安装

安装

	npm install -g express
	
express指定模块引擎，支持Jade和ejs	
	
建立工程

	express ejs hello
	
	产生目录：hello, hello/package.json, hello/app.js
	
	进入hello，执行npm install
	它自动安装依赖ejs和express，检查目录中的package.json文件内容
	
	无参数的npm install就是检查当前目录下的package.json并自动安装所有依赖
	
启动服务器

	node app.js
	或者supervisor app.js
	
工程结构

* app.js: 工程入口

		1. 引用模块
		2. ./routes/index.js，指定路径组织返回，相当于mvc中的控制器
		
		3. app.set是Express的参数设置工具，为KV
			port: 端口
			views: 视图文件的目录，存放模板文件。 __dirname + '/views'
			view engine: ejs， 视图引擎
			options: 全局视图参数对象
			cache： 视图缓存
			case sensitive routes: 
			strict routing:
			jsonp callback:
			
		4. Express依赖connect，短小精悍，偏向基础设施的框架，提供大量中间件	，可通过app.use启用。
			中间件：一些列的组件连接在一起，然后让http请求依次流过这些组件，这些被connect串联起来的组件称为中间件
			
			bodyParser: 解析客户端请求
			router： 项目路由支持
			static： 提供静态文件支持
			methodOverride：函数重写
			errorHandler：错误控制器
		
		5. app.get('/', routes.index), 路由控制器，路径'/'通过routes.index控制
		6. express.createServer创建一个应用实例
		
* routes文件夹

	index.js:
	
		exports.index = function(req, res){
			res.render('index', {title: 'abc'})
		};
		
		调用模板解析引擎index，并传入一个对象作为参数
		
		
	index.ejs模板文件
	
		它的基础语言是html语言， 其中更包含了<%=title%>标签，功能是显示的变量，即res.render函数的第二个参数
		
* views：视图文件目录，存放模板文件
* public：静态文件，js、css、html问及那
* nodes_modles: 包文件	

###路由控制



###模板引擎

从页面模板根据一定的规则生成html的工具。

* 启动模板引擎，告诉引擎模板的目录
* 调用模板引擎，接收两个参数

		res.render('index', {titile: 'abc'})
		
		参数1： 模板名字
		参数2： 模板的数据
		
	ejs的标签
	
		<% code %> js代码
		<%= code%> 显示替换过的html特殊字符内容
		<%- code%>	 显示原始html内容
	
####页面布局

layout.ejs是一个模板布局模板，它描述整个页面的框架结构，默认情况下每个单独的页面都继承自这个框架，替换掉`<%-body%>`部分，这个功能非常有用。

1. 一般为了保持整个网站的风格，头部和尾部内容都是一样的。因此可以把<head>放到layout.ejs，然后把body填充为自定义部分。

	如果想关闭
	
		app.set('view options'{
			layout:false
		})
		
2. 如果不止一种页面布局，可以在视图模板指定layout

		res.render('userlist', {
			title: 'userlist',
			layout: 'newlayout'
		})	
		
		
	jade的实现：
	
		在我们请求的目的页面中第一句话:extends 模板布局模板名			


	ejs实现（3.x）：
	
		//ß改造ejs引擎中的方法
		app.engine('ejs', engine);
		//将layout的模版布局模版设置为默认
		app.locals._layoutFile='layout'
		//片段视图
		app.get('/list',function(req,res){
			res.render('list',{
				title:'片段视图',
				items:['marico',1991,'pcat']
			})
		});
		//视图助手
		// 静态视图助手可以是任何类型的对象，包括接受任意参数的函数，但访问到的对象必须是用户请求无关的，而动态视图助手只能是一个函数，该函数没有参数，但是可以访问req和res两个对象
		
		app.locals({
			inspect:function(obj){
				return util.inspect(obj,true)+"    解析成功";
			}
		})	
		
		// 动态视图助手，只能是一个函数，可以访问res
			res.locals({
				headers:fucntion(req, res){
					return req.headers;
				}
			})
		
		app.get('/view',function(req,res){
			res.locals({
				headers:function(req,res){
					return req.headers;
				}
			})
			res.render('view',{title:"PCAT"});
		})		

##实例：微博

###创建项目

	express ejs blog
	cd blog
	npm install 加入包依赖

###路由规划	

	/
	/u/:user 用户主页
	/post 发表信息
	/reg 注册
	/doReg
	/login 用户登录
	/doLogin 
	/logout 退出
	
首先在app中加入路由规则，然后在index.js中写响应处理函数

###界面设计：views目录

可以利用优秀设计。简洁风格的Twitter bootstrap。

下载bootstrap，然后将js，css放到public目录的javascripts和stylesheets目录	，同时jquery

引用bootstrap：读取它的docs，学习使用方法。

####修改layout.ejs

引入css和js，加入网站的头和尾
			
####index.ejs

####login.ejs

####reg.ejs

###数据库

####安装mongodb

####创建blog的db

在安装目录创建data, log和data/db

指定数据库文件到data/db文件夹

	mongod -dpath ../data/db

操作数据库

	show dbs  查看所有库
	user blog 使用指定库
	show collections  查看所有文档
	db.表名.find()   查询指定文档的数据
	db.表名.insert({k:v})  插入数据 
	db.表名.find({name: 'admin'})

####blog项目加入mongodb

加入mongodb的依赖包：package.json依赖中加入，然后执行更新依赖包

	npm install
	
项目根目录创建settings.js, 用于配置数据库连接信息

在models文件夹创建db.js，创建数据库连接对象
	
	/**
	 *创建数据库连接
	 * 该模块只会被加载一次，一直使用相同的实例
	 */
	//引入连接配置的模块
	var settings=require("../settings");
	//得到db对象
	var Db=require("mongodb").Db;
	//得到连接对象
	var Connection=require("mongodb").Connection;
	//得到服务对象
	var Server=require("mongodb").Server;
	//创建连接对象并暴漏给你接口
	module.exports=new Db(settings.db,new Server(settings.host,Connection.DEFAULT_PORT,{}));
	
		
####会话支持

Express提供了会话中间件，默认情况下保存在内存中，可以将会话信息保存到mongodb中。这会用到mongodb的connect,connect-mongo两个模块

###业务逻辑实现

####创建User用户的model类

	function User(user) {
		this.name = user.name;
		this.password = user.password;
	}		
	

	/**
	 * 增加查询用户静态方法
	 * @param username 用户名
	 * @param callback
	 */		
	User.find= function(username,callback){ 
	 
	/**
	 *使用原型增加保存方法
	 * @param callback
	 */
	User.prototype.save=function save(callback){	 
	
####注册功能

index.js

	/**
	 * 登录操作
	 * @param req
	 * @param res
	 */
	exports.doLogin=function(req,res){
	    //将登录的密码转成md5形式
	    var md5=crypto.createHash("md5");
	    var password=md5.update(req.body.password).digest("base64");
	    //验证用户
	    User.find(req.body.username,function(err,user){
	        //首先根据用户名查询是否存在
	        if(!user){
	            req.session.error="用户不存在";
	            return res.redirect("/login");
	        }
	        //验证密码是否正确
	        if(user.password!=password){
	            req.session.error="用户密码错误";
	            return res.redirect("/login");
	        }
	        req.session.user=user;
	        req.session.success="登录成功";
	        res.redirect("/");
	    })
	}			
	
####中间件和权限控制

1. 加入中间件
	app.js
	返回成功和失败信息
	user设置成动态视图助手
	
2. 在layout.ejs模板布局中将权限动态显示			
####登录功能



####退出功能	


###微博信息

####创建微博类：models/post.js

####实现发表微博功能

####查询当前用户微博信息

####展示用户微博信息

####首页显示处理函数

		
	

	
	
	
		