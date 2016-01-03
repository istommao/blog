#express_mongodb_bootstrap_to_build_blog


##环境

安装express依赖和生成器

	npm install express --save
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

##程序执行流向

	app.js 调用 app.use('/', routes); ==> routes/index.js 调用 res.render('index', { title: 'Express' });使用ejs模板引擎 ==> views/index.ejs


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

添加数据库依赖

	npm install mongodb --save

添加数据库配置文件settings.js


#### 数据库实例
新建文件夹models, 并创建db.js，用于创建数据库连接实例

#### 使用数据库




##实现

### 会话和mongodb

使用 express-session 和 connect-mongo 模块实现了将会化信息存储到mongoldb中

### 实现通知
实现用户的注册和登陆，在这之前我们需要引入 flash 模块来实现页面通知（即成功与错误信息的显示）的功能。

我们所说的 flash 即 connect-flash 模块（https://github.com/jaredhanson/connect-flash），flash 是一个在 session 中用于存储信息的特定区域。信息写入 flash ，下一次显示完毕后即被清除。典型的应用是结合重定向的功能，确保信息是提供给下一个被渲染的页面。

###页面具体设计

#### 样式

使用bootstrap

将bootstrap相关文件分别复制到public目录下对应的文件夹里

#### 页首和页尾

添加header.ejs和footer.ejs

#### 登录和注册页面

使用bootstrap的form表单结合

### models--user

在 models 文件夹下新建 User.js，里面实现数据库的查询和插入，用于保存用户的账号和密码

### models--posts

在 models 文件夹新建 Post.js, 里面实现数据库的查询和插入，用于保存用户的文章




## 参考

<https://github.com/nswbmw/N-blog/>






	
	
	
	
	
			
