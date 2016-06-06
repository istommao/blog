# bootstrap笔记

## 简介

Bootstrap 是一个用于快速开发 Web 应用程序和网站的前端框架。Bootstrap 是基于 HTML、CSS、JAVASCRIPT 的。

使用bootstrap，必须具备 HTML 、 CSS 和 JavaScript 的基础知识。

## 安装

您可以从 [bootstrap](http://getbootstrap.com/) 上下载 Bootstrap 的最新版本.

P.S: 国内，还有很多其他网站都有cdn缓存。

### 预编译版


	bootstrap/
	├── css/
	│   ├── bootstrap.css
	│   ├── bootstrap.css.map
	│   ├── bootstrap.min.css
	│   ├── bootstrap-theme.css
	│   ├── bootstrap-theme.css.map
	│   └── bootstrap-theme.min.css
	├── js/
	│   ├── bootstrap.js
	│   └── bootstrap.min.js
	└── fonts/
	    ├── glyphicons-halflings-regular.eot
	    ├── glyphicons-halflings-regular.svg
	    ├── glyphicons-halflings-regular.ttf
	    ├── glyphicons-halflings-regular.woff
	    └── glyphicons-halflings-regular.woff2
	    
Bootstrap 的基本文件结构：预编译文件可以直接使用到任何 web 项目中。我们提供了编译好的 CSS 和 JS (bootstrap.\*) 文件，还有经过压缩的 CSS 和 JS (bootstrap.min.\*) 文件。同时还提供了 CSS 源码映射表 (bootstrap.*.map) ，可以在某些浏览器的开发工具中使用。同时还包含了来自 Glyphicons 的图标字体，在附带的 Bootstrap 主题中使用到了这些图标。


### Bootstrap 源代码
如果您下载了 Bootstrap 源代码，那么文件结构将如下所示:

	bootstrap/
	├── less/
	├── js/
	├── fonts/
	├── dist/
	│   ├── css/
	│   ├── js/
	│   └── fonts/
	└── docs/
	    └── examples/

less/、js/ 和 fonts/ 目录分别包含了 CSS、JS 和字体图标的源码。dist/ 目录包含了上面所说的预编译 Bootstrap 包内的所有文件。docs/ 包含了所有文档的源码文件，examples/ 目录是 Bootstrap 官方提供的实例工程。除了这些，其他文件还包含 Bootstrap 安装包的定义文件、许可证文件和编译脚本等。

## Bootstrap模板

一个使用了 Bootstrap 的基本的 HTML 模板如下所示：

	<!DOCTYPE html>
	<html>
	   <head>
	      <title>Bootstrap 模板</title>
	      <meta name="viewport" content="width=device-width, initial-scale=1.0">
	      <!-- 引入 Bootstrap -->
	      <link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
	
	      <!-- HTML5 Shim 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
	      <!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
	      <!--[if lt IE 9]>
	         <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	         <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
	      <![endif]-->
	   </head>
	   <body>
	      <h1>Hello, world!</h1>
	
	      <!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
	      <script src="https://code.jquery.com/jquery.js"></script>
	      <!-- 包括所有已编译的插件 -->
	      <script src="js/bootstrap.min.js"></script>
	   </body>
	</html>
	
在这里，您可以看到包含了**jquery.js、bootstrap.min.js 和 bootstrap.min.css **文件，用于让一个常规的 HTML 文件变为使用了 Bootstrap 的模板。	

### Bootstrap的hello world

Bootstrap输出"Hello, world!"：

	<!DOCTYPE html>
	<html>
	<head>
	   <title>Bootstrap 实例</title>
	   <link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
	   <script src="http://apps.bdimg.com/libs/jquery/2.0.0/jquery.min.js"></script>
	   <script src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	</head>
	<body>
	
	      <h1>Hello, world!</h1>
	
	</body>
	</html>

## less快速入门

Less 是一门 CSS 预处理语言，它扩充了 CSS 语言，增加了诸如变量、混合（mixin）、函数等功能，让 CSS 更易维护、方便制作主题、扩充。

Less 可以运行在 Node、浏览器和 Rhino 平台上。

### 安装

	npm install -g less
	
### 命令行用法

	lessc styles.less
	
	
### 代码使用

	var less = require('less');
	
	less.render('.class { width: (1 + 1) }', function (e, css) {
	  console.log(css);
	});		
	
输出结果为：

	.class {
	  width: 2;
	}		
	
### 客户端用法

# Bootstrap CSS
---
## 网格系统

Bootstrap 提供了一套响应式、移动设备优先的流式网格系统，随着屏幕或视口（viewport）尺寸的增加，系统会自动分为最多12列。

Bootstrap 官方文档中有关网格系统的描述：
> Bootstrap 包含了一个响应式的、移动设备优先的、不固定的网格系统，可以随着设备或视口大小的增加而适当地扩展到 12 列。它包含了用于简单的布局选项的预定义类，也包含了用于生成更多语义布局的功能强大的混合类。

### 使用

* 行必须放置在 .container class 内，以便获得适当的对齐（alignment）和内边距（padding）。
* 使用行来创建列的水平组。
* 内容应该放置在列内，且唯有列可以是行的直接子元素。
* 预定义的网格类，比如 .row 和 .col-xs-4，可用于快速创建网格布局。LESS 混合类可用于更多语义布局。
* 列通过内边距（padding）来创建列内容之间的间隙。该内边距是通过 .rows 上的外边距（margin）取负，表示第一列和最后一列的行偏移。
* 网格系统是通过指定您想要横跨的十二个可用的列来创建的。例如，要创建三个相等的列，则使用三个 .col-xs-4。

 **Bootstrap 网格的基本结构：**
 
	<div class="container">
	   <div class="row">
	      <div class="col-*-*"></div>
	      <div class="col-*-*"></div>      
	   </div>
	   <div class="row">...</div>
	</div>
	<div class="container">.... 

### 偏移列

> 使用偏移，请使用 .col-md-offset-* 类。这些类会把一个列的左外边距（margin）增加 * 列，其中 * 范围是从 1 到 11。

	<div class="row" >
	      <div class="col-xs-6 col-md-offset-3" 
	         style="background-color: #dedef8;box-shadow: 
	         inset 1px -1px 1px #444, inset -1px 1px 1px #444;">

### 嵌套列
> 为了在内容中嵌套默认的网格，请添加一个新的 .row，并在一个已有的 .col-md-* 列内添加一组 .col-md-* 列。被嵌套的行应包含一组列，这组列个数不能超过12（其实，没有要求你必须占满12列）。


### 列排序
> Bootstrap 网格系统另一个完美的特性，就是您可以很容易地以一种顺序编写列，然后以另一种顺序显示列。
> 您可以很轻易地改变带有 .col-md-push-* 和 .col-md-pull-* 类的内置网格列的顺序，其中 * 范围是从 1 到 11。


## 排版
Bootstrap 使用 Helvetica Neue、 Helvetica、 Arial 和 sans-serif 作为其默认的字体栈。
使用 Bootstrap 的排版特性，您可以创建标题、段落、列表及其他内联元素。

### 标题
Bootstrap 中定义了所有的 HTML 标题（h1 到 h6）的样式。

	<h1>我是标题1 h1</h1>
	<h2>我是标题2 h2</h2>
	<h3>我是标题3 h3</h3>
	<h4>我是标题4 h4</h4>
	<h5>我是标题5 h5</h5>
	<h6>我是标题6 h6</h6>
	
### 内联子标题
如果需要向任何标题添加一个内联子标题，只需要简单地在元素两旁添加 \<small\>，或者添加 .small class，这样子您就能得到一个字号更小的颜色更浅的文本

	<h1>我是标题1 h1. <small>我是副标题1 h1</small></h1> 
	<h2>我是标题2 h2. <small>我是副标题2 h2</small></h2>
	<h3>我是标题3 h3. <small>我是副标题3 h3</small></h3>
	<h4>我是标题4 h4. <small>我是副标题4 h4</small></h4>
	<h5>我是标题5 h5. <small>我是副标题5 h5</small></h5>
	<h6>我是标题6 h6. <small>我是副标题6 h6</small></h6>


### 引导主体副本
为了给段落添加强调文本，则可以添加 class="lead"，这将得到更大更粗、行高更高的文本

	<p class="lead">这是一个演示引导主体副本用法的实例。这是一个演示引导主体副本用法的实例。这是一个演示引导主体副本用法的实例。这是一个演示引导主体副本用法的实例。这是一个演示引导主体副本用法的实例。这是一个演示引导主体副本用法的实例。这是一个演示引导主体副本用法的实例。这是一个演示引导主体副本用法的实例。</p>

### 强调
> HTML 的默认强调标签 \<small\>（设置文本为父文本大小的 85%）、\<strong\>（设置文本为更粗的文本）、\<em\>（设置文本为斜体）。Bootstrap 提供了一些用于强调文本的类

	<small>本行内容是在标签内</small><br>
	<strong>本行内容是在标签内</strong><br>
	<em>本行内容是在标签内，并呈现为斜体</em><br>
	<p class="text-left">向左对齐文本</p>
	<p class="text-center">居中对齐文本</p>
	<p class="text-right">向右对齐文本</p>
	<p class="text-muted">本行内容是减弱的</p>
	<p class="text-primary">本行内容带有一个 primary class</p>
	<p class="text-success">本行内容带有一个 success class</p>
	<p class="text-info">本行内容带有一个 info class</p>
	<p class="text-warning">本行内容带有一个 warning class</p>
	<p class="text-danger">本行内容带有一个 danger class</p>

### 缩写
> HTML 元素提供了用于缩写的标记，比如 WWW 或 HTTP。Bootstrap 定义 \<abbr\> 元素的样式为显示在文本底部的一条虚线边框，当鼠标悬停在上面时会显示完整的文本（只要您为 \<abbr\> title 属性添加了文本）。为了得到一个更小字体的文本，请添加 .initialism 到 \<abbr\>。


### 引用（Blockquote）
> 您可以在任意的 HTML 文本旁使用默认的 \<blockquote\>。其他选项包括，添加一个 \<small\> 标签来标识引用的来源，使用 class .pull-right 向右对齐引用

### 列表
Bootstrap 支持有序列表、无序列表和定义列表。

* 有序列表：有序列表是指以数字或其他有序字符开头的列表。
* 无序列表：无序列表是指没有特定顺序的列表，是以传统风格的着重号开头的列表。如果您不想显示这些着重号，您可以使用 class .list-unstyled 来移除样式。您也可以通过使用 class .list-inline 把所有的列表项放在同一行中。
* 定义列表：在这种类型的列表中，每个列表项可以包含 \<dt\> 和 \<dd\> 元素。\<dt\> 代表 定义术语，就像字典，这是被定义的属于（或短语）。接着，\<dd\> 是 \<dt\> 的描述。您可以使用 class dl-horizontal 把 \<dl\> 行中的属于与描述并排显示。

		<h4>有序列表</h4>
		<ol>
		  <li>Item 1</li>
		  <li>Item 2</li>
		  <li>Item 3</li>
		  <li>Item 4</li>
		</ol>
		<h4>无序列表</h4>
		<ul>
		  <li>Item 1</li>
		  <li>Item 2</li>
		  <li>Item 3</li>
		  <li>Item 4</li>
		</ul>
		<h4>未定义样式列表</h4>
		<ul class="list-unstyled">
		  <li>Item 1</li>
		  <li>Item 2</li>
		  <li>Item 3</li>
		  <li>Item 4</li>
		</ul>
		<h4>内联列表</h4>
		<ul class="list-inline">
		  <li>Item 1</li>
		  <li>Item 2</li>
		  <li>Item 3</li>
		  <li>Item 4</li>
		</ul>
		<h4>定义列表</h4>
		<dl>
		  <dt>Description 1</dt>
		  <dd>Item 1</dd>
		  <dt>Description 2</dt>
		  <dd>Item 2</dd>
		</dl>
		<h4>水平的定义列表</h4>
		<dl class="dl-horizontal">
		  <dt>Description 1</dt>
		  <dd>Item 1</dd>
		  <dt>Description 2</dt>
		  <dd>Item 2</dd>
		</dl>

## 代码
Bootstrap 允许您以两种方式显示代码：

* 第一种是 \<code\> 标签。如果您想要内联显示代码，那么您应该使用 \<code\> 标签。
* 第二种是 \<pre\> 标签。如果代码需要被显示为一个独立的块元素或者代码有多行，那么您应该使用 \<pre\> 标签。

请确保当您使用 \<pre\> 和 \<code\> 标签时，开始和结束标签使用了 unicode 变体： \&lt; 和 \&gt;。

## 表格

Bootstrap 提供了一个清晰的创建表格的布局。

表格元素：

	<table>	为表格添加基础样式。
	<thead>	表格标题行的容器元素（<tr>），用来标识表格列。
	<tbody>	表格主体中的表格行的容器元素（<tr>）。
	<tr>	一组出现在单行上的表格单元格的容器元素（<td> 或 <th>）。
	<td>	默认的表格单元格。
	<th>	特殊的表格单元格，用来标识列或行（取决于范围和位置）。必须在 <thead> 内使用。
	<caption>	关于表格存储内容的描述或总结。
	
表样式

	.table	为任意 <table> 添加基本样式 (只有横向分隔线)	
	.table-striped	在 <tbody> 内添加斑马线形式的条纹 ( IE8 不支持)	
	.table-bordered	为所有表格的单元格添加边框	
	.table-hover	在 <tbody> 内的任一行启用鼠标悬停状态	
	.table-condensed	让表格更加紧凑

	
可用于表格的行或者单元格

	.active	将悬停的颜色应用在行或者单元格上
	.success	表示成功的操作	
	.info	表示信息变化的操作	
	.warning	表示一个警告的操作
	.danger	表示一个危险的操作	


两个例子

	<table class="table table-bordered">
	   <caption>边框表格布局</caption>
	   <thead>
	      <tr>
	         <th>名称</th>
	         <th>城市</th>
	         <th>密码</th>
	      </tr>
	   </thead>
	   <tbody>
	      <tr>
	         <td>Tanmay</td>
	         <td>Bangalore</td>
	         <td>560001</td>
	      </tr>
	      <tr>
	         <td>Sachin</td>
	         <td>Mumbai</td>
	         <td>400003</td>
	      </tr>
	      <tr>
	         <td>Uma</td>
	         <td>Pune</td>
	         <td>411027</td>
	      </tr>
	   </tbody>
	</table>

	<table class="table">
	   <caption>上下文表格布局</caption>
	   <thead>
	      <tr>
	         <th>产品</th>
	         <th>付款日期</th>
	         <th>状态</th>
	      </tr>
	   </thead>
	   <tbody>
	      <tr class="active">
	         <td>产品1</td>
	         <td>23/11/2013</td>
	         <td>待发货</td>
	      </tr>
	      <tr class="success">
	         <td>产品2</td>
	         <td>10/11/2013</td>
	         <td>发货中</td>
	      </tr>
	      <tr  class="warning">
	         <td>产品3</td>
	         <td>20/10/2013</td>
	         <td>待确认</td>
	      </tr>
	      <tr  class="danger">
	         <td>产品4</td>
	         <td>20/10/2013</td>
	         <td>已退货</td>
	      </tr>
	   </tbody>
	</table>


## 表单布局

Bootstrap 提供了下列类型的表单布局：

* 垂直表单（默认）
* 内联表单
* 水平表单	

### 垂直或基本表单
基本的表单结构是 Bootstrap 自带的，个别的表单控件自动接收一些全局样式。下面列出了创建基本表单的步骤：

* 向父 \<form\> 元素添加 role="form"。
* 把标签和控件放在一个带有 class .form-group 的 \<div\> 中。这是获取最佳间距所必需的。
* 向所有的文本元素 \<input\>、\<textarea\> 和 \<select\> 添加 class .form-control。


		<form role="form">
		   <div class="form-group">
		      <label for="name">名称</label>
		      <input type="text" class="form-control" id="name" 
		         placeholder="请输入名称">
		   </div>
		   <div class="form-group">
		      <label for="inputfile">文件输入</label>
		      <input type="file" id="inputfile">
		      <p class="help-block">这里是块级帮助文本的实例。</p>
		   </div>
		   <div class="checkbox">
		      <label>
		      <input type="checkbox"> 请打勾
		      </label>
		   </div>
		   <button type="submit" class="btn btn-default">提交</button>
		</form>



### 内联表单
如果需要创建一个表单，它的所有元素是内联的，向左对齐的，标签是并排的，请向\<form\> 标签添加 class .form-inline。


	<form class="form-inline" role="form">
	   <div class="form-group">
	      <label class="sr-only" for="name">名称</label>
	      <input type="text" class="form-control" id="name" 
	         placeholder="请输入名称">
	   </div>
	   <div class="form-group">
	      <label class="sr-only" for="inputfile">文件输入</label>
	      <input type="file" id="inputfile">
	   </div>
	   <div class="checkbox">
	      <label>
	      <input type="checkbox"> 请打勾
	      </label>
	   </div>
	   <button type="submit" class="btn btn-default">提交</button>
	</form>
	
* 默认情况下，Bootstrap 中的 input、select 和 textarea 有 100% 宽度。在使用内联表单时，您需要在表单控件上设置一个宽度。
* 使用 class .sr-only，您可以隐藏内联表单的标签。

### 水平表单
* 水平表单与其他表单不仅标记的数量上不同，而且表单的呈现形式也不同。如需创建一个水平布局的表单，请按下面的几个步骤进行：
* 向父\<form\> 元素添加 class .form-horizontal。
* 把标签和控件放在一个带有 class .form-group 的 \<div\> 中。
* 向标签添加 class .control-label。


		<form class="form-horizontal" role="form">
		   <div class="form-group">
		      <label for="firstname" class="col-sm-2 control-label">名字</label>
		      <div class="col-sm-10">
		         <input type="text" class="form-control" id="firstname" 
		            placeholder="请输入名字">
		      </div>
		   </div>
		   <div class="form-group">
		      <label for="lastname" class="col-sm-2 control-label">姓</label>
		      <div class="col-sm-10">
		         <input type="text" class="form-control" id="lastname" 
		            placeholder="请输入姓">
		      </div>
		   </div>
		   <div class="form-group">
		      <div class="col-sm-offset-2 col-sm-10">
		         <div class="checkbox">
		            <label>
		               <input type="checkbox"> 请记住我
		            </label>
		         </div>
		      </div>
		   </div>
		   <div class="form-group">
		      <div class="col-sm-offset-2 col-sm-10">
		         <button type="submit" class="btn btn-default">登录</button>
		      </div>
		   </div>
		</form>
	

### 支持的表单控件
Bootstrap 支持最常见的表单控件，主要是 *input、textarea、checkbox、radio 和 select。*

#### 输入框（Input）
最常见的表单文本字段是输入框 input。用户可以在其中输入大多数必要的表单数据。Bootstrap 提供了对所有原生的 HTML5 的 input 类型的支持，包括：*text、password、datetime、datetime-local、date、month、time、week、number、email、url、search、tel 和 color*。适当的 type 声明是必需的，这样才能让 input 获得完整的样式。


	<input type="text" class="form-control" placeholder="文本输入">
	
#### 文本框（Textarea）
当您需要进行多行输入的时，则可以使用文本框 textarea。必要时可以改变 rows 属性（较少的行 = 较小的盒子，较多的行 = 较大的盒子）。

	<textarea class="form-control" rows="3"></textarea>	
	
#### 复选框（（Checkbox）和单选框（Radio）
复选框和单选按钮用于让用户从一系列预设置的选项中进行选择。
当创建表单时，如果您想让用户从列表中选择若干个选项时，请使用 checkbox。如果您限制用户只能选择一个选项，请使用 radio。
对一系列复选框和单选框使用 *.checkbox-inline 或 .radio-inline class*，控制它们显示在同一行上。

	<div>
	   <label class="checkbox-inline">
	      <input type="checkbox" id="inlineCheckbox1" value="option1"> 选项 1
	   </label>
	   <label class="checkbox-inline">
	      <input type="checkbox" id="inlineCheckbox2" value="option2"> 选项 2
	   </label>
	   <label class="checkbox-inline">
	      <input type="checkbox" id="inlineCheckbox3" value="option3"> 选项 3
	   </label>
	   <label class="checkbox-inline">
	      <input type="radio" name="optionsRadiosinline" id="optionsRadios3" 
	         value="option1" checked> 选项 1
	   </label>
	   <label class="checkbox-inline">
	      <input type="radio" name="optionsRadiosinline" id="optionsRadios4" 
	         value="option2"> 选项 2
	   </label>
	</div>
	
#### 选择框（Select）
当您想让用户从多个选项中进行选择，但是默认情况下只能选择一个选项时，则使用选择框。
使用 \<select\> 展示列表选项，通常是那些用户很熟悉的选择列表，比如州或者数字。
使用 *multiple="multiple" *允许用户选择多个选项。
	
	<form role="form">
	   <div class="form-group">
	      <label for="name">选择列表</label>
	      <select class="form-control">
	         <option>1</option>
	         <option>2</option>
	         <option>3</option>
	         <option>4</option>
	         <option>5</option>
	      </select>
	
	      <label for="name">可多选的选择列表</label>
	      <select multiple class="form-control">
	         <option>1</option>
	         <option>2</option>
	         <option>3</option>
	         <option>4</option>
	         <option>5</option>
	      </select>
	   </div>
	</form>
	
#### 静态控件
当您需要在一个水平表单内的表单标签后放置纯文本时，请在 \<p\> 上使用 *class .form-control-static*。	

#### 表单控件状态
除了 :focus 状态（即，用户点击 input 或使用 tab 键聚焦到 input 上），Bootstrap 还为禁用的输入框定义了样式，并提供了表单验证的 class。
##### 输入框焦点
当输入框 input 接收到 *:focus* 时，输入框的轮廓会被移除，同时应用 *box-shadow*。
##### 禁用的输入框 input
如果您想要禁用一个输入框 input，只需要简单地添加 *disabled 属性*，这不仅会禁用输入框，还会改变输入框的样式以及当鼠标的指针悬停在元素上时鼠标指针的样式。
##### 禁用的字段集 fieldset
对 \<fieldset\> 添加 disabled 属性来禁用 \<fieldset\> 内的所有控件。
##### 验证状态
Bootstrap 包含了错误、警告和成功消息的验证样式。只需要对父元素简单地添加适当的 *class（.has-warning、 .has-error 或 .has-success）*即可使用验证状态。

	<form class="form-horizontal" role="form">
	   <div class="form-group">
	      <label class="col-sm-2 control-label">聚焦</label>
	      <div class="col-sm-10">
	         <input class="form-control" id="focusedInput" type="text" 
	            value="该输入框获得焦点...">
	      </div>
	   </div>
	   <div class="form-group">
	      <label for="inputPassword" class="col-sm-2 control-label">
	         禁用
	      </label>
	      <div class="col-sm-10">
	         <input class="form-control" id="disabledInput" type="text" 
	            placeholder="该输入框禁止输入..." disabled>
	      </div>
	   </div>
	   <fieldset disabled>
	      <div class="form-group">
	         <label for="disabledTextInput"  class="col-sm-2 control-label">
	            禁用输入（Fieldset disabled）
	         </label>
	         <div class="col-sm-10">
	            <input type="text" id="disabledTextInput" class="form-control" 
	               placeholder="禁止输入">
	         </div>
	      </div>
	      <div class="form-group">
	         <label for="disabledSelect"  class="col-sm-2 control-label">
	            禁用选择菜单（Fieldset disabled）
	         </label>
	         <div class="col-sm-10">
	            <select id="disabledSelect" class="form-control">
	               <option>禁止选择</option>
	            </select>
	         </div>
	      </div>
	   </fieldset>
	   <div class="form-group has-success">
	      <label class="col-sm-2 control-label" for="inputSuccess">
	         输入成功
	      </label>
	      <div class="col-sm-10">
	         <input type="text" class="form-control" id="inputSuccess">
	      </div>
	   </div>
	   <div class="form-group has-warning">
	      <label class="col-sm-2 control-label" for="inputWarning">
	         输入警告
	      </label>
	      <div class="col-sm-10">
	         <input type="text" class="form-control" id="inputWarning">
	      </div>
	   </div>
	   <div class="form-group has-error">
	      <label class="col-sm-2 control-label" for="inputError">
	         输入错误
	      </label>
	      <div class="col-sm-10">
	         <input type="text" class="form-control" id="inputError">
	      </div>
	   </div>
	</form>
	

#### 表单控件大小
您可以分别使用* class .input-lg 和 .col-lg-\* *来设置表单的高度和宽度。	

## 按钮

可用于\<a\>, \<button\>, 或 \<input\> 元素上：

	<!-- 标准的按钮 -->
	<button type="button" class="btn btn-default">默认按钮</button>
	
	<!-- 提供额外的视觉效果，标识一组按钮中的原始动作 -->
	<button type="button" class="btn btn-primary">原始按钮</button>
	
	<!-- 表示一个成功的或积极的动作 -->
	<button type="button" class="btn btn-success">成功按钮</button>
	
	<!-- 信息警告消息的上下文按钮 -->
	<button type="button" class="btn btn-info">信息按钮</button>
	
	<!-- 表示应谨慎采取的动作 -->
	<button type="button" class="btn btn-warning">警告按钮</button>
	
	<!-- 表示一个危险的或潜在的负面动作 -->
	<button type="button" class="btn btn-danger">危险按钮</button>
	
	<!-- 并不强调是一个按钮，看起来像一个链接，但同时保持按钮的行为 -->
	<button type="button" class="btn btn-link">链接按钮</button>


### 按钮大小

	<p>
	   <button type="button" class="btn btn-primary btn-lg">
	      大的原始按钮
	   </button>
	   <button type="button" class="btn btn-default btn-lg">
	      大的按钮
	   </button>
	</p>
	<p>
	   <button type="button" class="btn btn-primary">
	      默认大小的原始按钮
	   </button>
	   <button type="button" class="btn btn-default">
	      默认大小的按钮
	   </button>
	</p>
	<p>
	   <button type="button" class="btn btn-primary btn-sm">
	      小的原始按钮
	   </button>
	   <button type="button" class="btn btn-default btn-sm">
	      小的按钮
	   </button>
	</p>
	<p>
	   <button type="button" class="btn btn-primary btn-xs">
	      特别小的原始按钮
	   </button>
	   <button type="button" class="btn btn-default btn-xs">
	      特别小的按钮
	   </button>
	</p>
	<p>
	   <button type="button" class="btn btn-primary btn-lg btn-block">
	      块级的原始按钮
	   </button>
	   <button type="button" class="btn btn-default btn-lg btn-block">
	      块级的按钮
	   </button>
	</p>
	
	
### 按钮状态

#### 激活状态
按钮在激活时将呈现为被按压的外观（深色的背景、深色的边框、阴影）。

让按钮元素和锚元素呈激活状态的 class：

* 按钮元素	添加 .active class 来显示它是激活的。
* 锚元素	添加 .active class 到 \<a\> 按钮来显示它是激活的。

#### 禁用状态
当您禁用一个按钮时，它的颜色会变淡 50%，并失去渐变。

* 按钮元素	添加 disabled 属性 到 \<button\> 按钮。
* 锚元素	添加 disabled class 到 \<a\> 按钮。注意：该 class 只会改变 \<a\> 的外观，不会改变它的功能。在这里，您需要使用自定义的 JavaScript 来禁用链接。


#### 按钮标签
您可以在 \<a\>、\<button\> 或 \<input\> 元素上使用按钮 class。但是建议您在 \<button\> 元素上使用按钮 class，避免跨浏览器的不一致性问题。

## 图片
Bootstrap 提供了三个可对图片应用简单样式的 class：

* .img-rounded：添加 border-radius:6px 来获得图片圆角。
* .img-circle：添加 border-radius:500px 来让整个图片变成圆形。
* .img-thumbnail：添加一些内边距（padding）和一个灰色的边框。


### <img> 类

* .img-rounded	为图片添加圆角 (IE8 
* .img-circle	将图片变为圆形 (IE8 不支持)
* .img-thumbnail	缩略图功能
* .img-responsive	图片响应式 (将很好地扩展到父元素)

### 响应式图片
通过在 \<img\> 标签添加 .img-responsive 类来让图片支持响应式设计。 图片将很好地扩展到父元素。
.img-responsive 类将 max-width: 100%; 和 height: auto; 样式应用在图片上：

	<img src="cinqueterre.jpg" class="img-responsive" alt="Cinque Terre">

## 辅助类

### 文本

不同的类展示了不同的文本颜色。如果文本是个链接鼠标移动到文本上会变暗.


### 背景
不同的类展示了不同的背景颜色。 如果文本是个链接鼠标移动到文本上会变暗

### 其他

## 响应式实用工具
Bootstrap 提供了一些辅助类，以便更快地实现对移动设备友好的开发。这些可以通过媒体查询结合大型、小型和中型设备，实现内容对设备的显示和隐藏。

需要谨慎使用这些工具，避免在同一个站点创建完全不同的版本。**响应式实用工具目前只适用于块和表切换**。


# bootstrap布局组件
-----
## 字体图标(Glyphicons)

字体图标是在 Web 项目中使用的图标字体。

虽然，Glyphicons Halflings 需要商业许可，但是您可以通过基于项目的 Bootstrap 来免费使用这些图标。为了表示对图标作者的感谢，希望您在使用时加上 GLYPHICONS 网站的链接。


### 用法

使用图标，只需要简单地使用下面的代码即可。请在图标和文本之间保留适当的空间。	

	<span class="glyphicon glyphicon-search"></span>

e.g.

	<p>
	   <button type="button" class="btn btn-default">
	      <span class="glyphicon glyphicon-sort-by-attributes"></span>
	   </button>
	   <button type="button" class="btn btn-default">
	      <span class="glyphicon glyphicon-sort-by-attributes-alt"></span>
	   </button>
	   <button type="button" class="btn btn-default">
	      <span class="glyphicon glyphicon-sort-by-order"></span>
	   </button>
	   <button type="button" class="btn btn-default">
	      <span class="glyphicon glyphicon-sort-by-order-alt"></span>
	   </button>
	</p>
	<button type="button" class="btn btn-default btn-lg">
	  <span class="glyphicon glyphicon-user"></span> User
	</button>
	<button type="button" class="btn btn-default btn-sm">
	  <span class="glyphicon glyphicon-user"></span> User
	</button>
	<button type="button" class="btn btn-default btn-xs">
	  <span class="glyphicon glyphicon-user"></span> User
	</button>
	
### 定制字体图标

可以通过改变字体尺寸、颜色和应用文本阴影来进行定制图标


	定制字体尺寸：通过增加或减少图标的字体尺寸
	
	<button type="button" class="btn btn-primary btn-lg" style="font-size: 60px">
	  <span class="glyphicon glyphicon-user"></span> User
	</button>
	
	
	定制字体颜色
	<button type="button" class="btn btn-primary btn-lg" style="color: rgb(212, 106, 64);">
	  <span class="glyphicon glyphicon-user"></span> User
	</button>
	
	
	应用文本阴影
	<button type="button" class="btn btn-primary btn-lg" style="text-shadow: black 5px 3px 3px;">
	  <span class="glyphicon glyphicon-user"></span> User
	</button>

## 下拉菜单（Dropdowns）

Bootstrap 下拉菜单。下拉菜单是可切换的，是以列表格式显示链接的上下文菜单。这可以通过与 *下拉菜单（Dropdown） JavaScript 插件* 的互动来实现。

* 如需使用下列菜单，只需要在 *class .dropdown* 内加上下拉菜单即可
* 通过向 *.dropdown-menu*添加 *class .pull-right*来向右对齐下拉菜单
* 可以使用 *class dropdown-header *向下拉菜单的标签区域添加标题


## 按钮组

允许多个按钮被堆叠在同一行上。当你想要把按钮对齐在一起时，这就显得非常有用。您可以通过 *Bootstrap 按钮（Button） 插件* 添加可选的 JavaScript 单选框和复选框样式行为。



**(未完，由于不是做前端的，有上述的知识进本开发就够用了)
**



## 参考

[Bootstrap 教程](http://www.runoob.com/bootstrap/bootstrap-tutorial.html)

[Bootstrap中文网](http://www.bootcss.com/)




	
	
	
	
