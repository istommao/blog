title: css传统布局方式
date: 2016-06-27 21:59:00
tags:
- css
- flex

# css传统布局方式

* 盒子模型: margin, border, padding
* display属性
* positon属性 和 top, bottom, left, right, z-index
* float属性
* contenx: text-align, vertical-align, line-height



## 盒子模型文档流

### 盒子模型

* 所有HTML元素可以看作盒子，在CSS中，"box model"这一术语是用来设计和布局时使用。
* CSS盒模型本质上是一个盒子，封装周围的HTML元素，它包括：外边距(`margin`)，边框（`border`），填充/内边距（`padding`），和内容(`content`)

![image](http://images2015.cnblogs.com/blog/938876/201606/938876-20160629145809765-372812017.png)

* 内容的宽度和高度：`width` 和 `height`
* 总元素的宽度=`宽度+左填充+右填充+左边框+右边框+左边距+右边距`
* 总元素的高度=`高度+顶部填充+底部填充+上边框+下边框+上边距+下边距`

### 行盒子

行级元素沿着当前行依次排列，当当前行已经被填满时会重新创建一行。这些行就是所谓的`行盒子（line box）`

* 在这些行盒子内部，元素通过 `vertical-align属性`来进行对齐
* 行内元素的 `baseline` 就是文字所在的线
	
	* 当行内块元素的内容`都在文档流中`时，元素的 baseline 的位置由元素内容中最后一个元素的 baseline 的位置决定
	* 当行内元素的内容`都在文档流`中，但 `overflow` 属性的计算值不为 visible 时，baseline 的位置由 margin 盒子（margin-box）的下边界（bottom-edge）决定（参考中间图）
	* 当行内块元素的内容完全`脱离文档流`时，baseline 的位置是 margin 盒子（margin-box）的底边界
	
* 在 `baseline` 的周围，行盒子有个叫做`文本盒（text box）`的区域。文本盒可以被简单的看作为没有任何对齐方式的行内元素。文本盒的高度与其父元素的字体大小一致	

**小结：**

* 每一行中都存在一个行盒子，vertical-align 也仅作用于行盒子。行盒子中包含 baseline，文本盒以及上下边界
* 每一行中都有行级元素，每个行级元素都可以根据某种方式进行对齐，它们都有一个 `baseline`，上下边界

**简单来说：多个行元素，它们的对齐方式有`vertical-align` 和 `baseline`决定**



### 盒子模型属性

	
#### 边框属性 `border`

简写：`border`

分开写：

* `border-style`:
* `border-color`:
* `border-width`:

各个边：

* `border-bottom`和`border-bottom-color/style/width`
* `border-left/top/right`...
* ...

#### 轮廓：`outline`

* 位于边框边缘的外围
* 简写：`outline`
* 分开写：

	* `outline-color`
	* `outline-style`
	* `outline-width`


#### 外边距：`margin`

* margin清除周围的元素（外边框）的区域。margin没有`背景颜色，是完全透明`的
* 简写：`margin`
* 分开写：

	* `margin-left`
	* `margin-top`
	* `margin-right`
	* `margin-bottom`

#### 填充：`padding`

* 颜色被背景颜色填充
* 简写：`padding`
* 分开写：

	* `padding-left`
	* `padding-top`
	* `padding-right`
	* `padding-bottom`


## 其他布局属性

### 文档流

CSS有三种基本的定位机制：普通流，浮动和绝对定位

### 文本布局

有两个属性可以指定元素内容的对齐方式。这两个属性可以应用于任何文本类内容，不只是纯文本。 需要注意的是，它们会被元素的子元素继承

* `text-align`: 内容对齐
* `text-indent`: 内容缩进

### float


* 浮动元素不在文档的普通流中，文档的普通流中的元素表现的就像浮动元素不存在一样。但是，框的文本内容会受到浮动元素的影响,会移动以留出空间.用术语说就是浮动元素旁边的行框被缩短,从而给浮动元素流出空间,因而行框围绕浮动框。
* 控制元素水平移动，强制元素靠左或靠右。 这是控制元素位置和大小的简单方法
* 一个浮动元素会尽量向左或向右移动，直到它的外边缘碰到包含框或另一个浮动框的边框为止
* 浮动元素之后的元素将围绕它
* 浮动元素之前的元素将不会受到影响
* 如果图像是右浮动，下面的文本流将环绕在它左边
* 属性值：`left`, `right`, `none(默认值，不浮动)`, `inherit: 从父元素继承`


### clear

* 可以使用 `clear` 属性来避免其它元素受到浮动效果的影响
* `clear` 属性指定元素两侧不能出现浮动元素
* 属性值：`left`, `right`,`both`,`none`, `inherit`

### display

* 属性值：`block，显示为块级元素`、`block`、`inline，默认，行内元素`，`inherit`、`inline-block`
* 新属性：`flex`，新的布局方式：[flex布局学习](./flex学习.md)
* 隐藏元素: `display:none`或`visibility:hidden`。前者隐藏的元素不会占用任何空间。

### position

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
		
#### 	详解position属性值表现


* 普通流是默认定位方式，在普通流中元素框的位置由元素在html中的位置决定，元素`position`属性为static或继承来的static时就会按照普通流定位，这也是我们最常见的方式。
* 相对定位比较简单，对应position属性的relative值，如果对一个元素进行相对定位，它将出现在他所在的位置上，然后可以通过设置垂直或水平位置，让这个元素相对于它自己移动，**在使用相对定位时，无论元素是否移动，元素在文档流中占据原来空间，只是表现会改变。**
* 相对定位可以看作特殊的普通流定位，元素位置是相对于他在普通流中位置发生变化，而**绝对定位使元素的位置与文档流无关，也不占据文档流空间，普通流中的元素布局就像绝对定位元素不存在一样。**
* **绝对定位的元素的位置是相对于距离他最近的非static祖先元素位置决定的**。
* 因为绝对定位与文档流无关，所以绝对定位的元素可以覆盖页面上的其他元素，可以通过`z-index`属性控制叠放顺序，`z-index`越高，元素位置越靠上。
* fixed属性叫固定定位，固定定位是绝对定位的中，固定定位的元素也不包含在普通文档流中

### 尺寸属性：控制元素高度和宽度

* `height`
* `max-height`
* `min-height`
* `width`
* `max-width`
* `min-width`
* `line-height`



## 新的布局方式

* 详见[flex布局学习](./flex学习.md)


## 参考

* [关于 vertical-align 的一些小知识](http://www.cnblogs.com/bingooo/p/5628625.html)
* [CSS布局 ——从display，position， float属性谈起](http://www.cnblogs.com/dolphinx/archive/2012/10/13/2722501.html)
* [CSS美化自己的完美网页](http://www.cnblogs.com/aylin/p/5626068.html)
* [Learn CSS Layout](http://learnlayout.com/)

