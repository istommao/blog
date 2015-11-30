#DOM

文档对象类型。

用来将标记型文档封装成对象，并将标记型文档中所有内容（标签、文本、属性等）封装成对象。可以更好处理文档及其内容。

文档对象模型

* 文档：标记型文档
* 对象：封装了属性和行为的实现
* 模型：所有标记型文档都具备

只要是标记型文档，DOM都适用。要操作标记型文档，需要解析。

DOM技术的解析方式：

* 将标记型文档封装成对象document。dom解析按照标签的层次关系体现出标签的所属，形成一个树状结构。树的节点都是元素。

	这种DOM解析好处是可以对树进行任意操作，但是弊端需要将整个标签读入内存。

* SAX：非w3标准。基于事件驱动

##DOM模型
* dom level1：将html文档封装
* dom level2：在level1基础上，如命名空间
* dom level3：将xml文档封装成对象

##DHTML
动态的HTML。不是一门语言，是多项技术的简称。其中包含HTML，CSS、DOM、JS。在动态html页面效果：

* HTML：负责提供标签，对数据进行封装，目的是便于对该标签中的数据进行操作。
* CSS：提供样式属性，对标签中数据进行样式的定义
* DOM：将标记型文档及内容进行解析，并封装成对象。在对象中定义了更多属性和方法，便于对对象操作
* JS：程序设计语言，对页面中的对象进行逻辑操作。

##BOM模型

方便操作浏览器。浏览器对应的对象就是window。

	定义事件源， 注册时间管理的动作
	<input type="button" value="xxx" onclick="func"/>
	
window对象属性：

* document对象
* navigator对象
* location对象

window对象常见方法：

* alert
* confirm
* setTimeout
* setInterval
* clearTimeout
* clearInterval
* moveBy/moveTo
* resize
* scrollBy/scrollTo
* open
* close

window对象的常见事件

* onload
* onunload
* onbeforeunload


document对象

获取节点的方法

* getElementById
* getElementsByName
* getElementsByTagName

节点属性

通用属性

* nodeName
* nodeType
* nodeValue

* innerHTML

层次关系

* parentNode
* childNodes
* previousSibling
* nextSibling

节点操作

创建节点

* createTextNode
* appenChild
* createElement
* innerHTML

删除节点

* removeNode
* removeChild

修改节点

* replaceNode
* replaceChild
* cloneNode

思路：

1. 标签封装数据， html
2. 定义样式，css
3. 明确事件源，事件，以及要处理节点，dom
4. 明确具体操作方式，其实就是事件的处理内容，js

	* 获取节点
	* 设置预定义样式
	* 

















