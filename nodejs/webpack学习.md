title: Webpack学习
date: 2016-03-08 22:58
tags:
- Webpack

-----

# Webpack学习

## 简介

> 一个打包工具，而不是像RequireJS或SeaJS这样的模块加载器，通过使用Webpack，能够像Node.js一样处理依赖关系，然后解析出模块之间的依赖，将代码打包

## 使用

### 初始化项目

	mkdir react-webpack 
	cd react-webpack
	npm init

### 安装依赖包
	
	npm install --save-dev url-loader jsx-loader style-loader css-loader babel-loader babel-core
	
	npm install --save-dev react-hot-loader webpack-dev-server
	
	npm install --save-dev babel-preset-react
	
	npm install --save-dev babel-preset-es2015
	
	npm install --save-dev react react-router react-dom
	
	
### 编写配置文件 

webpack.config.js
	
	var webpack = require('webpack');
	
	module.exports = {
	    // 程序的入口文件
	    entry: [
	      'webpack/hot/only-dev-server',
	      "./js/app.js"
	    ],
	    // 所有打包好的资源的存放位置
	    output: {
	        path: './build',
	        // 生成的打包文件名
	        filename: "bundle.js"
	    },
	    module: {
	        loaders: [
	            // test: 用于匹配加载器支持的文件格式的正则表达式
	            // loader: 要使用的加载器类型
	            // 加载器支持通过查询字符串的方式接收参数, 如：'jsx-loader?xxx'
	            // 多个加载器通过“!”连接
	            { test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader'},
	            { test: /\.css$/, loader: "style!css" },
	            {test: /\.less/,loader: 'style-loader!css-loader!less-loader'},
	            {
	              test: /\.js$/,
	              exclude: /node_modules/,
	              loader: "babel-loader",
	              query:
	                {
	                  presets:['react','es2015']
	                }
	            }
	        ]
	    },
	    // resolve 指定可以被 import 的文件后缀。比如 Hello.jsx 这样的文件就可以直接用 import Hello from 'Hello' 引用。
	    resolve:{
	        extensions:['','.js','.json']
	    },
	
	    devServer: {
	        hot: true,
	        inline: true
	    },
	    plugins: [
	      new webpack.NoErrorsPlugin(),
	      new webpack.HotModuleReplacementPlugin()
	    ]
	};

	
### 常见命令

* 在开发环境构建一次: `webpack`  
* 构建并生成源代码映射文件: `webpack -d`
* 在生成环境构建，压缩、混淆代码，并移除无用代码: `webpack -p`  
* 快速增量构建，可以和其他选项一起使用: `webpack --watch` 
* 监听编译: webpack -d --watch	


#### 修改package.json文件

	...
	"scripts": {
    "start": "webpack-dev-server --hot --progress --colors",
    "build": "webpack --progress --colors"
    },
	...	

	
### 目录结构
	
	react-webpack
	├── index.html
	├── js
	│   ├── app.js
	│   └── hello.js
	├── node_modules
	├── package.json
	└── webpack.config.js	
	
#### app.js

	import React from 'react';
	import ReactDOM from 'react-dom';
	import { render } from 'react-dom';
	import { Router, Link, Route ,browserHistory} from 'react-router';
	
	import HelloHandler from './hello.js';
	
	let App = React.createClass({
	  render() {
	    return (
	      <div className="nav">
	        <Link to="/hello" className="hellolink">Say Hello</Link>
	        {this.props.children}
	      </div>
	    );
	  }
	});
	
	
	render(
	  (<Router history={browserHistory}>
	    <Route path="/" component={App}>
	      <Route path="/hello" component={HelloHandler} />
	    </Route>
	  </Router>), document.getElementById('content'));
	  	
#### hello.js

	import React from 'react';
	
	let Hello = React.createClass({
	
	  render() {
	    return(<div>Hello World!</div>);
	  }
	});
	
	export default Hello;
	
### 打包

	npm start
	
访问：

	http://localhost:8080/webpack-dev-server/		
	

### 示例

[react-webpack](https://github.com/zhuwei05/react-demo)


## 参考
* [Webpack+React+ES6](http://www.cnblogs.com/skylar/p/React-Webpack-ES6.html)
* [轻松入门React和Webpack](https://github.com/tmallfe/tmallfe.github.io/issues/23)
* [Webpack 与React](http://book.51cto.com/art/201505/476449.htm)
* [The React Way: Getting Started](https://github.com/RisingStack/react-way-getting-started)
	
	