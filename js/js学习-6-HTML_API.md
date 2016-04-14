title: js学习(6)-HTML网页的API
date: 2016-04-13 23:56:05
tags:
- js

# js学习(6)-HTML网页的API
---
没有系统学习过js，觉得基础太薄弱了，参考阮一峰老师的[JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)，希望可以提高自己js的基础。

# 7. HTML网页的API
------

# HTML网页元素

## image元素

### alt属性，src属性

alt属性返回image元素的HTML标签的alt属性值，src属性返回image元素的HTML标签的src属性值

### complete属性

complete属性返回一个布尔值，true表示当前图像属于浏览器支持的图形类型，并且加载完成，解码过程没有出错，否则就返回false。

### height属性，width属性

这两个属性返回image元素被浏览器渲染后的高度和宽度。

### naturalWidth属性，naturalHeight属性
这两个属性只读，表示image对象真实的宽度和高度

## audio元素，video元素

audio元素和video元素加载音频和视频时，以下事件按次序发生。

* loadstart：开始加载音频和视频。
* durationchange：音频和视频的duration属性（时长）发生变化时触发，即已经知道媒体文件的长度。如果没有指定音频和视频文件，duration属性等于NaN。如果播放流媒体文件，没有明确的结束时间，duration属性等于Inf（Infinity）。
* loadedmetadata：媒体文件的元数据加载完毕时触发，元数据包括duration（时长）、dimensions（大小，视频独有）和文字轨。
* loadeddata：媒体文件的第一帧加载完毕时触发，此时整个文件还没有加载完。
* progress：浏览器正在下载媒体文件，周期性触发。下载信息保存在元素的buffered属性中。
* canplay：浏览器准备好播放，即使只有几帧，readyState属性变为CAN_PLAY。
* canplaythrough：浏览器认为可以不缓冲（buffering）播放时触发，即当前下载速度保持不低于播放速度，readyState属性变为CAN_PLAY_THROUGH。

audio元素和video元素还支持以下事件:

*learning when using*


## iframe

iframe元素用于在网页之中，插入另一张网页。对于JavaScript来说，每一个iframe，构成一个单独的域，不同的域之间的变量是隔离的。

# Canvas API

## 概述

Canvas API（画布）用于在网页实时生成图像，并且可以操作图像内容，基本上它是一个可以用JavaScript操作的位图（bitmap）。

使用前，首先需要新建一个canvas网页元素。

	<canvas id="myCanvas" width="400" height="200">
	  您的浏览器不支持canvas！
	</canvas>
	
每个canvas元素都有一个对应的context对象（上下文对象），Canvas API定义在这个context对象上面，所以需要获取这个对象，方法是使用getContext方法。

## 绘图方法

## 图像处理方法

## 动画

## 像素处理


*learning when using*


# SVG 图像

SVG是“可缩放矢量图”（Scalable Vector Graphics）的缩写，是一种描述向量图形的XML格式的标记化语言。也就是说，SVG本质上是文本文件，格式采用XML，可以在浏览器中显示出矢量图像。由于结构是XML格式，使得它可以插入HTML文档，成为DOM的一部分，然后用JavaScript和CSS进行操作。

相比传统的图像文件格式（比如JPG和PNG），SVG图像的优势就是文件体积小，并且放大多少倍都不会失真，因此非常合适用于网页。

*learning when using*




## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)