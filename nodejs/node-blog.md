#node-blog


##环境

安装express依赖和生成器

	npm install express-generator -g

通过生成器新建工程
	
	express -e ejs blog

**p.s. 通过 Express 应用生长期创建应用只是众多方法中的一种。你可以不使用它，也可以修改它让它符合你的需求**

执行完后提示：
	
	install dependencies:
	  $ cd blog && npm install
	
	run the app:
	  $ DEBUG=blog:* npm start

依照提示执行依赖的安装：

	cd blog&npm install
	
	
执行：

	$ DEBUG=* npm start
	
	p.s: 如果想通过node app.js启动， 需要在app.js最后加上
	
		app.listen(3000)	
	
访问：

	localhost:3000	


##目录结构解析

	app.js
	routes: 路由
	----index.js: 路由及controller的实现
	public: 公共文件，
	----images
	----javascripts
	----stylesheets
	models: 自己创建的，模型类的js代码
	views: 视图，存放各种.ejs文件

##程序执行流向

	app.js 调用 app.use('/', routes); 
	==> routes/index.js 调用 
	==> res.render('index', { title: 'Express' });
	==> 使用ejs模板引擎 
	==> views/index.ejs



##路由控制

express 封装了多种 http 请求方式,我们主要只使用 get 和 post 两种。get 和 post 的第一个参数都为请求的路径,第二个参数为处理请求的回调函数,回调函数有两个参数分别是 req 和 res,代表请求信息和响 应信息 。路径请求及对应的获取路径有以下几种形式:	
##模板引擎

res.render() 渲染模版,并将其产生的页面直接返回给客户端。它接受两个参数,第一个是模板的名称,即 views 目录下的模板文件名,扩展名 .ejs 可选。第二个参数是传递给模板的数据,用于模板翻译。

ejs 的标签系统非常简单,它只有以下3种标签。
* <% code %>:JavaScript 代码。* <%= code %>:显示替换过 HTML 特殊字符的内容。 
* <%- code %>:显示原始 HTML 内容。**注意: <%=code%> 和 <%-code%> 的区别,当变量 code 为字符串时,两者没有区别。当 code 比如为 \<h1\>hello\</h1\> 时, <%= code %> 会原样输出 \<h1\>hello\</h1\> ,而 <%- code %> 则会输出 H1 大的 hello。**
##需求分析和设计方案

###功能分析
rest api

* 首页：/* 注册：/reg
* 发布：/login
* 登录：/post
* 登出：/logout###页面构成和设计

* 首页：index.ejs
* 登录：login.ejs
* 注册：reg.ejs

页面构成文件都放在views目录下###路由设计

由功能分析中，正好对应：

* 首页：/ GET* 注册：/reg POST
* 发布：/login GET POST
* 登录：/post GET POST
* 登出：/logout get
路由控制通过app.js的
	app.use('/', routes);
都指向routes目录的index.js，因此所有的路由逻辑都添加到index.js文件中，具体实现后文会进一步分析。	###数据库

使用mongodb，先安装数据库。并新建数据库blog。


##实现

### 路由实现

修改route/index.js文件，根据上一节的路由设计编写对应的路由函数，同时在views中添加对应的ejs文件。

	router.get('/', function(req, res, next) {
	    res.render('index', {
	        title: '首页',
	        user: ''
	    });
	});
	
上面的路由表示：
	
**GET方法访问主页`/`，render的第一个参数表示该页面对应的ejs文件，即路径/的页面是views/index.ejs，第二个参数表示index.ejs里可以使用title和user这两个对象**



###页面具体设计

上一步中把路由实现好了，下面通过bootstap和编写对应的ejs就可以进行页面的测试了。

**（这个时候可以测试路由实现是否正确，以及进行页面的初步设计）**

#### 样式

使用bootstrap

将bootstrap相关文件分别复制到public目录下对应的文件夹里

#### 页首和页尾

添加header.ejs和footer.ejs

#### 登录和注册页面

使用bootstrap的form表单结合


### 会话和mongodb

#### mongodb

使用 express-session 和 connect-mongo 模块实现了将会化信息存储到mongoldb中

#### 通知connect-flash
实现用户的注册和登陆，在这之前我们需要引入 flash 模块来实现页面通知（即成功与错误信息的显示）的功能。

我们所说的 flash 即 connect-flash 模块（https://github.com/jaredhanson/connect-flash），flash 是一个在 session 中用于存储信息的特定区域。信息写入 flash ，下一次显示完毕后即被清除。典型的应用是结合重定向的功能，确保信息是提供给下一个被渲染的页面。



express4.x的session和视图助手不内置，需要安装：

	session：
	npm install express-session --save
	视图助手：
	npm install express-partials --save
	会话通知：
	npm install connect-flash --save
	数据库：
	npm install --save kerberos mongodb
	连接数据库客户端：
	npm install connect-mongo@0.4.1 --save
	
	安装最新的connect-mongo会报错，不知道什么原因：
	
		const Promise = require('bluebird');
		^^^^^
		SyntaxError: Use of const in strict mode.
		    at exports.runInThisContext (vm.js:73:16)	


新建文件settings.js，存放数据库配置：

	module.exports = {
    	cookieSecret: 'blog',
    	db: 'blog',
    	host: 'localhost',
    	port: 27017
	};

新建models/db.js，建立数据库连接实例：

	var settings = require('../settings'),
	    Db = require('mongodb').Db,
	    Connection = require('mongodb').Connection,
	    Server = require('mongodb').Server;
	
	module.exports = new Db(settings.db, new Server(settings.host, settings.port), {safe: true});
	
	
在app.js添加

	var partials = require('express-partials');
	var session = require('express-session');
	var flash = require('connect-flash');	
	// 视图助手
	app.use(partials());

	// 使用 express-session 和 connect-mongo 模块实现了将会化信息存储到mongoldb中s
	app.use(flash());
	app.use(session({
	    secret: settings.cookieSecret,
	    key: settings.db,//cookie name
	    cookie: {maxAge: 1000 * 60 * 60 * 24 * 30},//30 days
	    store: new MongoStore({
	        db: settings.db,
	        host: settings.host,
	        port: settings.port
	    })
	}));

### login.ejs和reg.ejs增加form表单设计

### 发言表单say.ejs

借助视图助手实现

### 文章显示视图posts.ejs

借助视图助手实现

### 用户个人页面/u/:user

借助视图助手实现

### models--user

在 `models` 文件夹下新建 `User.js`，里面实现数据库的查询和插入，用于保存用户的账号和密码

#### users集合

数据库`blog`下的`users`集合用于存放注册用户的信息，包含字段：

	name
	password

### models--posts

在 `models` 文件夹新建 `Post.js`, 里面实现数据库的查询和插入，用于保存用户的文章

#### posts集合

数据库`blog`下的`posts`集合用于存放注册用户的信息，包含字段：

	user
	post
	time


## 总结

* 首先，需求分析，得出具体包含的页面和rest api接口
* 然后，完成每个页面的设计（MVC的`V`），结合express可以很好的查看到效果，这个过程不需要实现具体的页面逻辑和真实数据的展示
* 接着，根据业务逻辑，实现MVC的`C`和`M`，控制器主要在routes/index.js实现，模型通过在models目录下新建对应的js文件，完成单测。
* 最后，整体测试，调整。

## 实现

<https://github.com/zhuwei05/node-blog>

## 参考

<https://github.com/nswbmw/N-blog/>






	
	
	
	
	
			
