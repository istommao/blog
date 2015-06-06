#JSON学习笔记

#简介

JSON: JavaScript Object Notation(JavaScript 对象表示法)
JSON 是存储和交换文本信息的语法。类似 XML。
JSON 比 XML 更小、更快，更易解析。

##与 XML 相同之处

* JSON 是纯文本
* JSON 具有"自我描述性"（人类可读）
* JSON 具有层级结构（值中存在值）
* JSON 可通过 JavaScript 进行解析
* JSON 数据可使用 AJAX 进行传输
##与 XML 不同之处

* 没有结束标签
* 更短
* 读写的速度更快
* 能够使用内建的 JavaScript eval() 方法进行解析
* 使用数组
* 不使用保留字

#JSON 语法规则

JSON 语法是 JavaScript 对象表示法语法的子集。

* 数据在名称/值对中
* 数据由逗号分隔
* 花括号保存对象
* 方括号保存数组

##JSON 名称/值对
名称/值对包括字段名称（在双引号中），后面写一个冒号，然后是值：

	"firstName" : "John"
##JSON 值

JSON 值可以是：

* 数字（整数或浮点数）
* 字符串（在双引号中）
* 逻辑值（true 或 false）
* 数组（在方括号中）
* 对象（在花括号中）
* null

##JSON 对象

JSON 对象在花括号中书写：

对象可以包含多个名称/值对：

	{ "firstName":"John" , "lastName":"Doe" }


##JSON 数组

JSON 数组在方括号中书写：

数组可包含多个对象：

	{
	"employees": [
		{ "firstName":"John" , "lastName":"Doe" }, 
		{ "firstName":"Anna" , "lastName":"Smith" }, 
		{ "firstName":"Peter" , "lastName":"Jones" }
	]
	}
在上面的例子中，对象 "employees" 是包含三个对象的数组。每个对象代表一条关于某人（有姓和名）的记录。

