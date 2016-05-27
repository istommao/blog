title: reStructuredText语法
date: 2016-05-27 09:37:00
tags:
- rst
- reStructuredText


# reStructuredText语法

标题（Title）: 作为修饰的字符长度要大于等于文字长度。另外，标题是能够嵌套的

	===================
	这就是一个标题
	===================
	 
	----------------
	这也是一个章节标题
	----------------	
	
	这也是一个章节标题
	----------------
	
段落（Paragraphs）: 段落一般隶属于某个章节中，是一块左对齐并且没有其他元素体标记的块。在.rst文件中，段落和其他内容的分割是靠空行来完成，如果段落相较于其他的段落有缩进，reStructuredText会解析为引用段落，样式上有些不同。

	这里是一段reStructuredText的内容，它可以很长很长。。。。最后，末尾留出空行表示是本段落的结束即可。
	 
	 
	这里是另外一段reStructuredText的内容，这段内容和上一段之间，乃至后面的其他内容之间都要留出空行进行分割。
	 
	    这个也是段落，当时由于缩进了，会变成引用段落。显示和直接的段落有点不同	
	
列表(List): 无序列表要求文本块是以下面这些字符开始，并且后面紧跟空格，而后跟列表项的内容，其中列表项比趋势左对齐并且有与列表对应的缩进。有序列表在格式上和无序列表差不多，但是在使用的前缀修饰符上，使用的不是无序列表那种字符，而是可排序的字符。在你标明第一个条目的序号字符后，第二个开始你还可以使用`"#"`号来让reStructuredText自动生成需要的序号

	- 这里是列表的第一个列表项
	 
	- 这是第二个列表项
	 
	- 这是第三个列表项
	 
	  - 这是缩进的第一个列表项
	    注意，这里的缩进要和当前列表项的缩进同步。
	 
	- 第一级的第四个列表项
	 
	- 列表项之间要用个空格来分割。
	
定义列表：每个定义列表项里面包含术语（term），分类器（classifiers，可选）， 定义（definition）。术语是一行文字或者短语，分类器跟在术语后面，用“ ： ”(空格，冒号，空格）分隔。定义是相对于术语缩进后的一个块。定义中可以包含多个段落或者其他的内容元素。术语和定义之间可以没有空行，但是在定义列表前后必须要有空行的存在。下面是示例：

	术语1
	    术语1的定义
	 
	术语 2
	    术语2的定义,这是第一段
	 
	    术语2的定义，第二段
	 
	术语 3 : 分类器
	    术语3的定义
	 
	 
	术语 4 : 分类器1 : 分类器2
	    术语4的定义	

表格(Table)

列需要和`"="`左对齐，不然可能会导致出错；如果碰到第一列为空时，需要使用`"\"`来转义，不然会被视为是上一行的延续；网格表和简单表中，简单表比较适合展现简单的数据，这些数据本身不需要太复杂的展现形式，而一旦碰到需要和并单元格这类的复杂操作，可能网格表会更加适合。



简单表格：这种表格比网格表来说简单许多，一般用于简单的数据展示。其用于修饰的字符也仅两个而已：

	=====  =====  =======
	  A      B    A and B
	=====  =====  =======
	False  False  False
	True   False  False
	False  True   False
	True   True   True
	=====  =====  =======
	
	
	=====  =====  ======
	   Inputs     Output
	------------  ------
	  A      B    A or B
	=====  =====  ======
	False  False  False A
	True   False  True
	False  True   True
	True   True   True
	=====  =====  ======	
	
“-” 用来分隔行， “=“ 用来分隔表头和表体行，"|" 用来分隔列，而"+"用来表示行和列相交的节点，如下面的例子：

	+------------------------+------------+----------+----------+
	| Header row, column 1   | Header 2   | Header 3 | Header 4 |
	| (header rows optional) |            |          |          |
	+========================+============+==========+==========+
	| body row 1, column 1   | column 2   | column 3 | column 4 |
	+------------------------+------------+----------+----------+
	| body row 2             | Cells may span columns.          |
	+------------------------+------------+---------------------+
	| body row 3             | Cells may  | - Table cells       |
	+------------------------+ span rows. | - contain           |
	| body row 4             |            | - body elements.    |
	+------------------------+------------+---------------------+	
	
块（Blocks）

块在reStructuredText中的表现方式也有好几种，但是最常见的是文字块(Literal Blocks)。这种块的表达非常简单，就是在前面内容结束之后，用两个冒号`" :: "`(空格[Optional]，冒号，冒号）来分割，并在之后紧接着插入空行，而后放入块的内容，块内容要相对之前的内容有缩进。

	这里是块之前的的内容。。。::
	
	   这里是块的内容。前面有缩进，空行，和::分隔符。
	    此处内容会被一直视为块内容
	
	    空行也不能阻断块内容。。
	
	但是，当内容像这样，不再和块内容一样缩进时，块内容就自动的结束了。	
	
样式(Style)

reStructuredText中支持对文本进行样式控制，比如：粗体(Strong)，斜体(Italic)，等宽字体(Monospace)，引用( interpreted text)。

	.. Strong Emphasis
	 
	This is **Strong Text**. HTML tag is strong.粗体
	 
	.. Italic, Emphasis
	 
	This is *Emphasis* Text.这个HTML使用em， 斜体
	 
	.. Interpreted Text
	 
	This is `Interpreted Text`. 注意，这个HTML一般用<cite>表示
	 
	.. Inline Literals
	 
	This is ``Inline Literals``. HTML tag is <tt>. 等宽字体.
	
超链接：在链接文字前面要空格与前面进行分割

	这是一个 `链接<http://blog.useasp.net>`_，不需要特别设置。	
	

## 参考

* [reStructuredText(.rst)语法规则快速入门](http://blog.useasp.net/archive/2014/09/05/rst-file-restructuredtext-markup-syntax-quikstart.aspx)
* [reStructuredText Markup Specification](http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html)