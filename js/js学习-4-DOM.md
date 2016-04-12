title: js学习(4)-DOM
date: 2016-04-12 23:32:05
tags:
- js

# js学习(4)-DOM
---
没有系统学习过js，觉得基础太薄弱了，参考阮一峰老师的[JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)，希望可以提高自己js的基础。

# 5. DOM
------

# Node节点

## DOM的概念

DOM是文档对象模型（Document Object Model）的简称，它的基本思想是把结构化文档（比如HTML和XML）解析成一系列的节点，再由这些节点组成一个树状结构（DOM Tree）。所有的节点和最终的树状结构，都有规范的对外接口，以达到使用编程语言操作文档的目的（比如增删内容）。所以，**DOM可以理解成文档（HTML文档、XML文档和SVG文档）的编程接口**。

严格地说，DOM不属于JavaScript，但是操作DOM是JavaScript最常见的任务，而JavaScript也是最常用于DOM操作的语言。所以，DOM往往放在JavaScript里面介绍。

## 节点的概念

DOM的最小组成单位叫做节点（node），一个文档的树形结构（DOM树），就是由各种不同类型的节点组成。

对于HTML文档，节点主要有以下六种类型：*Document节点、DocumentType节点、Element节点、Attribute节点、Text节点和DocumentFragment节点*。

|节点	|名称|含义|
|-:-|-:-|-:-|
|Document	|文档节点	整个文档|（window.document）|
|DocumentType	|文档类型节点|	文档的类型（比如`<!DOCTYPE html>`）|
|Element|	元素节点|	HTML元素|（比如`<body>、<a>`等）|
|Attribute|	属性节点|	HTML元素的属性（比如class=”right”）|
|Text	|文本节点	|HTML文档中出现的文本|
|DocumentFragment|	文档碎片节点	文档的片段|

## Node节点的属性

### nodeName，nodeType

`nodeName`属性返回节点的名称，`nodeType`属性返回节点的常数值

通常来说，使用`nodeType`属性确定一个节点的类型，比较方便


### 返回当前节点的相关节点

`ownerDocument`，`nextSibling`，`previousSibling`，`parentNode`，`parentElement`

* `ownerDocument`属性返回当前节点所在的顶层文档对象，即document对象

	document对象本身的ownerDocument属性，返回null。
	
* `nextSibling`属性返回紧跟在当前节点后面的第一个同级节点。如果当前节点后面没有同级节点，则返回null。注意，该属性还包括文本节点和评论节点。因此如果当前节点后面有空格，该属性会返回一个文本节点，内容为空格
* `previousSibling`属性返回当前节点前面的、距离最近的一个同级节点。如果当前节点前面没有同级节点，则返回null
* `parentNode`属性返回当前节点的父节点。对于一个节点来说，它的父节点只可能是三种类型：element节点、document节点和documentfragment节点

	对于document节点和documentfragment节点，它们的父节点都是null。另外，对于那些生成后还没插入DOM树的节点，父节点也是null
	
* `parentElement`属性返回当前节点的父Element节点。如果当前节点没有父节点，或者父节点类型不是Element节点，则返回null		
### 返回当前节点的内容

* textContent属性返回当前节点和它的所有后代节点的文本内容

	该属性是可读写的，设置该属性的值，会用一个新的文本节点，替换所有它原来的子节点。它还有一个好处，就是自动对HTML标签转义。
	
	对于Text节点和Comment节点，该属性的值与nodeValue属性相同。对于其他类型的节点，该属性会将每个子节点的内容连接在一起返回，但是不包括Comment节点。如果一个节点没有子节点，则返回空字符串。
	
	document节点和doctype节点的textContent属性为null。如果要读取整个文档的内容，可以使用`document.documentElement.textContent`。
	
	在IE浏览器，所有Element节点都有一个`innerText`属性。它与textContent属性基本相同，但是有几点区别。
	
	* innerText受CSS影响，textContent不受。比如，如果CSS规则隐藏（hidden）了某段文本，innerText就不会返回这段文本，textContent则照样返回。
	* innerText返回的文本，会过滤掉空格、换行和回车键，textContent则不会。
	* innerText属性不是DOM标准的一部分，Firefox浏览器甚至没有部署这个属性，而textContent是DOM标准的一部分。
	
	
* nodeValue属性返回或设置当前节点的值，格式为字符串。但是，该属性只对Text节点、Comment节点、XML文档的CDATA节点有效，其他类型的节点一律返回null

	因此，nodeValue属性一般只用于Text节点。对于那些返回null的节点，设置nodeValue属性是无效的
	
### 返回当前节点的子节点

* childNodes属性返回一个NodeList集合，成员包括当前节点的所有子节点

	除了HTML元素节点，该属性返回的还包括Text节点和Comment节点。如果当前节点不包括任何子节点，则返回一个空的NodeList集合。由于NodeList对象是一个动态集合，一旦子节点发生变化，立刻会反映在返回结果之中
	
* firstNode属性返回当前节点的第一个子节点，如果当前节点没有子节点，则返回null。

	注意，除了HTML元素子节点，该属性还包括文本节点和评论节点。
	
* lastChild属性返回当前节点的最后一个子节点，如果当前节点没有子节点，则返回null

### baseURI

baseURI属性返回一个字符串，由当前网页的协议、域名和所在的目录组成，表示当前网页的绝对路径。如果无法取到这个值，则返回null。浏览器根据这个属性，计算网页上的相对路径的URL。该属性为只读。

通常情况下，该属性由当前网址的URL（即`window.location`属性）决定，但是可以使用HTML的`<base>`标签，改变该属性的值。

	<base href="http://www.example.com/page.html">
	<base target="_blank" href="http://www.example.com/page.html">

该属性不仅`document`对象有（`document.baseURI`），元素节点也有（`element.baseURI`）。通常情况下，它们的值是相同的。	

## Node节点的方法

### 与子节点相关appendChild()，hasChildNodes()

* appendChild()

	接受一个节点对象作为参数，将其作为最后一个子节点，插入当前节点
	
		var p = document.createElement("p");
		document.body.appendChild(p);

	如果参数节点是文档中现有的其他节点，appendChild方法会将其从原来的位置，移动到新位置
	
* hasChildNodes(): 返回一个布尔值，表示当前节点是否有子节点

	hasChildNodes方法结合`firstChild`属性和`nextSibling`属性，可以遍历当前节点的所有后代节点	
	
		function DOMComb (oParent, oCallback) {
		  if (oParent.hasChildNodes()) {
		    for (var oNode = oParent.firstChild; oNode; oNode = oNode.nextSibling) {
		      DOMComb(oNode, oCallback);
		    }
		  }
		  oCallback.call(oParent);
		}	
		
	面代码的DOMComb函数的第一个参数是某个指定的节点，第二个参数是回调函数。这个回调函数会依次作用于指定节点，以及指定节点的所有后代节点。

		function printContent () {
		  if (this.nodeValue) {
		    console.log(this.nodeValue);
		  }
		}
		
		DOMComb(document.body, printContent);	
### 与节点操作有关: cloneNode()，insertBefore()，removeChild()，replaceChild()

* cloneNode方法用于克隆一个节点。它接受一个布尔值作为参数，表示是否同时克隆子节点，默认是false，即不克隆子节点。

	需要注意的是，克隆一个节点，会拷贝该节点的所有属性，但是会丧失addEventListener方法和on-属性（即node.onclick = fn），添加在这个节点上的事件回调函数。

	克隆一个节点之后，DOM树有可能出现两个有相同ID属性（即id="xxx"）的HTML元素，这时应该修改其中一个HTML元素的ID属性。	
* insertBefore方法用于将某个节点插入当前节点的指定位置。它接受两个参数，第一个参数是所要插入的节点，第二个参数是当前节点的一个子节点，新的节点将插在这个节点的前面。该方法返回被插入的新节点。

	如果insertBefore方法的第二个参数为null，则新节点将插在当前节点的最后位置，即变成最后一个子节点。
	
	将新节点插在当前节点的最前面（即变成第一个子节点），可以使用当前节点的firstChild属性
	
	由于不存在insertAfter方法，如果要插在当前节点的某个子节点后面，可以用insertBefore方法结合nextSibling属性模拟
	
* removeChild方法接受一个子节点作为参数，用于从当前节点移除该节点。它返回被移除的节点。

* replaceChild方法用于将一个新的节点，替换当前节点的某一个子节点。它接受两个参数，第一个参数是用来替换的新节点，第二个参数将要被替换走的子节点。它返回被替换走的那个节点

### 用于节点的互相比较: contains()，compareDocumentPosition()，isEqualNode()

* contains方法接受一个节点作为参数，返回一个布尔值，表示参数节点是否为当前节点的后代节点
* compareDocumentPosition方法的用法，与contains方法完全一致，返回一个7个比特位的二进制值，表示参数节点与当前节点的关系
* isEqualNode方法返回一个布尔值，用于检查两个节点是否相等。所谓相等的节点，指的是两个节点的类型相同、属性相同、子节点相同。

### normalize()

normailize方法用于清理当前节点内部的所有Text节点。它会去除空的文本节点，并且将毗邻的文本节点合并成一个。

	
## NodeList接口，HTMLCollection接口

节点对象都是单个节点，但是有时会需要一种数据结构，能够容纳多个节点。DOM提供两种接口，用于部署这种节点的集合：NodeList接口和HTMLCollection接口。

### NodeList接口

有些属性和方法返回的是一组节点，比如`Node.childNodes`、`document.querySelectorAll`()。它们返回的都是一个部署了NodeList接口的对象	
NodeList接口有时返回一个动态集合，有时返回一个静态集合。所谓动态集合就是一个活的集合，DOM树删除或新增一个相关节点，都会立刻反映在NodeList接口之中。Node.childNodes返回的，就是一个动态集合。

document.querySelectorAll方法返回的是一个静态，DOM内部的变化，并不会实时反映在该方法的返回结果之中。

NodeList接口提供length属性和数字索引，因此可以像数组那样，使用数字索引取出每个节点，但是它本身并不是数组，不能使用pop或push之类数组特有的方法。

	// 数组的继承链
	myArray --> Array.prototype --> Object.prototype --> null
	
	// NodeList的继承链
	myNodeList --> NodeList.prototype --> Object.prototype --> null


* 如果要在NodeList接口使用数组方法，可以将NodeList接口对象转为真正的数组
* 也可以让数组的forEach方法在NodeList接口对象上调用
* 不过，遍历NodeList接口对象的首选方法，还是使用for循环
* 不要使用for…in循环去遍历NodeList接口对象，因为for…in循环会将非数字索引的length属性和下面要讲到的item方法，也遍历进去，而且不保证各个成员遍历的顺序
* ES6新增的for…of循环，也可以正确遍历NodeList接口对象

NodeList接口提供`item方法`，接受一个数字索引作为参数，返回该索引对应的成员。如果取不到成员，或者索引不合法，则返回null。

	// 实例
	var divs = document.getElementsByTagName("div");
	var secondDiv = divs.item(1);

所有类似数组的对象，都可以使用方括号运算符取出成员，所以一般情况下，都是使用下面的写法，而不使用item方法。

	nodeItem = nodeList[index]

### HTMLCollection接口

HTMLCollection接口与NodeList接口类似，也是节点的集合，但是集合成员都是Element节点。该接口都是动态集合，节点的变化会实时反映在集合中。`document.links`、`docuement.forms`、`document.images`等属性，返回的都是HTMLCollection接口对象。

部署了该接口的对象，具有length属性和数字索引，因此是一个类似于数组的对象。

item方法根据成员的位置参数（从0开始），返回该成员。如果取不到成员或数字索引不合法，则返回null。


	var c = document.images;
	var img1 = c.item(10);
	
	// 等价于下面的写法
	var img1 = c[1];
		
namedItem方法根据成员的ID属性或name属性，返回该成员。如果没有对应的成员，则返回null。


	// HTML代码为
	// <form id="myForm"></form>
	var elem = document.forms.namedItem("myForm");
	// 等价于下面的写法
	var elem = document.forms["myForm"];

由于item方法和namedItem方法，都可以用方括号运算符代替，所以建议一律使用方括号运算符


## ParentNode接口，ChildNode接口

ParentNode接口用于获取当前节点的Element子节点，ChildNode接口用于处理当前节点的子节点（包含但不限于Element子节点）

### ParentNode接口

ParentNode接口用于获取Element子节点。Element节点、Document节点和DocumentFragment节点，部署了ParentNode接口。凡是这三类节点，都具有以下四个属性，用于获取Element子节点。

* children属性返回一个动态的HTMLCollection集合，由当前节点的所有Element子节点组成
* firstElementChild属性返回当前节点的第一个Element子节点，如果不存在任何Element子节点，则返回null
* lastElementChild属性返回当前节点的最后一个Element子节点，如果不存在任何Element子节点，则返回null
* childElementCount属性返回当前节点的所有Element子节点的数目

### ChildNode接口

ChildNode接口用于处理子节点（包含但不限于Element子节点）。Element节点、DocumentType节点和CharacterData接口，部署了ChildNode接口。凡是这三类节点（接口），都可以使用下面四个方法。但是现实的情况是，除了第一个remove方法，目前没有浏览器支持后面三个方法

* remove方法用于移除当前节点
* 	before方法用于在当前节点的前面，插入一个同级节点。如果参数是节点对象，插入DOM的就是该节点对象；如果参数是文本，插入DOM的就是参数对应的文本节点
* 	after方法用于在当前节点的后面，插入一个同级节点。如果参数是节点对象，插入DOM的就是该节点对象；如果参数是文本，插入DOM的就是参数对应的文本节点
* 	replaceWith方法使用参数指定的节点，替换当前节点。如果参数是节点对象，替换当前节点的就是该节点对象；如果参数是文本，替换当前节点的就是参数对应的文本节点


## html元素

html元素是网页的根元素，document.documentElement就指向这个元素。

* clientWidth属性，clientHeight属性

	这两个属性返回视口（viewport）的大小，单位为像素。所谓“视口”，是指用户当前能够看见的那部分网页的大小

	`document.documentElement.clientWidth`和`document.documentElement.clientHeight`，基本上与`window.innerWidth`和`window.innerHeight`同义。只有一个区别，前者不将滚动条计算在内（很显然，滚动条和工具栏会减小视口大小），而后者包括了滚动条的高度和宽度。

* offsetWidth属性，offsetHeight属性

	这两个属性返回html元素的宽度和高度，即网页的总宽度和总高度

### dataset属性

`dataset`属性用于操作HTML标签元素的`data-*`属性

除了`dataset`属性，也可以用`getAttribute('data-foo')`、`removeAttribute('data-foo')`、`setAttribute('data-foo')`、`hasAttribute('data-foo')`等方法操作`data-*`属性。

需要注意的是，`dataset`属性使用骆驼拼写法表示属性名，这意味着`data-hello-world`会用`dataset.helloWorld`表示。而如果此时存在一个`data-helloWorld`属性，该属性将无法读取，也就是说，`data-*`属性本身只能使用连词号，不能使用骆驼拼写

### tabindex属性

tabindex属性用来指定，当前HTML元素节点是否被tab键遍历，以及遍历的优先级。

### 页面位置相关属性

offsetParent属性、offsetTop属性和offsetLeft属性，这三个属性提供Element对象在页面上的位置。

* offsetParent：当前HTML元素的最靠近的、并且CSS的position属性不等于static的父元素。
* offsetTop：当前HTML元素左上角相对于offsetParent的垂直位移。
* offsetLeft：当前HTML元素左上角相对于offsetParent的水平位移。

### style属性

style属性用来读写页面元素的行内CSS属性

### Element对象的方法

* 选择子元素的方法：

	* querySelector方法
	* querySelectorAll方法
	* getElementsByTagName方法
	* getElementsByClassName方法

* elementFromPoint方法：

	该方法用于选择在指定坐标的最上层的Element对象	
* HTML元素的属性相关方法

	* 	hasAttribute()：返回一个布尔值，表示Element对象是否有该属性。
	* 	getAttribute()
	* 	setAttribute()
	* 	removeAttribute()	

* matchesSelector方法

	该方法返回一个布尔值，表示Element对象是否符合某个CSS选择器

* focus方法

	focus方法用于将当前页面的焦点，转移到指定元素上	
	
### table元素

表格有一些特殊的DOM操作方法。

* insertRow()：在指定位置插入一个新行（tr）。
* deleteRow()：在指定位置删除一行（tr）。
* insertCell()：在指定位置插入一个单元格（td）。
* deleteCell()：在指定位置删除一个单元格（td）。
* createCaption()：插入标题。
* deleteCaption()：删除标题。
* createTHead()：插入表头。
* deleteTHead()：删除表头。	

table元素有以下属性：

* caption：标题。
* tHead：表头。
* tFoot：表尾。
* rows：行元素对象，该属性只读。
* rows.cells：每一行的单元格对象，该属性只读。
* tBodies：表体，该属性只读。

# document节点

## 概述




	
	
	


	

## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)