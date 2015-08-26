#jQuery基础
======

##简介

###什么是 jQuery ？
jQuery是一个JavaScript函数库。

jQuery是一个轻量级的"写的少，做的多"的JavaScript库。

jQuery库包含以下功能：

* HTML 元素选取
* HTML 元素操作
* CSS 操作
* HTML 事件函数
* JavaScript 特效和动画
* HTML DOM 遍历和修改
* AJAX
* Utilities

提示： 除此之外，Jquery还提供了大量的插件。

###jQuery安装

####下载 jQuery
有两个版本的 jQuery 可供下载：

* Production version - 用于实际的网站中，已被精简和压缩。
* Development version - 用于测试和开发（未压缩，是可读的代码）
以上两个版本都可以从 jquery.com中下载。

jQuery 库是一个 JavaScript 文件，您可以使用 HTML 的 \<script\> 标签引用它：

	<head>
	<script src="jquery-1.10.2.min.js"></script>
	</head>
	
###使用CDN

Baidu CDN:

	<head>
	<script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js">
	</script>
	</head>


##语法

通过 jQuery，您可以选取（查询，query） HTML 元素，并对它们执行"操作"（actions）。

**举例**

jQuery 语法是通过选取 HTML 元素，并对选取的元素执行某些操作。

基础语法： $(selector).action()

* 美元符号定义 jQuery

* 选择符（selector）"查询"和"查找" HTML 元素
* jQuery 的 action() 执行对元素的操作

实例:

	$(this).hide() - 隐藏当前元素
	
	$("p").hide() - 隐藏所有段落
	
	$("p .test").hide() - 隐藏所有 class="test" 的段落
	
	$("#test").hide() - 隐藏所有 id="test" 的元素

p.s.:jQuery 使用的语法是 XPath 与 CSS 选择器语法的组合。


###文档就绪事件

实例中的所有 jQuery 函数位于一个 document ready 函数中：

	$(document).ready(function(){

   	// jQuery methods go here...

	});
	
这是为了防止文档在完全加载（就绪）之前运行 jQuery 代码。

如果在文档没有完全加载之前就运行函数，操作可能失败。下面是两个具体的例子：

* 试图隐藏一个不存在的元素
* 获得未完全加载的图像的大小

提示：简洁写法（与以上写法效果相同）	

	$(function(){

   	// jQuery methods go here...

	});


	
	
	
	











