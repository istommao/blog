title: css知识点
date: 2016-06-30 00:25:00
tags: 
- css

# css知识点

css知识点，精华部分可在对应的 **快速指南** 小节中找到。


## 基础

详见：

* [MDN](https://developer.mozilla.org/zh-CN/docs/Web/CSS)
* [CSS美化自己的完美网页](http://www.cnblogs.com/aylin/p/5626068.html)
* [菜鸟css教程](http://www.runoob.com/css/css-intro.html)



## 布局

* [css布局相关](css布局相关.md)


## less和sass

* [less学习](less学习.md)
* [sass学习](sass学习.md)

## 快速指南

### css引入方式

* 行内式：`style`属性 

		<p style="background-color: #fff">abc</p>
		
* 嵌入式: `head`标签中的`style`标签

		<head>
			<style type="text/css">
			...此处写CSS样式
			</style>
		</head>

* 导入式: 将一个独立的`.css`文件引入HTML文件中，类似于`嵌入式`，只是在`style`标签写样式，而是通过导入方式

		<head>
			<style type="text/css">
			@import "CSS引入/css样式3.css";  # 导入css文件路径
			</style>
		</head>

* 链接式： `head`标签中的`link`标签

		<head>
			<link rel="stylesheet" href="css样式3.css" />
		</head>

注：

* 使用链接式时与导入式不同的是它会以网页文件主体装载前装载CSS文件

### css选择器

优先级: `标签选择器<类选择器<id选择器<style属性`

#### 基础选择器

基础选择器有： `*`、标签、类`.`、id `#`

* 匹配任何元素用`*`， 格式 `* {样式}`
* 标签选择器: 格式 `标签 {样式}`

	所有使用`p`标签使用该样式：
	
		p { ... }
		
* 类选择器: 格式 `.类名 {样式}`

	标签中，通过属性`class`指定为`类名`，这也是用的最多的方式。
	
	定义样式：
	
		.mytable-bg-color {...}
		
	在元素中通过`class属性`使用：
	
		<div class="mytable-bg-color"> ... </div>
	
* id选择器: 格式 `# {样式}`	

	定义样式：
	
		#mytable-id {...}
		
	在元素中通过`id属性`使用
	
		<div id="mytable-id"> ... </div>
	
#### 组合选择器

* 多元素选择器：`,`逗号分隔

		p, div {...}
		
* 后代选择器: `空格`分隔

	所有包含在div标签里p标签样式：
	
		div p {}	
	
* 子元素选择器：`>`大于号

	只能是div的直接子元素
	
		div > p {}
		
* 相邻元素选择器：`+`加号

#### 伪类选择器
		
伪类选择器： 专用于控制链接的显示效果。伪类指的是标签的不同状态

伪类选择器：`lvha`

* `a:link`
* `a:visited`
* `a:hover`
* `a:active`

#### 属性选择器

* `[]`中括号，指定某个属性，属性值全`=`

		[title] { color:blue; }
		[title="hello"]
		
* 属性值包含匹配：`~=`

		[title~=hello] { color:blue; }
		
* 属性值前缀匹配：`|=`			
	

		



### css常用属性

#### 字体属性`font-*`

简写：`font`

分开写：

* `font-size`: 字体大小，如`20px/50%/larger`
* `font-family`: 字体系列，如`Serif`
* `font-weight`: 字体粗细，如`bold、700`
* `font-style`: 字体样式

##### 字体大小单位

* 像素：px
* em： 1em和当前字体大小相等，默认：1em = 16px
* 百分比：在所有浏览器的解决方案中，设置 `<body>`元素的默认字体大小的是百分比


#### 背景属性 `background-*`

简写：`background`

分开写：

* `background-color`
* `background-image`
* `background-repeat`
* `background-position`

#### 文本属性

* `color`：文本颜色
* `direction`：
* `letter-spacing`：
* `word-spacing`:
* `line-height`: 行高
* `text-align`: 元素水平对齐方式
* `vertical-align`: 元素垂直对齐

	比如一个元素内包含多个行内元素，该属性可以设置这几个行内元素的对齐方式

##### 颜色属性  `color`

举例：

	<div style="color:blueviolet">ppppp</div> 输入颜色英文单词
	<div style="color:#ffee33">ppppp</div> 16进制颜色样式
	<div style="color:rgb(255,0,0)">ppppp</div> 红绿蓝三原色按顺序
	<div style="color:rgba(255,0,0,0.5)">ppppp</div> a代指透明度
	
#### 盒子模型

* 所有HTML元素可以看作盒子，在CSS中，"box model"这一术语是用来设计和布局时使用。
* CSS盒模型本质上是一个盒子，封装周围的HTML元素，它包括：外边距(`margin`)，边框（`border`），填充/内边距（`padding`），和内容(`content`)

![image](http://images2015.cnblogs.com/blog/938876/201606/938876-20160629145809765-372812017.png)

* 内容的宽度和高度：`width` 和 `height`
* 总元素的宽度=`宽度+左填充+右填充+左边框+右边框+左边距+右边距`
* 总元素的高度=`高度+顶部填充+底部填充+上边框+下边框+上边距+下边距`

##### 浏览器兼容性

	
##### 边框属性 `border`

简写：`border`

分开写：

* `border-style`:
* `border-color`:
* `border-width`:

各个边：

* `border-bottom`和`border-bottom-color/style/width`
* `border-left/top/right`...
* ...

##### 轮廓：`outline`

* 位于边框边缘的外围
* 简写：`outline`
* 分开写：

	* `outline-color`
	* `outline-style`
	* `outline-width`


##### 外边距：`margin`

* margin清除周围的元素（外边框）的区域。margin没有`背景颜色，是完全透明`的
* 简写：`margin`
* 分开写：

	* `margin-left`
	* `margin-top`
	* `margin-right`
	* `margin-bottom`

##### 填充

* 颜色被背景颜色填充
* 简写：`padding`
* 分开写：

	* `padding-left`
	* `padding-top`
	* `padding-right`
	* `padding-bottom`


#### 布局属性

* 盒子模型: margin, border, padding
* display属性
* positon属性 和 top, bottom, left, right, z-index
* float属性
* contenx: text-align, vertical-align, line-height




##### 文档流



##### 文本布局

有两个属性可以指定元素内容的对齐方式。这两个属性可以应用于任何文本类内容，不只是纯文本。 需要注意的是，它们会被元素的子元素继承

* `text-align`: 内容对齐
* `text-indent`: 内容缩进

##### float

* 控制元素水平移动，强制元素靠左或靠右。 这是控制元素位置和大小的简单方法
* 一个浮动元素会尽量向左或向右移动，直到它的外边缘碰到包含框或另一个浮动框的边框为止
* 浮动元素之后的元素将围绕它
* 浮动元素之前的元素将不会受到影响
* 如果图像是右浮动，下面的文本流将环绕在它左边
* 属性值：`left`, `right`, `none(默认值，不浮动)`, `inherit: 从父元素继承`


##### clear

* 可以使用 `clear` 属性来避免其它元素受到浮动效果的影响
* `clear` 属性指定元素两侧不能出现浮动元素
* 属性值：`left`, `right`,`both`,`none`, `inherit`

##### display

* 属性值：`block，显示为块级元素`、`block`、`inline，默认，行内元素`，`inherit`、`inline-block`
* 新属性：`flex`，新的布局方式：[flex布局学习](./flex学习.md)
* 隐藏元素: `display:none`或`visibility:hidden`。前者隐藏的元素不会占用任何空间。

##### position

设置元素位置

* `relative`：相对于其原来位置移动

	遵循正常文档流，但将依据top，right，bottom，left等属性在正常文档流中偏移位置。而其层叠通过z-index属性定义。

* `fixed`： 相对窗口的位置
* `absolute`: 相对于其父元素的确切位置

	脱离正常文档流，使用top，right，bottom，left等属性进行绝对定位。而其层叠通过z-index属性定义。
	
	只有在父元素使用 `relative`, `fixed` or `absolute` 时才有效。你可以为任何父元素指定 `position: relative;`因为它不会产生移动。
	
* `static`: 默认值，当明确要关闭位置属性时使用。

	脱离正常文档流，使用top，right，bottom，left等属性无效。
	
	一个元素若设置了 `position:absolute` 或 `fixed`; 则该元素就不能设置`float`。这是一个常识性的知识点，因为这是两个不同的流。
	
* 和 `position 属性`(除了 `static`)一起使用的, 有下列属性: `top`, `right`, `bottom`, `left`, `width`, `height`, `z-index` 通过设置它们来指定元素的`位置`或`大小`

		img
		{
			position:absolute;
			left:0px;
			top:0px;
			z-index:-1;
		}
	

#### 尺寸属性：控制元素高度和宽度

* `height`
* `max-height`
* `min-height`
* `width`
* `max-width`
* `min-width`
* `line-height`


#### 列表	

* `list-style-type`

#### 表格

* `border-collapse`



### 布局

* [css布局相关](css布局相关.md) 的快速指南小节
