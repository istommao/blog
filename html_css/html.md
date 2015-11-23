#HTML

##标签
	<html>
	   <head>
	   	<title>这是一个标题</title>
	   </head>
	 	<body>
	 	</body>
	</html> 	
	
##标记属性

	<font color='red' size='8'>x</font>
	
	属性和属性值之间用'='连接，属性值可用双引号，单引号或不用单引号。
	
格式

	<标签名 属性名="属性值"> 内容 </标签名>
	<标签名 属性名="属性值" />
	
注释

	<!-- 注释 -->	
	
标签就相当于一个容器。通过属性改变容器中的内容。


转义字符'&'开头，分号结束。比如`&lt;`

###列表标签

	dl: design list
	上层项目:dt
	下层项目:dd,封装的内容具有缩进效果
	<dl>
		<dt>
			<dd></dd>
			<dd></dd>
		</dt>
	</dl>
	
	有序无序项目列表
	有序 <ol>
	无序 <ul>
	条目的封装都是用li，而且它们都有缩进效果
	
	无序
	<ul type="circle">
		<li></li>
		<li></li>
	</ul>
	
	有序
	<ol type="o">
		<li></li>
		<li></li>
	</ol>
	
	
###图片标签

	<img />
	
	<img src="imgs\1.jpg" height=300 width=222 border=10 alt="desc" />
		
###表格标签

	<table border=1 bordercolor="#dfdfdf", cellpadding=10 cellspacing=10 width=500>
		<caption>标题</caption>
		<tr>
			<th></th>
		</tr>	
		<tr>
			<td></td>
		</tr>
	</table>
	
	不规则表格：行中分单元格，合并单元格属性colspan， rowspan
	
	表格下级标签
	<table>
		<thead></thead>
		<tbody></tbody>
		<tfoot></tfoot>
	</table>
		
###超链接

	href属性的值不同，解析的方式不同。如果没有指定任何协议，解析时按照默认的协议执行
	<a href="http://www.example.com" target="_blank"></a>	
	
	取消点击效果,自定义
	<a href="javascript:void(0)" onclick="alert('dd')"> </a>	
	
	页面回到顶部:锚
	<a name=top></a>
	<a href="#top"></a>	
	
	
###框架frameset

	<frameset rows="30%, *">
		<frame src="top.html" name="top"/>
		<frameset clos="30%, *">
			<frame src="left.html" />
			<frame src="left.html" />
		</frameset	>
	</frameset	>
	
###画中画iframe

	<iframe src="table.html" height=400 width=200>
		
	</iframe>
	
###表单标签form

	如果要给服务端提交数据，表单中的组件必须要有name和value属性
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
			 
		<textarea name="text"></textarea>	 
		
	</form>
	
###get和post提交区别

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

###div

	<div>区域标签，没有具体含义，用来封装整行区域</div>
	<span>封装行内区域</span>
	<p>段落标签</p>
	
	标签分类：
	1. 块级标签（元素）：标签结束后有换行
	2. 行内标签（元素）：不换行
	

##其他标签

	<base>
	
	<meta>:
		name属性：网页描述信息。如果取关键字时，content属性作为搜索引擎关键字进行搜索
		http-equiv属性：模拟http协议的相应消息体
		
		<meta http-equiv="refresh" content="3;url=http://www.baidu.com" />
		表示3s后自动跳转到百度首页
		
	<link>:
	
	<b>
	<i>
	<u>
	<sub>
	<sup>
	<marquee direction="" behavior>
	<pre>	
	
##XML和HTML、XHTML
* XML对数据信息的描述。HTML是数据显示表示
* XML	代码规定更为严格
* XML规范可以被更多应用程序解释，很多服务器、框架都讲xml作为配置文件
* XML标签不固定，HTML标签是固定的
* XHTML是基于XML的一种应用








