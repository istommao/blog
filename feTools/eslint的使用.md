title: ESLint的使用
date: 2016-04-07 23:28:22
tags:
- js
- eslint
- jslint


# ESLint的使用

## ESLint（Airbnb）

`ESLint`是一个语法规则和代码风格的检查工具，可以用来保证写出语法正确、风格统一的代码。

首先，安装ESLint

	$ npm i -g eslint

然后，安装Airbnb语法规则。

	$ npm i -g eslint-config-airbnb

最后，在项目的根目录下新建一个`.eslintrc`文件，配置`ESLint`。

	{
	  "extends": "eslint-config-airbnb"
	}

现在就可以检查，当前项目的代码是否符合预设的规则。

	$ eslint index.js
	
## ESLint 使用入门

	

## 参考

* [ECMAScript 6入门--编程风格](http://es6.ruanyifeng.com/#docs/style)
* [ESLint 使用入门](http://www.jianshu.com/p/c599185a0d84)