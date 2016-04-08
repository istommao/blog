title: js学习(1)
date: 2016-04-05 12:05:05
tags:
- js

# js学习(1)
---
没有系统学习过js，觉得基础太薄弱了，参考阮一峰老师的[JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)，希望可以提高自己js的基础。

# 2. 基本语法

## 基本句法和变量

### 语句

**语句（statement）**是为了完成某种任务而进行的操作

	var a = 1 + 3;

**表达式（expression）**为了得到返回值的计算式。

	1 + 3

> 语句和表达式的区别在于，前者主要为了进行某种操作，一般情况下不需要返回值；后者则是为了得到返回值，一定会返回一个值。

* 语句以分号结尾，一个分号就表示一个语句结束。多个语句可以写在一行内。
* 表达式不需要分号结尾。一旦在表达式后面添加分号，则JavaScript引擎就将表达式视为语句，这样会产生一些没有任何意义的语句。

### 变量

	var a;
	a = 1;
	var a = 1;

* 变量是对“值”的引用，使用变量等同于引用一个值。
* 变量的声明和赋值，是分开的两个步骤。但是可以合起来一起写。
* 只是声明变量而没有赋值，则该变量的值是不存在的，JavaScript使用`undefined`表示这种情况。
* 没有声明就直接使用，JavaScript会报错，告诉你变量未定义

#### 变量提升

JavaScript引擎的工作方式是，先解析代码，获取所有被声明的变量，然后再一行一行地运行。这造成的结果，就是所有的变量的声明语句，都会被提升到代码的头部，这就叫做**变量提升（hoisting）**

	console.log(a); // undefined
	var a = 1;
	
	==>
	
	var a;
	console.log(a);  // undefined
	a = 1;

变量提升只对var命令声明的变量有效，如果一个变量不是用var命令声明的，就不会发生变量提升。

### 标识符

* 第一个字符，可以是任意Unicode字母，以及美元符号（$）和下划线（_）。
* 第二个字符及后面的字符，除了Unicode字母、美元符号和下划线，还可以用数字0-9。
* JavaScript有一些保留字，不能用作标识符
* 不应该用作标识符：`Infinity`、`NaN`、`undefined`

### 注释

* 单行注释，用`//`起头；另一种是多行注释，放在`/*` 和 `*/`之间
* JavaScript兼容HTML代码的注释,`<!--`和`-->`也被视为单行注释（`-->`只有在行首，才会被当成单行注释，否则就是一个运算符）

### 区块

使用`大括号`，将多个相关的语句组合在一起，称为“*区块*”（block）

区块中的变量与区块外的变量，属于同一个作用域（ES6增加了[区块作用域](https://github.com/zhuwei05/blog/blob/master/js/es6%E5%AD%A6%E4%B9%A0\(1\).md#块级作用域)）

## 条件语句

### if 结构

	if (m === 3) {
	  m += 1;	
	}	

	if (m === 0) {
	  // ...
	} else if (m === 1) {
	  // ...
	} else if (m === 2) {
	  // ...
	} else {
	  // ...
	}

### switch结构

	switch (fruit) {
	  case "banana":
	    // ...
	    break;
	  case "apple":
	    // ...
	    break;
	  default:
	    // ...
	}
	
* `switch`语句部分和`case`语句部分，都可以使用`表达式`
* 每个`case`代码块内部的`break`语句不能少，否则会接下去执行下一个`case`代码块，而不是跳出`switch`结构
* `switch`语句后面的表达式与`case`语句后面的表示式，在比较运行结果时，采用的是严格相等运算符（`===`），而不是相等运算符（`==`），这意味着比较时不会发生类型转换
* `switch`结构不利于代码重用，往往可以用`对象形式`重写

## 循环语句

### while循环

	while (expression) {
	  statement
	}

### for循环
	
	for(initialize; test; increment) {
	  statement
	}	

* `for`语句后面的括号里面，有三个`表达式`
* `for`语句的三个部分（`initialize`，`test`，`increment`），可以省略任何一个，也可以全部省略

### do…while循环

`do...while`循环与`while`循环类似，唯一的区别就是先运行一次循环体，然后判断循环条件

	do {
	  statement
	} while(expression);

### break语句和continue语句

`break`语句和`continue`语句都具有跳转作用，可以让代码不按既有的顺序执行

### 标签（label）

	label:
	  statement

* 标签可以是任意的标识符，但是不能是保留字，语句部分可以是任意语句
* 标签通常与`break`语句和`continue`语句配合使用，跳出特定的循环

## 数据类型

* 数值（number）：整数和小数（比如1和3.14）
* 字符串（string）：字符组成的文本（比如”Hello World”）
* 布尔值（boolean）：true（真）和false（假）两个特定值
* undefined：表示“未定义”或不存在，即此处目前没有任何值
* null：表示空缺，即此处应该有一个值，但目前为空
* 对象（object）：各种值组成的集合
* Symbol类型(ES6)

> 数值、字符串、布尔值称为`原始类型（primitive type）`的值，即它们是最基本的数据类型，不能再细分了。而将对象称为`合成类型（complex type）`的值，因为一个对象往往是多个原始类型的值的合成，可以看作是一个存放各种值的容器。至于`undefined`s和`null`，一般将它们看成两个特殊值

对象又可以分成三个子类型:

* 狭义的对象（object）
* 数组（array）
* 函数（function）

### typeof运算符

JavaScript有三种方法，可以确定一个值到底是什么类型:

* `typeof`运算符
* `instanceof`运算符
* `Object.prototype.toString`方法

`typeof`运算符可以返回一个值的数据类型:

* 原始类型: 数值、字符串、布尔值分别返回`number`、`string`、`boolean`
	
		typeof 123 // "number"
* 函数: 返回`function`
* `undefined`: 返回`undefined`。利用这一点，typeof可以用来检查一个没有声明的变量，而不报错
* 其他：都返回`object`

		typeof window // "object"
		typeof {} // "object"
		typeof [] // "object"
		typeof null // "object"

	null的类型也是object，这是由于历史原因造成的
	
	`typeof`对数组（`array`）和对象（`object`）的显示结果都是`object`。`instanceof`运算符可以区分：
		
		var o = {};
		var a = [];
	
		o instanceof Array // false
		a instanceof Array // true

## null和undefined

`null`与`undefined`都可以表示“没有”，含义非常相似。将一个变量赋值为undefined或null，老实说，语法效果几乎没区别。

	var a = undefined;
	// 或者
	var a = null;

### 用法和含义

`null`表示空值，即该处的值现在为空。典型用法是：

* 作为函数的参数，表示该函数的参数是一个没有任何内容的对象
* 作为对象原型链的终点

`undefined`表示不存在值，就是此处目前不存在任何值。典型用法是：

* 变量被声明了，但没有赋值时，就等于undefined。
* 调用函数时，应该提供的参数没有提供，该参数等于undefined。
* 对象没有赋值的属性，该属性的值为undefined。
* 函数没有返回值时，默认返回undefined。

## 布尔值

“真”用关键字`true`表示，“假”用关键字`false`表示

返回布尔值的运算符

* 两元逻辑运算符： && (And)，|| (Or)
* 前置逻辑运算符： ! (Not)
* 相等运算符：===，!==，==，!=
* 比较运算符：>，>=，<，<=

如果发生自动转为布尔值，规则：以下转为`false`，其余为`true`

* undefined
* null
* false
* 0
* NaN
* ""（空字符串）

因此：特别注意的是，空数组（`[]`）和空对象（`{}`）对应的布尔值，都是`true`

## 数值

### 整数和浮点数

* 所有数字都是以64位浮点数形式储存，即使整数也是如此。
* 由于浮点数不是精确的值，所以涉及小数的比较和运算要特别小心

### 数值精度

> 根据国际标准IEEE 754，64位浮点数格式的64个二进制位中，第0位到第51位储存有效数字部分（共52位），第52到第62位储存指数部分，第63位是符号位，0表示正数，1表示负数







## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)