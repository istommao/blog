title: less学习
date: 2016-03-19 10:35:35
tags:
- less

----

# less学习

一种 `动态`样式`语言`. LESS 将 CSS 赋予了动态语言的特性，如 `变量`， `继承`， `运算`， `函数`. LESS 既可以在 客户端 上运行 (支持IE 6+, Webkit, Firefox)，也可以借助Node.js或者Rhino在服务端运行。

## 变量

变量允许我们单独定义一系列通用的样式，然后在需要的时候去调用。所以在做全局样式调整的时候我们可能只需要修改几行代码就可以了。

语法：`@variable`

 	// LESS
	@color: #4D926F;
	
	#header {
	  color: @color;
	}
	h2 {
	  color: @color;
	}
	
	/* 生成的 CSS */

	#header {
	  color: #4D926F;
	}
	h2 {
	  color: #4D926F;
	}	
	
## 混合

混合可以将一个定义好的class A轻松的引入到另一个class B中，从而简单实现class B继承class A中的所有属性。我们还可以带参数地调用，就像使用函数一样。

语法：与定义css类一致，并且可以设定参数。
 
	// LESS
	
	.rounded-corners (@radius: 5px) {
	  border-radius: @radius;
	  -webkit-border-radius: @radius;
	  -moz-border-radius: @radius;
	}
	
	#header {
	  .rounded-corners;
	}
	#footer {
	  .rounded-corners(10px);
	}
	

	/* 生成的 CSS */
	
	#header {
	  border-radius: 5px;
	  -webkit-border-radius: 5px;
	  -moz-border-radius: 5px;
	}
	#footer {
	  border-radius: 10px;
	  -webkit-border-radius: 10px;
	  -moz-border-radius: 10px;
	}	


## 嵌套规则

我们可以在一个选择器中嵌套另一个选择器来实现继承，这样很大程度减少了代码量，并且代码看起来更加的清晰。

	// LESS
	
	#header {
	  h1 {
	    font-size: 26px;
	    font-weight: bold;
	  }
	  p { font-size: 12px;
	    a { text-decoration: none;
	      &:hover { border-width: 1px }
	    }
	  }
	}
	
	#header h1 {
	  font-size: 26px;
	  font-weight: bold;
	}
	#header p {
	  font-size: 12px;
	}
	#header p a {
	  text-decoration: none;
	}
	#header p a:hover {
	  border-width: 1px;
	}

## 函数 & 运算

运算提供了加，减，乘，除操作；我们可以做属性值和颜色的运算，这样就可以实现属性值之间的复杂关系。LESS中的函数一一映射了JavaScript代码，如果你愿意的话可以操作属性值。		

	// LESS
	
	@the-border: 1px;
	@base-color: #111;
	@red:        #842210;
	
	#header {
	  color: @base-color * 3;
	  border-left: @the-border;
	  border-right: @the-border * 2;
	}
	#footer { 
	  color: @base-color + #003300;
	  border-color: desaturate(@red, 10%);
	}
	
	/* 生成的 CSS */
	
	#header {
	  color: #333;
	  border-left: 1px;
	  border-right: 2px;
	}
	#footer { 
	  color: #114411;
	  border-color: #7d2717;
	}

## 在客户端使用

引入你的 .less 样式文件的时候要设置 rel 属性值为 “stylesheet/less”:

	<link rel="stylesheet/less" type="text/css" href="styles.less">
	
在<head> 中引入:

	<script src="less.js" type="text/javascript"></script>
	

**注意less样式文件一定要在引入less.js前先引入。**		
## 在服务器端使用

### 安装

	$ npm install less
	
### 使用

在Node中调用编译器:

	var less = require('less');

	less.render('.class { width: 1 + 1 }', function (e, css) {
	    console.log(css);
	});	
	
也可以手动调用解析器和编译器:	

	var parser = new(less.Parser);
	
	parser.parse('.class { width: 1 + 1 }', function (err, tree) {
	    if (err) { return console.error(err) }
	    console.log(tree.toCSS());
	});
	
向解析器传递参数:

	var parser = new(less.Parser)({
	    paths: ['.', './lib'], // Specify search paths for @import directives
	    filename: 'style.less' // Specify a filename, for better error messages
	});
	
	parser.parse('.class { width: 1 + 1 }', function (e, tree) {
	    tree.toCSS({ compress: true }); // Minify CSS output
	});	

在命令行下使用：

	$ lessc styles.less
	$ lessc styles.less > styles.css
	$ lessc -x styles.less > styles.css
	
## less语法

### 变量

	@variable
	
使用变量名定义变量

	@fnord: "I am fnord.";
	@var: 'fnord';
	content: @@var;
	
@var通过变量@fnord的变量名定义，解析后:
	
	content: "I am fnord.";	

注意 LESS 中的变量为完全的 ‘常量’ ，所以只能定义一次.

### 混合

在 LESS 中我们可以定义一些通用的属性集为一个class（`该class可以带参数，也可以设置默认值，或者不带参数`），然后在另一个class中去调用这些属性. 下面有这样一个class:

	.bordered {
	  border-top: dotted 1px black;
	  border-bottom: solid 2px black;
	}

在其他class中引入通用的属性集：

	#menu a {
	  color: #111;
	  .bordered;
	}
	.post a {
	  color: red;
	  .bordered;
	}
	

* CSS class, id 或者 元素 属性集都可以以同样的方式引入.
* @arguments包含了所有传递进来的参数. 

### 模式匹配和导引表达式

根据传入的参数来改变混合的默认呈现。

例子：根据第一个参数进行匹配

	.mixin (dark, @color) {
	  color: darken(@color, 10%);
	}
	.mixin (light, @color) {
	  color: lighten(@color, 10%);
	}
	.mixin (@_, @color) {
	  display: block;
	}	
	
	@switch: light;
	
	.class {
	  .mixin(@switch, #888);
	}	

只有被匹配的混合才会被使用。变量可以匹配任意的传入值。也可以匹配多个参数。

### 引导

当我们想根据表达式进行匹配，而非根据值和参数匹配时，导引就显得非常有用。

为了尽可能地保留CSS的可声明性，LESS通过导引混合而非if/else语句来实现条件判断

	.mixin (@a) when (lightness(@a) >= 50%) {
	  background-color: black;
	}
	.mixin (@a) when (lightness(@a) < 50%) {
	  background-color: white;
	}
	.mixin (@a) {
	  color: @a;
	}

when关键字用以定义一个导引序列(此例只有一个导引)。接下来我们运行下列代码：

	.class1 { .mixin(#ddd) }
	.class2 { .mixin(#555) }

* 导引中可用的全部比较运算有： > >= = =< <。
* 关键字true只表示布尔真值，除去关键字true以外的值都被视示布尔假
* 导引序列使用逗号‘,’分割，当且仅当所有条件都符合时，才会被视为匹配成功
* 导引可以无参数，也可以对参数进行比较运算
* 基于值的类型进行匹配，我们就可以使用is*函式

		.mixin (@a, @b: 0) when (isnumber(@b)) { ... }
		.mixin (@a, @b: black) when (iscolor(@b)) { ... }

	常见的检测函式：

	* 	iscolor
	* 	isnumber
	* 	isstring
	* 	iskeyword
	* 	isurl
	* ispixel
	* ispercentage
	* isem

* 在导引序列中可以使用and关键字实现与条件
* 使用not关键字实现或条件

### 嵌套规则

LESS 可以让我们以嵌套的方式编写层叠样式. 

	#header {
	  color: black;
	
	  .navigation {
	    font-size: 12px;
	  }
	  .logo {
	    width: 300px;
	    &:hover { text-decoration: none }
	  }
	}
	
	或者：
	
	#header        { color: black;
	  .navigation  { font-size: 12px }
	  .logo        { width: 300px;
	    &:hover    { text-decoration: none }
	  }
	}

	对应css
	
	#header { color: black; }
	#header .navigation {
	  font-size: 12px;
	}
	#header .logo { 
	  width: 300px; 
	}
	#header .logo:hover {
	  text-decoration: none;
	}

注意 `&` 符号的使用—如果你想写串联选择器，而不是写后代选择器，就可以用到&了. 这点对伪类尤其有用如 :hover 和 :focus.

### 运算

任何数字、颜色或者变量都可以参与运算

LESS 的运算已经超出了我们的期望，它能够分辨出颜色和单位

### Color 函数

LESS 提供了一系列的颜色运算函数. 颜色会先被转化成 HSL 色彩空间, 然后在通道级别操作。比如：

	lighten(@color, 10%);     // return a color which is 10% *lighter* than @color
	darken(@color, 10%);      // return a color which is 10% *darker* than @color
	
### Math 函数

LESS提供了一组方便的数学函数，你可以使用它们处理一些数字类型的值

比如：

	round(1.67); // returns `2`
	ceil(2.4);   // returns `3`
	
### 命名空间

有时候，你可能为了更好组织CSS或者单纯是为了更好的封装，将一些变量或者混合模块打包起来, 你可以像下面这样在#bundle中定义一些属性集之后可以重复使用

	#bundle {
	  .button () {
	    display: block;
	    border: 1px solid black;
	    background-color: grey;
	    &:hover { background-color: white }
	  }
	  .tab { ... }
	  .citation { ... }
	}
	
	在 #header a中像这样引入 .button:
	
	#header a {
	  color: orange;
	  #bundle > .button;
	}
	
### 作用域

LESS 中的作用域跟其他编程语言非常类似，首先会从本地查找变量或者混合模块，如果没找到的话会去父级作用域中查找，直到找到为止

### 注释

CSS 形式的注释在 LESS 中是依然保留的，也支持双斜线的注释, 但是编译成 CSS 的时候自动过滤掉

### Importing

通过下面的形势引入 .less 文件, .less 后缀可带可不带

	@import "lib.less";
	@import "lib";

想导入一个CSS文件而且不想LESS对它进行处理，只需要使用.css后缀就：

	@import "lib.css";
	
### 字符串插值

用类似ruby和php的方式嵌入到字符串中，像@{name}这样的结构

	@base-url: "http://assets.fnord.com";
	background-image: url("@{base-url}/images/bg.png");	
### 避免编译

有时候我们需要输出一些不正确的CSS语法或者使用一些 LESS不认识的专有语法.

要输出这样的值我们可以在字符串前加上一个`~`
	
### JavaScript 表达式

JavaScript 表达式也可以在.less 文件中使用. 可以通过反引号的方式使用

	
	

## 参考

* [bootcss](http://www.bootcss.com/p/lesscss/)
* [LESS中国网站](http://www.lesscss.net/)




	















		