title: html常用标签
date: 2016-06-30 00:25:00
tags: 
- html

# html常用标签

## 标题、段落

 	标题：h1~h6
 	段落：p
 	水平线：hr
 	换行：br
 	空格： &nbsp
 	
## 标签：div、span

	<div>区域标签，没有具体含义，用来封装整行区域</div>
	<span>封装行内区域</span>
	<p>段落标签</p>
	 	
* div、span都用来封装区域
* div封装的元素按照文档流输出，因此div及其内部的元素就需要合理设置属性：`style`、`class`等

常见属性和用法：

	<div class="form-group">
		<lable style="width:40%;float: left;margin: 0 -1px 0 0;padding-bottom: 0;padding-top: 0;vertical-align: middle;"
		<span class="red-color"></span>
		<a></a> 
	</div>

## 标签：a

格式：

	<a href="url">链接文本</a>

常见属性和用法：

	<a href="url" target="_blank">google</a>
	
## 图片 img

	<img src="url" >
	设置宽、高	
	<img src="pulpit.jpg" alt="Pulpit rock" width="304" height="228">

## 样式

### 内联样式

设置元素的`style`属性，样式属性值可以是包含任意`css属性`，用分号隔开

	<p style="color:blue;margin-left:20px;">This is a paragraph.</p>
	
	
### 内部样式表

在头部`head`标签中使用标签`style`	，标签内容可以包含任意`css属性`

	<style type="text/css">
		body {background-color:yellow}
		p {color:blue}
	</style>	

### 外部样式

头部标签`head`中使用标签`link`

	<link rel="stylesheet" type="text/css" href="mystyle.css">	
	  	
## 头部标签： head

### link

定义了文档与外部资源之间的关系。通常用于链接到样式表:

	<link rel="stylesheet" type="text/css" href="mystyle.css">
	<link rel="stylesheet" href="mystyle.css">
	
### style

定义了HTML文档的样式文件引用地址

	<style type="text/css">
		body {background-color:yellow}
		p {color:blue}
	</style>		

### meta

描述了一些基本的元数据。通常用于指定网页的描述，关键词，文件的最后修改时间，作者，和其他元数据。

	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<meta name="keywords" content="HTML, CSS, XML, XHTML, JavaScript">
	<meta name="description" content="Free Web tutorials on HTML and CSS">
	<meta name="author" content="Hege Refsnes">
	
### script

加载脚本文件

	<script>
		document.write("Hello World!")
		js code...
	</script>


## table 和 边框属性

tr: table row, td: table data, th: table head

	<table border="1">
		<tr><th>可选表头</th></tr>
		<tr> 
			<td></td>
		</tr>
		...
	</table>
	
也可结合：thead, tbody, tfoot使用。		
## 列表 ul、ol

无序：ul, li

	<ul>
		<li>*</li>
	</ul>
		
有序：ol, li

	<ol>
		<li>1</li>
	</ol>			

自定义: dl(定义列表), dt(项目), dd(描述)

	<dl>
	<dt>Coffee</dt>
	<dd>- black hot drink</dd>
	<dt>Milk</dt>
	<dd>- white cold drink</dd>
	</dl>

## 属性

### 全局属性

#### style

定义元素的内联样式，见前文。

#### class

定义了元素的类名

	<element class="classname">
	
规定元素的类的名称。如需为一个元素规定多个类，用`空格分隔`类名（p.s. style属性中的多个css属性用`分号`隔开）。 

	<span class="left important">	
class 属性通常用于指向`样式表的类`。	
#### data-\*

存储页面的自定义数据(H5新增)

	<element data-*="somevalue">
	
## 事件

### 窗口事件

* onblur： 当窗口失去焦点时运行脚本
* onfocus：当窗口获得焦点时运行脚本
* onload: 当文档加载时运行脚本
* onbeforeload: 在文档加载之前运行脚本
* onresize: 当调整窗口大小时运行脚本
* ...


### 表单事件

* onblur: 当元素失去焦点时运行脚本
* onchange: 当元素改变时运行脚本
* onfoucus: 当元素获得焦点时运行脚本
* oninput: 当元素获得用户输入时运行脚本
* onselect: 当选取元素时运行脚本
* onsubmit: 当提交表单时运行脚本

### 键盘事件

* onkeydown: 当按下按键时运行脚本
* onkeypress: 当按下并松开按键时运行脚本
* onkeyup: 当松开按键时运行脚本


### 鼠标事件

* onclick:
* ondbclick:
* ondrag:
* ondragend:
* ondragenter:
* ondragleave:
* ondragover:
* ondragstart:
* ondragedrop:
* onmousedown:
* onmousemove:
* onmouseout:
* onmouseover:
* onmouseup:
* nomousescroll:



## 参考

* [MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTML)






