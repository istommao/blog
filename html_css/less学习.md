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
	



















		