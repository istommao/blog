#XML
#什么是XML

* XML 指可扩展标记语言（eXtensible Markup Language）。
* XML 被设计用来传输和存储数据。
* XML 是一种很像HTML的标记语言。
* XML 的设计宗旨是传输数据，而不是显示数据。
* XML 标签没有被预定义。您需要自行定义标签。
* XML 被设计为具有自我描述性。
* XML 是 W3C 的推荐标准。


#XML 和 HTML 之间的差异
XML 不是 HTML 的替代。

XML 和 HTML 为不同的目的而设计：

* XML 被设计用来传输和存储数据，其焦点是数据的内容。
* HTML 被设计用来显示数据，其焦点是数据的外观。
* HTML 旨在显示信息，而 XML 旨在传输信息。

XML 不会做任何事情。也许这有点难以理解，但是 XML 不会做任何事情。XML 被设计用来结构化、存储以及传输信息。

**通过 XML，您可以发明自己的标签。**

##XML 不是对 HTML 的替代
**XML 是对 HTML 的补充。**

XML 不会替代 HTML，理解这一点很重要。在大多数 Web 应用程序中，XML 用于传输数据，而 HTML 用于格式化并显示数据。

对 XML 最好的描述是：

**XML 是独立于软件和硬件的信息传输工具。**

#XML用途
XML 应用于 Web 开发的许多方面，常用于简化数据的存储和共享。

##XML 把数据从 HTML 分离
如果您需要在 HTML 文档中显示动态数据，那么每当数据改变时将花费大量的时间来编辑 HTML。

通过 XML，数据能够存储在独立的 XML 文件中。这样您就可以专注于使用 HTML/CSS 进行显示和布局，并确保修改底层数据不再需要对 HTML 进行任何的改变。

通过使用几行 JavaScript 代码，您就可以读取一个外部 XML 文件，并更新您的网页的数据内容。

##XML 简化数据共享
在真实的世界中，计算机系统和数据使用不兼容的格式来存储数据。

XML 数据以纯文本格式进行存储，因此提供了一种独立于软件和硬件的数据存储方法。

这让创建不同应用程序可以共享的数据变得更加容易。

##XML 简化数据传输
对开发人员来说，其中一项最费时的挑战一直是在互联网上的不兼容系统之间交换数据。

由于可以通过各种不兼容的应用程序来读取数据，以 XML 交换数据降低了这种复杂性。

##XML 简化平台变更
升级到新的系统（硬件或软件平台），总是非常费时的。必须转换大量的数据，不兼容的数据经常会丢失。

XML 数据以文本格式存储。这使得 XML 在不损失数据的情况下，更容易扩展或升级到新的操作系统、新的应用程序或新的浏览器。

##XML 使您的数据更有用
不同的应用程序都能够访问您的数据，不仅仅在 HTML 页中，也可以从 XML 数据源中进行访问。

通过 XML，您的数据可供各种阅读设备使用（掌上计算机、语音设备、新闻阅读器等），还可以供盲人或其他残障人士使用。

##XML 用于创建新的互联网语言
很多新的互联网语言是通过 XML 创建的。

这里有一些实例：

* XHTML
* 用于描述可用的 Web 服务 的 WSDL
* 作为手持设备的标记语言的 WAP 和 WML
* 用于新闻 feed 的 RSS 语言
* 描述资本和本体的 RDF 和 OWL
* 用于描述针针对 Web 的多媒体 的 SMIL



#XML 树结构

XML 文档形成了一种树结构，它从"根部"开始，然后扩展到"枝叶"。

**e.g. **

	<?xml version="1.0" encoding="ISO-8859-1"?>
	<note>
	<to>Tove</to>
	<from>Jani</from>
	<heading>Reminder</heading>
	<body>Don't forget me this weekend!</body>
	</note>

#XML 语法规则

* 所有的 XML 元素都必须有一个关闭标签
  >XML 声明没有关闭标签。这不是错误。声明不是 XML 文档本身的一部分，它没有关闭标签。
* XML 标签对大小写敏感 
* XML 必须正确嵌套
* XML 文档必须有根元素
* XML 属性值必须加引号
* 在 XML 中，空格会被保留
* XML 以 LF 存储换行

##实体引用
在 XML 中，有 5 个预定义的实体引用：
<table class="reference notranslate" style="width:50%"> <tbody><tr> <td>&amp;lt;</td> <td>&lt;</td> <td>less than</td> </tr> <tr> <td>&amp;gt;</td> <td>&gt;</td> <td>greater than</td> </tr> <tr> <td>&amp;amp;</td> <td>&amp;</td> <td>ampersand </td> </tr> <tr> <td>&amp;apos;</td> <td>'</td> <td>apostrophe</td> </tr> <tr> <td>&amp;quot;</td> <td>"</td> <td>quotation mark</td> </tr> </tbody></table>

##XML 中的注释
在 XML 中编写注释的语法与 HTML 的语法很相似。

	<!-- This is a comment -->


#XML 元素
XML 文档包含 XML 元素。

##什么是 XML 元素？
XML 元素指的是从（且包括）开始标签直到（且包括）结束标签的部分。

一个元素可以包含：

* 其他元素
* 文本
* 属性
* 或混合以上所有...

##XML 命名规则
XML 元素必须遵循以下命名规则：

* 名称可以包含字母、数字以及其他的字符
* 名称不能以数字或者标点符号开始
* 名称不能以字母 xml（或者 XML、Xml 等等）开始
* 名称不能包含空格
* 可使用任何名称，没有保留的字词。


##XML 属性

XML元素具有属性，类似 HTML。

属性（Attribute）提供有关元素的额外信息。

##XML 属性必须加引号
属性值必须被引号包围，不过单引号和双引号均可使用。

##XML 元素 vs. 属性
>没有什么规矩可以告诉我们什么时候该使用属性，而什么时候该使用元素。我的经验是在 HTML 中，属性用起来很便利，但是在 XML 中，您应该尽量避免使用属性。如果信息感觉起来很像数据，那么请使用元素吧。


因使用属性而引起的一些问题：

* 属性不能包含多个值（元素可以）
* 属性不能包含树结构（元素可以）
* 属性不容易扩展（为未来的变化）
* 属性难以阅读和维护。请尽量使用元素来描述数据。而仅仅使用属性来提供与数据无关的信息。


针对元数据的 XML 属性。有时候会向元素分配 ID 引用。这些 ID 索引可用于标识 XML 元素，它起作用的方式与 HTML 中 id 属性是一样的。

>极力向您传递的理念是：元数据（有关数据的数据）应当存储为属性，而数据本身应当存储为元素。


#XML 验证

拥有正确语法的 XML 被称为"形式良好"的 XML。

通过 DTD 验证的XML是"合法"的 XML。

形式良好的 XML 文档
"形式良好"的 XML 文档拥有正确的语法。

在前面的章节描述的语法规则：

* XML 文档必须有一个根元素
* XML元素都必须有一个关闭标签
* XML 标签对大小写敏感
* XML 元素必须被正确的嵌套
* XML 属性值必须加引号

##验证 XML 文档
合法的 XML 文档是"形式良好"的 XML 文档，这也符合文档类型定义（DTD）的规则。

###XML DTD
DTD 的目的是定义 XML 文档的结构。它使用一系列合法的元素来定义文档结构：

**e.g. **

	<?xml version="1.0" encoding="ISO-8859-1"?>
	<!DOCTYPE note SYSTEM "Note.dtd">
	<note>
	<to>Tove</to>
	<from>Jani</from>
	<heading>Reminder</heading>
	<body>Don't forget me this weekend!</body>
	</note>

DTD:

	<!DOCTYPE note
	[
	<!ELEMENT note (to,from,heading,body)>
	<!ELEMENT to (#PCDATA)>
	<!ELEMENT from (#PCDATA)>
	<!ELEMENT heading (#PCDATA)>
	<!ELEMENT body (#PCDATA)>
	]>

###XML Schema
W3C 支持一种基于 XML 的 DTD 代替者，它名为 XML Schema：

	<xs:element name="note">

	<xs:complexType>
	<xs:sequence>
	<xs:element name="to" type="xs:string"/>
	<xs:element name="from" type="xs:string"/>
	<xs:element name="heading" type="xs:string"/>
	<xs:element name="body" type="xs:string"/>
	</xs:sequence>
	</xs:complexType>

	</xs:element>


##显示XML
###使用 CSS 显示 XML

通过使用 CSS（Cascading Style Sheets 层叠样式表），您可以添加显示信息到 XML 文档中。

使用 CSS 格式化 XML 不是常用的方法。W3C 推荐使用 XSLT。

###使用 XSLT 显示 XML

通过使用 XSLT，您可以把 XML 文档转换成 HTML 格式。

XSLT 是首选的 XML 样式表语言。

XSLT（eXtensible Stylesheet Language Transformations）远比 CSS 更加完善。

XSLT 是在浏览器显示 XML 文件之前，先把它转换为 HTML。

#XMLHttpRequest 对象

XMLHttpRequest 对象用于在后台与服务器交换数据。

XMLHttpRequest 对象是开发者的梦想，因为您能够：

* 在不重新加载页面的情况下更新网页
* 在页面已加载后从服务器请求数据
* 在页面已加载后从服务器接收数据
* 在后台向服务器发送数据

#XML DOM

DOM（Document Object Model 文档对象模型）定义了访问和操作文档的标准方法。

##XML DOM
XML DOM（XML Document Object Model）定义了访问和操作 XML 文档的标准方法。

XML DOM 把 XML 文档作为树结构来查看。

所有元素可以通过 DOM 树来访问。可以修改或删除它们的内容，并创建。

##HTML DOM
HTML DOM 定义了访问和操作 HTML 文档的标准方法。

所有 HTML 元素可以通过 HTML DOM 来访问。


#XML 命名空间

XML 命名空间提供避免元素命名冲突的方法。

##xmlns 属性
当在 XML 中使用前缀时，一个所谓的用于前缀的命名空间必须被定义。

命名空间是在元素的开始标签的 xmlns 属性中定义的。

	<h:table xmlns:h="http://www.w3.org/TR/html4/">
	<f:table xmlns:f="http://www.w3cschool.cc/furniture">
<table> 标签的 xmlns 属性定义了 h: 和 f: 前缀的合格命名空间。

##统一资源标识符（URI，全称 Uniform Resource Identifier）
统一资源标识符（URI）是一串可以标识因特网资源的字符。

最常用的 URI 是用来标识因特网域名地址的统一资源定位器（URL）。另一个不那么常用的 URI 是统一资源命名（URN）。

###默认的命名空间
为元素定义默认的命名空间可以让我们省去在所有的子元素中使用前缀的工作。它的语法如下：

	xmlns="namespaceURI"

#XML CDATA

XML 文档中的所有文本均会被解析器解析。

只有 CDATA 区段中的文本会被解析器忽略。


#XML 编码

* 始终使用编码属性
* 使用支持编码的编辑器
* 确保您知道编辑器使用什么编码
* 在您的编码属性中使用相同的编码

不同编码

	<?xml version="1.0" encoding="us-ascii"?>
	<?xml version="1.0" encoding="windows-1252"?>
	<?xml version="1.0" encoding="ISO-8859-1"?>
	<?xml version="1.0" encoding="UTF-8"?>
	<?xml version="1.0" encoding="UTF-16"?>

#XML 总结
XML 可用于交换、共享和存储数据。

XML 文档形成 树状结构，在"根"和"叶子"的分支机构开始的。

XML 有非常简单的 语法规则。带有正确语法的 XML 是"形式良好"的。有效的 XML 是针对 DTD 进行验证的。

XSLT 用于把 XML 转换为其他格式，比如 HTML。

所有现代的浏览器有一个内建的 XML 解析器，可读取和操作 XML。

DOM（Document Object Model）定义了一个访问 XML 的标准方式。

XMLHttpRequest 对象提供了一个网页加载后与服务器进行通信的方式。

XML 命名空间提供了一种避免元素命名冲突的方法。

CDATA 区域内的文本会被解析器忽略。



##下一步学习什么呢？
我们推荐学习 XML DOM 和 XSLT。

如果您想要学习有关验证 XML 的知识，我们推荐学习 DTD 和 XML Schema。

下面是每个主题的一个简短描述。

###XML DOM（Document Object Model）
XML DOM 定义了一种访问和处理 XML 文档的标准方式。

XML DOM 是平台和语言独立的，可用于任何编程语言，如 Java、JavaScript 和 VBScript。


###XSLT（XML 样式表语言转换）
XSLT 是 XML 文件的样式表语言。

通过使用 XSLT，可以把 XML 文档转换为其他格式，比如 XHTML。

###XML DTD（文档类型定义）
DTD 的目的是定义 XML 文档中合法的元素、属性和实体。

通过使用 DTD，每个 XML 文件可以随身携带它自己的格式的描述。

DTD 可以被用来确认您收到的数据和您自己的数据是否有效。

###XML Schema
XML Schema 是一种基于 XML 的 DTD 替代。

不像 DTD，XML Schema 支持数据类型，且使用 XML 语法。

如果您想要学习更多有关 XML Schema 的知识，请访问我们的 XML Schema 教程。





















