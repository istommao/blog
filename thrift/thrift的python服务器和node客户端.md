# thrift的python服务器和node客户端

分别使用python作为服务器和node作为客户端是，测试thrift自带的示例tutorial.thrift的操作步骤。

## 安装thrift
首先安装源码thrift，然后生成对应的gen-py和gen-node
	
	thrift -r --gen py tutorial.thrift   
	thrift -r --gen js:node tutorial.thrift    
	
## 创建server和client

首先创建示例目录

	mkdir demo
	cd demo

### 创建python server

使用python server比较简单，没什么复杂的。

* 新建demo/py;
* 拷贝gen-py目录到demo/py下；
* 拷贝tutorial/py/PythonServer.py到demo/py下；
* 拷贝lib/py/build目录到demo/py下
* 目录结构
		
		└── py
		    ├── PythonServer.py
		    ├── build
		    └── gen-py

* 修改PythonServer.py的路径导入为：

		sys.path.insert(0, glob.glob('./build/lib.*')[0])
	
* 运行PythonServer.py

		python PythonServer.py
		
### 创建node客户端

使用node作客户端比较复杂，要搭建nodejs环境、安装express、thrift、node-int64、ws、q等对应模块。

* 新建demo/node;
* 拷贝gen-nodejs目录到demo/node下；
* 拷贝tutorial/nodejs/NodeClient.js到demo/node下；
* 拷贝lib/nodejs/lib/build目录到demo/node下;
* 目录结构：

		├── node
		│   ├── NodeClient.js
		│   ├── gen-nodejs
		│   ├── node_modules
		│   ├── package.json
		│   └── thrift

* 配置node环境

	* cd demo/node
	* 使用`npm init`初始化package.json, 在指定入口的时候，将index.js修改为NodeClient.js
	* 安装express: `npm install express --save`
	
* 修改NodeClient.js开头的require为：

		var thrift = require('./thrift');
		var ThriftTransports = require('./thrift/transport');
		var ThriftProtocols = require('./thrift/protocol');
		var Calculator = require('./gen-nodejs/Calculator');
		var ttypes = require('./gen-nodejs/tutorial_types');	

* 启动NodeClient.js

		node 	NodeClient.js
	
	这是会报错，找不到thrift等。
	
* 	根据启动报错，安装对应模块，反正提示缺少什么就安装什么，大概需要安装的有：

		npm install thrift --save
		npm install node-int64 --save
		npm install ws --save
		npm install q --save
		
	p.s 	
		
* 成功启动NodeClient.js

		node 	NodeClient.js

## 源码

<https://github.com/zhuwei05/thrift/tree/master/tutorial>
		
