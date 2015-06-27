#JS进阶之一
===
#JavaScript HTML DOM

通过 HTML DOM，可访问 JavaScript HTML 文档的所有元素。

##HTML DOM (文档对象模型)
当网页被加载时，浏览器会创建页面的文档对象模型（Document Object Model）。

HTML DOM 模型被构造为对象的树：

![HTMl DOM](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/js-html-dom-tree.gif)

##查找 HTML 元素
通常，通过 JavaScript，您需要操作 HTML 元素。

为了做到这件事情，您必须首先找到该元素。有三种方法来做这件事：

* 通过 id 找到 HTML 元素

		var x=document.getElementById("intro");

* 通过标签名找到 HTML 元素

		var y=x.getElementsByTagName("p");

* 通过类名找到 HTML 元素

		var x=document.getElementsByClassName("intro");
		
##改变 HTML 输出流

	在 JavaScript 中，document.write() 可用于直接向 HTML 输出流写内容。

> 绝对不要在文档加载完成之后使用 document.write()。这会覆盖该文档。

##改变 HTML 内容
修改 HTML 内容的最简单的方法时使用 innerHTML 属性。

	document.getElementById(id).innerHTML=new HTML
	e.g.
	document.getElementById("p1").innerHTML="New text!";
	
##改变 HTML 属性
	
	document.getElementById(id).attribute=new value
	e.g.
	document.getElementById("image").src="landscape.jpg";
	
	
##改变 HTML 样式
如需改变 HTML 元素的样式，请使用这个语法：

	document.getElementById(id).style.property=new style
	e.g.
	document.getElementById("p2").style.color="blue";
		
##对事件做出反应

##HTML 事件属性
如需向 HTML 元素分配 事件，您可以使用事件属性。

	向 button 元素分配 onclick 事件：

	<button onclick="displayDate()">Try it</button>

##使用 HTML DOM 来分配事件
HTML DOM 允许您使用 JavaScript 来向 HTML 元素分配事件

	向 button 元素分配 onclick 事件：

	<script>
	document.getElementById("myBtn").onclick=function(){displayDate()};
	</script>		
	
##HTML 事件的例子：

* 当用户点击鼠标时:onclick、onmouseup、onmousedown
* 当网页已加载时:onload和onunload
* 当图像已加载时：
* 当鼠标移动到元素上时：onmouseover和onmouseout
* 当输入字段被改变时：onchange
* 当提交 HTML 表单时
* 当用户触发按键时

##EventListener

###addEventListener() 方法

addEventListener() 方法用于向指定元素添加事件句柄。

addEventListener() 方法添加的事件句柄不会覆盖已存在的事件句柄。

你可以向一个元素添加多个事件句柄。

你可以向同个元素添加多个同类型的事件句柄，如：两个 "click" 事件。

你可以向任何 DOM 对象添加事件监听，不仅仅是 HTML 元素。如： window 对象。

addEventListener() 方法可以更简单的控制事件（冒泡与捕获）。

当你使用 addEventListener() 方法时, JavaScript 从 HTML 标记中分离开来，可读性更强， 在没有控制HTML标记时也可以添加事件监听。

你可以使用 removeEventListener() 方法来移除事件的监听。

	element.addEventListener(event, function, useCapture);

* 第一个参数是事件的类型 (如 "click" 或 "mousedown").

* 第二个参数是事件触发后调用的函数。

* 第三个参数是个布尔值用于描述事件是冒泡还是捕获。该参数是可选的。

###传递参数
当传递参数值时，使用"匿名函数"调用带参数的函数

	element.addEventListener("click", function(){ myFunction(p1, p2); });

###事件冒泡或事件捕获？
事件传递有两种方式：冒泡与捕获。

事件传递定义了元素事件触发的顺序。 如果你将 <p> 元素插入到 <div> 元素中，用户点击 <p> 元素, 哪个元素的 "click" 事件先被触发呢？

在 冒泡 中，内部元素的事件会先被触发，然后再触发外部元素，即： <p> 元素的点击事件先触发，然后会触发 <div> 元素的点击事件。

在 捕获 中，外部元素的事件会先被触发，然后才会触发内部元素的事件，即： <div> 元素的点击事件先触发 ，然后再触发 <p> 元素的点击事件。


















	