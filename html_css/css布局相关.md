title: css布局相关
date: 2016-06-29 22:39:00
tags:
- css
- layout
- flex

# css布局相关

## 传统方式

相关知识点：

* 盒子模型
* display属性
* positon属性
* float属性




## flex方式

* 详解[flex布局](./flex学习.md)

### 快速指南

Flex是Flexible Box的缩写，意为"弹性布局"，用来为盒状模型提供最大的灵活性。

#### 基础

	<div class="box">
  		<span class="item"></span>
	</div>

* 如何使用？

	* 任何一个容器都可以指定为Flex布局。
	* 指定`display属性`为：`flex`即可
	
			.box {
				display: flex;
			}

	* `Webkit`内核的浏览器，必须加上`-webkit`前缀。

			.box {
				display:  -webkit-flex; /* Safari */
			}
			
	* 设为Flex布局以后，子元素的`float`、`clear`和`vertical-align`属性将失效。
	

* 基本概念： `容器(container)` 和 `项目(item)`

	* 采用Flex布局的元素，称为Flex容器（flex container），简称"容器".
	* 它的所有子元素自动成为容器成员，称为Flex项目（flex item），简称"项目"。
	
* 基本概念： 水平的 `主轴（main axis）` 和 垂直的`交叉轴（cross axis）`

	* `main start`
	* `main end`
	* `cross start`
	* `cross end`
	* `main size`
	* `cross size`	

#### 容器属性

以下6个属性设置在容器上：

* flex-direction：项目排列方向，默认：`row 水平方向`

	`.box { flex-direction: row | row-reverse | column | column-reverse; }`
	
* flex-wrap: 项目换行方式，默认 `nowrap 不换行`

	`.box { flex-wrap: nowrap | wrap | wrap-reverse; }s`

* flex-flow：`flex-diretion + flex-wrap`
* justify-content: 项目在主轴上的对齐方式，默认：`flex-start 左对齐`

	`.box { justify-content: flex-start | flex-end | center | space-between | space-around; }`


* align-items： 项目在交叉轴上对齐方式，默认：`stretch 如果项目未设置高度或设为auto，将占满整个容器的高度`

	`.box { align-items: flex-start | flex-end | center | baseline | stretch; }`


* align-content: 定义多根轴线的对齐方式, 如果项目只有一根轴线不起作用，默认：`stretch 轴线占满整个交叉轴`


	`.box { align-content: flex-start | flex-end | center | space-between | space-around | stretch; }`


#### 项目的属性

以下6个属性设置在项目上。

* order：定义项目的排列顺序。数值越小，排列越靠前。默认： `0`

	`.item { order: <integer>; }`

* flex-grow: 项目的放大比例，默认为 `0 如果存在剩余空间，也不放大`

	`.item { flex-grow: <number>; }`

* flex-shrink: 项目的缩小比例，默认为 `1，即如果空间不足，该项目将缩小`

	`.item { flex-shrink: <number>; }`

* flex-basis: 项目占据的主轴空间（main size）, 默认为`auto，即项目的本来大小`
	
	`.item { flex-basis: <length> | auto; }`
	
	设为跟width或height属性一样的值, 则项目将占据*固定空间, 不受flex-grow, flwx-shrink影响*

* flex： `flex-grow + flew-shrink + flex-basis`。 默认为 `0 1 auto 不放大不缩小保持项目本来大小`

	`.item { flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ] }`
	
	* 建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值
	* 后两个属性可选
	* 快捷值：`auto (1 1 auto)` 和 `none (0 0 auto)。`

* align-self: 允许单个项目有与其他项目不一样的对齐方式，可覆盖`align-items`属性。 默认为 `auto，表示继承父元素的align-items属性，如果没有父元素，则等同于stretch`

	`.item { align-self: auto | flex-start | flex-end | center | baseline | stretch; }`

### 小结

* 设置`display: flex`
* flex布局就是：容器内项目的：排列（`flex-flow`）和 对齐（`justify-content、align-items、align-content`），项目的： 排序（`order`） 和 缩放（`flex`）

