#CSS3学习笔记

#CSS3 简介

对CSS3已完全向后兼容，所以你就不必改变现有的设计。浏览器将永远支持CSS2。

##CSS3 模块
CSS3被拆分为"模块"。旧规范已拆分成小块，还增加了新的。

一些最重要CSS3模块如下：

* 选择器
* 盒模型
* 背景和边框
* 文字特效
* 2D/3D转换
* 动画
* 多列布局
* 用户界面

#CSS3 边框
用CSS3，你可以创建圆角边框，添加阴影框，并作为边界的形象而不使用设计程序，如Photoshop。

<table class="reference"> <tbody><tr> <th width="30%" align="left">属性</th> <th width="65%" align="left">说明</th> <th width="5%" align="left">CSS</th> </tr> <tr> <td><a href="/cssref/css3-pr-border-image.html">border-image</a></td> <td>设置所有边框图像的速记属性。</td> <td>3</td> </tr> <tr> <td><a href="/cssref/css3-pr-border-radius.html">border-radius</a></td> <td>一个用于设置所有四个边框- *-半径属性的速记属性</td> <td>3</td> </tr> <tr> <td><a href="/cssref/css3-pr-box-shadow.html">box-shadow</a></td> <td>附加一个或多个下拉框的阴影</td> <td>3</td> </tr> </tbody></table>

##CSS3 border-radius - 指定每个圆角
如果你在 border-radius 属性中只指定一个值，那么将生成 4 个 圆角。

但是，如果你要在四个角上一一指定，可以使用以下规则：

* 四个值: 第一个值为左上角，第二个值为右上角，第三个值为右下角，第四个值为左下角。
* 三个值: 第一个值为左上角, 第二个值为右上角和左下角，第三个值为右下角
* 两个值: 第一个值为左上角与右下角，第二个值为右上角与左下角
* 一个值： 四个圆角值相同

<table class="reference"> <tbody><tr> <th style="width:30%">属性</th> <th>描述</th> </tr> <tr> <td><a href="/cssref/css3-pr-border-radius.html" target="_blank">border-radius</a></td> <td>所有四个边角 border-*-*-radius 属性的缩写 </td> </tr> <tr> <td> <a href="/cssref/css3-pr-border-top-left-radius.html" target="_blank">border-top-left-radius</a></td> <td>定义了左上角的弧度</td> </tr> <tr> <td> <a href="/cssref/css3-pr-border-top-right-radius.html" target="_blank">border-top-right-radius</a></td> <td>定义了右上角的弧度</td> </tr> <tr> <td> <a href="/cssref/css3-pr-border-bottom-right-radius.html" target="_blank">border-bottom-right-radius</a></td> <td>定义了右下角的弧度</td> </tr> <tr> <td> <a href="/cssref/css3-pr-border-bottom-left-radius.html" target="_blank">border-bottom-left-radius</a></td> <td>定义了左下角的弧度</td> </tr> </tbody></table>

#CSS3 背景
CSS3中包含几个新的背景属性，提供更大背景元素控制。
<table class="reference"> <tbody><tr> <th width="28%" align="left">顺序</th> <th width="67%" align="left">描述</th> <th width="5%" align="left">CSS</th> </tr> <tr> <td><a href="/cssref/css3-pr-background-clip.html">background-clip</a></td> <td>规定背景的绘制区域。</td> <td>3</td> </tr> <tr> <td><a href="/cssref/css3-pr-background-origin.html">background-origin</a></td> <td>规定背景图片的定位区域。</td> <td>3</td> </tr> <tr> <td><a href="/cssref/css3-pr-background-size.html">background-size</a></td> <td>规定背景图片的尺寸。</td> <td>3</td> </tr> </tbody></table>


#CSS3 渐变（Gradients）
CSS3 渐变（gradients）可以让您在两个或多个指定的颜色之间显示平稳的过渡。

以前，您必须使用图像来实现这些效果。但是，通过使用 CSS3 渐变（gradients），您可以减少下载的事件和宽带的使用。此外，渐变效果的元素在放大时看起来效果更好，因为渐变（gradient）是由浏览器生成的。

CSS3 定义了两种类型的渐变（gradients）：

* 线性渐变（Linear Gradients）- 向下/向上/向左/向右/对角方向
* 径向渐变（Radial Gradients）- 由它们的中心定义

##语法

	background: linear-gradient(direction, color-stop1, color-stop2, ...);
	background: linear-gradient(angle, color-stop1, color-stop2);
	background: radial-gradient(center, shape size, start-color, ..., last-color);
	

**e.g. ** 从左到右的线性渐变：

	#grad {
  		background: -webkit-linear-gradient(left, red , blue); /* Safari 5.1 - 6.0 */
  		background: -o-linear-gradient(right, red, blue); /* Opera 11.1 - 12.0 */
  		background: -moz-linear-gradient(right, red, blue); /* Firefox 3.6 - 15 */
  		background: linear-gradient(to right, red , blue); /* 标准的语法 */
	}






























