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


###jQuery选择器

jQuery 选择器允许您对 HTML 元素组或单个元素进行操作。

jQuery 选择器基于元素的 id、类、类型、属性、属性值等"查找"（或选择）HTML 元素。 它基于已经存在的 CSS 选择器，除此之外，它还有一些自定义的选择器。

jQuery 中所有选择器都以美元符号开头：$()。

* 元素选择器

	jQuery 元素选择器基于元素名选取元素。

	在页面中选取所有 \<p\> 元素:

		$("p")	
		
* \#id 选择器

	jQuery #id 选择器通过 HTML 元素的 id 属性选取指定的元素。

	页面中元素的 id 应该是唯一的，所以您要在页面中选取唯一的元素需要通过 #id 选择器。

	通过 id 选取元素语法如下：

		$("#test")		
	
* .class 选择器

	jQuery 类选择器可以通过指定的 class 查找元素。

	语法如下：

		$(".test")	
	
###jQuery事件

常见 DOM 事件：

|鼠标事件|键盘事件|表单事件|文档/窗口事件|
|:-:|:-:|:-:|:-:|
|click	|keypress	|submit	|load|
|dblclick	|keydown	|change|	resize|
|mouseenter|	keyup	|focus	|scroll|
|mouseleave	|| 	blur|	unload|

大多数 DOM 事件都有一个等效的 jQuery 方法。

常用的 jQuery 事件方法

* $(document).ready() 允许我们在文档完全加载完后执行函数。
* click() 方法是当按钮点击事件被触发时会调用一个函数。
* dblclick() 方法触发 dblclick 事件，或规定当发生 dblclick 事件时运行的函数
* mouseenter() 方法触发 mouseenter 事件，或规定当发生 mouseenter 事件时运行的函数
* mouseleave() 方法触发 mouseleave 事件，或规定当发生 mouseleave 事件时运行的函数
* mousedown() 方法触发 mousedown 事件，或规定当发生 mousedown 事件时运行的函数
* mouseup() 方法触发 mouseup 事件，或规定当发生 mouseup 事件时运行的函数
* hover()方法用于模拟光标悬停事件
* focous()当通过鼠标点击选中元素或通过 tab 键定位到元素时，该元素就会获得焦点
* blur()当元素失去焦点时，发生 blur 事件。

###jQuery效果

* 隐藏和显示: hide() 和 show(), 使用 toggle() 方法来切换 hide() 和 show() 方法
* 淡入淡出: fadeIn()、fadeOut()、fadeToggle()、fadeTo()
* 滑动：slideDown()、slideUp()、slideToggle()
* 动画

		$(selector).animate({params},speed,callback);
		
	* 必需的 params 参数定义形成动画的 CSS 属性。
	* 可选的 speed 参数规定效果的时长。它可以取以下值："slow"、"fast" 或毫秒。
	* 可选的 callback 参数是动画完成后所执行的函数名称。

* stop() 方法用于停止动画或效果，在它们完成之前。
* Callback 函数在当前动画 100% 完成之后执行。

###Chaining

Chaining 允许我们在一条语句中运行多个 jQuery 方法（在相同的元素上）。















