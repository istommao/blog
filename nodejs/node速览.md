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
4. process.nextTick(callback)为事件循环设置任务。node会在下次事件循环响应是调用。node适合io密集型
	
	

	
	
	
	
		