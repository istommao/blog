title: ES6学习
date: 2016-04-02 12:05:05
tags:
- es6
- js

# ES6学习

最近想学习ES6，读[ECMAScript 6入门](http://es6.ruanyifeng.com/)，并做笔记。

## 1. 简介

### Babel转码器

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

## 2. let和const命令

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

ES5只有全局作用域和函数作用域，没有块级作用域，这带来很多不合理的场景。

* 内层变量可能会覆盖外层变量。
* 用来计数的循环变量泄露为全局变量。

ES6块级作用域：

* 允许任意嵌套。
* 外层作用域无法读取内层作用域的变量。

* 块级作用域的出现，实际上使得获得广泛应用的立即执行匿名函数（IIFE）不再必要了。

		// IIFE写法
		(function () {
		  var tmp = ...;
		  ...
		}());
		
		// 块级作用域写法
		{
		  let tmp = ...;
		  ...
		}
	
* ES6也规定，函数本身的作用域，在其所在的块级作用域之内

	ES5的严格模式规定，函数只能在顶层作用域和函数内声明，其他情况（比如if代码块、循环代码块）的声明都会报错。
	
	ES6由于引入了块级作用域，这种情况可以理解成函数在块级作用域内声明，因此不报错，但是构成区块的大括号不能少，否则还是会报错。
	
### const

`const`也用来声明变量，但是声明的是常量。一旦声明，常量的值就不能改变。

* 常规模式，对常量赋值不会报错，但也是无效的。strict模式报错
* const声明的变量不得改变值，这意味着，const一旦声明变量，就必须立即初始化，不能留到以后赋值。
* const的作用域与let命令相同：只在声明所在的块级作用域内有效。
* const命令声明的常量也是不提升，同样存在暂时性死区，只能在声明的位置后面使用。
* const声明的常量，也与`let`一样不可重复声明
* 对于复合类型的变量，变量名不指向数据，而是指向数据所在的地址。const命令只是保证变量名指向的地址不变，并不保证该地址的数据不变，所以将一个对象声明为常量必须非常小心。如果真的想将对象冻结，应该使用`Object.freeze`方法

		const foo = Object.freeze({});

		// 常规模式时，下面一行不起作用；
		// 严格模式时，该行会报错
		foo.prop = 123;

	除了将对象本身冻结，对象的属性也应该冻结。下面是一个将对象彻底冻结的函数
	
		var constantize = (obj) => {
		  Object.freeze(obj);
		  Object.keys(obj).forEach( (key, value) => {
		    if ( typeof obj[key] === 'object' ) {
		      constantize( obj[key] );
		    }
		  });
		};	
		
> ES5只有两种声明变量的方法：var命令和function命令。ES6除了添加let和const命令，后面章节还会提到，另外两种声明变量的方法：import命令和class命令。所以，ES6一共有6种声明变量的方法。

### 跨模块常量

const声明的常量只在当前代码块有效。如果想设置跨模块的常量，可以采用下面的写法

	// constants.js 模块
	export const A = 1;
	export const B = 3;
	
	// test1.js 模块
	import * as constants from './constants';
	console.log(constants.A); // 1
	console.log(constants.B); // 3
	
	// test2.js 模块
	import {A, B} from './constants';
	console.log(A); // 1
	console.log(B); // 3	
	
### 全局对象的属性

全局对象是最顶层的对象，在浏览器环境指的是`window`对象，在Node.js指的是`global`对象。ES5之中，全局对象的属性与全局变量是等价的。

这种规定被视为JavaScript语言的一大问题，因为很容易不知不觉就创建了全局变量。ES6为了改变这一点，一方面规定，`var`命令和`function`命令声明的全局变量，依旧是全局对象的属性；另一方面规定，`let`命令、`const`命令、`class`命令声明的全局变量，不属于全局对象的属性。	

## 3. 变量的解构赋值

### 数组的解构赋值

	var [a, b, c] = [1, 2, 3];
	
本质上，这种写法属于`模式匹配`，只要等号两边的模式相同，左边的变量就会被赋予对应的值。	

	let [foo, [[bar], baz]] = [1, [[2], 3]];
	foo // 1
	bar // 2
	baz // 3
	
	let [ , , third] = ["foo", "bar", "baz"];
	third // "baz"
	
	let [x, , y] = [1, 2, 3];
	x // 1
	y // 3
	
	let [head, ...tail] = [1, 2, 3, 4];
	head // 1
	tail // [2, 3, 4]
	
	let [x, y, ...z] = ['a'];
	x // "a"
	y // undefined
	z // []

* 如果解构不成功，变量的值就等于`undefined`。
* 不完全解构，即等号左边的模式，只匹配一部分的等号右边的数组
* 解构赋值不仅适用于`var`命令，也适用于`let`和`const`命令
* 对于Set结构，也可以使用数组的解构赋值

		let [x, y, z] = new Set(["a", "b", "c"])

* 事实上，只要某种数据结构具有Iterator接口，都可以采用数组形式的解构赋值。
* 默认值: 

	解构赋值允许指定默认值(ES6内部使用严格相等运算符`===`，判断一个位置是否有值。所以，如果一个数组成员不严格等于`undefined`，默认值是不会生效的)

	默认值是一个表达式，那么这个表达式是惰性求值的，即只有在用到的时候

		[x, y = 'b'] = ['a'] // x='a', y='b'
		[x, y = 'b'] = ['a', undefined] // x='a', y='b'
		var [x = 1] = [null]; x // null

### 对象的解构赋值

解构不仅可以用于数组，还可以用于对象。对象的解构与数组有一个重要的不同。数组的元素是按次序排列的，变量的取值由它的位置决定；而对象的属性没有次序，变量必须与属性同名，才能取到正确的值

	var { foo, bar } = { foo: "aaa", bar: "bbb" };
	foo // "aaa"
	bar // "bbb"
	
对象的解构赋值:对象的解构赋值的内部机制，是先找到同名属性，然后再赋给对应的变量。真正被赋值的是后者，而不是前者(参见《对象的扩展》一章）

	var { foo: foo, bar: bar } = { foo: "aaa", bar: "bbb" };
	
* 对象的解构也可以指定默认值
* 对象的解构也可以指定默认值
* 解构模式是嵌套的对象，而且子对象所在的父属性不存在，那么将会报错

		// 报错
		var {foo: {bar}} = {baz: 'baz'}

* 要将一个已经声明的变量用于解构赋值，必须非常小心
* 对象的解构赋值，可以很方便地将现有对象的方法，赋值到某个变量

		let { log, sin, cos } = Math;
		//将Math对象的对数、正弦、余弦三个方法，赋值到对应的变量上，使用起来就会方便很多。
		
### 字符串的解构赋值

字符串也可以解构赋值。这是因为此时，字符串被转换成了一个类似数组的对象

	const [a, b, c, d, e] = 'hello';
	a // "h"
	b // "e"
	c // "l"
	d // "l"
	e // "o"

类似数组的对象都有一个length属性，因此还可以对这个属性解构赋值。

	let {length : len} = 'hello';
	len // 5		

### 数值和布尔值的解构赋值

解构赋值时，如果等号右边是数值和布尔值，则会先转为对象

	let {toString: s} = 123;
	s === Number.prototype.toString // true
	
	let {toString: s} = true;
	s === Boolean.prototype.toString // true

上面代码中，数值和布尔值的包装对象都有`toString`属性，因此变量s都能取到值。

> 解构赋值的规则是，只要等号右边的值不是对象，就先将其转为对象。由于`undefined`和`null`无法转为对象，所以对它们进行解构赋值，都会报错。

	let { prop: x } = undefined; // TypeError
	let { prop: y } = null; // TypeError

### 函数参数的解构赋值 

函数的参数也可以使用解构赋值。

	[[1, 2], [3, 4]].map(([a, b]) => a + b)
	
函数参数的解构也可以使用默认值:

	function move({x = 0, y = 0} = {}) {
	  return [x, y];
	}
	
	move({x: 3, y: 8}); // [3, 8]
	move({x: 3}); // [3, 0]
	move({}); // [0, 0]
	move(); // [0, 0]	
	
上面代码中，函数`move`的参数是一个对象，通过对这个对象进行解构，得到变量x和y的值。如果解构失败，x和y等于默认值。
	
注意，下面的写法会得到不一样的结果。

	function move({x, y} = { x: 0, y: 0 }) {
	  return [x, y];
	}
	
	move({x: 3, y: 8}); // [3, 8]
	move({x: 3}); // [3, undefined]
	move({}); // [undefined, undefined]
	move(); // [0, 0]
	
上面代码是为函数`move`的**参数**指定默认值，而不是为变量x和y指定默认值，所以会得到与前一种写法不同的结果。

### 圆括号问题

解构赋值虽然很方便，但是解析起来并不容易。对于编译器来说，一个式子到底是模式，还是表达式，没有办法从一开始就知道，必须解析到（或解析不到）等号才能知道。

由此带来的问题是，如果模式中出现圆括号怎么处理。ES6的规则是，只要有可能导致解构的歧义，就不得使用圆括号。

但是，这条规则实际上不那么容易辨别，处理起来相当麻烦。因此，建议只要有可能，就不要在模式中放置圆括号。

不能使用圆括号的情况:

* 变量声明语句中，不能带有圆括号
* 函数参数中，模式不能带有圆括号
* 赋值语句中，不能将整个模式，或嵌套模式中的一层，放在圆括号之中

可以使用圆括号的情况:

可以使用圆括号的情况只有一种：赋值语句的非模式部分，可以使用圆括号

### 用途

变量的解构赋值用途很多。

* 交换变量的值
* 从函数返回多个值: 函数只能返回一个值，如果要返回多个值，只能将它们放在数组或对象里返回。有了解构赋值，取出这些值就非常方便
* 函数参数的定义: 方便地将一组参数与变量名对应起来(命名参数)
* 提取JSON数据

		var jsonData = {
		  id: 42,
		  status: "OK",
		  data: [867, 5309]
		}
		
		let { id, status, data: number } = jsonData;
		
		console.log(id, status, number)
		// 42, "OK", [867, 5309]
		
* 函数参数的默认值
* 遍历Map结构

	任何部署了`Iterator`接口的对象，都可以用`for...of`循环遍历。Map结构原生支持`Iterator`接口，配合变量的解构赋值，获取键名和键值就非常方便
	
		var map = new Map();
		map.set('first', 'hello');
		map.set('second', 'world');
		
		for (let [key, value] of map) {
		  console.log(key + " is " + value);
		}
		// first is hello
		// second is world
		
		// 获取键名
		for (let [key] of map) {
		  // ...
		}
		
		// 获取键值
		for (let [,value] of map) {
		  // ...
		}	

* 输入模块的指定方法

	加载模块时，往往需要指定输入那些方法。解构赋值使得输入语句非常清晰
	
		const { SourceMapConsumer, SourceNode } = require("source-map");
		
## 4. 字符串的扩展

### 字符的Unicode表示法

### 字符串的遍历器接口

ES6为字符串添加了`遍历器接口`（详见《Iterator》一章），使得字符串可以被`for...of`循环遍历。除了遍历字符串，这个遍历器最大的优点是可以识别大于`0xFFFF`的码点，传统的for循环无法识别这样的码点。

### 模板字符串

模板字符串（template string）是增强版的字符串，用`反引号`标识。它可以当作普通字符串使用，也可以用来定义多行字符串，或者在字符串中嵌入变量.

* 如果在模板字符串中需要使用反引号，则前面要用反斜杠转义
* 如果使用模板字符串表示多行字符串，所有的空格和缩进都会被保留在输出之中
* 模板字符串中嵌入变量，需要将变量名写在`${}`之中, 大括号内部可以放入任意的JavaScript表达式，可以进行运算，以及引用对象属性，调用函数。如果大括号中的值不是字符串，将按照一般的规则转为字符串
* 如果模板字符串中的变量没有声明，将报错
* 如果需要引用模板字符串本身：

		// 写法一
		let str = 'return ' + '`Hello ${name}!`';
		let func = new Function('name', str);
		func('Jack') // "Hello Jack!"
		
		// 写法二
		let str = '(name) => `Hello ${name}!`';
		let func = eval.call(null, str);
		func('Jack') // "Hello Jack!"

### 标签模板

标签模板其实不是模板，而是函数调用的一种特殊形式。“标签”指的就是函数，紧跟在后面的模板字符串就是它的参数。


			
		




		

		
	
	



	





## 参考

* [ECMAScript 6入门](http://es6.ruanyifeng.com/)