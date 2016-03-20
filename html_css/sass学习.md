title: sass学习
date: 2016-03-20 22:36:20
tags: 
- sass
- css

# sass学习

## 什么是SASS

SASS是一种CSS的开发工具，提供了许多便利的写法，大大节省了设计者的时间，使得CSS的开发，变得简单和可维护。

SASS是Ruby语言写的，必须先安装Ruby，然后再安装SASS。

安装：

	gem install sass

## 语法

SASS文件就是普通的文本文件，里面可以直接使用CSS语法。文件后缀名是.scss，意思为Sassy CSS。

### 变量

SASS允许使用变量，所有变量以$开头。

	$blue : #1875e7;　
	　　div {
	　　　color : $blue;
	　　}
	　
如果变量需要镶嵌在字符串之中，就必须需要写在#{}之中

	$side : left;
	.rounded {
		border-#{$side}-radius: 5px;
	}	　　
	　　
### 运算

使用算式

	body {
	　　　　margin: (14px/2);
	　　　　top: 50px + 100px;
	　　　　right: $var * 10%;
	　　}
### 嵌套

SASS允许

* 选择器嵌套：

		sass
		div {
		　　　　hi {
		　　　　　　color:red;
		　　　　}
		　　}	
		
		css
		div h1 {
			color : red;
		}　　
	
* 属性也可以嵌套，比如border-color属性（border后面必须加上冒号）	

		p {
			border: {
				color: red;
				}
			}

* 使用&引用父元素，比如a:hover伪类

		a {
			&:hover { color: #ffb3ff; }
		}

### 注释

* 标准的CSS注释 `/* comment */ `，会保留到编译后的文件。
* 单行注释 `// comment`，只保留在SASS源文件中，编译后被省略。
* 在`/*后面加一个感叹号: /*!`，表示这是"重要注释"。即使是压缩模式编译，也会保留这行注释，通常可以用于声明版权信息。

### 继承

* 一个选择器，继承另一个选择器，使用`@extend`命令

		.class1 {
		　　border: 1px solid #ddd;
		}
		
		.class2 {
			@extend .class1;
			font-size:120%;
		}
		
### mixin

Mixin有点像C语言的宏（macro），是可以重用的代码块。

* 使用`@mixin`命令，定义一个代码块	
* 使用`@include`命令，调用这个mixin。
* mixin可以指定参数和缺省值，使用的时候，根据需要加入参数
	
e.g.: 
	
	@mixin left {
		float: left;
		margin-left: 10px;
	}
	
	div {
		@include left;
	}

e.g.: 带参数和缺省值

	@mixin left($value: 10px) {
		float: left;
		margin-right: $value;
	}	
			
	div {
		@include left(20px);
	}		

### 颜色函数

SASS提供了一些内置的颜色函数，以便生成系列颜色

	lighten(#cc3, 10%) // #d6d65c
	darken(#cc3, 10%) // #a3a329
	grayscale(#cc3) // #808080
	complement(#cc3) // #33c

### 插入文件

`@import`命令，用来插入外部文件。

	@import "path/filename.scss";
	
如果插入的是.css文件，则等同于css的import命令。

	@import "foo.css";	

### 高级用法

#### @if

	@if lightness($color) > 30% {
		background-color: #000;
	} @else {
		background-color: #fff;
	}
	
#### 循环

@for

	@for $i from 1 to 10 {
		.border-#{$i} {
			border: #{$i}px solid blue;
		}
	}			

@while

	$i: 6;
	
	@while $i > 0 {
		.item-#{$i} { width: 2em * $i; }
		$i: $i - 2;
	}
	
@each，作用与for类似

	@each $member in a, b, c, d {
		.#{$member} {
			background-image: url("/image/#{$member}.jpg");
		}
	}
	
#### 自定义函数

	@function double($n) {
		@return $n * 2;
	}
	
	#sidebar {
		width: double(5px);
	}			
		


## 参考

* [SASS用法指南](http://www.ruanyifeng.com/blog/2012/06/sass.html)
* [SASS](http://sass-lang.com/)
* [less学习](https://github.com/zhuwei05/blog/blob/master/html_css/less%E5%AD%A6%E4%B9%A0.md)