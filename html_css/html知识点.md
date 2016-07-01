title: html知识点
date: 2016-06-30 00:25:00
tags: 
- html

# html知识点

html知识点，精华部分可在 **快速指南** 中找到。

## 基础

详解：

* [MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTML)
* [菜鸟html教程](http://www.runoob.com/html/html-intro.html)


## 快速指南

### HTML文档（网页构成）

	<html>
	   <head>
	   	<title>这是一个标题</title>
	   </head>
	 	<body>
	 	</body>
	</html> 

### 标签、元素、属性

HTML 标记标签通常被称为 HTML 标签 (HTML tag)，如：`<body>`

	HTML元素 = <标签>内容</标签>

每个标签可以设置属性，用来给`元素`添加附加信息。通常用来对元素：指定`id`，`样式 style/class`，`字体 font`，`背景 `，

* 属性和属性值之间用`=`连接，属性值可用双引号，单引号或不用单引号
* 属性值应该始终被包括在引号内，双引号是最常用的

格式：

HTML元素 = 

	<标签名 属性名="属性值"> 内容 </标签名>
	<标签名 属性名="属性值" />


### 注释

	<!-- 注释 -->	
	
### 行内、块级元素

* 常见行内元素

	`a`, `img`, `span`, `button`, `input`, `label`, `select`, `textarea`, `script`
	
* 常见块级元素	

	`div`, `p`, `h1-6`, `header`, `form`, `table`, `ul/ol`, `dd/dl`
	
#### 对比

内容上：

* 一般情况下，行内元素只能包含数据和其他行内元素。
* 块级元素可以包含行内元素和其他块级元素。这种结构上的包含继承区别可以使块级元素创建比行内元素更”大型“的结构。

格式上：

* 默认情况下，行内元素不会以新行开始，而块级元素会新起一行。


### 常用标签

* [html常用标签和属性](html常用标签和属性.md)	

### 表单

* 如果要给服务端提交数据，表单中的组件必须要有`name`和`value`属性
* jQuery可使用`$("#id").serialize()`序列化`非diabled`的表单数据, 得到类似字符串：`name1=value1&name2=value2`

表单标签举例：

	<form action="服务器路径" method="get、post">
		文本框<input type="text" name="a" value=""/>
		密码  <input type="password" name="a" value=""/>
		单选  <input type="radio" name="x" checked="checked" name="a" value=""/>
		复选框 <input type="checkbox" name="a" value=""/>
		重置 <input type="reset">
		提交 <input type="submit" value="提交"/>
		文件 <input type="file" />
		图片 <input type="image" src="11.jpg" />
		隐藏 <input type="hidden" name="" value />
		按钮 <input type="button" value="" onclick=""/>
		
		下拉 
			<select>
				<option value="none">----</option>
				<option value="1" selected="selected">1</option>
			 </select>
			 
		<textarea name="text" rows="60" cols="20"></textarea>
	</form>	
	
#### get和post提交区别

1. get提交，提交的信息都在地址栏中
2. post提交，提交信息不在地址栏
3. get对于敏感数据不安全
4. post安全
5. get对大数据不行，有长度限制
6. post可以提交大体积数据
7. get提交，将信息封装到了请求
8. post将信息封装到请求体中	
9. 如果出现将中文提交到服务器，服务器会选用默认字符集解码，会出现中文乱码，通过默认字符集编码，再用中文对应解码。该方法对get和post都使用。post方法还可以在request对象的setCharacter指定中文码表就可以将中文数据解析出来。
10. 表单提交，建议post

和服务端交互

1. 地址栏输入url。get
2. 超链接。get
3. 表单。get/post


## 参考

* [MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTML)



