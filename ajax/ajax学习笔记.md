title: ajax学习笔记
date: 2016-01-25 15:16:06
tags: 
- ajax

----

# AJAX学习笔记

# 简介
AJAX = Asynchronous JavaScript and XML（异步的 JavaScript 和 XML）。

AJAX 不是新的编程语言，而是一种使用现有标准的新方法。

AJAX 是与服务器交换数据并更新部分网页的艺术，在不重新加载整个页面的情况下。

AJAX = 异步 JavaScript 和 XML。

AJAX 是一种用于创建快速动态网页的技术。

通过在后台与服务器进行少量数据交换，AJAX 可以使网页实现异步更新。这意味着可以在不重新加载整个网页的情况下，对网页的某部分进行更新。


## AJAX是基于现有的Internet标准
AJAX是基于现有的Internet标准，并且联合使用它们：

* XMLHttpRequest 对象 (异步的与服务器交换数据)
* JavaScript/DOM (信息显示/交互)
* CSS (给数据定义样式)
* XML (作为转换数据的格式)

# AJAX - 创建 XMLHttpRequest 对象

*XMLHttpRequest 是 AJAX 的基础。*

## XMLHttpRequest 对象
所有现代浏览器均支持 XMLHttpRequest 对象（IE5 和 IE6 使用 ActiveXObject）。

XMLHttpRequest 用于在后台与服务器交换数据。这意味着可以在不重新加载整个网页的情况下，对网页的某部分进行更新。

### 创建 XMLHttpRequest 对象
所有现代浏览器（IE7+、Firefox、Chrome、Safari 以及 Opera）均内建 XMLHttpRequest 对象。

**创建 XMLHttpRequest 对象的语法：**

	variable=new XMLHttpRequest();
老版本的 Internet Explorer （IE5 和 IE6）使用 ActiveX 对象：

	variable=new ActiveXObject("Microsoft.XMLHTTP");
	
*e.g.*
	
	var xmlhttp;
	if (window.XMLHttpRequest)
  	{// code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}
	else
  	{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
  	
  	
## AJAX - 向服务器发送请求请求

*XMLHttpRequest 对象用于和服务器交换数据。*

**向服务器发送请求:**
如需将请求发送到服务器，我们使用 XMLHttpRequest 对象的 open() 和 send() 方法：

	xmlhttp.open("GET","ajax_info.txt",true);
	xmlhttp.send();  	

两个函数的说明：
<table class="reference"> <tbody><tr> <th style="width:40%;">方法</th> <th>描述</th> </tr> <tr> <td>open(<i>method</i>,<i>url</i>,<i>async</i>)</td> <td> <p>规定请求的类型、URL 以及是否异步处理请求。</p> <ul class="listintable"> <li><i>method</i>：请求的类型；GET 或 POST</li> <li><i>url</i>：文件在服务器上的位置</li> <li><i>async</i>：true（异步）或 false（同步）</li> </ul> </td> </tr> <tr> <td>send(<i>string</i>)</td> <td> <p>将请求发送到服务器。</p> <ul class="listintable"> <li><i>string</i>：仅用于 POST 请求</li> </ul> </td> </tr> </tbody></table>  	


### GET 还是 POST？
与 POST 相比，GET 更简单也更快，并且在大部分情况下都能用。

然而，在以下情况中，请使用 POST 请求：

* 无法使用缓存文件（更新服务器上的文件或数据库）
* 向服务器发送大量数据（POST 没有数据量限制）
* 发送包含未知字符的用户输入时，POST 比 GET 更稳定也更可靠

如果需要像 HTML 表单那样 POST 数据，请使用 *setRequestHeader() *来添加 HTTP 头。然后在 send() 方法中规定您希望发送的数据。


### Async=true
当使用 async=true 时，请规定在响应处于 onreadystatechange 事件中的就绪状态时执行的函数。
	
	xmlhttp.onreadystatechange=function()
  	{
  		if (xmlhttp.readyState==4 && xmlhttp.status==200)
    	{
    		document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
    	}
  	}
	xmlhttp.open("GET","ajax_info.txt",true);
	xmlhttp.send();

## AJAX - 服务器 响应

如需获得来自服务器的响应，请使用 XMLHttpRequest 对象的 responseText 或 responseXML 属性。

### responseText 属性
如果来自服务器的响应并非 XML，请使用 responseText 属性。

responseText 属性返回字符串形式的响应，因此您可以这样使用：

	document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
	
### responseXML 属性
如果来自服务器的响应是 XML，而且需要作为 XML 对象进行解析，请使用 responseXML 属性：

	xmlDoc=xmlhttp.responseXML;
	txt="";
	x=xmlDoc.getElementsByTagName("ARTIST");
	for (i=0;i<x.length;i++)
  	{
  		txt=txt + x[i].childNodes[0].nodeValue + "<br>";
  	}
	document.getElementById("myDiv").innerHTML=txt;		
## AJAX - onreadystatechange 事件
当请求被发送到服务器时，我们需要执行一些基于响应的任务。

### onreadystatechange 事件
每当 readyState 改变时，就会触发 onreadystatechange 事件。

readyState 属性存有 XMLHttpRequest 的状态信息。

下面是 XMLHttpRequest 对象的三个重要的属性：

<table class="reference notranslate"> <tbody><tr> <th align="left" width="20%">属性</th> <th align="left" width="80%">描述</th> </tr> <tr> <td>onreadystatechange</td> <td>存储函数（或函数名），每当 readyState 属性改变时，就会调用该函数。</td> </tr> <tr> <td>readyState</td> <td> <p>存有 XMLHttpRequest 的状态。从 0 到 4 发生变化。</p> <ul class="listintable"> <li>0: 请求未初始化</li> <li>1: 服务器连接已建立</li> <li>2: 请求已接收</li> <li>3: 请求处理中</li> <li>4: 请求已完成，且响应已就绪</li> </ul> </td> </tr> <tr> <td>status</td> <td>200: "OK"<br> 404: 未找到页面</td> </tr> </tbody></table>

在 onreadystatechange 事件中，我们规定当服务器响应已做好被处理的准备时所执行的任务。

当 readyState 等于 4 且状态为 200 时，表示响应已就绪:

	xmlhttp.onreadystatechange=function()
  	{
  		if (xmlhttp.readyState==4 && xmlhttp.status==200)
    	{
    		document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
    	}
  	}

### 使用回调函数
回调函数是一种以参数形式传递给另一个函数的函数。

如果您的网站上存在多个 AJAX 任务，那么您应该为创建 XMLHttpRequest 对象编写一个标准的函数，并为每个 AJAX 任务调用该函数。

该函数调用应该包含 URL 以及发生 onreadystatechange 事件时执行的任务（每次调用可能不尽相同）
  	
	var xmlhttp;
	function loadXMLDoc(url,cfunc)
	{
		if (window.XMLHttpRequest)
  		{// IE7+, Firefox, Chrome, Opera, Safari 代码
  			xmlhttp=new XMLHttpRequest();
  		}
		else
  		{// IE6, IE5 代码
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=cfunc;
		xmlhttp.open("GET",url,true);
		xmlhttp.send();
	}
	function myFunction()
	{
		loadXMLDoc("/try/ajax/ajax_info.txt",function()
  		{
  			if (xmlhttp.readyState==4 && xmlhttp.status==200)
    		{
    			document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
    		}
  		});
	}  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	