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

首先，安装ESLint。

	$ npm i -g eslint

其次，在项目根目录下面新建一个`.eslintrc`文件，里面定义了你的语法规则。

	{
	  "rules": {
	    "indent": 2,
	    "no-unused-vars": 2,
	    "no-alert": 1
	  },
	  "env": {
	    "browser": true
	  }
	}

上面的`.eslintrc`文件是JSON格式，里面首先定义，这些规则只适用于浏览器环境。如果要定义，同时适用于浏览器环境和Node环境，可以写成下面这样。

	{
	  "env": {
	    "browser": true,
	    "node": true
	  }
	}

然后，上面的`.eslintrc`文件定义了三条语法规则。每个语法规则后面，表示这个规则的级别。

* 0：关闭该条规则。
* 1：违反这条规则，会抛出一个警告。
* 2：违反这条规则，会抛出一个错误。

### 预置规则

自己设置所有语法规则，是非常麻烦的。所以，ESLint提供了预设的语法样式，比较常用的Airbnb的语法规则。由于这个规则集涉及ES6，所以还需要安装Babel插件。

	$ npm i -g babel-eslint eslint-config-airbnb
安装完成后，在.eslintrc文件中注明，使用Airbnb语法规则。

	{
	  "extends": "eslint-config-airbnb"
	}

你也可以用自己的规则，覆盖预设的语法规则。

	{
	  "extends": "eslint-config-airbnb",
	  "rules": {
	    "no-var": 0,
	    "no-alert": 0
	  }
	}

### 语法规则

* indent: 设定行首的缩进，默认是四个空格。
* no-unused-vars: 不允许声明了变量，却不使用
* no-alert: 不得使用alert、confirm和prompt	

## 参考

* [ECMAScript 6入门--编程风格](http://es6.ruanyifeng.com/#docs/style)
* [Lint工具](http://javascript.ruanyifeng.com/tool/lint.html)
* [ESLint 使用入门](http://www.jianshu.com/p/c599185a0d84)