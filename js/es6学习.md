title: ES6学习
date: 2016-04-02 12:05:05
tags:
- es6
- js

# ES6学习

最近想学习ES6，读[ECMAScript 6入门](http://es6.ruanyifeng.com/)，并做笔记。

## Babel转码器

[Babel](https://babeljs.io/)是一个广泛使用的ES6转码器，可以将ES6代码转为ES5代码，从而在现有环境执行。这意味着，你可以用ES6的方式编写程序，又不用担心现有环境是否支持。

### 配置文件.babelrc

Babel的配置文件是.babelrc，存放在项目的根目录下。使用Babel的第一步，就是配置这个文件。

该文件用来设置转码规则和插件，基本格式如下。

	{
	  "presets": [],
	  "plugins": []
	}

presets字段设定转码规则，官方提供以下的规则集，你可以根据需要安装。

	# ES2015转码规则
	$ npm install --save-dev babel-preset-es2015
	
	# react转码规则
	$ npm install --save-dev babel-preset-react
	
	# ES7不同阶段语法提案的转码规则（共有4个阶段），选装一个
	$ npm install --save-dev babel-preset-stage-0
	$ npm install --save-dev babel-preset-stage-1
	$ npm install --save-dev babel-preset-stage-2
	$ npm install --save-dev babel-preset-stage-3

然后，将这些规则加入.babelrc。

	{
	  "presets": [
	    "es2015",
	    "react",
	    "stage-2"
	  ],
	  "plugins": []
	}
	
一般来说，Babel工具和模块的使用，都必须先写好.babelrc	
* babel-cli： `npm install -D babel-cli`
* babel-node： 随babel-cli一起安装
* babel-register：改写`require`命令，为它加上一个钩子。此后，每当使用require加载`.js`、`.jsx`、`.es`和`.es6`后缀名的文件，就会先用`Babel`进行转码。
* babel-core：如果某些代码需要调用Babel的API进行转码，就要使用babel-core模块。`npm install babel-core --save`
* babel-polyfill ：` npm install --save babel-polyfill`


### 与其他工具的配合

许多工具需要Babel进行前置转码，如：ESLint和Mocha。 

`ESLint`用于静态检查代码的语法和风格：

	npm install --save-dev eslint babel-eslint
	
在项目根目录下，新建一个配置文件`.eslintrc`，在其中加入parser字段：

	{
	  "parser": "babel-eslint",
	  "rules": {
	    ...
	  }
	}		

再在`package.json`之中，加入相应的`scripts`脚本：

	{
	    "name": "my-module",
	    "scripts": {
	      "lint": "eslint my-files.js"
	    },
	    "devDependencies": {
	      "babel-eslint": "...",
	      "eslint": "..."
	    }
	  }

`Mocha`则是一个测试框架，如果需要执行使用ES6语法的测试脚本，可以修改`package.json`的`scripts.test`：

	"scripts": {
	  "test": "mocha --ui qunit --compilers js:babel-core/register"
	}
	
上面命令中，`--compilers`参数指定脚本的转码器，规定后缀名为`js`的文件，都需要使用`babel-core/register`先转码。

## let和const命令

### let

ES6新增了`let`命令，用来`声明变量`。它的用法类似于`var`，但是所声明的变量，只在`let`命令*所在的代码块内有效*	

* 不存在变量提升

	`let`不像`var`那样会发生*“变量提升”*现象。所以，变量一定要在声明后使用，否则报错。

* 暂时性死区

	只要块级作用域内存在`let`命令，它所声明的变量就“绑定”（binding）这个区域，不再受外部的影响。
	
	ES6明确规定，如果区块中存在`let`和`const`命令，这个区块对这些命令声明的变量，从一开始就形成了封闭作用域。凡是在声明之前就使用这些变量，就会报错。

	总之，*在代码块内，使用let命令声明变量之前，该变量都是不可用的。这在语法上，称为“暂时性死区”（temporal dead zone，简称TDZ）*。

	“暂时性死区”也意味着`typeof`不再是一个百分之百安全的操作。

* 不允许重复声明

	let不允许在相同作用域内，重复声明同一个变量
	
### 块级作用域

ES5只有全局作用域和函数作用域，没有块级作用域	





## 参考

* [ECMAScript 6入门](http://es6.ruanyifeng.com/)