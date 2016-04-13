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

`document`节点是文档的根节点，每张网页都有自己的`document`节点。`window.document`属性就指向这个节点。也就是说，只要浏览器开始载入HTML文档，这个节点对象就存在了，可以直接调用。

`document`节点有不同的办法可以获取

* 对于正常的网页，直接使用`document`或`window.document`。
* 对于`iframe`载入的网页，使用`iframe`节点的`contentDocument`属性。
* 对`Ajax`操作返回的文档，使用`XMLHttpRequest`对象的`responseXML`属性。
* 对于某个节点包含的文档，使用该节点的`ownerDocument`属性。
	
## document节点的属性

### 指向文档内部的某个节点

doctype，documentElement，defaultView，body，head，activeElement

* doctype

	对于HTML文档来说，document对象一般有两个子节点。第一个子节点是document.doctype，它是一个对象，包含了当前文档类型（Document Type Declaration，简写DTD）信息。对于HTML5文档，该节点就代表<!DOCTYPE html>。如果网页没有声明DTD，该属性返回null。
	
	document.firstChild通常就返回这个节点。
	
* document.documentElement属性，表示当前文档的根节点（root）。它通常是document节点的第二个子节点，紧跟在document.doctype节点后面。
* defaultView属性，在浏览器中返回document对象所在的window对象，否则返回null
* 	body属性返回当前文档的body或frameset节点，如果不存在这样的节点，就返回null。这个属性是可写的，如果对其写入一个新的节点，会导致原有的所有子节点被移除。
* 	head属性返回当前文档的head节点。如果当前文档有多个head，则返回第一个。
* 	activeElement属性返回当前文档中获得焦点的那个元素。用户通常可以使用tab键移动焦点，使用空格键激活焦点，比如如果焦点在一个链接上，此时按一下空格键，就会跳转到该链接。

### 返回文档信息

documentURI，URL，domain，lastModified，location，referrer，title，characterSet

* documentURI属性和URL属性都返回当前文档的网址。不同之处是documentURI属性是所有文档都具备的，URL属性则是HTML文档独有的
* domain属性返回当前文档的域名。
* lastModified属性返回当前文档最后修改的时间戳，格式为字符串
* location属性返回一个只读对象，提供了当前文档的URL信息

		// 假定当前网址为http://user:passwd@www.example.com:4097/path/a.html?x=111#part1
		
		document.location.href // "http://user:passwd@www.example.com:4097/path/a.html?x=111#part1"
		document.location.protocol // "http:"
		document.location.host // "www.example.com:4097"
		document.location.hostname // "www.example.com"
		document.location.port // "4097"
		document.location.pathname // "/path/a.html"
		document.location.search // "?x=111"
		document.location.hash // "#part1"
		document.location.user // "user"
		document.location.password // "passed"
		
		// 跳转到另一个网址
		document.location.assign('http://www.google.com')
		// 优先从服务器重新加载
		document.location.reload(true)
		// 优先从本地缓存重新加载（默认值）
		document.location.reload(false)
		// 跳转到另一个网址，但当前文档不保留在history对象中，
		// 即无法用后退按钮，回到当前文档
		document.location.replace('http://www.google.com')
		// 将location对象转为字符串，等价于document.location.href
		document.location.toString()
		
	虽然location属性返回的对象是只读的，但是可以将URL赋值给这个属性，网页就会自动跳转到指定网址。
	
	document.location属性与window.location属性等价，历史上，IE曾经不允许对document.location赋值，为了保险起见，建议优先使用window.location。如果只是单纯地获取当前网址，建议使用document.URL。
	
* referrer属性返回一个字符串，表示当前文档的访问来源，如果是无法获取来源或是用户直接键入网址，而不是从其他网页点击，则返回一个空字符串
* title属性返回当前文档的标题，该属性是可写的
* characterSet属性返回渲染当前文档的字符集，比如UTF-8、ISO-8859-1

### readyState，designMode

以下属性与文档行为有关	

* readyState属性返回当前文档的状态，共有三种可能的值，加载HTML代码阶段（尚未完成解析）是“loading”，加载外部资源阶段是“interactive”，全部加载完成是“complete”。

		// 基本检查
		if (document.readyState === 'complete') {
		  // ...
		}	

* designMode属性控制当前document是否可编辑。通常会打开iframe的designMode属性，将其变为一个所见即所得的编辑器

### implementation，compatMode

以下属性返回文档的环境信息

* implementation属性返回一个对象，用来甄别当前环境部署了哪些DOM相关接口。implementation属性的hasFeature方法，可以判断当前环境是否部署了特定版本的特定接口
* compatMode属性返回浏览器处理文档的模式，可能的值为BackCompat（向后兼容模式）和 CSS1Compat（严格模式）

### anchors，embeds，forms，images，links，scripts，styleSheets

以下属性返回文档内部特定元素的集合（即HTMLCollection对象，详见下文）。这些集合都是动态的，原节点有任何变化，立刻会反映在集合中。

* anchors属性返回网页中所有的a节点元素。注意，只有指定了name属性的a元素，才会包含在anchors属性之中
* embeds属性返回网页中所有嵌入对象，即embed标签，返回的格式为类似数组的对象（nodeList）
* forms属性返回页面中所有表单。
* images属性返回页面所有图片元素（即img标签）
* links属性返回当前文档所有的链接元素（即a标签，或者说具有href属性的元素）
* scripts属性返回当前文档的所有脚本（即script标签）
* styleSheets属性返回一个类似数组的对象，包含了当前网页的所有样式表。该属性提供了样式表操作的接口。然后，每张样式表对象的cssRules属性，返回该样式表的所有CSS规则。这又方便了操作具体的CSS规则。
* document.cookie属性用来操作浏览器Cookie

## document对象的方法

* `document.open`方法用于新建一个文档，供write方法写入内容。它实际上等于清除当前文档，重新写入内容。不要将此方法与`window.open`()混淆，后者用来打开一个新窗口，与当前文档无关。

* `document.close`方法用于关闭open方法所新建的文档。一旦关闭，write方法就无法写入内容了。如果再调用write方法，就等同于又调用open方法，新建一个文档，再写入内容。

* `document.write`方法用于向当前文档写入内容。只要当前文档还没有用close方法关闭，它所写入的内容就会追加在已有内容的后面。总之，除了某些特殊情况，应该尽量避免使用`document.write`这个方法。

* `document.writeln`方法与write方法完全一致，除了会在输出内容的尾部添加换行符

* `document.hasFocus`方法返回一个布尔值，表示当前文档之中是否有元素被激活或获得焦点

### 选中当前文档中的元素

* `querySelector`方法返回匹配指定的CSS选择器的元素节点。如果有多个节点满足匹配条件，则返回第一个匹配的节点。如果没有发现匹配的节点，则返回null。
* `getElementById`方法返回匹配指定ID属性的元素节点。如果没有发现匹配的节点，则返回null
* `querySelectorAll`方法返回匹配指定的CSS选择器的所有节点，返回的是NodeList类型的对象。NodeList对象不是动态集合，所以元素节点的变化无法实时反映在返回结果中
* `getElementsByClassName`方法返回一个类似数组的对象（HTMLCollection类型的对象），包括了所有class名字符合指定条件的元素（搜索范围包括本身），元素的变化实时反映在返回结果中。这个方法不仅可以在document对象上调用，也可以在任何元素节点上调用。
* `getElementsByTagName`方法返回所有指定标签的元素（搜索范围包括本身）。返回值是一个HTMLCollection对象，也就是说，搜索结果是一个动态集合，任何元素的变化都会实时反映在返回的集合中。这个方法不仅可以在document对象上调用，也可以在任何元素节点上调用
* `getElementsByName`方法用于选择拥有name属性的HTML元素，比如form、img、frame、embed和object，返回一个NodeList格式的对象，不会实时反映元素的变化。
* `elementFromPoint`方法返回位于页面指定位置的元素


### 生成元素节点

* `createElement`方法用来生成HTML元素节点
* `document.createTextNode`方法用来生成文本节点，参数为所要生成的文本节点的内容
* `document.createAttribute`方法生成一个新的属性对象节点，并返回它
* `createDocumentFragment`方法生成一个DocumentFragment对象

### createEvent()

createEvent方法生成一个事件对象，该对象可以被element.dispatchEvent方法使用，触发指定事件

### 遍历元素节点

* createNodeIterator方法返回一个DOM的子节点遍历器。

	所谓“遍历器”，在这里指可以用nextNode方法和previousNode方法依次遍历根节点的所有子节点。
	
* createTreeWalker方法返回一个DOM的子树遍历器。它与createNodeIterator方法的区别在于，后者只遍历子节点，而它遍历整个子树

### 获取外部文档的节点

* `adoptNode`方法将某个节点，从其原来所在的文档移除，插入当前文档，并返回插入后的新节点
* `importNode`方法从外部文档拷贝指定节点，插入当前文档	
### addEventListener()，removeEventListener()，dispatchEvent()

与Document节点的事件相关。这些方法都继承自EventTarget接口


# Element对象

Element对象对应网页的HTML标签元素。每一个HTML标签元素，在DOM树上都会转化成一个Element节点对象（以下简称元素节点）。

元素节点的nodeType属性都是1，但是不同HTML标签生成的元素节点是不一样的。

因此，元素节点不是一种对象，而是一组对象。

## 属性

### attributes，id，tagName

* attributes属性返回一个类似数组的对象，成员是当前元素节点的所有属性节点，每个数字索引对应一个属性节点（Attribute）对象。返回值中，所有成员都是动态的，即属性的变化会实时反映在结果集。
* id属性返回指定元素的id标识。该属性可读写。
* tagName属性返回指定元素的大写的标签名，与nodeName属性的值相等。

### innerHTML，outerHTML

* innerHTML属性返回该元素包含的HTML代码。该属性可读写，常用来设置某个节点的内容。

	注意，如果文本节点中包含`&`、小于号（`<`）和大于号（`>`），innerHTML属性会将它们转为实体形式`&amp`、`&lt`、`&gt`。因此在innerHTML插入`<script>`标签，不会被执行。但是，innerHTML还是有安全风险的。因此为了安全考虑，如果插入的是文本，最好用textContent属性代替innerHTML。
	
* outerHTML属性返回一个字符串，内容为指定元素的所有HTML代码，包括它自身和包含的所有子元素

### children，childElementCount，firstElementChild，lastElementChild

以下属性与元素节点的子元素相关	

* children属性返回一个类似数组的动态对象（实时反映变化），包括当前元素节点的所有子元素。如果当前元素没有子元素，则返回的对象包含零个成员。
* childElementCount属性返回当前元素节点包含的子元素节点的个数。
* firstElementChild属性返回第一个子元素，如果没有，则返回null。
* lastElementChild属性返回最后一个子元素，如果没有，则返回null。


### nextElementSibling，previousElementSibling

以下属性与元素节点的同级元素相关

* nextElementSibling属性返回指定元素的后一个同级元素，如果没有则返回null。
* previousElementSibling属性返回指定元素的前一个同级元素，如果没有则返回null。

### className，classList

* className属性用来读取和设置当前元素的class属性。它的值是一个字符串，每个class之间用空格分割。
* classList属性则返回一个类似数组的对象，当前元素节点的每个class就是这个对象的一个成员

	classList对象有下列方法。
	
	* add()：增加一个class。
	* remove()：移除一个class。
	* contains()：检查当前元素是否包含某个class。
	* toggle()：将某个class移入或移出当前元素。
	* item()：返回指定索引位置的class。
	* toString()：将class的列表转为字符串。

### clientHeight，clientLeft，clientTop，clientWidth

以下属性与元素节点的可见区域的坐标相关

* clientHeight属性

	返回元素节点的可见高度，包括padding、但不包括水平滚动条、边框和margin的高度，单位为像素。该属性可以计算得到，等于元素的CSS高度，加上CSS的padding高度，减去水平滚动条的高度（如果存在水平滚动条）。

	如果一个元素是可以滚动的，则clientHeight只计算它的可见部分的高度。

* clientLeft属性

	等于元素节点左边框（border）的宽度，单位为像素，包括垂直滚动条的宽度，不包括左侧的margin和padding。但是，除非排版方向是从右到左，且发生元素宽度溢出，否则是不可能存在左侧滚动条。如果该元素的显示设为display: inline，clientLeft一律为0，不管是否存在左边框。

* clientTop属性等于网页元素顶部边框的宽度，不包括顶部的margin和padding。
* clientWidth属性等于网页元素的可见宽度，即包括padding、但不包括垂直滚动条（如果有的话）、边框和margin的宽度，单位为像素。

### scrollHeight，scrollWidth，scrollLeft，scrollTop

以下属性与元素节点占据的总区域的坐标相关

* scrollHeight属性返回指定元素的总高度，包括由于溢出而无法展示在网页的不可见部分
* scrollWidth属性返回元素的总宽度，包括由于溢出容器而无法显示在网页上的那部分宽度，不管是否存在水平滚动条。该属性是只读属性。
* scrollLeft属性设置或返回水平滚动条向右侧滚动的像素数量。它的值等于元素的最左边与其可见的最左侧之间的距离。对于那些没有滚动条或不需要滚动的元素，该属性等于0。该属性是可读写属性，设置该属性的值，会导致浏览器将指定元素自动滚动到相应的位置。
* scrollTop属性设置或返回垂直滚动条向下滚动的像素数量。它的值等于元素的顶部与其可见的最高位置之间的距离。对于那些没有滚动条或不需要滚动的元素，该属性等于0。该属性是可读写属性，设置该属性的值，会导致浏览器将指定元素自动滚动到相应位置。

## 方法

### hasAttribute()，getAttribute()，removeAttribute()，setAttribute()

以下方法与元素节点的属性相关。

### querySelector()，querySelectorAll()，getElementsByClassName()，getElementsByTagName()

以下方法与获取当前元素节点的子元素相关。

### closest()，matches()

### addEventListener()，removeEventListener()，dispatchEvent()

以下三个方法与Element节点的事件相关。这些方法都继承自EventTarget接口，
详细介绍参见《Event对象》章节的《EventTarget》部分。

### getBoundingClientRect()，getClientRects()

以下方法返回元素节点的CSS盒状模型信息。

### insertAdjacentHTML()，remove()

以下方法操作元素节点的DOM树。

### scrollIntoView()

scrollIntoView方法滚动当前元素，进入浏览器的可见区域


# Text节点和DocumentFragment节点

## Text节点的概念

Text节点代表Element节点和Attribute节点的文本内容。如果一个节点只包含一段文本，那么它就有一个Text子节点，代表该节点的文本内容。通常我们使用Element节点的firstChild、nextSibling等属性获取Text节点，或者使用Document节点的createTextNode方法创造一个Text节点

	// 获取Text节点
	var textNode = document.querySelector('p').firstChild;
	
	// 创造Text节点
	var textNode = document.createTextNode('Hi');
	document.querySelector('div').appendChild(textNode);

浏览器原生提供一个Text构造函数。它返回一个Text节点。它的参数就是该Text节点的文本内容。

	var text1 = new Text();
	var text2 = new Text("This is a text node");

注意，由于空格也是一个字符，所以哪怕只有一个空格，也会形成Text节点。

Text节点除了继承Node节点的属性和方法，还继承了CharacterData接口。Node节点的属性和方法请参考《Node节点》章

## Text节点的属性

* data属性等同于nodeValue属性，用来设置或读取Text节点的内容。
* wholeText属性将当前Text节点与毗邻的Text节点，作为一个整体返回。大多数情况下，wholeText属性的返回值，与data属性和textContent属性相同。但是，某些特殊情况会有差异
* length属性返回当前Text节点的文本长度。
* nextElementSibling属性返回紧跟在当前Text节点后面的那个同级Element节点。如果取不到这样的节点，则返回null
* previousElementSibling属性返回当前Text节点前面最近的那个Element节点。如果取不到这样的节点，则返回null

## Text节点的方法

### appendData()，deleteData()，insertData()，replaceData()，subStringData()

以下5个方法都是编辑Text节点文本内容的方法。

### remove方法用于移除当前Text节点

### splitText()，normalize()

splitText方法将Text节点一分为二，变成两个毗邻的Text节点。它的参数就是分割位置（从零开始），分割到该位置的字符前结束。如果分割位置不存在，将报错。

normalize方法可以将毗邻的两个Text节点合并。

## DocumentFragment节点

DocumentFragment节点代表一个文档的片段，本身就是一个完整的DOM树形结构。它没有父节点，不属于当前文档，操作DocumentFragment节点，要比直接操作DOM树快得多。

它一般用于构建一个DOM结构，然后插入当前文档。document.createDocumentFragment方法，以及浏览器原生的DocumentFragment构造函数，可以创建一个空的DocumentFragment节点。然后再使用其他DOM方法，向其添加子节点。

	var docFrag = document.createDocumentFragment();
	// or
	var docFrag = new DocumentFragment();
	
	var li = document.createElement("li");
	li.textContent = "Hello World";
	docFrag.appendChild(li);
	
	document.queryselector('ul').appendChild(docFrag);
	
	
上面代码创建了一个DocumentFragment节点，然后将一个li节点添加在它里面，最后将DocumentFragment节点移动到原文档。

一旦DocumentFragment节点被添加进原文档，它自身就变成了空节点（textContent属性为空字符串）。如果想要保存DocumentFragment节点的内容，可以使用cloneNode方法。


DocumentFragment节点对象没有自己的属性和方法，全部继承自Node节点和ParentNode接口。也就是说，DocumentFragment节点比Node节点多出以下四个属性。

* children：返回一个动态的HTMLCollection集合对象，包括当前DocumentFragment对象的所有子元素节点。
* firstElementChild：返回当前DocumentFragment对象的第一个子元素节点，如果没有则返回null。
* lastElementChild：返回当前DocumentFragment对象的最后一个子元素节点，如果没有则返回null。
* childElementCount：返回当前DocumentFragment对象的所有子元素数量。

另外，Node节点的所有方法，都接受DocumentFragment节点作为参数（比如Node.appendChild、Node.insertBefore）。这时，DocumentFragment的子节点（而不是DocumentFragment节点本身）将插入当前节点。


# Event对象

事件是一种异步编程的实现方式，本质上是程序各个组成部分之间传递的特定消息。DOM支持大量的事件

## EventTarget接口

DOM的事件操作（监听和触发），都定义在`EventTarget`接口。`Element`节点、`document`节点和`window`对象，都部署了这个接口。此外，`XMLHttpRequest`、`AudioNode`、`AudioContext`等浏览器内置对象，也部署了这个接口。

该接口就是三个方法，`addEventListener`和`removeEventListener`用于绑定和移除监听函数，`dispatchEvent`用于触发事件。

### addEventListener()

用于在当前节点或对象上，定义一个特定事件的监听函数。

	target.addEventListener(type, listener[, useCapture]);

* type，事件名称，大小写不敏感。
* listener，监听函数。指定事件发生时，会调用该监听函数。
* useCapture，监听函数是否在捕获阶段（capture）触发（参见后文《事件的传播》部分）。该参数是一个布尔值，默认为false（表示监听函数只在冒泡阶段被触发）。老式浏览器规定该参数必写，较新版本的浏览器允许该参数可选。为了保持兼容，建议总是写上该参数。

可以使用addEventListener方法，为当前对象的同一个事件，添加多个监听函数。这些函数按照添加顺序触发，即先添加先触发。

如果希望向监听函数传递参数，可以用匿名函数包装一下监听函数

### removeEventListener()

`removeEventListener`方法用来移除`addEventListener`方法添加的事件监听函数

`removeEventListener`方法的参数，与`addEventListener`方法完全一致。它对第一个参数“事件类型”，也是大小写不敏感。

	div.addEventListener('click', listener, false);
	div.removeEventListener('click', listener, false);

### dispatchEvent()

	target.dispatchEvent(event)
	
`dispatchEvent`方法的参数是一个`Event`对象的实例
	
	para.addEventListener('click', hello, false);
	var event = new Event('click');
	para.dispatchEvent(event);
	
`dispatchEvent`方法在当前节点上触发指定事件，从而触发监听函数的执行。该方法返回一个布尔值，只要有一个监听函数调用了`Event.preventDefault()`，则返回值为false，否则为true	
## 监听函数

监听函数（listener）是事件发生时，程序所要执行的函数。它是事件驱动编程模式的主要编程方式。

DOM提供三种方法，可以用来为事件绑定监听函数

### HTML标签的on-属性

HTML语言允许在元素标签的属性中，直接定义某些事件的监听代码

	<body onload="doSomething()">
	
使用这个方法指定的监听函数，只会在冒泡阶段触发。

**注意**，使用这种方法时，on-属性的值是“监听代码”，而不是“监听函数”。也就是说，一旦指定事件发生，这些代码是原样传入JavaScript引擎执行。因此如果要执行函数，必须在函数名后面加上一对圆括号。

另外，Element节点的setAttribue方法，其实设置的也是这种效果。

	el.setAttribute('onclick', 'doSomething()');

### Element节点的事件属性

Element节点有事件属性，可以定义监听函数

	window.onload = doSomething;
	
	div.onclick = function(event){
	  console.log('触发事件');
	};

使用这个方法指定的监听函数，只会在冒泡阶段触发

### addEventListener方法

通过`Element`节点、`document`节点、`window`对象的`addEventListener`方法，也可以定义事件的监听函数。
	
	window.addEventListener('load', doSomething, false);
	
> 在上面三种方法中，第一种“HTML标签的on-属性”，违反了HTML与JavaScript代码相分离的原则；第二种“Element节点的事件属性”的缺点是，同一个事件只能定义一个监听函数，也就是说，如果定义两次onclick属性，后一次定义会覆盖前一次。因此，这两种方法都不推荐使用，除非是为了程序的兼容问题，因为所有浏览器都支持这两种方法。

`addEventListener`是推荐的指定监听函数的方法。它有如下优点：

* 可以针对同一个事件，添加多个监听函数。
* 能够指定在哪个阶段（捕获阶段还是冒泡阶段）触发回监听函数。
* 除了DOM节点，还可以部署在window、XMLHttpRequest等对象上面，等于统一了整个JavaScript的监听函数接口。	


### this对象的指向

实际编程中，监听函数内部的this对象，常常需要指向触发事件的那个Element节点。

addEventListener方法指定的监听函数，内部的this对象总是指向触发事件的那个节点

**总结一下**，以下写法的this对象都指向Element节点。

	// JavaScript代码
	element.onclick = print
	element.addEventListener('click', print, false)
	element.onclick = function () {console.log(this.id);}
	
	// HTML代码
	<element onclick="console.log(this.id)">

以下写法的this对象，都指向全局对象。

	// JavaScript代码
	element.onclick = function (){ doSomething() };
	element.setAttribute('onclick', 'doSomething()');
	
	// HTML代码
	<element onclick="doSomething()">

## 事件的传播

一个事件发生以后，它会在不同的DOM节点之间传播（propagation）。这种传播分成三个阶段：

第一阶段：从window对象传导到目标节点，称为“捕获阶段”（capture phase）。

第二阶段：在目标节点上触发，称为“目标阶段”（target phase）。

第三阶段：从目标节点传导回window对象，称为“冒泡阶段”（bubbling phase）。

### 事件的代理

由于事件会在冒泡阶段向上传播到父节点，因此可以把子节点的监听函数定义在父节点上，由父节点的监听函数统一处理多个子元素的事件。这种方法叫做事件的代理（`delegation`）。

这样做的好处是，只要定义一个监听函数，就能处理多个子节点的事件，而且以后再添加子节点，监听函数依然有效。

如果希望事件到某个节点为止，不再传播，可以使用`事件对象`的`stopPropagation`方法。

但是，`stopPropagation`方法不会阻止p节点上的其他click事件的监听函数。如果想要不再触发那些监听函数，可以使用`stopImmediatePropagation`方法。

## Event对象

事件发生以后，会生成一个事件对象，作为参数传给监听函数。浏览器原生提供一个`Event对象`，所有的事件都是这个对象的实例，或者说继承了`Event.prototype`对象。

Event对象本身就是一个构造函数，可以用来生成新的实例。

	event = new Event(typeArg, eventInit);

Event构造函数接受两个参数。第一个参数是字符串，表示事件的名称；第二个参数是一个对象，表示事件对象的配置。


### Event实例的属性和方法

* `bubbles`属性返回一个布尔值，表示当前事件是否会冒泡。该属性为只读属性
* `eventPhase`属性返回一个整数值，表示事件目前所处的节点
* `cancelable`属性返回一个布尔值，表示事件是否可以取消。该属性为只读属性
* `defaultPrevented`属性返回一个布尔值，表示该事件是否调用过preventDefault方法
* `currentTarget`属性返回事件当前所在的节点，即正在执行的监听函数所绑定的那个节点。
* `target`属性返回事件发生的节点，即事件最初发生的节点。如果监听函数不在该节点触发，那么它与currentTarget属性返回的值是不一样的。
* `type`属性返回一个字符串，表示事件类型
* `detail`属性返回一个数值，表示事件的某种信息。
* `timeStamp`属性返回一个毫秒时间戳，表示事件发生的时间。
* `isTrusted`属性返回一个布尔值，表示该事件是否可以信任
* `preventDefault`方法取消浏览器对当前事件的默认行为

	比如点击链接后，浏览器跳转到指定页面，或者按一下空格键，页面向下滚动一段距离。该方法生效的前提是，事件的cancelable属性为true，如果为false，则调用该方法没有任何效果。
	
	该方法不会阻止事件的进一步传播（stopPropagation方法可用于这个目的）。只要在事件的传播过程中（捕获阶段、目标阶段、冒泡阶段皆可），使用了preventDefault方法，该事件的默认方法就不会执行
	
* `stopPropagation`方法阻止事件在DOM中继续传播，防止再触发定义在别的节点上的监听函数，但是不包括在当前节点上新定义的事件监听函数。		
* `stopImmediatePropagation`方法阻止同一个事件的其他监听函数被调用


## 鼠标事件

### 事件种类

* `click`事件当用户在Element节点、document节点、window对象上，单击鼠标（或者按下回车键）时触发。“鼠标单击”定义为，用户在同一个位置完成一次mousedown动作和mouseup动作。它们的触发顺序是：mousedown首先触发，mouseup接着触发，click最后触发。
* `dblclick`事件当用户在element、document、window对象上，双击鼠标时触发。该事件会在mousedown、mouseup、click之后触发
* `mouseup`事件，`mousedown`事件
* `mousemove`事件
* `mouseover`事件，`mouseenter`事件，都是鼠标进入一个节点时触发。区别是，mouseover事件会冒泡，mouseenter事件不会。
* `mouseout`事件，`mouseleave`事件，都是鼠标离开一个节点时触发。区别是，mouseout事件会冒泡，mouseleave事件不会。
* `contextmenu`事件在一个节点上点击鼠标右键时触发，或者按下“上下文菜单”键时触发。


### MouseEvent对象

鼠标事件使用`MouseEvent`对象表示，它继承UIEvent对象和Event对象。浏览器提供一个MouseEvent构造函数，用于新建一个MouseEvent实例。

	event = new MouseEvent(typeArg, mouseEventInit);

MouseEvent构造函数的第一个参数是事件名称（可能的值包括click、mousedown、mouseup、mouseover、mousemove、mouseout），第二个参数是一个事件初始化对象。

### altKey，ctrlKey，metaKey，shiftKey

表示鼠标事件发生时，是否按下某个键

* altKey属性：alt键
* ctrlKey属性：key键
* metaKey属性：Meta键（Mac键盘是一个四瓣的小花，Windows键盘是Windows键）
* shiftKey属性：Shift键


### button，buttons

* button属性返回一个数值，表示按下了鼠标哪个键。
* buttons属性返回一个3个比特位的值，表示同时按下了哪些键。它用来处理同时按下多个鼠标键的情况。


### clientX，clientY，movementX，movementY，screenX，screenY

这些属性与事件的位置相关


### relatedTarget

relatedTarget属性返回事件的次要相关节点。对于那些没有次要相关节点的事件，该属性返回null。

### wheel事件

wheel事件是与鼠标滚轮相关的事件，目前只有一个wheel事件。用户滚动鼠标的滚轮，就触发这个事件。

该事件除了继承了MouseEvent、UIEvent、Event的属性，还有几个自己的属性。

## 键盘事件

键盘事件用来描述键盘行为，主要有`keydown`、`keypress`、`keyup`三个事件。

* `keydown`：按下键盘时触发该事件。
* `keypress`：只要按下的键并非Ctrl、Alt、Shift和Meta，就接着触发keypress事件。
* `keyup`：松开键盘时触发该事件。

如果用户一直按键不松开，就会连续触发键盘事件，触发的顺序如下。

* keydown
* keypress
* keydown
* keypress
* （重复以上过程）
* keyup

键盘事件使用`KeyboardEvent`对象表示，该对象继承了UIEvent和MouseEvent对象。浏览器提供KeyboardEvent构造函数，用来新建键盘事件的实例。

	event = new KeyboardEvent(typeArg, KeyboardEventInit);

`KeyboardEvent`构造函数的第一个参数是一个字符串，表示事件类型，第二个参数是一个事件配置对象。


### altKey，ctrlKey，metaKey，shiftKey

### key，charCode

`key`属性返回一个字符串，表示按下的键名。如果同时按下一个控制键和一个符号键，则返回符号键的键名。比如，按下Ctrl+a，则返回a。如果无法识别键名，则返回字符串Unidentified。

`charCode`属性返回一个数值，表示keypress事件按键的Unicode值，keydown和keyup事件不提供这个属性。注意，该属性已经从标准移除，虽然浏览器还支持，但应该尽量不使用。

## 进度事件

进度事件用来描述一个事件进展的过程

进度事件有以下几种。

* abort事件：当进度事件被中止时触发。如果发生错误，导致进程中止，不会触发该事件。
* error事件：由于错误导致资源无法加载时触发。
* load事件：进度成功结束时触发。
* loadstart事件：进度开始时触发。
* loadend事件：进度停止时触发，发生顺序排在error事件\abort事件\load事件后面。
* progress事件：当操作处于进度之中，由传输的数据块不断触发。
* timeout事件：进度超过限时触发。

## 拖拉事件

拖拉指的是，用户在某个对象上按下鼠标键不放，拖动它到另一个位置，然后释放鼠标键，将该对象放在那里。

拖拉的对象有好几种，包括Element节点、图片、链接、选中的文字等等。在HTML网页中，除了Element节点默认不可以拖拉，其他（图片、链接、选中的文字）都是可以直接拖拉的。为了让Element节点可拖拉，可以将该节点的draggable属性设为true。

draggable属性可用于任何Element节点，但是图片（img元素）和链接（a元素）不加这个属性，就可以拖拉。对于它们，用到这个属性的时候，往往是将其设为false，防止拖拉。

注意，一旦某个Element节点的draggable属性设为true，就无法再用鼠标选中该节点内部的文字或子节点了。

## 事件种类

当Element节点或选中的文本被拖拉时，就会持续触发拖拉事件，包括以下一些事件。

* drag事件
* dragstart
* dragend
* dragenter
* dragover
* dragleave
* drop

拖拉事件用一个`DragEvent`对象表示，该对象继承MouseEvent对象，因此也就继承了UIEvent和Event对象。DragEvent对象只有一个独有的属性DataTransfer，其他都是继承的属性。DataTransfer属性用来读写拖拉事件中传输的数据，详见下文《DataTransfer对象》的部分。

### DataTransfer对象概述

所有的拖拉事件都有一个dataTransfer属性，用来保存需要传递的数据。这个属性的值是一个DataTransfer对象。

拖拉的数据保存两方面的数据：数据的种类（又称格式）和数据的值。数据的种类是一个MIME字符串，比如 text/plain或者image/jpeg，数据的值是一个字符串。一般来说，如果拖拉一段文本，则数据默认就是那段文本；如果拖拉一个链接，则数据默认就是链接的URL。

当拖拉事件开始的时候，可以提供数据类型和数据值；在拖拉过程中，通过dragenter和dragover事件的监听函数，检查数据类型，以确定是否允许放下（drop）被拖拉的对象。比如，在只允许放下链接的区域，检查拖拉的数据类型是否为text/uri-list。

发生drop事件时，监听函数取出拖拉的数据，对其进行处理。

### DataTransfer对象的属性

* dropEffect: 设置放下（drop）被拖拉节点时的效果
* effectAllowed属性设置本次拖拉中允许的效果
* files属性是一个FileList对象，包含一组本地文件，可以用来在拖拉操作中传送。
* types属性是一个数组，保存每一次拖拉的数据格式

### DataTransfer对象的方法

* setData()：用来设置事件所带有的指定类型的数据。
* getData()：接受一个字符串（表示数据类型）作为参数，返回事件所带的指定类型的数据（通常是用setData方法添加的数据）
* clearData()：接受一个字符串（表示数据类型）作为参数，删除事件所带的指定类型的数据。
* setDragImage()：拖动过程中（dragstart事件触发后），浏览器会显示一张图片跟随鼠标一起移动，表示被拖动的节点。


## 触摸事件

触摸API由三个对象组成。

* Touch
* TouchList
* TouchEvent

## 表单事件

### Input事件，select事件，change事件

这些事件与表单成员的值变化有关

### reset事件，submit事件

这两个事件发生在表单对象上，而不是发生在表单的成员上

## 文档事件

### beforeunload事件，unload事件，load事件，error事件，pageshow事件，pagehide事件

与网页的加载与卸载相关

* beforeunload事件当窗口将要关闭，或者document和网页资源将要卸载时触发。
* unload事件在窗口关闭或者document对象将要卸载时触发，发生在window、body、frameset等对象上面。
* load事件在页面加载成功时触发，error事件在页面加载失败时触发。

	注意，页面从浏览器缓存加载，并不会触发load事件。

	这两个事件实际上属于进度事件，不仅发生在document对象，还发生在各种外部资源上面。浏览网页就是一个加载各种资源的过程，图像（image）、样式表（style sheet）、脚本（script）、视频（video）、音频（audio）、Ajax请求（XMLHttpRequest）等等。这些资源和document对象、window对象、XMLHttpRequestUpload对象，都会触发load事件和error事件。
	
* pageshow事件在页面加载时触发，包括第一次加载和从缓存加载两种情况。	
* pagehide事件与pageshow事件类似，当用户通过“前进/后退”按钮，离开当前页面时触发。它与unload事件的区别在于，如果在window对象上定义unload事件的监听函数之后，页面不会保存在缓存中，而使用pagehide事件，页面会保存在缓存中。

### DOMContentLoaded事件，readystatechange事件

与文档状态相关。

* DOMContentLoaded事件

	当HTML文档下载并解析完成以后，就会在document对象上触发DOMContentLoaded事件。这时，仅仅完成了HTML文档的解析（整张页面的DOM生成），所有外部资源（样式表、脚本、iframe等等）可能还没有下载结束。也就是说，这个事件比load事件，发生时间早得多。
	
* readystatechange事件

	readystatechange事件发生在Document对象和XMLHttpRequest对象，当它们的readyState属性发生变化时触发。
	
### scroll事件，resize事件

与窗口行为有关

* scroll事件在文档或文档元素滚动时触发
* resize事件在改变浏览器窗口大小时触发，发生在window、body、frameset对象上面

### hashchange事件，popstate事件

与文档的URL变化相关。

* hashchange事件在URL的hash部分（即#号后面的部分，包括#号）发生变化时触发。
* popstate事件在浏览器的history对象的当前记录发生显式切换时触发。

### cut事件，copy事件，paste事件

属于文本操作触发的事件

* cut事件：在将选中的内容从文档中移除，加入剪贴板后触发。
* copy事件：在选中的内容加入剪贴板后触发。
* paste事件：在剪贴板内容被粘贴到文档后触发



### 焦点事件

发生在Element节点和document对象上面，与获得或失去焦点相关。它主要包括以下四个事件

* focus事件：Element节点获得焦点后触发，该事件不会冒泡。
* blur事件：Element节点失去焦点后触发，该事件不会冒泡。
* focusin事件：Element节点将要获得焦点时触发，发生在focus事件之前。该事件会冒泡。Firefox不支持该事件。
* focusout事件：Element节点将要失去焦点时触发，发生在blur事件之前。该事件会冒泡。Firefox不支持该事件。	
## 自定义事件和事件模拟

用户还可以自定义事件，然后手动触发

	// 新建事件实例
	var event = new Event('build');
	
	// 添加监听函数
	elem.addEventListener('build', function (e) { ... }, false);
	
	// 触发事件
	elem.dispatchEvent(event);

 
### CustomEvent()

Event构造函数只能指定事件名，不能在事件上绑定数据。如果需要在触发事件的同时，传入指定的数据，需要使用CustomEvent构造函数生成自定义的事件对象。

	var event = new CustomEvent('build', { 'detail': 'hello' });
	function eventHandler(e) {
	  console.log(e.detail);
	}

### 事件的模拟

有时，需要在脚本中模拟触发某种类型的事件，这时就必须使用这种事件的构造函数。 

# CSS操作


# Mutation Observer


## 概述

Mutation Observer（变动观察器）是监视DOM变动的接口。DOM发生任何变动，Mutation Observer会得到通知。

概念上，它很接近事件。可以理解为，当DOM发生变动，会触发Mutation Observer事件。但是，它与事件有一个本质不同：事件是同步触发，也就是说，当DOM发生变动，立刻会触发相应的事件；Mutation Observer则是异步触发，DOM发生变动以后，并不会马上触发，而是要等到当前所有DOM操作都结束后才触发。

这样设计是为了应付DOM变动频繁的特点。

Mutation Observer有以下特点：

* 它等待所有脚本任务完成后，才会运行，即采用异步方式。
* 它把DOM变动记录封装成一个数组进行处理，而不是一条条地个别处理DOM变动。
* 它既可以观察发生在DOM的所有类型变动，也可以观察某一类变动。

## MutationObserver构造函数

使用MutationObserver构造函数，新建一个观察器实例，同时指定这个实例的回调函数。

	var observer = new MutationObserver(callback);

观察器的回调函数会在每次DOM发生变动后调用。它接受两个参数，第一个是变动数组（详见后文），第二个是观察器实例。


## Mutation Observer实例的方法

* observe方法指定所要观察的DOM节点，以及所要观察的特定变动

	observe方法接受两个参数，第一个是所要观察的DOM元素是article，第二个是所要观察的变动类型（子节点变动和属性变动）。
	
* disconnect()方法用来停止观察。
* takeRecords方法用来清除变动记录，即不再处理未处理的变动。该方法返回变动记录的数组。

### MutationRecord对象

DOM每次发生变化，就会生成一条变动记录。这个变动记录对应一个MutationRecord对象，该对象包含了与变动相关的所有信息。Mutation Observer处理的是一个个MutationRecord对象所组成的数组。

MutationRecord对象包含了DOM的相关信息，有如下属性：

* type：观察的变动类型（attribute、characterData或者childList）。
* target：发生变动的DOM节点。
* addedNodes：新增的DOM节点。
* removedNodes：删除的DOM节点。
* previousSibling：前一个同级节点，如果没有则返回null。
* nextSibling：下一个同级节点，如果没有则返回null。
* attributeName：发生变动的属性。如果设置了attributeFilter，则只返回预先指定的属性。
* oldValue：变动前的值。这个属性只对attribute和characterData变动有效，如果发生childList变动，则返回null。	


## 实例

子元素的变动

	var callback = function(records){
	  records.map(function(record){
	    console.log('Mutation type: ' + record.type);
	    console.log('Mutation target: ' + record.target);
	  });
	};
	
	var mo = new MutationObserver(callback);
	
	var option = {
	  'childList': true,
	  'subtree': true
	};
	
	mo.observe(document.body, option);

上面代码的观察器，观察body的所有下级节点（childList表示观察子节点，subtree表示观察后代节点）的变动。回调函数会在控制台显示所有变动的类型和目标节点。


	

## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)