#CSS入门学习笔记


#什么是CSS
<ul> <li>CSS 指层叠样式表 (<strong>C</strong>ascading <strong>S</strong>tyle <strong>S</strong>heets)</li> <li>样式定义<strong>如何显示</strong> HTML 元素</li> <li>样式通常存储在<strong>样式表</strong>中</li> <li>把样式添加到 HTML 4.0 中，是为了<strong>解决内容与表现分离的问题</strong></li> <li><strong>外部样式表</strong>可以极大提高工作效率</li> <li>外部样式表通常存储在 <strong>CSS 文件</strong>中</li> <li>多个样式定义可<strong>层叠</strong>为一</li> </ul>

#CSS语法

CSS 规则由两个主要的部分构成：选择器，以及一条或多条声明:

![Alt css selector rule](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/css-selector.gif)

选择器通常是您需要改变样式的 HTML 元素。

每条声明由一个属性和一个值组成。

属性（property）是您希望设置的样式属性（style attribute）。每个属性有一个值。属性和值被冒号分开。

CSS声明总是以分号(;)结束，声明组以大括号({})括起来。

CSS 注释
注释是用来解释你的代码，并且可以随意编辑它，浏览器会忽略它。

CSS注释以 "/\*" 开始, 以 "\*/" 结束。

##CSS Id 和 Class

如果你要在HTML元素中设置CSS样式，你需要在元素中设置"id" 和 "class"选择器。

##id 选择器
id 选择器可以为标有特定 id 的 HTML 元素指定特定的样式。

HTML元素以id属性来设置id选择器,CSS 中 id 选择器以 "#" 来定义。
	
	#para1
	{
	text-align:center;
	color:red;
	}

##class 选择器
class 选择器用于描述一组元素的样式，class 选择器有别于id选择器，class可以在多个元素中使用。

class 选择器在HTML中以class属性表示, 在 CSS 中，类选择器以一个点"."号显示。

**e.g.** 所有拥有 center 类的 HTML 元素均为居中。

	.center {text-align:center;}
	
#CSS 创建

##如何插入样式表
插入样式表的方法有三种:

* 外部样式表
* 内部样式表
* 内联样式

###外部样式表
当样式需要应用于很多页面时，外部样式表将是理想的选择。在使用外部样式表的情况下，你可以通过改变一个文件来改变整个站点的外观。

**e.g.** 每个页面使用 <link> 标签链接到样式表。 <link> 标签在（文档的）头部：

	<head>
	<link rel="stylesheet" type="text/css" href="mystyle.css">
	</head>

浏览器会从文件 mystyle.css 中读到样式声明，并根据它来格式文档。

外部样式表可以在任何文本编辑器中进行编辑。文件不能包含任何的 html 标签。样式表应该以 .css 扩展名进行保存。

###内部样式表

当单个文档需要特殊的样式时，就应该使用内部样式表。你可以使用\<style\> 标签在文档头部定义内部样式表，就像这样:

	<head>
	<style>
	hr {color:sienna;}
	p {margin-left:20px;}
	body {background-image:url("xxx.gif");}
	</style>
	</head>


###内联样式
由于要将表现和内容混杂在一起，内联样式会损失掉样式表的许多优势。请慎用这种方法，例如当样式仅需要在一个元素上应用一次时。

要使用内联样式，你需要在相关的标签内使用样式（style）属性。Style 属性可以包含任何 CSS 属性。本例展示如何改变段落的颜色和左外边距：

	<p style="color:sienna;margin-left:20px">This is a paragraph.</p>
	

###多重样式将层叠为一个
样式表允许以多种方式规定样式信息。样式可以规定在单个的 HTML 元素中，在 HTML 页的头元素中，或在一个外部的 CSS 文件中。甚至可以在同一个 HTML 文档内部引用多个外部样式表。

####层叠次序

当同一个 HTML 元素被不止一个样式定义时，会使用哪个样式呢？

一般而言，所有的样式会根据下面的规则层叠于一个新的虚拟样式表中，其中数字 4 拥有最高的优先权。

1. 浏览器缺省设置
2. 外部样式表
3. 内部样式表（位于 <head> 标签内部）
4. 内联样式（在 HTML 元素内部）

因此，内联样式（在 HTML 元素内部）拥有最高的优先权，这意味着它将优先于以下的样式声明： 标签中的样式声明，外部样式表中的样式声明，或者浏览器中的样式声明（缺省值）。


#CSS 背景


CSS 背景属性用于定义HTML元素的背景。

<table class="reference notranslate"> <tbody><tr> <th width="30%" align="left">Property</th> <th width="70%" align="left">描述</th> </tr> <tr> <td><a href="/cssref/css3-pr-background.html">background</a></td> <td>简写属性，作用是将背景属性设置在一个声明中。</td> </tr> <tr> <td><a href="/cssref/pr-background-attachment.html">background-attachment</a></td> <td>背景图像是否固定或者随着页面的其余部分滚动。</td> </tr> <tr> <td><a href="/cssref/pr-background-color.html">background-color</a></td> <td>设置元素的背景颜色。</td> </tr> <tr> <td><a href="/cssref/pr-background-image.html">background-image</a></td> <td>把图像设置为背景。</td> </tr> <tr> <td><a href="/cssref/pr-background-position.html">background-position</a></td> <td>设置背景图像的起始位置。</td> </tr> <tr> <td><a href="/cssref/pr-background-repeat.html">background-repeat</a></td> <td>设置背景图像是否及如何重复。</td> </tr> </tbody></table>


##背景- 简写属性

当使用简写属性时，属性值得顺序为：:

* background-color
* background-image
* background-repeat
* background-attachment
* background-position

以上属性无需全部使用，你可以按照页面的实际需要使用.

#CSS文本属性

<table class="reference"> <tbody><tr> <th width="20%" align="left">属性</th> <th width="80%" align="left">描述</th> </tr> <tr> <td><a href="/cssref/pr-text-color.html">color</a></td> <td>设置文本颜色</td> </tr> <tr> <td><a href="/cssref/pr-text-direction.html">direction</a></td> <td>设置文本方向。</td> </tr> <tr> <td><a href="/cssref/pr-text-letter-spacing.html">letter-spacing</a></td> <td>设置字符间距</td> </tr> <tr> <td><a href="/cssref/pr-dim-line-height.html">line-height</a></td> <td>设置行高</td> </tr> <tr> <td><a href="/cssref/pr-text-text-align.html">text-align</a></td> <td>对齐元素中的文本</td> </tr> <tr> <td><a href="/cssref/pr-text-text-decoration.html">text-decoration</a></td> <td>向文本添加修饰</td> </tr> <tr> <td><a href="/cssref/pr-text-text-indent.html">text-indent</a></td> <td>缩进元素中文本的首行</td> </tr> <tr> <td><a href="/cssref/css3-pr-text-shadow.html">text-shadow</a></td> <td>设置文本阴影</td> </tr> <tr> <td><a href="/cssref/pr-text-text-transform.html">text-transform</a></td> <td>控制元素中的字母</td> </tr> <tr> <td>unicode-bidi</td> <td>&nbsp;</td> </tr> <tr> <td><a href="/cssref/pr-pos-vertical-align.html">vertical-align</a></td> <td>设置元素的垂直对齐</td> </tr> <tr> <td><a href="/cssref/pr-text-white-space.html">white-space</a></td> <td>设置元素中空白的处理方式</td> </tr> <tr> <td><a href="/cssref/pr-text-word-spacing.html">word-spacing</a></td> <td>设置字间距</td> </tr> </tbody></table>

#CSS 字体
CSS字体属性定义字体，加粗，大小，文字样式。

所有CSS字体属性
<table class="reference notranslate"> <tbody><tr> <th width="25%" align="left">Property</th> <th width="75%" align="left">描述</th> </tr> <tr> <td><a href="/cssref/pr-font-font.html">font</a></td> <td>在一个声明中设置所有的字体属性</td> </tr> <tr> <td><a href="/cssref/pr-font-font-family.html">font-family</a></td> <td>指定文本的字体系列</td> </tr> <tr> <td><a href="/cssref/pr-font-font-size.html">font-size</a></td> <td>指定文本的字体大小</td> </tr> <tr> <td><a href="/cssref/pr-font-font-style.html">font-style</a></td> <td>指定文本的字体样式</td> </tr> <tr> <td><a href="/cssref/pr-font-font-variant.html">font-variant</a></td> <td>以小型大写字体或者正常字体显示文本。</td> </tr> <tr> <td><a href="/cssref/pr-font-weight.html">font-weight</a></td> <td>指定字体的粗细。</td> </tr> </tbody></table>

#CSS 链接

不同的链接可以有不同的样式。

##链接样式
链接的样式，可以用任何CSS属性（如颜色，字体，背景等）。

特别的链接，可以有不同的样式，这取决于他们是什么状态。

这四个链接状态是：

* a:link - 正常，未访问过的链接
* a:visited - 用户已访问过的链接
* a:hover - 当用户鼠标放在链接上时
* a:active - 链接被点击的那一刻

**e.g. **
	
	a:link {color:#FF0000;}      /* unvisited link */
	a:visited {color:#00FF00;}  /* visited link */
	a:hover {color:#FF00FF;}  /* mouse over link */
	a:active {color:#0000FF;}  /* selected link */

当设置为若干链路状态的样式，也有一些顺序规则：

* a:hover 必须跟在 a:link 和 a:visited后面
* a:active 必须跟在 a:hover后面


#CSS 列表

CSS列表属性作用如下：

* 设置不同的列表项标记为有序列表
* 设置不同的列表项标记为无序列表
* 设置列表项标记为图像

<table class="reference"> <tbody><tr> <th width="20%" align="left">属性</th> <th width="80%" align="left">描述</th> </tr> <tr> <td><a href="/cssref/pr-list-style.html">list-style</a></td> <td>简写属性。用于把所有用于列表的属性设置于一个声明中</td> </tr> <tr> <td><a href="/cssref/pr-list-style-image.html">list-style-image</a></td> <td>将图象设置为列表项标志。</td> </tr> <tr> <td><a href="/cssref/pr-list-style-position.html">list-style-position</a></td> <td>设置列表中列表项标志的位置。</td> </tr> <tr> <td><a href="/cssref/pr-list-style-type.html">list-style-type</a></td> <td>设置列表项标志的类型。</td> </tr> </tbody></table>

#CSS 表格
##表格边框
指定CSS表格边框，使用border属性。
##折叠边框
border-collapse 属性设置表格的边框是否被折叠成一个单一的边框或隔开
##表格宽度和高度
Width和height属性定义表格的宽度和高度。

##表格文字对齐
表格中的文本对齐和垂直对齐属性。

text-align属性设置水平对齐方式，像左，右，或中心

##表格填充
如果在表的内容中控制空格之间的边框，应使用td和th元素的填充属性

#CSS 框模型(Box Model)
所有HTML元素可以看作盒子，在CSS中，"box model"这一术语是用来设计和布局时使用。

CSS盒模型本质上是一个盒子，封装周围的HTML元素，它包括：边距，边框，填充，和实际内容。

盒模型允许我们在其它元素和周围元素边框之间的空间放置元素。
![box model](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/css-box-model.gif)

* Margin - 清除边框区域。Margin没有背景颜色，它是完全透明
* Border - 边框周围的填充和内容。边框是受到盒子的背景颜色影响
* Padding - 清除内容周围的区域。会受到框中填充的背景颜色影响
* Content - 盒子的内容，显示文本和图像

最终元素的总宽度计算公式是这样的：

	总元素的宽度=宽度+左填充+右填充+左边框+右边框+左边距+右边距

元素的总高度最终计算公式是这样的：

	总元素的高度=高度+顶部填充+底部填充+上边框+下边框+上边距+下边距


#CSS 边框属性
<table class="reference"> <tbody><tr> <th>属性</th> <th>描述</th> </tr> <tr> <td><a title="CSS border 属性" href="/cssref/pr-border.html">border</a></td> <td>简写属性，用于把针对四个边的属性设置在一个声明。</td> </tr> <tr> <td><a title="CSS border-style 属性" href="/cssref/pr-border-style.html">border-style</a></td> <td>用于设置元素所有边框的样式，或者单独地为各边设置边框样式。</td> </tr> <tr> <td><a title="CSS border-width 属性" href="/cssref/pr-border-width.html">border-width</a></td> <td>简写属性，用于为元素的所有边框设置宽度，或者单独地为各边边框设置宽度。</td> </tr> <tr> <td><a title="CSS border-color 属性" href="/cssref/pr-border-color.html">border-color</a></td> <td>简写属性，设置元素的所有边框中可见部分的颜色，或为 4 个边分别设置颜色。</td> </tr> <tr> <td><a title="CSS border-bottom 属性" href="/cssref/pr-border-bottom.html">border-bottom</a></td> <td>简写属性，用于把下边框的所有属性设置到一个声明中。</td> </tr> <tr> <td><a title="CSS border-bottom-color 属性" href="/cssref/pr-border-bottom-color.html">border-bottom-color</a></td> <td>设置元素的下边框的颜色。</td> </tr> <tr> <td><a title="CSS border-bottom-style 属性" href="/cssref/pr-border-bottom-style.html">border-bottom-style</a></td> <td>设置元素的下边框的样式。</td> </tr> <tr> <td><a title="CSS border-bottom-width 属性" href="/cssref/pr-border-bottom-width.html">border-bottom-width</a></td> <td>设置元素的下边框的宽度。</td> </tr> <tr> <td><a title="CSS border-left 属性" href="/cssref/pr-border-left.html">border-left</a></td> <td>简写属性，用于把左边框的所有属性设置到一个声明中。</td> </tr> <tr> <td><a title="CSS border-left-color 属性" href="/cssref/pr-border-left-color.html">border-left-color</a></td> <td>设置元素的左边框的颜色。</td> </tr> <tr> <td><a title="CSS border-left-style 属性" href="/cssref/pr-border-left-style.html">border-left-style</a></td> <td>设置元素的左边框的样式。</td> </tr> <tr> <td><a title="CSS border-left-width 属性" href="/cssref/pr-border-left-width.html">border-left-width</a></td> <td>设置元素的左边框的宽度。</td> </tr> <tr> <td><a title="CSS border-right 属性" href="/cssref/pr-border-right.html">border-right</a></td> <td>简写属性，用于把右边框的所有属性设置到一个声明中。</td> </tr> <tr> <td><a title="CSS border-right-color 属性" href="/cssref/pr-border-right-color.html">border-right-color</a></td> <td>设置元素的右边框的颜色。</td> </tr> <tr> <td><a title="CSS border-right-style 属性" href="/cssref/pr-border-right-style.html">border-right-style</a></td> <td>设置元素的右边框的样式。</td> </tr> <tr> <td><a title="CSS border-right-width 属性" href="/cssref/pr-border-right-width.html">border-right-width</a></td> <td>设置元素的右边框的宽度。</td> </tr> <tr> <td><a title="CSS border-top 属性" href="/cssref/pr-border-top.html">border-top</a></td> <td>简写属性，用于把上边框的所有属性设置到一个声明中。</td> </tr> <tr> <td><a title="CSS border-top-color 属性" href="/cssref/pr-border-top-color.html">border-top-color</a></td> <td>设置元素的上边框的颜色。</td> </tr> <tr> <td><a title="CSS border-top-style 属性" href="/cssref/pr-border-top-style.html">border-top-style</a></td> <td>设置元素的上边框的样式。</td> </tr> <tr> <td><a title="CSS border-top-width 属性" href="/cssref/pr-border-top-width.html">border-top-width</a></td> <td>设置元素的上边框的宽度。</td> </tr> </tbody></table>

#CSS Outlines

轮廓（outline）是绘制于元素周围的一条线，位于边框边缘的外围，可起到突出元素的作用。

轮廓（outline）属性指定了样式，颜色和外边框的宽度。

<table width="100%" cellspacing="0" cellpadding="0" border="1" class="reference"> <tbody><tr> <th width="20%" align="left">属性</th> <th width="53%" align="left">说明</th> <th width="20%" align="left">值</th> <th width="7%" align="left">CSS</th> </tr> <tr> <td><a href="/cssref/pr-outline.html">outline</a> </td> <td>在一个声明中设置所有的外边框属性</td> <td><i>outline-color<br> outline-style<br> outline-width<br> </i>inherit</td> <td>2</td> </tr> <tr> <td> <a href="/cssref/pr-outline-color.html"> outline-color</a> </td> <td>设置外边框的颜色</td> <td><i>color-name<br> hex-number<br> rgb-number<br> </i>invert<br> inherit</td> <td>2</td> </tr> <tr> <td> <a href="/cssref/pr-outline-style.html"> outline-style</a> </td> <td>设置外边框的样式</td> <td>none<br> dotted<br> dashed<br> solid<br> double<br> groove<br> ridge<br> inset<br> outset<br> inherit</td> <td>2</td> </tr> <tr> <td> <a href="/cssref/pr-outline-width.html"> outline-width</a> </td> <td>设置外边框的宽度</td> <td>thin<br> medium<br> thick<br> <i>length<br> </i>inherit</td> <td>2</td> </tr> </tbody></table>

#CSS Margin(外边距)

CSS Margin(外边距)属性定义元素周围的空间。

margin清除周围的元素（外边框）的区域。margin没有背景颜色，是完全透明的

margin可以单独改变元素的上，下，左，右边距。也可以一次改变所有的属性。

<table class="reference"> <tbody><tr> <th>属性</th> <th>描述</th> </tr> <tr> <td><a href="/cssref/pr-margin.html" title="CSS margin 属性">margin</a></td> <td>简写属性。在一个声明中设置所有外边距属性。</td> </tr> <tr> <td><a href="/cssref/pr-margin-bottom.html" title="CSS margin-bottom 属性">margin-bottom</a></td> <td>设置元素的下外边距。</td> </tr> <tr> <td><a href="/cssref/pr-margin-left.html" title="CSS margin-left 属性">margin-left</a></td> <td>设置元素的左外边距。</td> </tr> <tr> <td><a href="/cssref/pr-margin-right.html" title="CSS margin-right 属性">margin-right</a></td> <td>设置元素的右外边距。</td> </tr> <tr> <td><a href="/cssref/pr-margin-top.html" title="CSS margin-top 属性">margin-top</a></td> <td>设置元素的上外边距。</td> </tr> </tbody></table>


#CSS Padding（填充）

CSS Padding（填充）属性定义元素边框与元素内容之间的空间。

当元素的 Padding（填充）（内边距）被清除时，所"释放"的区域将会受到元素背景颜色的填充。

单独使用填充属性可以改变上下左右的填充。缩写填充属性也可以使用，一旦改变一切都改变。

<table width="100%" cellspacing="0" cellpadding="0" border="1" class="reference"> <tbody><tr> <th width="20%" align="left">属性</th> <th width="80%" align="left">说明</th> </tr> <tr> <td><a href="/cssref/pr-padding.html">padding</a></td> <td>使用缩写属性设置在一个声明中的所有填充属性</td> </tr> <tr> <td><a href="/cssref/pr-padding-bottom.html">padding-bottom</a></td> <td>设置元素的底部填充</td> </tr> <tr> <td><a href="/cssref/pr-padding-left.html">padding-left</a></td> <td>设置元素的左部填充</td> </tr> <tr> <td><a href="/cssref/pr-padding-right.html">padding-right</a></td> <td>设置元素的右部填充</td> </tr> <tr> <td><a href="/cssref/pr-padding-top.html">padding-top</a></td> <td>设置元素的顶部填充</td> </tr> </tbody></table>

#CSS 分组 和 嵌套 选择器
##Grouping Selectors
在样式表中有很多具有相同样式的元素。
为了尽量减少代码，你可以使用分组选择器。
每个选择器用逗号分隔.

**e.g.**
	
	h1,h2,p
	{
	color:green;
	}

##嵌套选择器
它可能适用于选择器内部的选择器的样式。

在下面的例子，为所有p元素指定一个样式，为所有元素指定一个class="marked"的样式，并仅用于class="标记"，类内的p元素指定第三个样式：

	p
	{
	color:blue;
	text-align:center;
	}
	.marked
	{
	background-color:red;
	}
	.marked p
	{
	color:white;
	}

#CSS 尺寸 (Dimension)

CSS 尺寸 (Dimension) 属性允许你控制元素的高度和宽度。同样，它允许你增加行间距。

<table class="reference"> <tbody><tr> <th>属性</th> <th>描述</th> </tr> <tr> <td><a href="/cssref/pr-dim-height.html">height</a></td> <td>设置元素的高度。</td> </tr> <tr> <td><a href="/cssref/pr-dim-line-height.html">line-height</a></td> <td>设置行高。</td> </tr> <tr> <td><a href="/cssref/pr-dim-max-height.html">max-height</a></td> <td>设置元素的最大高度。</td> </tr> <tr> <td><a href="/cssref/pr-dim-max-width.html">max-width</a></td> <td>设置元素的最大宽度。</td> </tr> <tr> <td><a href="/cssref/pr-dim-min-height.html">min-height</a></td> <td>设置元素的最小高度。</td> </tr> <tr> <td><a href="/cssref/pr-dim-min-width.html">min-width</a></td> <td>设置元素的最小宽度。</td> </tr> <tr> <td><a href="/cssref/pr-dim-width.html">width</a></td> <td>设置元素的宽度。</td> </tr> </tbody></table>

#CSS Display(显示) 与 Visibility（可见性）

display属性设置一个元素应如何显示，visibility属性指定一个元素应可见还是隐藏。

##隐藏元素 - display:none或visibility:hidden
隐藏一个元素可以通过把display属性设置为"none"，或把visibility属性设置为"hidden"。但是请注意，这两种方法会产生不同的结果。

visibility:hidden可以隐藏某个元素，但隐藏的元素仍需占用与未隐藏之前一样的空间。也就是说，该元素虽然被隐藏了，但仍然会影响布局。

##CSS Display - 块和内联元素
块元素是一个元素，占用了全部宽度，在前后都是换行符。

块元素的例子：

* \<h1\>
* \<p\>
* \<div\>

内联元素只需要必要的宽度，不强制换行。

内联元素的例子：

* \<span\>
* \<a\>


#Positioning(定位)
CSS定位属性允许你为一个元素定位。它也可以将一个元素放在另一个元素后面，并指定一个元素的内容太大时，应该发生什么。

元素可以使用的顶部，底部，左侧和右侧属性定位。然而，这些属性无法工作，除非是先设定position属性。他们也有不同的工作方式，这取决于定位方法.

有四种不同的定位方法。

##Static 定位
HTML元素的默认值，即没有定位，元素出现在正常的流中。

静态定位的元素不会受到top, bottom, left, right影响。

##Fixed 定位
元素的位置相对于浏览器窗口是固定位置。

即使窗口是滚动的它也不会移动：


##Relative 定位
相对定位元素的定位是相对其正常位置。

##Absolute 定位

<table class="reference"> <tbody><tr> <th width="25%" align="left">属性</th> <th width="43%" align="left">说明</th> <th width="27%" align="left">值</th> <th width="5%" align="left">CSS</th> </tr> <tr> <td><a href="/cssref/pr-pos-bottom.html">bottom</a></td> <td>定义了定位元素下外边距边界与其包含块下边界之间的偏移。</td> <td>auto<br> <i>length<br> %<br> </i>inherit</td> <td>2</td> </tr> <tr> <td><a href="/cssref/pr-pos-clip.html">clip</a></td> <td>剪辑一个绝对定位的元素</td> <td><i>shape<br> </i>auto<br> inherit</td> <td>2</td> </tr> <tr> <td><a href="/cssref/pr-class-cursor.html">cursor</a></td> <td>显示光标移动到指定的类型</td> <td><span class="value-inst-uri noxref"><i>url</i><br> </span>auto<br> crosshair<br> default<br> pointer<br> move<br> e-resize<br> ne-resize<br> nw-resize<br> n-resize<br> se-resize<br> sw-resize<br> s-resize<br> w-resize<br> text<br> wait<br> help</td> <td>2</td> </tr> <tr> <td><a href="/cssref/pr-pos-left.html">left</a></td> <td>定义了定位元素左外边距边界与其包含块左边界之间的偏移。</td> <td>auto<br> <i>length<br> %<br> </i>inherit</td> <td>2</td> </tr> <tr> <td><a href="/cssref/pr-pos-overflow.html">overflow</a><br> </td> <td>设置当元素的内容溢出其区域时发生的事情。</td> <td>auto<br> hidden<br> scroll<br> visible<br> inherit</td> <td>2</td> </tr> <tr> <td><a href="/cssref/pr-class-position.html">position</a></td> <td>指定元素的定位类型</td> <td>absolute<br> fixed<br> relative<br> static<br> inherit</td> <td>2</td> </tr> <tr> <td><a href="/cssref/pr-pos-right.html">right</a></td> <td>定义了定位元素右外边距边界与其包含块右边界之间的偏移。</td> <td>auto<br> <i>length<br> %<br> </i>inherit</td> <td>2</td> </tr> <tr> <td><a href="/cssref/pr-pos-top.html">top</a></td> <td>定义了一个定位元素的上外边距边界与其包含块上边界之间的偏移。</td> <td>auto<br> <i>length<br> %<br> </i>inherit</td> <td>2</td> </tr> <tr> <td><a href="/cssref/pr-pos-z-index.html">z-index</a></td> <td>设置元素的堆叠顺序</td> <td> <i>number<br> </i>auto<br> inherit</td> <td>2</td> </tr> </tbody></table>

#Float(浮动)
CSS 的 Float（浮动），会使元素向左或向右移动，其周围的元素也会重新排列。

Float（浮动），往往是用于图像，但它在布局时一样非常有用。

##元素怎样浮动
元素的水平方向浮动，意味着元素只能左右移动而不能上下移动。

一个浮动元素会尽量向左或向右移动，直到它的外边缘碰到包含框或另一个浮动框的边框为止。

浮动元素之后的元素将围绕它。

浮动元素之前的元素将不会受到影响。

##CSS 中所有的浮动属性
"CSS" 列中的数字表示不同的 CSS 版本（CSS1 或 CSS2）定义了该属性。
<table class="reference notranslate"> <tbody><tr> <th width="25%" align="left">属性</th> <th width="43%" align="left">描述</th> <th width="27%" align="left">值</th> <th width="5%" align="left">CSS</th> </tr> <tr> <td><a href="/cssref/pr-class-clear.html">clear</a></td> <td>指定不允许元素周围有浮动元素。</td> <td>left<br> right<br> both<br> none<br> inherit</td> <td>1</td> </tr> <tr> <td><a href="/cssref/pr-class-float.html">float</a></td> <td>指定一个盒子（元素）是否可以浮动。</td> <td>left<br> right<br> none<br> inherit</td> <td>1</td> </tr> </tbody></table>


#CSS 水平对齐(Horizontal Align)

#CSS组合选择符
包括各种简单选择符的组合方式。
在 CSS3 中包含了四种组合方式:

* 后代选取器(以空格分隔)
* 子元素选择器(以大于号分隔）
* 相邻兄弟选择器（以加号分隔）
* 普通兄弟选择器（以破折号分隔）


#CSS 伪类(Pseudo-classes)

CSS伪类是用来添加一些选择器的特殊效果。

##语法
伪类的语法：

	selector:pseudo-class {property:value;}
CSS类也可以使用伪类：

	selector.class:pseudo-class {property:value;}

所有CSS伪类/元素
<table width="100%" cellspacing="0" cellpadding="0" border="1" id="table13" class="reference"> <tbody><tr> <th width="20%" align="left">选择器</th> <th width="17%" align="left">示例</th> <th width="63%" align="left">示例说明</th> </tr> <tr> <td><a href="/cssref/sel-link.html">:link</a></td> <td class="notranslate">a:link</td> <td>选择所有未访问链接</td> </tr> <tr> <td><a href="/cssref/sel-visited.html">:visited</a></td> <td class="notranslate">a:visited</td> <td>选择所有访问过的链接</td> </tr> <tr> <td><a href="/cssref/sel-active.html">:active</a></td> <td class="notranslate">a:active</td> <td>选择正在活动链接</td> </tr> <tr> <td><a href="/cssref/sel-hover.html">:hover</a></td> <td class="notranslate">a:hover</td> <td>把鼠标放在链接上的状态</td> </tr> <tr> <td><a href="/cssref/sel-focus.html">:focus</a></td> <td class="notranslate">input:focus</td> <td>选择元素输入后具有焦点</td> </tr> <tr> <td><a href="/cssref/sel-firstletter.html">:first-letter</a></td> <td class="notranslate">p:first-letter</td> <td>选择每个&lt;p&gt; 元素的第一个字母</td> </tr> <tr> <td><a href="/cssref/sel-firstline.html">:first-line</a></td> <td class="notranslate">p:first-line</td> <td>选择每个&lt;p&gt; 元素的第一行</td> </tr> <tr> <td><a href="/cssref/sel-firstchild.html">:first-child</a></td> <td class="notranslate">p:first-child</td> <td>选择器匹配属于任意元素的第一个子元素的 &lt;]p&gt; 元素</td> </tr> <tr> <td><a href="/cssref/sel-before.html">:before</a></td> <td class="notranslate">p:before</td> <td>Insert content before every &lt;p&gt; element</td> </tr> <tr> <td><a href="/cssref/sel-after.html">:after</a></td> <td class="notranslate">p:after</td> <td>在每个&lt;p&gt;元素之前插入内容</td> </tr> <tr> <td><a href="/cssref/sel-lang.html">:lang(<i>language</i>)</a></td> <td class="notranslate">p:lang(it)</td> <td>为&lt;p&gt;元素的lang属性选择一个开始值</td> </tr> </tbody></table>


#CSS 伪元素

CSS伪元素是用来添加一些选择器的特殊效果。

##语法
伪元素的语法：

	selector:pseudo-element {property:value;}
CSS类也可以使用伪元素：

	selector.class:pseudo-element {property:value;}

所有CSS伪类/元素	
<table width="100%" cellspacing="0" cellpadding="0" border="1" id="table13" class="reference"> <tbody><tr> <th width="20%" align="left">选择器</th> <th width="17%" align="left">示例</th> <th width="63%" align="left">示例说明</th> </tr> <tr> <td><a href="/cssref/sel-link.html">:link</a></td> <td class="notranslate">a:link</td> <td>选择所有未访问链接</td> </tr> <tr> <td><a href="/cssref/sel-visited.html">:visited</a></td> <td class="notranslate">a:visited</td> <td>选择所有访问过的链接</td> </tr> <tr> <td><a href="/cssref/sel-active.html">:active</a></td> <td class="notranslate">a:active</td> <td>选择正在活动链接</td> </tr> <tr> <td><a href="/cssref/sel-hover.html">:hover</a></td> <td class="notranslate">a:hover</td> <td>把鼠标放在链接上的状态</td> </tr> <tr> <td><a href="/cssref/sel-focus.html">:focus</a></td> <td class="notranslate">input:focus</td> <td>选择元素输入后具有焦点</td> </tr> <tr> <td><a href="/cssref/sel-firstletter.html">:first-letter</a></td> <td class="notranslate">p:first-letter</td> <td>选择每个&lt;p&gt; 元素的第一个字母</td> </tr> <tr> <td><a href="/cssref/sel-firstline.html">:first-line</a></td> <td class="notranslate">p:first-line</td> <td>选择每个&lt;p&gt; 元素的第一行</td> </tr> <tr> <td><a href="/cssref/sel-firstchild.html">:first-child</a></td> <td class="notranslate">p:first-child</td> <td>选择器匹配属于任意元素的第一个子元素的 &lt;]p&gt; 元素</td> </tr> <tr> <td><a href="/cssref/sel-before.html">:before</a></td> <td class="notranslate">p:before</td> <td>在每个&lt;p&gt;元素之前插入内容</td> </tr> <tr> <td><a href="/cssref/sel-after.html">:after</a></td> <td class="notranslate">p:after</td> <td>在每个&lt;p&gt;元素之后插入内容</td> </tr> <tr> <td><a href="/cssref/sel-lang.html">:lang(<i>language</i>)</a></td> <td class="notranslate">p:lang(it)</td> <td>为&lt;p&gt;元素的lang属性选择一个开始值</td> </tr> </tbody></table>		

#导航栏
熟练使用导航栏，对于任何网站都非常重要。

使用CSS你可以转换成好看的导航栏而不是枯燥的HTML菜单。

#CSS 媒体类型

媒体类型允许你指定文件将如何在不同媒体呈现。该文件可以以不同的方式显示在屏幕上，在纸张上，或听觉浏览器等等。 

##媒体类型
一些CSS属性只设计了某些媒体。例如"voice-family"属性是专为听觉用户代理。其他一些属性可用于不同的媒体类型。例如，"font-size"属性可用于屏幕和印刷媒体，但有不同的值。屏幕和纸上的文件不同，通常需要一个更大的字体，sans - serif字体比较适合在屏幕上阅读，而serif字体更容易在纸上阅读。

##@media 规则
@media 规则允许在相同样式表为不同媒体设置不同的样式。


##其他媒体类型
注意：媒体类型名称不区分大小写。

<table class="reference"> <tbody><tr> <th>媒体类型</th> <th>描述</th> </tr> <tr> <td>all</td> <td>用于所有的媒体设备。</td> </tr> <tr> <td>aural</td> <td>用于语音和音频合成器。</td> </tr> <tr> <td>braille</td> <td>用于盲人用点字法触觉回馈设备。</td> </tr> <tr> <td>embossed</td> <td>用于分页的盲人用点字法打印机。</td> </tr> <tr> <td>handheld</td> <td>用于小的手持的设备。</td> </tr> <tr> <td>print</td> <td>用于打印机。</td> </tr> <tr> <td>projection</td> <td>用于方案展示，比如幻灯片。</td> </tr> <tr> <td>screen</td> <td>用于电脑显示器。</td> </tr> <tr> <td>tty</td> <td>用于使用固定密度字母栅格的媒体，比如电传打字机和终端。</td> </tr> <tr> <td>tv</td> <td>用于电视机类型的设备。</td> </tr> </tbody></table>

#CSS 总结

对于如何使用 CSS 来添加背景、格式化文本、以及格式化边框，并定义元素的填充和边距都有了解。

同时，如何定位元素、控制元素的可见性和尺寸、设置元素的形状、将一个元素置于另一个之后，以及向某些选择器添加特殊的效果，比如链接。








	


	

