# JavaScript学习笔记
========

# 为什么学习 JavaScript?
====
JavaScript web 开发人员必须学习的 3 门语言中的一门：

* HTML 定义了网页的内容
* CSS 描述了网页的布局
* JavaScript 网页的行为

# JavaScript 是脚本语言
=====
JavaScript 是一种轻量级的编程语言。

JavaScript 是可插入 HTML 页面的编程代码。

JavaScript 插入 HTML 页面后，可由所有的现代浏览器执行。


# JS用法
===

HTML 中的脚本必须位于 <script> 与 </script> 标签之间。

脚本可被放置在 HTML 页面的 <body> 和 <head> 部分中。

##\<script\> 标签
如需在 HTML 页面中插入 JavaScript，请使用 \<script\> 标签。

\<script> 和 \</script> 会告诉 JavaScript 在何处开始和结束。

\<script> 和 \</script> 之间的代码行包含了 JavaScrip

#JavaScript 语法
=====
##JavaScript 字面量
在编程语言中，一个字面量是一个常量，如 3.14。

* 数字（Number）字面量 可以是整数或者是小数，或者是科学计数(e)
* 字符串（String）字面量 可以使用单引号或双引号
* 数组（Array）字面量 定义一个数组:[]

		[40, 100, 1, 5, 25, 10]
		
* 对象（Object）字面量 :{}

		{firstName:"John", lastName:"Doe", age:50, eyeColor:"blue"}	
* 函数（Function）字面量 定义一个函数: function

		function myFunction(a, b) { return a * b;}


##JavaScript 变量: var

使用关键字 var 来定义变量， 使用等号来为变量赋值。

变量可以使用短名称（比如 x 和 y），也可以使用描述性更好的名称（比如 age, sum, totalvolume）。

* 变量必须以字母开头
* 变量也能以 $ 和 _ 符号开头（不过我们不推荐这么做）
* 变量名称对大小写敏感（y 和 Y 是不同的变量）

##JavaScript 操作符


* JavaScript使用 算术运算符 来计算值
* JavaScript使用赋值运算符给变量赋值

##JavaScript 语句
在 HTML 中，JavaScript 语句向浏览器发出的命令。

语句是用分号分隔。


##JavaScript 标识符
和其他任何编程语言一样，JavaScript 保留了一些标识符为自己所用。

JavaScript 同样保留了一些关键字，这些关键字在当前的语言版本中并没有使用，但在以后 JavaScript 扩展中会用到。

JavaScript 标识符必须以字母、下划线（_）或美元符（$）开始。

后续的字符可以是字母、数字、下划线或美元符（数字是不允许作为首字符出现的，以便 JavaScript 可以轻易区分开标识符和数字）。

以下是 JavaScript 中最​​重要的保留字（按字母顺序）：

<table class="reference"> <tbody><tr> <td>abstract</td> <td>else</td> <td>instanceof</td> <td>super</td> </tr><tr> </tr><tr> <td>boolean</td> <td>enum</td> <td>int</td> <td>switch</td> </tr><tr> </tr><tr> <td>break</td> <td>export</td> <td>interface</td> <td>synchronized</td> </tr><tr> </tr><tr> <td>byte</td> <td>extends</td> <td>let</td> <td>this</td> </tr><tr> </tr><tr> <td>case</td> <td>false</td> <td>long</td> <td>throw</td> </tr><tr> </tr><tr> <td>catch</td> <td>final</td> <td>native</td> <td>throws</td> </tr><tr> </tr><tr> <td>char</td> <td>finally</td> <td>new</td> <td>transient</td> </tr><tr> </tr><tr> <td>class</td> <td>float</td> <td>null</td> <td>true</td> </tr><tr> </tr><tr> <td>const</td> <td>for</td> <td>package</td> <td>try</td> </tr><tr> </tr><tr> <td>continue</td> <td>function</td> <td>private</td> <td>typeof</td> </tr><tr> </tr><tr> <td>debugger</td> <td>goto</td> <td>protected</td> <td>var</td> </tr><tr> </tr><tr> <td>default</td> <td>if</td> <td>public</td> <td>void</td> </tr><tr> </tr><tr> <td>delete</td> <td>implements</td> <td>return</td> <td>volatile</td> </tr><tr> </tr><tr> <td>do</td> <td>import</td> <td>short</td> <td>while</td> </tr><tr> </tr><tr> <td>double</td> <td>in</td> <td>static</td> <td>with</td> </tr><tr> </tr></tbody></table>


##JavaScript 注释: //和/**/

##JavaScript 数据类型
JavaScript 有多种数据类型：数字，字符串，数组，对象，布尔等等。

* JavaScript 字符串：使用单引号或双引号
* JavaScript 数字：只有一种数字类型。数字可以带小数点，也可以不带
* JavaScript 布尔： true、false
* JavaScript 对象：由花括号分隔。在括号内部，对象的属性以名称和值对的形式 (name : value) 来定义。属性由逗号分隔。
* 



**e.g.**

	var length = 16;                                  // Number 通过数字字面量赋值 
	var points = x * 10;                              // Number 通过表达式字面量赋值
	var lastName = "Johnson";                         // String 通过字符串字面量赋值
	var cars = ["Saab", "Volvo", "BMW"];              // Array  通过数组字面量赋值
	var person = {firstName:"John", lastName:"Doe"};  // Object 通过对象字面量赋值
	
JavaScript 拥有动态类型。这意味着相同的变量可用作不同的类型。




##JavaScript 对大小写敏感

	JavaScript 中，常见的是驼峰法的命名规则


##JavaScript 语句标识符

JavaScript 语句通常以一个 语句标识符 为开始，并执行该语句。

语句标识符是保留关键字不能作为变量名使用。

下表列出了 JavaScript 语句标识符 (关键字) ：

<table class="reference" "style="width: 100%"> <tbody><tr> <th>语句</th> <th>描述</th> </tr> <tr> <td>break</td> <td>用于跳出循环。</td> </tr> <tr> <td>catch</td> <td>语句块，在 try 语句块执行出错时执行 catch 语句块。</td> </tr> <tr> <td>continue</td> <td>跳过循环中的一个迭代。</td> </tr> <tr> <td>do ... while</td> <td>执行一个语句块，在条件语句为 true 时继续执行该语句块。</td> </tr> <tr> <td>for</td> <td>在条件语句为 true 时，可以将代码块执行指定的次数。 </td> </tr> <tr> <td>for ... in </td> <td>用于遍历数组或者对象的属性（对数组或者对象的属性进行循环操作）。</td> </tr> <tr> <td>function</td> <td>定义一个函数</td> </tr> <tr> <td>if ... else</td> <td>用于基于不同的条件来执行不同的动作。</td> </tr> <tr> <td>return</td> <td>退出函数</td> </tr> <tr> <td>switch</td> <td>用于基于不同的条件来执行不同的动作。</td> </tr> <tr> <td>throw</td> <td>抛出（生成）错误 。 </td> </tr> <tr> <td>try</td> <td>实现错误处理，与 catch 一同使用。 </td> </tr> <tr> <td>var</td> <td>声明一个变量。</td> </tr> <tr> <td>while</td> <td>当条件语句为 true 时，执行语句块。 </td> </tr> </tbody></table>


##JavaScript对象

JavaScript 对象是属性和方法的容器。

键值对通常写法为 name : value (键与值以冒号分割)。

键值对在 JavaScript 对象通常称为 对象属性。

###访问对象属性
你可以通过两种方式访问对象属性:
	
	person.lastName;
	person["lastName"];

###对象方法
对象的方法定义了一个函数，并作为对象的属性存储。

创建对象方法：

	methodName : function() { code lines }

访问对象方法：

	objectName.methodName()
	

##JavaScript函数
	
函数是由事件驱动的或者当它被调用时执行的可重复使用的代码块。

###JavaScript 函数语法
函数就是包裹在花括号中的代码块，前面使用了关键词 function：

	function functionname()
	{
	执行代码
	}

* 带参数的函数:在调用函数时，您可以向其传递值，这些值被称为参数.
* 带有返回值的函数


##Javascript变量

###局部 JavaScript 变量
在 JavaScript 函数内部声明的变量（使用 var）是局部变量，所以只能在函数内部访问它。（该变量的作用域是局部的）。

###全局 JavaScript 变量
在函数外声明的变量是全局变量，网页上的所有脚本和函数都能访问它。

###JavaScript 变量的生存期
JavaScript 变量的生命期从它们被声明的时间开始。

局部变量会在函数运行以后被删除。

全局变量会在页面关闭后被删除。


##JavaScript 作用域
在 JavaScript 中, 对象和函数同样也是变量。

在 JavaScript 中, 作用域为可访问变量，对象，函数的集合。

JavaScript 函数作用域: 作用域在函数内修改。

###JavaScript 局部作用域
变量在函数内声明，变量为局部作用域。

局部变量：只能在函数内部访问。

###JavaScript 全局变量
变量在函数外定义，即为全局变量。

全局变量有 全局作用域: 网页中所有脚本和函数均可使用。 


#JavaScript 事件

HTML 事件是发生在 HTML 元素上的事情。

当在 HTML 页面中使用 JavaScript 时， JavaScript 可以触发这些事件。

##HTML 事件
HTML 事件可以是浏览器行为，也可以是用户行为。

以下是 HTML 事件的 ：

* HTML 页面完成加载
* HTML input 字段改变时
* HTML 按钮被点击

在事件触发时 JavaScript 可以执行一些代码。

HTML 元素中可以添加事件属性，使用 JavaScript 代码来添加 HTML 元素。

	<some-HTML-element some-event='some JavaScript'>
	or
	<some-HTML-element some-event="some JavaScript">
	
###常见的HTML事件

<table class="reference" style="width: 100%"> <tbody><tr> <th>事件</th> <th>描述</th> </tr> <tr> <td>onchange</td> <td> HTML 元素改变</td> </tr> <tr> <td>onclick</td> <td>用户点击 HTML 元素</td> </tr> <tr> <td>onmouseover</td> <td>用户在一个HTML元素上移动鼠标</td> </tr> <tr> <td>onmouseout</td> <td>用户从一个HTML元素上移开鼠标</td> </tr> <tr> <td>onkeydown</td> <td>用户按下键盘按键</td> </tr> <tr> <td>onload</td> <td>浏览器已完成页面的加载</td> </tr> </tbody></table>


#JavaScript 字符串

JavaScript 字符串用于存储和处理文本。


###字符串属性

<table class="reference"> <tbody><tr> <th style="width:24%">属性</th> <th>描述</th> </tr> <tr> <td>constructor</td> <td>返回创建字符串属性属性的函数</td> </tr> <tr> <td>length</td> <td>返回字符串的长度</td> </tr> <tr> <td>prototype</td> <td>允许您向对象添加属性和方法</td> </tr> </tbody></table>		
		
###字符串方法

<table class="reference"> <tbody><tr> <th style="width:24%">Method</th> <th>描述</th> </tr> <tr> <td>charAt()</td> <td>返回指定索引位置的字符</td> </tr> <tr> <td>charCodeAt()</td> <td>返回指定索引位置字符的 Unicode 值</td> </tr> <tr> <td>concat()</td> <td>连接两个或多个字符串，返回连接后的字符串</td> </tr> <tr> <td>fromCharCode()</td> <td>将字符转换为 Unicode 值</td> </tr> <tr> <td>indexOf()</td> <td>返回字符串中检索指定字符第一次出现的位置</td> </tr> <tr> <td>lastIndexOf()</td> <td>返回字符串中检索指定字符最后一次出现的位置</td> </tr> <tr> <td>localeCompare()</td> <td>用本地特定的顺序来比较两个字符串</td> </tr> <tr> <td>match()</td> <td>找到一个或多个正则表达式的匹配</td> </tr> <tr> <td>replace()</td> <td>替换与正则表达式匹配的子串</td> </tr> <tr> <td>search()</td> <td>检索与正则表达式相匹配的值</td> </tr> <tr> <td>slice()</td> <td>提取字符串的片断，并在新的字符串中返回被提取的部分</td> </tr> <tr> <td>split()</td> <td>把字符串分割为子字符串数组</td> </tr> <tr> <td>substr()</td> <td>从起始索引号提取字符串中指定数目的字符</td> </tr> <tr> <td>substring()</td> <td>提取字符串中两个指定的索引号之间的字符</td> </tr> <tr> <td>toLocaleLowerCase()</td> <td>根据主机的语言环境把字符串转换为小写，只有几种语言（如土耳其语）具有地方特有的大小写映射</td> </tr> <tr> <td>toLocaleUpperCase()</td> <td>根据主机的语言环境把字符串转换为大写，只有几种语言（如土耳其语）具有地方特有的大小写映射</td> </tr> <tr> <td>toLowerCase()</td> <td>把字符串转换为小写</td> </tr> <tr> <td>toString()</td> <td>返回字符串对象值</td> </tr> <tr> <td>toUpperCase()</td> <td>把字符串转换为大写</td> </tr> <tr> <td>trim()</td> <td>移除字符串首尾空白</td> </tr> <tr> <td>valueOf()</td> <td>返回某个字符串对象的原始值</td> </tr> </tbody></table>


#JavaScript 运算符

###JavaScript 算术运算符

<table class="reference notranslate"> <tbody><tr> <th width="13%" align="left">运算符</th> <th width="32%" align="left">描述</th> <th width="15%" align="left">例子</th> <th width="15%" align="left"> x 运算结果</th> <th width="15%" align="left"> y 运算结果</th> </tr> <tr> <td valign="top">+</td> <td valign="top">加法</td> <td valign="top">x=y+2</td> <td valign="top">7</td> <td valign="top">5</td>  </tr> <tr> <td valign="top">-</td> <td valign="top">减法</td> <td valign="top">x=y-2</td> <td valign="top">3</td> <td valign="top">5</td>  </tr> <tr> <td valign="top">*</td> <td valign="top">乘法</td> <td valign="top">x=y*2</td> <td valign="top">10</td> <td valign="top">5</td>  </tr> <tr> <td valign="top">/</td> <td valign="top">除法 </td> <td valign="top">x=y/2</td> <td valign="top">2.5</td> <td valign="top">5</td>  </tr> <tr> <td valign="top">%</td> <td valign="top">取模（余数）</td> <td valign="top">x=y%2</td> <td valign="top">1</td> <td valign="top">5</td>  </tr> <tr> <td valign="top" rowspan="2">++</td> <td valign="top" rowspan="2">自增</td> <td valign="top">x=++y</td> <td valign="top">6</td> <td valign="top">6</td>  </tr> <tr class="fixzebra"> <td valign="top">x=y++</td> <td valign="top">5</td> <td valign="top">6</td>  </tr> <tr style="background-color:#ffffff"> <td valign="top" rowspan="2">--</td> <td valign="top" rowspan="2">自减</td> <td valign="top">x=--y</td> <td valign="top">4</td> <td valign="top">4</td>  </tr> <tr style="background-color:#ffffff"> <td valign="top">x=y--</td> <td valign="top">5</td> <td valign="top">4</td>  </tr> </tbody></table>

		
###JavaScript 赋值运算符	

=、+=、-=、*=、/=、%=

###用于字符串的 + 运算符
\+ 运算符用于把文本值或字符串变量加起来（连接起来）。

两个数字相加，返回数字相加的和，如果数字与字符串相加，返回字符串	
		
###比较运算符
<table class="reference "> <tbody><tr> <th width="15%" align="left">运算符</th> <th width="40%" align="left">描述</th> <th width="18%" align="left">比较</th> <th width="17%" align="left">返回值</th> <th width="10%" align="left">实例</th> </tr> <tr style="background-color:#ffffff"> <td valign="top" rowspan="2">==</td> <td valign="top" rowspan="2">等于</td> <td valign="top">x==8</td> <td valign="top"><em>false</em></td>  </tr> <tr style="background-color:#ffffff"> <td valign="top">x==5</td> <td valign="top"><em>true</em></td>  </tr> <tr class="fixzebra"> <td valign="top" rowspan="2">===</td> <td valign="top" rowspan="2">绝对等于 (值和类型均相等)</td> <td valign="top">x==="5"</td> <td valign="top"><em>false</em></td>  </tr> <tr class="fixzebra"> <td valign="top">x===5</td> <td valign="top"><em>true</em></td> <</tr> <tr> <td valign="top">!=</td> <td valign="top">&nbsp;不等于</td> <td valign="top">x!=8</td> <td valign="top"><em>true</em></td>  </tr> <tr> <td valign="top" rowspan="2">!==</td> <td valign="top" rowspan="2">&nbsp;绝对不等于 (值和类型均不相等)</td> <td valign="top">x!=="5"</td> <td valign="top"><em>true</em></td>  </tr> <tr class="fixzebra"> <td valign="top">x!==5</td> <td valign="top"><em>false</em></td>  </tr> <tr style="background-color:#ffffff"> <td valign="top">&gt;</td> <td valign="top">&nbsp;大于</td> <td valign="top">x&gt;8</td> <td valign="top"><em>false</em></td> </tr> <tr class="fixzebra"> <td valign="top">&lt;</td> <td valign="top">&nbsp;小于</td> <td valign="top">x&lt;8</td> <td valign="top"><em>true</em></td>  </tr> <tr style="background-color:#ffffff"> <td valign="top">&gt;=</td> <td valign="top">&nbsp;大于或等于</td> <td valign="top">x&gt;=8</td> <td valign="top"><em>false</em></td>  </tr> <tr class="fixzebra"> <td valign="top">&lt;=</td> <td valign="top">&nbsp;小于或等于</td> <td valign="top">x&lt;=8</td> <td valign="top"><em>true</em></td>  </tr> </tbody></table>


###逻辑运算符

&&、||、!


#JavaScript语句

> 基本和C语言是一致的

###If...Else 语句
	if (condition1)
	  {
	  当条件 1 为 true 时执行的代码
	  }
	else if (condition2)
	  {
	 当条件 2 为 true 时执行的代码
	  }
	else
	  {
	  当条件 1 和 条件 2 都不为 true 时执行的代码
	  }		

###switch 语句

switch 语句用于基于不同的条件来执行不同的动作。

	switch(n)
	{
	case 1:
	  执行代码块 1
	break;
	case 2:
	  执行代码块 2
	break;
	default:
	 n 与 case 1 和 case 2 不同时执行的代码
	}		
		
###for 循环

循环可以将代码块执行指定的次数。

	for (语句 1; 语句 2; 语句 3)
	  {
	  被执行的代码块
	  }
		

###For/In 循环
JavaScript for/in 语句循环遍历对象的属性

	var person={fname:"John",lname:"Doe",age:25}; 
	
	for (x in person)
	  {
	  txt=txt + person[x];
	  }

###while 循环		

	while (条件)
	  {
	  需要执行的代码
	  }
  
###do/while 循环

	do
	  {
	  需要执行的代码
	  }
	while (条件);
  		 
		
		
###Break 和 Continue 语句

break 语句用于跳出循环。

continue 用于跳过循环中的一个迭代。

###JavaScript 标签
如需标记 JavaScript 语句，请在语句之前加上冒号

#typeof, null, 和 undefined

###typeof 操作符
你可以使用 typeof 操作符来检测变量的数据类型。

###Null
在 JavaScript 中 null 表示 "什么都没有"。

null是一个只有一个值的特殊类型。表示一个空对象引用。

###Undefined
在 JavaScript 中, undefined 是一个没有设置值的变量。

typeof 一个没有值的变量会返回 undefined。

	typeof undefined             // undefined
	typeof null                  // object
	null === undefined           // false
	null == undefined            // true


#JavaScript 数据类型
在 JavaScript 中有 5 中不同的数据类型：

* string
* number
* boolean
* object
* function

3 种对象类型：

* Object
* Date
* Array

2 个不包含任何值的数据类型：

* null
* undefined
		
		
#JavaScript 正则表达式

语法

	/pattern/modifiers;

使用字符串方法
在 JavaScript 中，正则表达式通常用于两个字符串方法 : search() 和 replace()。

> search() 方法 用于检索字符串中指定的子字符串，或检索与正则表达式相匹配的子字符串，并返回子串的起始位置。

> replace() 方法 用于在字符串中用一些字符替换另一些字符，或替换一个与正则表达式匹配的子串。

search() 方法使用正则表达式

	var str = "Visit w3cschool";
	var n = str.search(/w3cschool/i);

search() 方法使用字符串:

	检索字符串中 "w3cschool" 的子串：
	
	var str = "Visit w3cschool!";
	var n = str.search("w3cschool");	

replace() 方法使用正则表达式

	var str = "Visit Microsoft!";
	var res = str.replace(/microsoft/i, "w3cschool");

replace() 方法使用字符串

	var str = "Visit Microsoft!";
	var res = str.replace("Microsoft", "w3cschool");

###正则表达式修饰符
修饰符 可以在全局搜索中不区分大小写:

<table class="reference"> <tbody><tr> <th style="width: 22%;">修饰符</th> <th>描述</th> </tr> <tr> <td>i</td> <td>执行对大小写不敏感的匹配。</td> </tr> <tr> <td>g</td> <td>执行全局匹配（查找所有匹配而非在找到第一个匹配后停止）。</td> </tr> <tr> <td>m</td> <td>执行多行匹配。</td> </tr> </tbody></table>

###正则表达式模式
方括号用于查找某个范围内的字符：

<table class="reference"> <tbody><tr> <th style="width: 22%;">表达式</th> <th>描述</th> </tr> <tr> <td>[abc]</td> <td>查找方括号之间的任何字符。</td> </tr><tr> <td>[0-9]</td> <td>查找任何从 0 至 9 的数字。</td> </tr><tr> <td>(x|y)</td> <td>查找任何以 | 分隔的选项。 </td> </tr> </tbody></table>

元字符是拥有特殊含义的字符：

<table class="reference"> <tbody><tr> <th style="width: 22%;">元字符</th> <th>描述</th> </tr> <tr> <td>\d</td> <td>查找数字。</td> </tr> <tr> <td>\s</td> <td>查找空白字符。</td> </tr> <tr> <td>\b</td> <td>匹配单词边界。</td> </tr> <tr> <td>\uxxxx</td> <td>查找以十六进制数 xxxx 规定的 Unicode 字符。</td> </tr> </tbody></table>


量词:

<table class="reference"> <tbody><tr> <th style="width: 22%;">量词</th> <th>描述</th> </tr> <tr> <td>n+</td> <td>匹配任何包含至少一个 <em>n</em> 的字符串。</td> </tr> <tr> <td>n*</td> <td>匹配任何包含零个或多个 <em>n</em> 的字符串。 </td> </tr> <tr> <td>n?</td> <td>匹配任何包含零个或一个 <em>n</em> 的字符串。</td> </tr> </tbody></table>


##使用 RegExp 对象
在 JavaScript 中，RegExp 对象是一个预定义了属性和方法的正则表达式对象。

###使用 test()
test() 方法是一个正则表达式方法。

test() 方法用于检测一个字符串是否匹配某个模式，如果字符串中含有匹配的文本，则返回 true，否则返回 false。


###使用 exec()
exec() 方法是一个正则表达式方法。

exec() 方法用于检索字符串中的正则表达式的匹配。

该函数返回一个数组，其中存放匹配的结果。如果未找到匹配，则返回值为 null。


#错误 - throw、try 和 catch

try 语句测试代码块的错误。

catch 语句处理错误。

throw 语句创建自定义错误。

##try 和 catch
try 语句允许我们定义在执行时进行错误测试的代码块。

catch 语句允许我们定义当 try 代码块发生错误时，所执行的代码块。

JavaScript 语句 try 和 catch 是成对出现的。

	try
	  {
	  //在这里运行代码
	  }
	catch(err)
	  {
	  //在这里处理错误
	  }

##Throw 语句
throw 语句允许我们创建自定义错误。

正确的技术术语是：创建或抛出异常（exception）。

如果把 throw 与 try 和 catch 一起使用，那么您能够控制程序流，并生成自定义的错误消息。


#JavaScript 表单验证
JavaScript 可用来在数据被送往服务器前对 HTML 表单中的这些输入数据进行验证。

表单数据经常需要使用 JavaScript 来验证其正确性：


* 验证表单数据是否为空？

* 验证输入是否是一个正确的email地址？

* 验证日期是否输入正确？

* 验证表单输入内容是否为数字型？


#保留字
##JavaScript 保留关键字
Javascript 的保留关键字不可以用作变量、标签或者函数名。有些保留关键字是作为 Javascript 以后扩展使用。

<table class="reference"> <tbody><tr> <td>abstract</td> <td>arguments</td> <td>boolean</td> <td>break</td> <td>byte</td> </tr> <tr> <td>case</td> <td>catch</td> <td>char</td> <td>class*</td> <td>const</td> </tr> <tr> <td>continue</td> <td>debugger</td> <td>default</td> <td>delete</td> <td>do</td> </tr> <tr> <td>double</td> <td>else</td> <td>enum*</td> <td>eval</td> <td>export*</td> </tr> <tr> <td>extends*</td> <td>false</td> <td>final</td> <td>finally</td> <td>float</td> </tr> <tr> <td>for</td> <td>function</td> <td>goto</td> <td>if</td> <td>implements</td> </tr> <tr> <td>import*</td> <td>in</td> <td>instanceof</td> <td>int</td> <td>interface</td> </tr> <tr> <td>let</td> <td>long</td> <td>native</td> <td>new</td> <td>null</td> </tr> <tr> <td>package</td> <td>private</td> <td>protected</td> <td>public</td> <td>return</td> </tr> <tr> <td>short</td> <td>static</td> <td>super*</td> <td>switch</td> <td>synchronized</td> </tr> <tr> <td>this</td> <td>throw</td> <td>throws</td> <td>transient</td> <td>true</td> </tr> <tr> <td>try</td> <td>typeof</td> <td>var</td> <td>void</td> <td>volatile</td> </tr> <tr> <td>while</td> <td>with</td> <td>yield</td> <td></td> <td></td> </tr> </tbody></table>



##JavaScript 对象、属性和方法
您也应该避免使用 JavaScript 内置的对象、属性和方法的名称作为 Javascript 的变量或函数名：
<table class="reference"> <tbody><tr> <td>Array</td> <td>Date</td> <td>eval</td> <td>function</td> <td>hasOwnProperty</td> </tr> <tr> <td>Infinity</td> <td>isFinite</td> <td>isNaN</td> <td>isPrototypeOf</td> <td>length</td> </tr> <tr> <td>Math</td> <td>NaN</td> <td>name</td> <td>Number</td> <td>Object</td> </tr> <tr> <td>prototype</td> <td>String</td> <td>toString</td> <td>undefined</td> <td>valueOf</td> </tr> </tbody></table>


##Java 保留关键字
JavaScript 经常与 Java 一起使用。您应该避免使用一些 Java 对象和属性作为 JavaScript 标识符：

<table class="reference"> <tbody><tr> <td>getClass</td> <td>java</td> <td>JavaArray</td> <td>javaClass</td> <td>JavaObject</td> <td>JavaPackage</td> </tr> </tbody></table>

##Windows 保留关键字
JavaScript 可以在 HTML 外部使用。它可在许多其他应用程序中作为编程语言使用。

在 HTML 中，您必须（为了可移植性，您也应该这么做）避免使用 HTML 和 Windows 对象和属性的名称作为 Javascript 的变量及函数名

<table class="reference"> <tbody><tr> <td>alert</td> <td>all</td> <td>anchor</td> <td>anchors</td> <td>area</td> </tr> <tr> <td>assign</td> <td>blur</td> <td>button</td> <td>checkbox</td> <td>clearInterval</td> </tr> <tr> <td>clearTimeout</td> <td>clientInformation</td> <td>close</td> <td>closed</td> <td>confirm</td> </tr> <tr> <td>constructor</td> <td>crypto</td> <td>decodeURI</td> <td>decodeURIComponent</td> <td>defaultStatus</td> </tr> <tr> <td>document</td> <td>element</td> <td>elements</td> <td>embed</td> <td>embeds</td> </tr> <tr> <td>encodeURI</td> <td>encodeURIComponent</td> <td>escape</td> <td>event</td> <td>fileUpload</td> </tr> <tr> <td>focus</td> <td>form</td> <td>forms</td> <td>frame</td> <td>innerHeight</td> </tr> <tr> <td>innerWidth</td> <td>layer</td> <td>layers</td> <td>link</td> <td>location</td> </tr> <tr> <td>mimeTypes</td> <td>navigate</td> <td>navigator</td> <td>frames</td> <td>frameRate</td> </tr> <tr> <td>hidden</td> <td>history</td> <td>image</td> <td>images</td> <td>offscreenBuffering</td> </tr> <tr> <td>open</td> <td>opener</td> <td>option</td> <td>outerHeight</td> <td>outerWidth</td> </tr> <tr> <td>packages</td> <td>pageXOffset</td> <td>pageYOffset</td> <td>parent</td> <td>parseFloat</td> </tr> <tr> <td>parseInt</td> <td>password</td> <td>pkcs11</td> <td>plugin</td> <td>prompt</td> </tr> <tr> <td>propertyIsEnum</td> <td>radio</td> <td>reset</td> <td>screenX</td> <td>screenY</td> </tr> <tr> <td>scroll</td> <td>secure</td> <td>select</td> <td>self</td> <td>setInterval</td> </tr> <tr> <td>setTimeout</td> <td>status</td> <td>submit</td> <td>taint</td> <td>text</td> </tr> <tr> <td>textarea</td> <td>top</td> <td>unescape</td> <td>untaint</td> <td>window</td> </tr> </tbody></table>

##HTML 事件句柄
除此之外，您还应该避免使用 HTML 事件句柄的名称作为 Javascript 的变量及函数名。

<table class="reference"> <tbody><tr> <td>onblur</td> <td>onclick</td> <td>onerror</td> <td>onfocus</td> </tr> <tr> <td>onkeydown</td> <td>onkeypress</td> <td>onkeyup</td> <td>onmouseover</td> </tr> <tr> <td>onload</td> <td>onmouseup</td> <td>onmousedown</td> <td>onsubmit</td> </tr><tr> </tr></tbody></table>



#JavaScript 函数定义

###函数声明

	function functionName(parameters) {
	  执行的代码
	}

###函数表达式
JavaScript 函数可以通过一个表达式定义。

函数表达式可以存储在变量中：
	
	var x = function (a, b) {return a * b};

在函数表达式存储在变量后，变量也可作为一个函数使用：

	var z = x(4, 3);
	

以上函数实际上是一个 匿名函数 (函数没有名称)。

函数存储在变量中，不需要函数名称，通常通过变量名来调用。

上述函数以分号结尾，因为它是一个执行语句。


###Function() 构造函数
在以上实例中，我们了解到函数通过关键字 function 定义。

函数同样可以通过内置的 JavaScript 函数构造器（Function()）定义。

	var myFunction = new Function("a", "b", "return a * b");

	var x = myFunction(4, 3);
	
	或者：
	
	var myFunction = function (a, b) {return a * b}

	var x = myFunction(4, 3);

在 JavaScript 中，很多时候，你需要避免使用 new 关键字。


###自调用函数
函数表达式可以 "自调用"。

自调用表达式会自动调用。

如果表达式后面紧跟 () ，则会自动调用。

	(function () {
    	var x = "Hello!!";      // 我将调用自己
	})();


##函数是对象
在 JavaScript 中使用 typeof 操作符判断函数类型将返回 "function" 。

但，JavaScript 函数描述为一个对象更加准确。

JavaScript 函数有 属性 和 方法。

arguments.length 属性返回函数调用过程接收到的参数个数

##函数参数

JavaScript 函数对参数的值(arguments)没有进行任何的检查。

###函数显式参数与隐藏参数(arguments)

###默认参数
如果函数在调用时缺少参数，参数会默认设置为： undefined

###Arguments 对象
JavaScript 函数有个内置的对象 arguments 对象.

argument 对象包含了函数调用的参数数组。


###通过值传递参数
在函数中调用的参数是函数的参数。

如果函数修改参数的值，将不会修改参数的初始值（在函数外定义）。

函数参数的改变不会影响函数外部的变量（局部变量）。

###通过对象传递参数
在JavaScript中，可以引用对象的值。

因此我们在函数内部修改对象的属性就会修改其初始的值。

修改对象属性可作用于函数外部（全局变量）。


##函数调用

JavaScript 函数有 4 种调用方式。

每种方式的不同方式在于 this 的初始化。

* 作为一个函数调用
	
		myFunction(10, 2);

* 函数作为方法调用

		myObject.fullName();

* 使用构造函数调用函数

		var x = new myFunction("John","Doe");
		x.firstName; 

* 作为函数方法调用函数

	call() 和 apply() 是预定义的函数方法。 两个方法可用于调用函数，两个方法的第一个参数必须是对象本身。
	
		function myFunction(a, b) {
		    return a * b;
		}
		myFunction.call(myObject, 10, 2);  
		
		function myFunction(a, b) {
		    return a * b;
		}
		myArray = [10,2];
		myFunction.apply(myObject, myArray); 

#JavaScript 闭包

 JavaScript 闭包。它使得函数拥有私有变量变成可能。
 
 闭包是可访问上一层函数作用域里变量的函数，即便上一层函数已经关闭。



