#Python学习笔记
=====
#Python简介
=====

Python是一个高层次的结合了解释性、编译性、互动性和面向对象的脚本语言。

Python的设计具有很强的可读性，相比其他语言经常使用英文关键字，其他语言的一些标点符号，它具有比其他语言更有特色语法结构。

* Python 是一种解释型语言： 这意味着开发过程中没有了编译这个环节。类似于PHP和Perl语言。

* Python 是交互式语言： 这意味着，您可以在一个Python提示符，直接互动执行写你的程序。

* Python 是面向对象语言: 这意味着Python支持面向对象的风格或代码封装在对象的编程技术。

* Python是初学者的语言：Python 对初级程序员而言，是一种伟大的语言，它支持广泛的应用程序开发，从简单的文字处理到 WWW 浏览器再到游戏。

#运行Python
有三种方式可以运行Python：

1. 交互式解释器：

	通过命令行窗口输入命令python，进入python并开在交互式解释器中开始编写Python代码。

2. 命令行脚本：

	在应用程序中通过引入解释器(#!/usr/bin/python)可以在命令行中执行Python脚本。如：python hello.py

3. 集成开发环境（IDE：Integrated Development Environment）

	使用图形用户界面（GUI）环境来编写及运行Python代码。
	
#Python基础语法
===
##Python 中文编码

在文件开头加入 # -\*- coding: UTF-8 -\*- 或者 #coding=utf-8 

##Python标识符

在python里，标识符有字母、数字、下划线组成。

在python中，所有标识符可以包括英文、数字以及下划线（_），但不能以数字开头。

python中的标识符是区分大小写的。

以下划线开头的标识符是有特殊意义的。以单下划线开头（_foo）的代表不能直接访问的类属性，需通过类提供的接口进行访问，不能用"from xxx import *"而导入；

以双下划线开头的（\_\_foo）代表类的私有成员；以双下划线开头和结尾的（\_\_foo\_\_）代表python里特殊方法专用的标识，如\_\_init\_\_（）代表类的构造函数。

##Python保留字符

保留字不能用作常数或变数，或任何其他标识符名称。

所有Python的关键字只包含小写字母。

<table class="reference"> <tbody><tr><td>and</td><td>exec</td><td>not</td></tr> <tr><td>assert</td><td>finally</td><td>or</td></tr> <tr><td>break</td><td>for</td><td>pass</td></tr> <tr><td>class</td><td>from</td><td>print</td></tr> <tr><td>continue</td><td>global</td><td>raise</td></tr> <tr><td>def</td><td>if</td><td>return</td></tr> <tr><td>del</td><td>import</td><td>try</td></tr> <tr><td>elif</td><td>in</td><td>while</td></tr> <tr><td>else</td><td>is</td><td>with </td></tr> <tr><td>except</td><td>lambda</td><td>yield</td></tr> </tbody></table>

##行和缩进

学习Python与其他语言最大的区别就是，Python的代码块不使用大括号（{}）来控制类，函数以及其他逻辑判断。python最具特色的就是用缩进来写模块。

缩进的空白数量是可变的，但是所有代码块语句必须包含相同的缩进空白数量，这个必须严格执行。

缩进相同的一组语句构成一个代码块，我们称之代码组。

像if、while、def和class这样的复合语句，首行以关键字开始，以冒号( : )结束，该行之后的一行或多行代码构成代码组。

我们将首行及后面的代码组称为一个子句(clause)。

##Python 引号
Python 接收单引号(' )，双引号(" )，三引号(''' """) 来表示字符串，引号的开始与结束必须的相同类型的。

其中三引号可以由多行组成，编写多行文本的快捷语法，常用语文档字符串，在文件的特定地点，被当做注释。

##Python注释
python中单行注释采用 # 开头。

python没有块注释

##Python 变量

###变量赋值
Python中的变量不需要声明，变量的赋值操作既是变量声明和定义的过程。

每个变量在内存中创建，都包括变量的标识，名称和数据这些信息。

每个变量在使用前都必须赋值，变量赋值以后该变量才会被创建。

等号（=）用来给变量赋值。

等号（=）运算符左边是一个变量名,等号（=）运算符右边是存储在变量中的值。

Python允许你同时为多个变量赋值： a = b = c = 1 或 a, b, c = 1, 2, "john"

###标准数据类型

* Numbers（数字）
* String（字符串）
* List（列表）
* Tuple（元组）
* Dictionary（字典）

###变量作用域
一个程序的所有的变量并不是在哪个位置都可以访问的。访问权限决定于这个变量是在哪里赋值的。

变量的作用域决定了在哪一部分程序你可以访问哪个特定的变量名称。两种最基本的变量作用域如下：
* 全局变量
* 局部变量

####局部变量
定义在函数内部的变量拥有一个局部作用域，定义在函数外的拥有全局作用域。

局部变量只能在其被声明的函数内部访问，而全局变量可以在整个程序范围内访问。调用函数时，所有在函数内声明的变量名称都将被加入到作用域中。


##Python数字
**数字数据类型用于存储数值，是不可改变的数据类型，这意味着改变数字数据类型会分配一个新的对象。**

这点和C、Cpp、Java都不同，但是与erlang是一样的。

四种不同的数值类型：

* 整型(Int) - 通常被称为是整型或整数，是正或负整数，不带小数点。
* 长整型(long integers) - 无限大小的整数，整数最后是一个大写或小写的L。
* 浮点型(floating point real values) - 浮点型由整数部分与小数部分组成，浮点型也可以使用科学计数法表示（2.5e2 = 2.5 x 102 = 250）
* 复数( (complex numbers)) - 复数的虚部以字母J 或 j结尾 。如：2+3i

<table class="reference"> <tbody><tr><th>int</th><th>long</th><th>float</th><th>complex</th></tr> <tr><td>10</td><td>51924361L</td><td>0.0</td><td>3.14j</td></tr> <tr><td>100</td><td>-0x19323L</td><td>15.20</td><td>45.j</td></tr> <tr><td>-786</td><td>0122L</td><td>-21.9</td><td>9.322e-36j</td></tr> <tr><td>080</td><td>0xDEFABCECBDAECBFBAEl</td><td>32.3+e18</td><td>.876j</td></tr> <tr><td>-0490</td><td>535633629843L</td><td>-90.</td><td>-.6545+0J</td></tr> <tr><td>-0x260</td><td>-052318172735L</td><td>-32.54e100</td><td>3e+26J</td></tr> <tr><td>0x69</td><td>-4721885298529L</td><td>70.2-E12</td><td>4.53e-7j</td></tr> </tbody></table>

###Python数学函数


###Python随机数函数

随机数可以用于数学，游戏，安全等领域中，还经常被嵌入到算法中，用以提高算法效率，并提高程序的安全性。


###Python三角函数

###Python数学常量
	

##Python序列
序列是Python中最基本的数据结构。序列中的每个元素都分配一个数字 - 它的位置，或索引，第一个索引是0，第二个索引是1，依此类推。

Python有6个序列的内置类型，但最常见的是列表和元组。

序列都可以进行的操作包括索引[]，切片[2:5]，加，乘，检查成员in/not in。

此外，Python已经内置确定序列的长度以及确定最大和最小的元素的方法。


##Python字符串
字符串或串(String)是由数字、字母、下划线组成的一串字符。

python的字串列表有2种取值顺序:

* 从左到右索引默认0开始的，最大范围是字符串长度少1
* 从右到左索引默认-1开始的，最大范围是字符串开头

###访问字符串中的值
Python不支持单字符类型，单字符也在Python也是作为一个字符串使用。

Python访问子字符串，可以使用方括号来截取字符串：str[5]。

###字符串更新
你可以对已存在的字符串进行修改，并赋值给另一个变量。

###字符串运算符

<table class="reference"> <tbody><tr> <th width="10%">操作符</th><th>描述</th><th>实例</th> </tr> <tr> <td>+</td><td>字符串连接</td><td> a + b 输出结果： HelloPython</td> </tr> <tr> <td>*</td><td>重复输出字符串</td><td> a*2 输出结果：HelloHello</td> </tr> <tr> <td>[]</td><td>通过索引获取字符串中字符</td><td> a[1] 输出结果 <b>e</b></td> </tr> <tr> <td>[ : ]</td><td>截取字符串中的一部分</td><td> a[1:4] 输出结果 <b>ell</b></td> </tr> <tr> <td>in</td><td>成员运算符 - 如果字符串中包含给定的字符返回 True </td><td> <b>H in a</b> 输出结果 1</td> </tr> <tr> <td>not in </td><td>成员运算符 - 如果字符串中不包含给定的字符返回 True </td><td> <b>M not in a</b> 输出结果 1</td> </tr> <tr> <td>r/R</td><td>原始字符串 - 原始字符串：所有的字符串都是直接按照字面的意思来使用，没有转义特殊或不能打印的字符。 原始字符串除在字符串的第一个引号前加上字母"r"（可以大小写）以外，与普通字符串有着几乎完全相同的语法。</td><td> <b>print r'\n'</b> prints \n 和 <b>print R'\n'</b> prints \n </td> </tr> <tr> <td>%</td><td>格式字符串</td><td>请看下一章节</td> </tr> </tbody></table>

###字符串格式化
Python 支持格式化字符串的输出 。尽管这样可能会用到非常复杂的表达式，但最基本的用法是将一个值插入到一个有字符串格式符 %s 的字符串中。

在 Python 中，字符串格式化使用与 C 中 sprintf 函数一样的语法。

	#!/usr/bin/python
	
	print "My name is %s and weight is %d kg!" % ('Zara', 21) 

python字符串格式化符号:


格式化操作符辅助指令:


###Unicode 字符串
Python 中定义一个 Unicode 字符串和定义一个普通字符串一样简单

	u'Hello World !'

###字符串内建函数





##Python列表
List（列表） 是 Python 中使用最频繁的数据类型。
列表可以完成大多数集合类的数据结构实现。它支持字符，数字，字符串甚至可以包含列表（所谓嵌套）。

列表用[ ]标识。是python最通用的复合数据类型。

###访问列表中的值

使用下标索引来访问列表中的值，同样你也可以使用方括号的形式截取字符

	#!/usr/bin/python

	list1 = ['physics', 'chemistry', 1997, 2000];
	list2 = [1, 2, 3, 4, 5, 6, 7 ];
	
	print "list1[0]: ", list1[0]
	print "list2[1:5]: ", list2[1:5]
	
	
###更新列表
你可以对列表的数据项进行修改或更新，你也可以使用append()方法来添加列表项。

	list[2] = 2001;

###删除列表元素
可以使用 del 语句来删除列表的的元素

	del list1[2];
	
###列表脚本操作符
列表对 + 和 * 的操作符与字符串相似。+ 号用于组合列表，* 号用于重复列表。

<table class="reference"> <tbody><tr> <th>Python 表达式</th><th>结果 </th><th> 描述</th></tr> <tr><td>len([1, 2, 3])</td><td>3</td><td>长度</td></tr> <tr><td>[1, 2, 3] + [4, 5, 6]</td><td>[1, 2, 3, 4, 5, 6]</td><td>组合</td></tr> <tr><td>['Hi!'] * 4</td><td>['Hi!', 'Hi!', 'Hi!', 'Hi!']</td><td>重复</td></tr> <tr><td>3 in [1, 2, 3]</td><td>True</td><td>元素是否存在于列表中</td></tr> <tr><td>for x in [1, 2, 3]: print x,</td><td>1 2 3</td><td>迭代</td></tr> </tbody></table>

###列表截取
Python的列表截取与字符串操作类似。


###列表函数&方法			

##Python元组

元组是另一个数据类型，类似于List（列表）。

元组用"()"标识。内部元素用逗号隔开。但是元素不能二次赋值，相当于只读列表。

Python的元组与列表类似，不同之处在于元组的元素不能修改。

元组使用小括号，列表使用方括号。

元组创建很简单，只需要在括号中添加元素，并使用逗号隔开即可。

###访问元组
元组可以使用下标索引来访问元组中的值

###修改元组

元组中的元素值是不允许修改的，但我们可以对元组进行连接组合

###删除元组
元组中的元素值是不允许删除的，但我们可以使用del语句来删除整个元组。

###元组运算符
与字符串一样，元组之间可以使用 + 号和 * 号进行运算。这就意味着他们可以组合和复制，运算后会生成一个新的元组。

###元组索引，截取
因为元组也是一个序列，所以我们可以访问元组中的指定位置的元素，也可以截取索引中的一段元素

###无关闭分隔符
任意无符号的对象，以逗号隔开，默认为元组

	x, y = 1, 2;
	==>
	(x, y) = (1, 2)
	
###元组内置函数



##Python元字典

字典(dictionary)是除列表以外python之中最灵活的内置数据结构类型。列表是有序的对象结合，字典是无序的对象集合。

两者之间的区别在于：字典当中的元素是通过键来存取的，而不是通过偏移存取。

字典用"{ }"标识。字典由索引(key)和它对应的值value组成。

字典是另一种可变容器模型，且可存储任意类型对象，如其他容器模型。

字典由键和对应值成对组成。字典也被称作关联数组或哈希表。

###访问字典里的值

把相应的键放入熟悉的方括弧: dict['Name']

如果用字典里没有的键访问数据，会输出错误。

###修改字典

向字典添加新内容的方法是增加新的键/值对。

	dict = {'Name': 'Zara', 'Age': 7, 'Class': 'First'};
 
	dict['Age'] = 8; # update existing entry
	dict['School'] = "DPS School"; # Add new entry


###删除字典元素

能删单一的元素也能清空字典，清空只需一项操作。

	del dict['Name']; # 删除键是'Name'的条目
	dict.clear();     # 清空词典所有条目
	del dict ;        # 删除词典


###字典键的特性

字典值可以没有限制地取任何python对象，既可以是标准的对象，也可以是用户定义的，但键不行。

两个重要的点需要记住：

	1）不允许同一个键出现两次。创建时如果同一个键被赋值两次，后一个值会被记住
	
	2）键必须不可变，所以可以用数，字符串或元组充当，所以用列表就不行

###字典内置函数&方法



##Python数据类型转换
有时候，我们需要对数据内置的类型进行转换，数据类型的转换，你只需要将数据类型作为函数名即可。

<table class="reference"> <tbody><tr><th>函数</th><th>描述</th></tr> <tr valign="top"> <td> <p>int(x [,base])</p> </td> <td> <p>将x转换为一个整数</p> </td> </tr> <tr valign="top"> <td> <p>long(x [,base] )</p> </td> <td> <p>将x转换为一个长整数</p> </td> </tr> <tr valign="top"> <td> <p>float(x)</p> </td> <td> <p>将x转换到一个浮点数</p> </td> </tr> <tr valign="top"> <td> <p>complex(real [,imag])</p> </td> <td> <p>创建一个复数</p> </td> </tr> <tr valign="top"> <td> <p>str(x)</p> </td> <td> <p>将对象 x 转换为字符串</p> </td> </tr> <tr valign="top"> <td> <p>repr(x)</p> </td> <td> <p>将对象 x 转换为表达式字符串</p> </td> </tr> <tr valign="top"> <td> <p>eval(str)</p> </td> <td> <p>用来计算在字符串中的有效Python表达式,并返回一个对象</p> </td> </tr> <tr valign="top"> <td> <p>tuple(s)</p> </td> <td> <p>将序列 s 转换为一个元组</p> </td> </tr> <tr valign="top"> <td> <p>list(s)</p> </td> <td> <p>将序列 s 转换为一个列表</p> </td> </tr> <tr valign="top"> <td> <p>set(s)</p> </td> <td> <p>转换为可变集合</p> </td> </tr> <tr valign="top"> <td> <p>dict(d)</p> </td> <td> <p>创建一个字典。d 必须是一个序列 (key,value)元组。</p> </td> </tr> <tr valign="top"> <td> <p>frozenset(s)</p> </td> <td> <p>转换为不可变集合</p> </td> </tr> <tr valign="top"> <td> <p>chr(x)</p> </td> <td> <p> 将一个整数转换为一个字符</p> </td> </tr> <tr valign="top"> <td> <p>unichr(x)</p> </td> <td> <p>将一个整数转换为Unicode字符</p> </td> </tr> <tr valign="top"> <td> <p>ord(x)</p> </td> <td> <p> 将一个字符转换为它的整数值</p> </td> </tr> <tr valign="top"> <td> <p>hex(x)</p> </td> <td> <p> 将一个整数转换为一个十六进制字符串</p> </td> </tr> <tr valign="top"> <td> <p>oct(x)</p> </td> <td> <p> 将一个整数转换为一个八进制字符串</p> </td> </tr> </tbody></table>

##Python 运算符

###算术运算符

变量a为10，变量b为20：

<table class="reference"> <tbody><tr> <th>运算符</th><th>描述</th><th>实例</th> </tr> <tr> <td>+</td><td>加 - 两个对象相加</td><td> a + b 输出结果 30</td> </tr> <tr> <td>-</td><td>减 - 得到负数或是一个数减去另一个数</td><td> a - b 输出结果 -10</td> </tr> <tr> <td>*</td><td>乘 - 两个数相乘或是返回一个被重复若干次的字符串</td><td> a * b 输出结果 200</td> </tr> <tr> <td>/</td><td>除 - x除以y</td><td> b / a 输出结果 2</td> </tr> <tr> <td>%</td><td>取模 - 返回除法的余数</td><td> b % a 输出结果 0</td> </tr> <tr> <td>**</td><td>幂 - 返回x的y次幂</td><td> a**b 为10的20次方， 输出结果 100000000000000000000</td> </tr> <tr> <td>//</td><td>取整除 - 返回商的整数部分</td><td> 9//2 输出结果 4 , 9.0//2.0 输出结果 4.0</td> </tr> </tbody></table>

###比较运算符

<table class="reference"> <tbody><tr> <th width="10%">运算符</th><th>描述</th><th>实例</th> </tr> <tr> <td>==</td><td> 等于 - 比较对象是否相等</td><td> (a == b) 返回 False。 </td> </tr> <tr> <td>!=</td><td> 不等于 - 比较两个对象是否不相等</td><td> (a != b) 返回 true. </td> </tr> <tr> <td>&lt;&gt;</td><td>不等于 - 比较两个对象是否不相等</td><td> (a &lt;&gt; b) 返回 true。这个运算符类似 != 。</td> </tr> <tr> <td>&gt;</td><td> 大于 - 返回x是否大于y</td><td> (a &gt; b) 返回 False。</td> </tr> <tr> <td>&lt;</td><td> 小于 - 返回x是否小于y。所有比较运算符返回1表示真，返回0表示假。这分别与特殊的变量True和False等价。注意，这些变量名的大写。</td><td> (a &lt; b) 返回 true。 </td> </tr> <tr> <td>&gt;=</td><td> 大于等于 - 返回x是否大于等于y。</td><td> (a &gt;= b) 返回 False。</td> </tr> <tr> <td>&lt;=</td><td> 小于等于 - 返回x是否小于等于y。</td><td> (a &lt;= b) 返回 true。 </td> </tr> </tbody></table>


###赋值运算符

<table class="reference"> <tbody><tr> <th>运算符</th><th>描述</th><th>实例</th> </tr> <tr> <td>=</td><td>简单的赋值运算符</td><td> c = a + b 将 a + b 的运算结果赋值为 c</td> </tr> <tr> <td>+=</td><td>加法赋值运算符</td><td> c += a 等效于 c = c + a</td> </tr> <tr> <td>-=</td><td>减法赋值运算符</td><td> c -= a 等效于 c = c - a</td> </tr> <tr> <td>*=</td><td>乘法赋值运算符</td><td> c *= a 等效于 c = c * a</td> </tr> <tr> <td>/=</td><td>除法赋值运算符</td><td> c /= a 等效于 c = c / a</td> </tr> <tr> <td>%=</td><td>取模赋值运算符</td><td> c %= a 等效于 c = c % a</td> </tr> <tr> <td>**=</td><td>幂赋值运算符</td><td> c **= a 等效于 c = c ** a</td> </tr> <tr> <td>//=</td><td> 取整除赋值运算符</td><td> c //= a 等效于 c = c // a</td> </tr> </tbody></table><table class="reference"> <tbody><tr> <th>运算符</th><th>描述</th><th>实例</th> </tr> <tr> <td>=</td><td>简单的赋值运算符</td><td> c = a + b 将 a + b 的运算结果赋值为 c</td> </tr> <tr> <td>+=</td><td>加法赋值运算符</td><td> c += a 等效于 c = c + a</td> </tr> <tr> <td>-=</td><td>减法赋值运算符</td><td> c -= a 等效于 c = c - a</td> </tr> <tr> <td>*=</td><td>乘法赋值运算符</td><td> c *= a 等效于 c = c * a</td> </tr> <tr> <td>/=</td><td>除法赋值运算符</td><td> c /= a 等效于 c = c / a</td> </tr> <tr> <td>%=</td><td>取模赋值运算符</td><td> c %= a 等效于 c = c % a</td> </tr> <tr> <td>**=</td><td>幂赋值运算符</td><td> c **= a 等效于 c = c ** a</td> </tr> <tr> <td>//=</td><td> 取整除赋值运算符</td><td> c //= a 等效于 c = c // a</td> </tr> </tbody></table>

###位运算符

<table class="reference"> <tbody><tr> <th>运算符</th><th>描述</th><th>实例</th> </tr> <tr> <td>&amp;</td><td> 按位与运算符</td><td> (a &amp; b) 输出结果 12 ，二进制解释： 0000 1100</td> </tr> <tr> <td>|</td><td> 按位或运算符</td><td> (a | b) 输出结果 61 ，二进制解释： 0011 1101</td> </tr> <tr> <td>^</td><td> 按位异或运算符 </td><td> (a ^ b) 输出结果 49 ，二进制解释： 0011 0001</td> </tr> <tr> <td>~</td><td> 按位取反运算符 </td><td> (~a ) 输出结果 -61 ，二进制解释： 1100 0011， 在一个有符号二进制数的补码形式。</td> </tr> <tr> <td>&lt;&lt;</td><td>左移动运算符 </td><td> a &lt;&lt; 2 输出结果 240 ，二进制解释： 1111 0000</td> </tr> <tr> <td>&gt;&gt;</td><td> 右移动运算符</td><td> a &gt;&gt; 2 输出结果 15 ，二进制解释： 0000 1111</td> </tr> </tbody></table>

###逻辑运算符

<table class="reference"> <tbody><tr> <th>运算符</th><th>描述</th><th>实例</th> </tr> <tr> <td>and</td><td> 布尔"与" - 如果x为False，x and y返回False，否则它返回y的计算值。</td><td> (a and b) 返回 true。</td> </tr> <tr> <td>or</td><td>布尔"或" - 如果x是True，它返回True，否则它返回y的计算值。</td><td> (a or b) 返回 true。</td> </tr> <tr><td>not</td><td>布尔"非" - 如果x为True，返回False。如果x为False，它返回True。</td><td> not(a and b) 返回 false。 </td> </tr> </tbody></table>

###成员运算符

测试实例中包含了一系列的成员，包括字符串，列表或元组

<table class="reference"> <tbody><tr> <th>运算符</th><th>描述</th><th>实例</th> </tr> <tr> <td>in</td><td> 如果在指定的序列中找到值返回True，否则返回False。</td> <td> x 在 y序列中 , 如果x在y序列中返回True。</td> </tr> <tr> <td>not in</td><td>如果在指定的序列中没有找到值返回True，否则返回False。</td> <td>x 不在 y序列中 , 如果x不在y序列中返回True。</td> </tr> </tbody></table>

###身份运算符

身份运算符用于比较两个对象的存储单元

<table class="reference"> <tbody><tr> <th>运算符</th><th>描述</th><th>实例</th> </tr> <tr> <td>is</td><td> is是判断两个标识符是不是引用自一个对象</td><td> x is y, 如果 id(x) 等于 id(y) , <b>is</b> 返回结果 1</td> </tr> <tr> <td>is not</td><td>is not是判断两个标识符是不是引用自不同对象</td><td> x is not y, 如果 id(x) 不等于 id(y). <b>is not</b> 返回结果 1 </td> </tr> </tbody></table>


###运算符优先级

<table class="reference"> <tbody><tr><th>运算符</th><th>描述</th></tr> <tr> <td>**</td> <td>指数 (最高优先级)</td> </tr><tr> <td>~ + -</td> <td>按位翻转, 一元加号和减号 (最后两个的方法名为 +@ 和 -@)</td> </tr><tr> <td>* / % //</td> <td>乘，除，取模和取整除</td> </tr><tr> <td>+ -</td> <td>加法减法</td> </tr><tr> <td>&gt;&gt; &lt;&lt;</td> <td>右移，左移运算符</td> </tr><tr> <td>&amp;</td> <td>位 'AND'</td> </tr><tr> <td>^ |</td> <td>位运算符</td> </tr><tr> <td>&lt;= &lt; &gt; &gt;=</td> <td>比较运算符</td> </tr><tr> <td>&lt;&gt; == !=</td> <td>等于运算符</td> </tr> <tr> <td>= %= /= //= -= += *= **=</td> <td>赋值运算符</td> </tr> <tr> <td>is is not</td> <td>身份运算符</td> </tr> <tr> <td>in not in</td> <td>成员运算符</td> </tr><tr> <td>not or and</td> <td>逻辑运算符</td> </tr> </tbody></table>


##Python 条件语句

if 语句用于控制程序的执行，基本形式为：

	if 判断条件：
	    执行语句……
	else：
	    执行语句……

##Python 循环语句

###While循环语句

	while 判断条件：
	    执行语句……

###循环使用 else 语句

> 在 python 中，for … else 表示这样的意思，for 中的语句和普通的没有区别，else 中的语句会在循环正常执行完（即 for 不是通过 break 跳出而中断的）的情况下执行，while … else 也是一样。

###for 循环语句

Python for循环可以遍历任何序列的项目，如一个列表或者一个字符串。

	for iterating_var in sequence:
	   statements(s)

###循环嵌套

Python 语言允许在一个循环体里面嵌入另一个循环。


###循环控制语句


####break 语句

Python break语句，就像在C语言中，打破了最小封闭for或while循环。

break语句用来终止循环语句，即循环条件没有False条件或者序列还没被完全递归完，也会停止执行循环语句。

break语句用在while和for循环中。

如果您使用嵌套循环，break语句将停止执行最深层的循环，并开始执行下一行代码。

####continue 语句

Python continue 语句跳出本次循环，而break跳出整个循环。

continue 语句用来告诉Python跳过当前循环的剩余语句，然后继续进行下一轮循环。

continue语句用在while和for循环中。

##pass 语句

Python pass是空语句，是为了保持程序结构的完整性。



#Python函数

函数是组织好的，可重复使用的，用来实现单一，或相关联功能的代码段。

函数能提高应用的模块性，和代码的重复利用率。

##定义一个函数
你可以定义一个由自己想要功能的函数，以下是简单的规则：

* 函数代码块以def关键词开头，后接函数标识符名称和圆括号()。
* 任何传入参数和自变量必须放在圆括号中间。圆括号之间可以用于定义参数。
* 函数的第一行语句可以选择性地使用文档字符串—用于存放函数说明。
* 函数内容以冒号起始，并且缩进。
* Return[expression]结束函数，选择性地返回一个值给调用方。不带表达式的return相当于返回 None。

语法：

	def functionname( parameters ):
	   "函数_文档字符串"
	   function_suite
	   return [expression]

###函数调用
定义一个函数只给了函数一个名称，指定了函数里包含的参数，和代码块结构。

###按值传递参数和按引用传递参数
所有参数（自变量）在Python里都是按引用传递。如果你在函数里修改了参数，那么在调用这个函数的函数里，原始的参数也被改变了。

###参数
以下是调用函数时可使用的正式参数类型：

* 必备参数：须以正确的顺序传入函数。调用时的数量必须和声明时的一样。例如: fun(para1, para2)
* 命名参数：命名参数和函数调用关系紧密，调用方用参数的命名确定传入的参数值。你可以跳过不传的参数或者乱序传参，因为Python解释器能够用参数名匹配参数值。 例如：fun(para = "para")
* 缺省参数: 调用函数时，缺省参数的值如果没有传入，则被认为是默认值。定义函数时已指定默认值。
* 不定长参数：需要一个函数能处理比当初声明时更多的参数。这些参数叫做不定长参数，和上述2种参数不同，声明时不会命名。

语法：

	def functionname([formal_args,] *var_args_tuple ):
	   "函数_文档字符串"
	   function_suite
	   return [expression]	

加了星号（*）的变量名会存放所有未命名的变量参数。选择不多传参数也可。

##匿名函数
用lambda关键词能创建小型匿名函数。这种函数得名于省略了用def声明函数的标准步骤。

* Lambda函数能接收任何数量的参数但只能返回一个表达式的值，同时只能不能包含命令或多个表达式。
* 匿名函数不能直接调用print，因为lambda需要一个表达式。
* lambda函数拥有自己的名字空间，且不能访问自有参数列表之外或全局名字空间里的参数。
* 虽然lambda函数看起来只能写一行，却不等同于C或C++的内联函数，后者的目的是调用小函数时不占用栈内存从而增加运行效率。

lambda函数的语法只包含一个语句

	lambda [arg1 [,arg2,.....argn]]:expression
	
	sum = lambda arg1, arg2: arg1 + arg2;


#Python 日期和时间
======

Python程序能用很多方式处理日期和时间。转换日期格式是一个常见的例行琐事。Python有一个time and calendar模组可以帮忙。

###什么是Tick？
时间间隔是以秒为单位的浮点小数。

每个时间戳都以自从1970年1月1日午夜（历元）经过了多长时间来表示。

###什么是时间元组？
很多Python函数用一个元组装起来的9组数字处理时间。

###获取当前时间
从返回浮点数的时间辍方式向时间元组转换，只要将浮点数传递给如localtime之类的函数

	localtime = time.localtime(time.time())
	
###获取格式化的时间
你可以根据需求选取各种格式，但是最简单的获取可读的时间模式的函数是asctime():

	localtime = time.asctime( time.localtime(time.time()) )

###获取某月日历
Calendar模块有很广泛的方法用来处理年历和月历。

###Time模块
Time模块包含了以下内置函数，既有时间处理相的，也有转换时间格式的

###日历（Calendar）模块
此模块的函数都是日历相关的，例如打印某月的字符月历。


#Python 模块

模块让你能够有逻辑地组织你的Python代码段。

简单地说，模块就是一个保存了Python代码的文件。模块能定义函数，类和变量。模块里也能包含可执行的代码。

##import 语句
想使用Python源文件，只需在另一个源文件里执行import语句

	import module1[, module2[,... moduleN]

##From…import 语句

Python的from语句让你从模块中导入一个指定的部分到当前命名空间中。

	from modname import name1[, name2[, ... nameN]]
	
###From…import* 语句
把一个模块的所有内容全都导入到当前的命名空间也是可行的

	from modname import *
	
	
##定位模块
当你导入一个模块，Python解析器对模块位置的搜索顺序是：

* 当前目录
* 如果不在当前目录，Python则搜索在shell变量PYTHONPATH下的每个目录
* 如果都找不到，Python会察看默认路径。UNIX下，默认路径一般为/usr/local/lib/python/

模块搜索路径存储在system模块的sys.path变量中。变量里包含当前目录，PYTHONPATH和由安装过程决定的默认目录。		
##命名空间和作用域
变量是拥有匹配对象的名字（标识符）。命名空间是一个包含了变量名称们（键）和它们各自相应的对象们（值）的字典。

一个Python表达式可以访问局部命名空间和全局命名空间里的变量。如果一个局部变量和一个全局变量重名，则局部变量会覆盖全局变量。

每个函数都有自己的命名空间。类的方法的作用域规则和通常函数的一样。

Python会智能地猜测一个变量是局部的还是全局的，它假设任何在函数内赋值的变量都是局部的。

因此，如果要给全局变量在一个函数里赋值，必须使用global语句。

global VarName的表达式会告诉Python， VarName是一个全局变量，这样Python就不会在局部命名空间里寻找这个变量了。

###dir()函数
dir()函数一个排好序的字符串列表，内容是一个模块里定义过的名字。

返回的列表容纳了在一个模块里定义的所有模块，变量和函数。

###globals()和locals()函数
根据调用地方的不同，globals()和locals()函数可被用来返回全局和局部命名空间里的名字。

如果在函数内部调用locals()，返回的是所有能在该函数里访问的命名。

如果在函数内部调用globals()，返回的是所有在该函数里能访问的全局名字。

两个函数的返回类型都是字典。所以名字们能用keys()函数摘取。

###reload()函数
当一个模块被导入到一个脚本，模块顶层部分的代码只会被执行一次。

因此，如果你想重新执行模块里顶层部分的代码，可以用reload()函数。该函数会重新导入之前导入过的模块。

	reload(module_name)
	
#Python中的包

包是一个分层次的文件目录结构，它定义了一个由模块及子包，和子包下的子包等组成的Python的应用环境。

创建文件 \_\_init\_\_.py，导入每个文件：

	from Pots import Pots
	from Isdn import Isdn
	from G3 import G3

#Python 文件I/O

##打印到屏幕
最简单的输出方法是用print语句，你可以给它传递零个或多个用逗号隔开的表达式。此函数把你传递的表达式转换成一个字符串表达式，并将结果写到标准输出

##读取键盘输入
Python提供了两个内置函数从标准输入读入一行文本，默认的标准输入是键盘。如下：

* raw_input
* input

###raw_input函数

raw_input([prompt]) 函数从标准输入读取一个行，并返回一个字符串（去掉结尾的换行符）
	
###input函数

input([prompt]) 函数和raw_input([prompt]) 函数基本可以互换，但是input会假设你的输入是一个有效的Python表达式，并返回运算结果。

##打开和关闭文件

###open函数

你必须先用Python内置的open()函数打开一个文件，创建一个file对象，相关的辅助方法才可以调用它进行读写。

	file object = open(file_name [, access_mode][, buffering])
	
###File对象的属性
一个文件被打开后，你有一个file对象，你可以得到有关该文件的各种信息。

<table class="reference"> <tbody><tr><th>属性</th><th>描述</th></tr> <tr><td>file.closed</td><td>返回true如果文件已被关闭，否则返回false。</td></tr> <tr><td>file.mode</td><td>返回被打开文件的访问模式。</td></tr> <tr><td>file.name</td><td>返回文件的名称。</td></tr> <tr><td>file.softspace</td><td>如果用print输出后，必须跟一个空格符，则返回false。否则返回true。</td></tr> </tbody></table>

###Close()方法

File对象的close（）方法刷新缓冲区里任何还没写入的信息，并关闭该文件，这之后便不能再进行写入。

当一个文件对象的引用被重新指定给另一个文件时，Python会关闭之前的文件。用close（）方法关闭文件是一个很好的习惯。

###Write()方法

Write()方法可将任何字符串写入一个打开的文件。需要重点注意的是，Python字符串可以是二进制数据，而不是仅仅是文字。

Write()方法不在字符串的结尾不添加换行符('\n')：
	
	fileObject.write(string);

###read()方法

read（）方法从一个打开的文件中读取一个字符串。需要重点注意的是，Python字符串可以是二进制数据，而不是仅仅是文字。		
	fileObject.read([count]);
	
###文件位置：

Tell()方法告诉你文件内的当前位置；换句话说，下一次的读写会发生在文件开头这么多字节之后：

seek（offset [,from]）方法改变当前文件的位置。Offset变量表示要移动的字节数。From变量指定开始移动字节的参考位置。

如果from被设为0，这意味着将文件的开头作为移动字节的参考位置。如果设为1，则使用当前的位置作为参考位置。如果它被设为2，那么该文件的末尾将作为参考位置。

###重命名和删除文件
Python的os模块提供了帮你执行文件处理操作的方法，比如重命名和删除文件。

要使用这个模块，你必须先导入它，然后可以调用相关的各种功能。

####rename()方法：

	os.rename(current_file_name, new_file_name)

####remove()方法

	os.remove(file_name)
	
##Python里的目录：
所有文件都包含在各个不同的目录下，不过Python也能轻松处理。os模块有许多方法能帮你创建，删除和更改目录。

####mkdir()方法

	os.mkdir("newdir")
	
####chdir()方法

	os.chdir("newdir")

####getcwd()方法：

	os.getcwd()

####rmdir()方法

	os.rmdir('dirname')

#Python 异常处理

python提供了两个非常重要的功能来处理python程序在运行中出现的异常和错误。你可以使用该功能来调试python程序。

* 异常处理
* 断言(Assertions)		

##python标准异常

<table class="reference"> <tbody><tr> <th> 异常名称</th><th> 描述</th> </tr><tr> </tr><tr><td> BaseException</td><td> 所有异常的基类</td></tr><tr><td> SystemExit</td><td>解释器请求退出</td></tr><tr><td> KeyboardInterrupt</td><td> 用户中断执行(通常是输入^C)</td></tr><tr><td> Exception</td><td>常规错误的基类</td></tr><tr><td> StopIteration </td><td>迭代器没有更多的值</td></tr><tr><td> GeneratorExit </td><td>生成器(generator)发生异常来通知退出</td></tr><tr><td> StandardError</td><td> 所有的内建标准异常的基类</td></tr><tr><td> ArithmeticError </td><td>所有数值计算错误的基类</td></tr><tr><td> FloatingPointError </td><td>浮点计算错误</td></tr><tr><td> OverflowError</td><td> 数值运算超出最大限制</td></tr><tr><td> ZeroDivisionError</td><td> 除(或取模)零 (所有数据类型)</td></tr><tr><td> AssertionError</td><td> 断言语句失败</td></tr><tr><td> AttributeError</td><td> 对象没有这个属性</td></tr><tr><td> EOFError </td><td>没有内建输入,到达EOF 标记</td></tr><tr><td> EnvironmentError </td><td>操作系统错误的基类</td></tr><tr><td> IOError </td><td>输入/输出操作失败</td></tr><tr><td> OSError </td><td>操作系统错误</td></tr><tr><td> WindowsError</td><td> 系统调用失败</td></tr><tr><td> ImportError </td><td>导入模块/对象失败</td></tr><tr><td> LookupError </td><td>无效数据查询的基类</td></tr><tr><td> IndexError</td><td> 序列中没有此索引(index)</td></tr><tr><td> KeyError</td><td> 映射中没有这个键</td></tr><tr><td> MemoryError</td><td> 内存溢出错误(对于Python 解释器不是致命的)</td></tr><tr><td> NameError</td><td> 未声明/初始化对象 (没有属性)</td></tr><tr><td> UnboundLocalError </td><td>访问未初始化的本地变量</td></tr><tr><td> ReferenceError</td><td> 弱引用(Weak reference)试图访问已经垃圾回收了的对象</td></tr><tr><td> RuntimeError </td><td>一般的运行时错误</td></tr><tr><td> NotImplementedError</td><td> 尚未实现的方法</td></tr><tr><td> SyntaxError</td><td>Python 语法错误</td></tr><tr><td> IndentationError</td><td> 缩进错误</td></tr><tr><td> TabError</td><td> Tab 和空格混用</td></tr><tr><td> SystemError </td><td>一般的解释器系统错误</td></tr><tr><td> TypeError</td><td> 对类型无效的操作</td></tr><tr><td> ValueError </td><td>传入无效的参数</td></tr><tr><td> UnicodeError </td><td>Unicode 相关的错误</td></tr><tr><td> UnicodeDecodeError </td><td>Unicode 解码时的错误</td></tr><tr><td> UnicodeEncodeError </td><td>Unicode 编码时错误</td></tr><tr><td> UnicodeTranslateError</td><td> Unicode 转换时错误</td></tr><tr><td> Warning </td><td>警告的基类</td></tr><tr><td> DeprecationWarning</td><td> 关于被弃用的特征的警告</td></tr><tr><td> FutureWarning </td><td>关于构造将来语义会有改变的警告</td></tr><tr><td> OverflowWarning</td><td> 旧的关于自动提升为长整型(long)的警告</td></tr><tr><td> PendingDeprecationWarning</td><td> 关于特性将会被废弃的警告</td></tr><tr><td> RuntimeWarning </td><td>可疑的运行时行为(runtime behavior)的警告</td></tr><tr><td> SyntaxWarning</td><td> 可疑的语法的警告</td></tr><tr><td> UserWarning</td><td> 用户代码生成的警告</td></tr></tbody></table>


##异常处理
捕捉异常可以使用try/except语句。

try/except语句用来检测try语句块中的错误，从而让except语句捕获异常信息并处理。

如果你不想在异常发生时结束你的程序，只需在try里捕获它。

	try:
	<语句>        #运行别的代码
	except <名字>：
	<语句>        #如果在try部份引发了'name'异常
	except <名字>，<数据>:
	<语句>        #如果引发了'name'异常，获得附加的数据
	else:
	<语句>        #如果没有异常发生


try的工作原理是，当开始一个try语句后，python就在当前程序的上下文中作标记，这样当异常出现时就可以回到这里，try子句先执行，接下来会发生什么依赖于执行时是否出现异常。

* 如果当try后的语句执行时发生异常，python就跳回到try并执行第一个匹配该异常的except子句，异常处理完毕，控制流就通过整个try语句（除非在处理异常时又引发新的异常）。
* 如果在try后的语句里发生了异常，却没有匹配的except子句，异常将被递交到上层的try，或者到程序的最上层（这样将结束程序，并打印缺省的出错信息）。
* 如果在try子句执行时没有发生异常，python将执行else语句后的语句（如果有else的话），然后控制流通过整个try语句。

###使用except而不带任何异常类型

可以不带任何异常类型使用except。

	try:
	   You do your operations here;
	   ......................
	except:
	   If there is any exception, then execute this block.
	   ......................
	else:
	   If there is no exception then execute this block.

###使用except而带多种异常类型

也可以使用相同的except语句来处理多个异常信息

	try:
	   You do your operations here;
	   ......................
	except(Exception1[, Exception2[,...ExceptionN]]]):
	   If there is any exception from the given exception list, 
	   then execute this block.
	   ......................
	else:
	   If there is no exception then execute this block.  


###try-finally 语句
try-finally 语句无论是否发生异常都将执行最后的代码。
	
	try:
	<语句>
	finally:
	<语句>    #退出try时总会执行
	raise

注意：你可以使用except语句或者finally语句，但是两者不能同时使用。else语句也不能与finally语句同时使用

###异常的参数
一个异常可以带上参数，可作为输出的异常信息参数。

你可以通过except语句来捕获异常的参数，

	try:
	   You do your operations here;
	   ......................
	except ExceptionType, Argument:
	   You can print value of Argument here...

###触发异常

	raise [Exception [, args [, traceback]]]

###用户自定义异常
通过创建一个新的异常类，程序可以命名它们自己的异常。异常应该是典型的继承自Exception类，通过直接或间接的方式。


#Python 面向对象

##面向对象技术简介
* 类(Class): 用来描述具有相同的属性和方法的对象的集合。它定义了该集合中每个对象所共有的属性和方法。对象是类的实例。
* 类变量：类变量在整个实例化的对象中是公用的。类变量定义在类中且在函数体之外。类变量通常不作为实例变量使用。
* 数据成员：类变量或者实例变量用于处理类及其实例对象的相关的数据。
* 方法重载：如果从父类继承的方法不能满足子类的需求，可以对其进行改写，这个过程叫方法的覆盖（override），也称为方法的重载。
* 实例变量：定义在方法中的变量，只作用于当前实例的类。
* 继承：即一个派生类（derived class）继承基类（base class）的字段和方法。继承也允许把一个派生类的对象作为一个基类对象对待。例如，有这样一个设计：一个Dog类型的对象派生自Animal类，这是模拟"是一个（is-a）"关系（例图，Dog是一个Animal）。
* 实例化：创建一个类的实例，类的具体对象。
* 方法：类中定义的函数。
* 对象：通过类定义的数据结构实例。对象包括两个数据成员（类变量和实例变量）和方法。

##创建类
使用class语句来创建一个新类，class之后为类的名称并以冒号结尾

	class ClassName:
	   '类的帮助信息'   #类文档字符串
	   class_suite  #类体

类的帮助信息可以通过ClassName.__doc__查看。

class_suite 由类成员，方法，数据属性组成。

\_\_init\_\_()方法是一种特殊的方法，被称为类的构造函数或初始化方法，当创建了这个类的实例时就会调用该方法


###创建实例对象
要创建一个类的实例，你可以使用类的名称，并通过__init__方法接受参数。

###访问属性
您可以使用点(.)来访问对象的属性。

使用以下函数的方式来访问属性：

	getattr(obj, name[, default]) : 访问对象的属性。
	hasattr(obj,name) : 检查是否存在一个属性。
	setattr(obj,name,value) : 设置一个属性。如果属性不存在，会创建一个新属性。
	delattr(obj, name) : 删除属性。


###Python内置类属性
	__dict__ : 类的属性（包含一个字典，由类的数据属性组成）
	__doc__ :类的文档字符串
	__name__: 类名
	__module__: 类定义所在的模块（类的全名是'__main__.className'，如果类位于一个导入模块mymod中，那么className.__module__ 等于 mymod）
	__bases__ : 类的所有父类构成元素（包含了以个由所有父类组成的元组）

##python对象销毁(垃圾回收)
同Java语言一样，Python使用了引用计数这一简单技术来追踪内存中的对象。

在Python内部记录着所有使用中的对象各有多少引用。
一个内部跟踪变量，称为一个引用计数器。

当对象被创建时， 就创建了一个引用计数， 当这个对象不再需要时， 也就是说， 这个对象的引用计数变为0 时， 它被垃圾回收。但是回收不是"立即"的， 由解释器在适当的时机，将垃圾对象占用的内存空间回收。

垃圾回收机制不仅针对引用计数为0的对象，同样也可以处理循环引用的情况。循环引用指的是，两个对象相互引用，但是没有其他变量引用他们。这种情况下，仅使用引用计数是不够的。Python 的垃圾收集器实际上是一个引用计数器和一个循环垃圾收集器。作为引用计数的补充， 垃圾收集器也会留心被分配的总量很大（及未通过引用计数销毁的那些）的对象。 在这种情况下， 解释器会暂停下来， 试图清理所有未引用的循环。

##类的继承
面向对象的编程带来的主要好处之一是代码的重用，实现这种重用的方法之一是通过继承机制。继承完全可以理解成类之间的类型和子类型关系。

需要注意的地方：继承语法 class 派生类名（基类名）：//... 基类名写作括号里，基本类是在类定义的时候，在元组之中指明的。

在python中继承中的一些特点：

1. 在继承中基类的构造（__init__()方法）不会被自动调用，它需要在其派生类的构造中亲自专门调用。
2. 在调用基类的方法时，需要加上基类的类名前缀，且需要带上self参数变量。区别于在类中调用普通函数时并不需要带上self参数
3. Python总是首先查找对应类型的方法，如果它不能在派生类中找到对应的方法，它才开始到基类中逐个查找。（先在本类中查找调用的方法，找不到才去基类中找）。

如果在继承元组中列了一个以上的类，那么它就被称作"多重继承" 。

	class SubClassName (ParentClass1[, ParentClass2, ...]):
	   'Optional class documentation string'
	   class_suite

使用issubclass()或者isinstance()方法来检测。

* issubclass() - 布尔函数判断一个类是另一个类的子类或者子孙类，语法：issubclass(sub,sup)
* isinstance(obj, Class) 布尔函数如果obj是Class类的实例对象或者是一个Class子类的实例对象则返回true。

###方法重写
如果你的父类方法的功能不能满足你的需求，你可以在子类重写你父类的方法.

####基础重载方法

<table class="reference"> <tbody><tr> <th style="width:10%">序号</th><th>方法, 描述 &amp; 简单的调用</th> </tr> <tr><td>1</td><td><b>__init__ ( self [,args...] )</b><br>构造函数<br>简单的调用方法: <i>obj = className(args)</i></td></tr> <tr><td>2</td><td><b>__del__( self )</b><br>析构方法, 删除一个对象<br>简单的调用方法 : <i>dell obj</i></td></tr> <tr><td>3</td><td><b>__repr__( self )</b><br>转化为供解释器读取的形式<br>简单的调用方法 : <i>repr(obj)</i></td></tr> <tr><td>4</td><td><b>__str__( self )</b><br> 用于将值转化为适于人阅读的形式<br>简单的调用方法 : <i>str(obj)</i></td></tr> <tr><td>5</td><td><b>__cmp__ ( self, x )</b><br>对象比较<br>简单的调用方法 : <i>cmp(obj, x)</i></td></tr> </tbody></table>


###运算符重载	


###类属性与方法
####类的私有属性

**__private_attrs**：两个下划线开头，声明该属性为私有，不能在类地外部被使用或直接访问。在类内部的方法中使用时 **self.__private_attrs**。

**类的方法**

在类地内部，使用def关键字可以为类定义一个方法，与一般函数定义不同，类方法必须包含参数self,且为第一个参数

**类的私有方法**

**__private_method**：两个下划线开头，声明该方法为私有方法，不能在类地外部调用。在类的内部调用**self.__private_methods**

Python不允许实例化的类访问私有数据，但你可以使用 **object._className__attrName** 访问属性


#Python正则表达式

正则表达式是一个特殊的字符序列，它能帮助你方便的检查一个字符串是否与某种模式匹配。

re 模块使 Python 语言拥有全部的正则表达式功能。

compile 函数根据一个模式字符串和可选的标志参数生成一个正则表达式对象。该对象拥有一系列方法用于正则表达式匹配和替换。

re 模块也提供了与这些方法功能完全一致的函数，这些函数使用一个模式字符串做为它们的第一个参数。

###re.match函数
re.match 尝试从字符串的开始匹配一个模式。

	re.match(pattern, string, flags=0)

<table class="reference"> <tbody><tr> <th style="width:30%">参数</th><th>描述</th> </tr> <tr><td>pattern</td><td>匹配的正则表达式</td></tr> <tr><td>string</td><td>要匹配的字符串。</td></tr> <tr><td>flags</td><td>标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等。</td></tr> </tbody></table>

匹配成功re.match方法返回一个匹配的对象，否则返回None。

可以使用group(num) 或 groups() 匹配对象函数来获取匹配表达式。	
<table class="reference"> <tbody><tr> <th style="width:30%">匹配对象方法</th><th>描述</th> </tr> <tr><td>group(num=0)</td><td>匹配的整个表达式的字符串，group() 可以一次输入多个组号，在这种情况下它将返回一个包含那些组所对应值的元组。</td></tr> <tr><td>groups()</td><td>返回一个包含所有小组字符串的元组，从 1 到 所含的小组号。</td></tr> </tbody></table>

###re.search方法
re.search 会在字符串内查找模式匹配，直到找到第一个匹配。

	re.search(pattern, string, flags=0)
	
匹配成功re.search方法返回一个匹配的对象，否则返回None。

可以使用group(num) 或 groups() 匹配对象函数来获取匹配表达式。

###re.match与re.search的区别
re.match只匹配字符串的开始，如果字符串开始不符合正则表达式，则匹配失败，函数返回None；而re.search匹配整个字符串，直到找到一个匹配。

###检索和替换
Python 的re模块提供了re.sub用于替换字符串中的匹配项。

	re.sub(pattern, repl, string, max=0)
	
返回的字符串是在字符串中用 RE 最左边不重复的匹配来替换。如果模式没有发现，字符将被没有改变地返回。

可选参数 count 是模式匹配后替换的最大次数；count 必须是非负整数。缺省值是 0 表示替换所有的匹配。

##正则表达式修饰符 - 可选标志
正则表达式可以包含一些可选标志修饰符来控制匹配的模式。修饰符被指定为一个可选的标志。多个标志可以通过按位 OR(|) 它们来指定。如 re.I | re.M 被设置成 I 和 M 标志

<table class="reference"> <tbody><tr><th style="width:25%">修饰符</th><th>描述</th></tr> <tr><td>re.I</td><td>使匹配对大小写不敏感</td></tr> <tr><td>re.L</td><td>做本地化识别（locale-aware）匹配</td></tr> <tr><td>re.M</td><td>多行匹配，影响 ^ 和 $</td></tr> <tr><td>re.S</td><td>使 . 匹配包括换行在内的所有字符</td></tr> <tr><td>re.U</td><td>根据Unicode字符集解析字符。这个标志影响 \w, \W, \b, \B.</td></tr> <tr><td>re.X</td><td>该标志通过给予你更灵活的格式以便你将正则表达式写得更易于理解。</td></tr> </tbody></table>


##正则表达式模式
模式字符串使用特殊的语法来表示一个正则表达式：

字母和数字表示他们自身。一个正则表达式模式中的字母和数字匹配同样的字符串。

多数字母和数字前加一个反斜杠时会拥有不同的含义。

标点符号只有被转义时才匹配自身，否则它们表示特殊的含义。

反斜杠本身需要使用反斜杠转义。

由于正则表达式通常都包含反斜杠，所以你最好使用原始字符串来表示它们。模式元素(如 r'/t'，等价于'//t')匹配相应的特殊字符。

<table class="reference"> <tbody><tr><th style="width:25%">模式</th><th>描述</th></tr> <tr><td>^</td><td>匹配字符串的开头</td></tr> <tr><td>$</td><td>匹配字符串的末尾。</td></tr> <tr><td>.</td><td>匹配任意字符，除了换行符，当re.DOTALL标记被指定时，则可以匹配包括换行符的任意字符。</td></tr> <tr><td>[...]</td><td>用来表示一组字符,单独列出：[amk] 匹配 'a'，'m'或'k'</td></tr> <tr><td>[^...]</td><td>不在[]中的字符：[^abc] 匹配除了a,b,c之外的字符。</td></tr> <tr><td>re*</td><td>匹配0个或多个的表达式。</td></tr> <tr><td>re+</td><td>匹配1个或多个的表达式。</td></tr> <tr><td>re?</td><td> 匹配0个或1个由前面的正则表达式定义的片段，非贪婪方式</td></tr> <tr><td>re{ n}</td><td></td></tr> <tr><td>re{ n,}</td><td>精确匹配n个前面表达式。</td></tr> <tr><td>re{ n, m}</td><td>匹配 n 到 m 次由前面的正则表达式定义的片段，贪婪方式</td></tr> <tr><td>a| b</td><td>匹配a或b</td></tr> <tr><td>(re)</td><td>G匹配括号内的表达式，也表示一个组</td></tr> <tr><td>(?imx)</td><td>正则表达式包含三种可选标志：i, m, 或 x 。只影响括号中的区域。</td></tr> <tr><td>(?-imx)</td><td>正则表达式关闭 i, m, 或 x 可选标志。只影响括号中的区域。</td></tr> <tr><td>(?: re)</td><td> 类似 (...), 但是不表示一个组</td></tr> <tr><td>(?imx: re)</td><td>在括号中使用i, m, 或 x 可选标志</td></tr> <tr><td>(?-imx: re)</td><td>在括号中不使用i, m, 或 x 可选标志</td></tr> <tr><td>(?#...)</td><td>注释.</td></tr> <tr><td>(?= re)</td><td>前向肯定界定符。如果所含正则表达式，以 ... 表示，在当前位置成功匹配时成功，否则失败。但一旦所含表达式已经尝试，匹配引擎根本没有提高；模式的剩余部分还要尝试界定符的右边。</td></tr> <tr><td>(?! re)</td><td>前向否定界定符。与肯定界定符相反；当所含表达式不能在字符串当前位置匹配时成功</td></tr> <tr><td>(?&gt; re)</td><td>匹配的独立模式，省去回溯。</td></tr> <tr><td>\w</td><td> 匹配字母数字</td></tr> <tr><td>\W</td><td>匹配非字母数字</td></tr> <tr><td>\s</td><td> 匹配任意空白字符，等价于 [\t\n\r\f].</td></tr> <tr><td>\S</td><td>匹配任意非空字符</td></tr> <tr><td>\d</td><td> 匹配任意数字，等价于 [0-9].</td></tr> <tr><td>\D</td><td>匹配任意非数字</td></tr> <tr><td>\A</td><td>匹配字符串开始</td></tr> <tr><td>\Z</td><td>匹配字符串结束，如果是存在换行，只匹配到换行前的结束字符串。c</td></tr> <tr><td>\z</td><td>匹配字符串结束</td></tr> <tr><td>\G</td><td>匹配最后匹配完成的位置。</td></tr> <tr><td>\b</td><td>匹配一个单词边界，也就是指单词和空格间的位置。例如， 'er\b' 可以匹配"never" 中的 'er'，但不能匹配 "verb" 中的 'er'。</td></tr> <tr><td>\B</td><td>匹配非单词边界。'er\B' 能匹配 "verb" 中的 'er'，但不能匹配 "never" 中的 'er'。</td></tr> <tr><td>\n, \t, 等.</td><td>匹配一个换行符。匹配一个制表符。等</td></tr> <tr><td>\1...\9</td><td>匹配第n个分组的子表达式。</td></tr> <tr><td>\10</td><td>匹配第n个分组的子表达式，如果它经匹配。否则指的是八进制字符码的表达式。</td></tr> </tbody></table>


##正则表达式实例
###字符匹配

###字符类	

<table class="reference"> <tbody><tr><th style="width:25%">实例</th><th>描述</th></tr> <tr><td>[Pp]ython </td><td>匹配 "Python" 或 "python"</td></tr> <tr><td>rub[ye]</td><td>匹配 "ruby" 或 "rube"</td></tr> <tr><td>[aeiou]</td><td>匹配中括号内的任意一个字母</td></tr> <tr><td>[0-9]</td><td>匹配任何数字。类似于 [0123456789]</td></tr> <tr><td>[a-z]</td><td>匹配任何小写字母</td></tr> <tr><td>[A-Z]</td><td>匹配任何大写字母</td></tr> <tr><td>[a-zA-Z0-9]</td><td>匹配任何字母及数字</td></tr> <tr><td>[^aeiou]</td><td>除了aeiou字母以外的所有字符 </td></tr> <tr><td>[^0-9]</td><td>匹配除了数字外的字符 </td></tr> </tbody></table>

###特殊字符类

<table class="reference"> <tbody><tr><th style="width:25%">实例</th><th>描述</th></tr> <tr><td>.</td><td>匹配除 "\n" 之外的任何单个字符。要匹配包括 '\n' 在内的任何字符，请使用象 '[.\n]' 的模式。</td></tr> <tr><td>\d</td><td>匹配一个数字字符。等价于 [0-9]。</td></tr> <tr><td>\D </td><td>匹配一个非数字字符。等价于 [^0-9]。</td></tr> <tr><td>\s</td><td>匹配任何空白字符，包括空格、制表符、换页符等等。等价于 [ \f\n\r\t\v]。</td></tr> <tr><td>\S </td><td>匹配任何非空白字符。等价于 [^ \f\n\r\t\v]。</td></tr> <tr><td>\w</td><td>匹配包括下划线的任何单词字符。等价于'[A-Za-z0-9_]'。</td></tr> <tr><td>\W</td><td>匹配任何非单词字符。等价于 '[^A-Za-z0-9_]'。</td></tr> </tbody></table>

#Python CGI编程

##什么是CGI

CGI(Common Gateway Interface),通用网关接口,它是一段程序,运行在服务器上如：HTTP服务器，提供同客户端HTML页面的接口。

CGI程序可以是Python脚本，PERL脚本，SHELL脚本，C或者C++程序等。

CGI架构图

![CGI架构图](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/python-cgi.gif)

##Web服务器支持及配置
在你进行CGI编程前，确保Web服务器支持CGI及已经配置了CGI的处理程序。

所有的HTTP服务器执行CGI程序都保存在一个预先配置的目录。这个目录被称为CGI目录，并按照惯例，它被命名为/var/www/cgi-bin目录。

CGI文件的扩展名为.cgi，python也可以使用.py扩展名。

默认情况下，Linux服务器配置运行的cgi-bin目录中为/var/www。

如果你想指定其他运行CGI脚本的目录，可以修改httpd.conf配置文件

##HTTP头部

CGI程序中HTTP头部经常使用的信息

<table class="reference"> <tbody><tr> <th style="width:30%">头</th><th>描述</th> </tr> <tr> <td>Content-type: </td><td>请求的与实体对应的MIME信息。例如: Content-type:text/html</td></tr> <tr> <td>Expires: Date </td><td>响应过期的日期和时间</td> </tr> <tr> <td>Location: URL </td><td>用来重定向接收方到非请求URL的位置来完成请求或标识新的资源</td> </tr> <tr> <td>Last-modified: Date</td><td>请求资源的最后修改时间</td> </tr> <tr> <td>Content-length: N</td><td>请求的内容长度</td> </tr> <tr> <td>Set-Cookie: String </td><td>设置Http Cookie</td> </tr> </tbody></table>

##CGI环境变量
所有的CGI程序都接收以下的环境变量，这些变量在CGI程序中发挥了重要的作用

<table class="reference"> <tbody><tr><th style="width:30%;">变量名</th><th>描述</th></tr> <tr> <td>CONTENT_TYPE</td><td>这个环境变量的值指示所传递来的信息的MIME类型。目前，环境变量CONTENT_TYPE一般都是：application/x-www-form-urlencoded,他表示数据来自于HTML表单。</td> </tr> <tr> <td>CONTENT_LENGTH</td><td>如果服务器与CGI程序信息的传递方式是POST，这个环境变量即使从标准输入STDIN中可以读到的有效数据的字节数。这个环境变量在读取所输入的数据时必须使用。</td> </tr> <tr> <td>HTTP_COOKIE</td><td>客户机内的 COOKIE 内容。</td> </tr> <tr> <td>HTTP_USER_AGENT</td><td>提供包含了版本数或其他专有数据的客户浏览器信息。</td> </tr> <tr> <td>PATH_INFO</td><td>这个环境变量的值表示紧接在CGI程序名之后的其他路径信息。它常常作为CGI程序的参数出现。</td> </tr> <tr> <td>QUERY_STRING</td><td>如果服务器与CGI程序信息的传递方式是GET，这个环境变量的值即使所传递的信息。这个信息经跟在CGI程序名的后面，两者中间用一个问号'?'分隔。</td> </tr> <tr> <td>REMOTE_ADDR</td><td>这个环境变量的值是发送请求的客户机的IP地址，例如上面的192.168.1.67。这个值总是存在的。而且它是Web客户机需要提供给Web服务器的唯一标识，可以在CGI程序中用它来区分不同的Web客户机。</td> </tr> <tr> <td>REMOTE_HOST</td><td>这个环境变量的值包含发送CGI请求的客户机的主机名。如果不支持你想查询，则无需定义此环境变量。</td> </tr> <tr> <td>REQUEST_METHOD</td><td>提供脚本被调用的方法。对于使用 HTTP/1.0 协议的脚本，仅 GET 和 POST 有意义。</td></tr> <tr> <td>SCRIPT_FILENAME</td><td>CGI脚本的完整路径</td></tr> <tr> <td>SCRIPT_NAME</td><td>CGI脚本的的名称</td></tr> <tr> <td>SERVER_NAME</td><td>这是你的 WEB 服务器的主机名、别名或IP地址。</td></tr> <tr> <td>SERVER_SOFTWARE</td><td>这个环境变量的值包含了调用CGI程序的HTTP服务器的名称和版本号。例如，上面的值为Apache/2.2.14(Unix)</td></tr> </tbody></table>

##GET和POST方法
浏览器客户端通过两种方法向服务器传递信息，这两种方法就是 GET 方法和 POST 方法。

###使用GET方法传输数据

GET方法发送编码后的用户信息到服务端，数据信息包含在请求页面的URL上，以"?"号分割

	<form action="/cgi-bin/hello_get.py" method="get">

###使用POST方法传递数据

使用POST方法向服务器传递数据是更安全可靠的，像一些敏感信息如用户密码等需要使用POST传输数据。

e.g. 为表单通过POST方法向服务器脚本hello_get.py提交数据:
	
	<form action="/cgi-bin/hello_get.py" method="post">

###通过CGI程序传递checkbox数据

checkbox用于提交一个或者多个选项数据.cgi程序可以为.cgi也可以为.py

	<form action="/cgi-bin/checkbox.cgi" method="POST" target="_blank">

###通过CGI程序传递Radio数据

Radio只向服务器传递一个数据

	<form action="/cgi-bin/radiobutton.py" method="post" target="_blank">
	
###通过CGI程序传递 Textarea 数据

###通过CGI程序传递下拉数据

##CGI中使用Cookie
在http协议一个很大的缺点就是不作用户身份的判断，这样给编程人员带来很大的不便，

而cookie功能的出现弥补了这个缺憾。
所有cookie就是在客户访问脚本的同时，通过客户的浏览器，在客户硬盘上写入纪录数据 ，当下次客户访问脚本时取回数据信息，从而达到身份判别的功能，cookie常用在密码判断中 。

　
###cookie的语法

http cookie的发送是通过http头部来实现的，他早于文件的传递，头部set-cookie的语法如下：

	Set-cookie:name=name;expires=date;path=path;domain=domain;secure 
	
* name=name: 需要设置cookie的值(name不能使用"；"和"，"号),有多个name值时用"；"分隔例如：name1=name1;name2=name2;name3=name3。
* expires=date: cookie的有效期限,格式： expires="Wdy,DD-Mon-YYYY HH:MM:SS"
* path=path: 设置cookie支持的路径,如果path是一个路径，则cookie对这个目录下的所有文件及子目录生效，例如： path="/cgi-bin/"，如果path是一个文件，则cookie指对这个文件生效，例如：path="/cgi-bin/cookie.cgi"。
* domain=domain: 对cookie生效的域名，例如：domain="www.chinalb.com"
* secure: 如果给出此标志，表示cookie只能通过SSL协议的https服务器来传递。
* cookie的接收是通过设置环境变量HTTP_COOKIE来实现的，CGI程序可以通过检索该变量获取cookie信息。

###检索Cookie信息
Cookie信息检索页非常简单，Cookie信息存储在CGI的环境变量HTTP_COOKIE中，存储格式如下：

	key1=value1;key2=value2;key3=value3....

#python操作mysql数据库

Python 标准数据库接口为 Python DB-API，Python DB-API为开发人员提供了数据库应用编程接口。

不同的数据库你需要下载不同的DB API模块，例如你需要访问Oracle数据库和Mysql数据，你需要下载Oracle和MySQL数据库模块。

DB-API 是一个规范. 它定义了一系列必须的对象和数据库存取方式, 以便为各种各样的底层数据库系统和多种多样的数据库接口程序提供一致的访问接口 。

Python的DB-API，为大多数的数据库实现了接口，使用它连接各数据库后，就可以用相同的方式操作各数据库。

Python DB-API使用流程：

* 引入 API 模块。
* 获取与数据库的连接。
* 执行SQL语句和存储过程。
* 关闭数据库连接。

**e.g. **

	# encoding: utf-8
	#!/usr/bin/python
	
	import MySQLdb
	
	# 打开数据库连接
	db = MySQLdb.connect("localhost","testuser","test123","TESTDB" )
	
	# 使用cursor()方法获取操作游标 
	cursor = db.cursor()
	
	# SQL 查询语句
	sql = "SELECT * FROM EMPLOYEE \
	       WHERE INCOME > '%d'" % (1000)
	try:
	   # 执行SQL语句
	   cursor.execute(sql)
	   # 获取所有记录列表
	   results = cursor.fetchall()
	   for row in results:
	      fname = row[0]
	      lname = row[1]
	      age = row[2]
	      sex = row[3]
	      income = row[4]
	      # 打印结果
	      print "fname=%s,lname=%s,age=%d,sex=%s,income=%d" % \
	             (fname, lname, age, sex, income )
	except:
	   print "Error: unable to fecth data"
	
	# 关闭数据库连接
	db.close()


##错误处理
DB API中定义了一些数据库操作的错误及异常，下表列出了这些错误和异常:

<table class="reference"> <tbody><tr> <th style="width:15%">异常</th><th>描述</th> </tr> <tr><td>Warning</td><td>当有严重警告时触发，例如插入数据是被截断等等。必须是 StandardError 的子类。</td></tr> <tr><td>Error</td><td>警告以外所有其他错误类。必须是 StandardError 的子类。</td></tr> <tr><td>InterfaceError</td><td>当有数据库接口模块本身的错误（而不是数据库的错误）发生时触发。 必须是Error的子类。</td></tr> <tr><td>DatabaseError</td><td>和数据库有关的错误发生时触发。 必须是Error的子类。</td></tr> <tr><td>DataError</td><td>当有数据处理时的错误发生时触发，例如：除零错误，数据超范围等等。 必须是DatabaseError的子类。</td></tr> <tr><td>OperationalError</td><td>指非用户控制的，而是操作数据库时发生的错误。例如：连接意外断开、 数据库名未找到、事务处理失败、内存分配错误等等操作数据库是发生的错误。 必须是DatabaseError的子类。</td></tr> <tr><td>IntegrityError</td><td>完整性相关的错误，例如外键检查失败等。必须是DatabaseError子类。</td></tr> <tr><td>InternalError</td><td> 数据库的内部错误，例如游标（cursor）失效了、事务同步失败等等。 必须是DatabaseError子类。</td></tr> <tr><td>ProgrammingError</td><td>程序错误，例如数据表（table）没找到或已存在、SQL语句语法错误、 参数数量错误等等。必须是DatabaseError的子类。</td></tr> <tr><td>NotSupportedError</td><td>不支持错误，指使用了数据库不支持的函数或API等。例如在连接对象上 使用.rollback()函数，然而数据库并不支持事务或者事务已关闭。 必须是DatabaseError的子类。</td></tr> </tbody></table>



#Python 多线程

Python中使用线程有两种方式：函数或者用类来包装线程对象。

函数式：调用thread模块中的start_new_thread()函数来产生新线程。

	thread.start_new_thread ( function, args[, kwargs] )

参数说明:

* function - 线程函数。
* args - 传递给线程函数的参数,他必须是个tuple类型。
* kwargs - 可选参数。	

##线程模块
Python通过两个标准库thread和threading提供对线程的支持。thread提供了低级别的、原始的线程以及一个简单的锁。

thread 模块提供的其他方法：

* threading.currentThread(): 返回当前的线程变量。
* threading.enumerate(): 返回一个包含正在运行的线程的list。正在运行指线程启动后、结束前，不包括启动前和终止后的线程。
* threading.activeCount(): 返回正在运行的线程数量，与len(threading.enumerate())有相同的结果。

除了使用方法外，线程模块同样提供了Thread类来处理线程，Thread类提供了以下方法:

* run(): 用以表示线程活动的方法。
* start():启动线程活动。
* join([time]): 等待至线程中止。这阻塞调用线程直至线程的join() 方法被调用中止-正常退出或者抛出未处理的异常-或者是可选的超时发生。
* isAlive(): 返回线程是否活动的。
* getName(): 返回线程名。
* setName(): 设置线程名。

###使用Threading模块创建线程
使用Threading模块创建线程，直接从threading.Thread继承，然后重写__init__方法和run方法：


	#coding=utf-8
	#!/usr/bin/python
	
	import threading
	import time
	
	exitFlag = 0
	
	class myThread (threading.Thread):   #继承父类threading.Thread
	    def __init__(self, threadID, name, counter):
	        threading.Thread.__init__(self)
	        self.threadID = threadID
	        self.name = name
	        self.counter = counter
	    def run(self):                   #把要执行的代码写到run函数里面 线程在创建后会直接运行run函数 
	        print "Starting " + self.name
	        print_time(self.name, self.counter, 5)
	        print "Exiting " + self.name
	
	def print_time(threadName, delay, counter):
	    while counter:
	        if exitFlag:
	            thread.exit()
	        time.sleep(delay)
	        print "%s: %s" % (threadName, time.ctime(time.time()))
	        counter -= 1
	
	# 创建新线程
	thread1 = myThread(1, "Thread-1", 1)
	thread2 = myThread(2, "Thread-2", 2)
	
	# 开启线程
	thread1.start()
	thread2.start()
	
	print "Exiting Main Thread"


##线程同步
如果多个线程共同对某个数据修改，则可能出现不可预料的结果，为了保证数据的正确性，需要对多个线程进行同步。

使用Thread对象的Lock和Rlock可以实现简单的线程同步，这两个对象都有acquire方法和release方法，对于那些需要每次只允许一个线程操作的数据，可以将其操作放到acquire和release方法之间。如下：

多线程的优势在于可以同时运行多个任务（至少感觉起来是这样）。但是当线程需要共享数据时，可能存在数据不同步的问题。

考虑这样一种情况：一个列表里所有元素都是0，线程"set"从后向前把所有元素改成1，而线程"print"负责从前往后读取列表并打印。

那么，可能线程"set"开始改的时候，线程"print"便来打印列表了，输出就成了一半0一半1，这就是数据的不同步。为了避免这种情况，引入了锁的概念。

锁有两种状态——锁定和未锁定。每当一个线程比如"set"要访问共享数据时，必须先获得锁定；如果已经有别的线程比如"print"获得锁定了，那么就让线程"set"暂停，也就是同步阻塞；等到线程"print"访问完毕，释放锁以后，再让线程"set"继续。

##线程优先级队列（ Queue）
Python的Queue模块中提供了同步的、线程安全的队列类，包括FIFO（先入先出)队列Queue，LIFO（后入先出）队列LifoQueue，和优先级队列PriorityQueue。这些队列都实现了锁原语，能够在多线程中直接使用。可以使用队列来实现线程间的同步。

Queue模块中的常用方法:

* Queue.qsize() 返回队列的大小
* Queue.empty() 如果队列为空，返回True,反之False
* Queue.full() 如果队列满了，返回True,反之False
* Queue.full 与 maxsize 大小对应
* Queue.get([block[, timeout]])获取队列，timeout等待时间
* Queue.get_nowait() 相当Queue.get(False)
* Queue.put(item) 写入队列，timeout等待时间
* Queue.put_nowait(item) 相当Queue.put(item, False)
* Queue.task_done() 在完成一项工作之后，Queue.task_done()函数向任务已经完成的队列发送一个信号
* Queue.join() 实际上意味着等到队列为空，再执行别的操作

#Python XML解析

常见的XML编程接口有DOM和SAX，这两种接口处理XML文件的方式不同，当然使用场合也不同。

python有三种方法解析XML，SAX，DOM，以及ElementTree:

1. SAX (simple API for XML )

	pyhton 标准库包含SAX解析器，SAX用事件驱动模型，通过在解析XML的过程中触发一个个的事件并调用用户定义的回调函数来处理XML文件。

2. DOM(Document Object Model)

	将XML数据在内存中解析成一个树，通过对树的操作来操作XML。

3. ElementTree(元素树)

	ElementTree就像一个轻量级的DOM，具有方便友好的API。代码可用性好，速度快，消耗内存少。

注：因DOM需要将XML数据映射到内存中的树，一是比较慢，二是比较耗内存，而SAX流式读取XML文件，比较快，占用内存少，但需要用户实现回调函数（handler）。

#python GUI编程(Tkinter)

python提供了多个图形开发界面的库，几个常用Python GUI库如下：

* Tkinter： Tkinter模块("Tk 接口")是Python的标准Tk GUI工具包的接口.Tk和Tkinter可以在大多数的Unix平台下使用,同样可以应用在Windows和Macintosh系统里.,Tk8.0的后续版本可以实现本地窗口风格,并良好地运行在绝大多数平台中。
* wxPython：wxPython 是一款开源软件，是 Python 语言的一套优秀的 GUI 图形库，允许 Python 程序员很方便的创建完整的、功能键全的 GUI 用户界面。
* Jython：Jython程序可以和Java无缝集成。除了一些标准模块，Jython使用Java的模块。Jython几乎拥有标准的Python中不依赖于C语言的全部模块。比如，Jython的用户界面将使用Swing，AWT或者SWT。Jython可以被动态或静态地编译成Java字节码。



#Python2.x与3​​.x版本区别

Python的3​​.0版本，常被称为Python 3000，或简称Py3k。相对于Python的早期版本，这是一个较大的升级。

为了不带入过多的累赘，Python 3.0在设计的时候没有考虑向下相容。

许多针对早期Python版本设计的程式都无法在Python 3.0上正常执行。

为了照顾现有程式，Python 2.6作为一个过渡版本，基本使用了Python 2.x的语法和库，同时考虑了向Python 3.0的迁移，允许使用部分Python 3.0的语法与函数。

新的Python程式建议使用Python 3.0版本的语法。
除非执行环境无法安装Python 3.0或者程式本身使用了不支援Python 3.0的第三方库。目前不支援Python 3.0的第三方库有Twisted, py2exe, PIL等。

大多数第三方库都正在努力地相容Python 3.0版本。即使无法立即使用Python 3.0，也建议编写相容Python 3.0版本的程式，然后使用Python 2.6, Python 2.7来执行。

##主要变化
Python 3.0的变化主要在以下几个方面:

* print语句没有了，取而代之的是print()函数。 Python 2.6与Python 2.7部分地支持这种形式的print语法。在Python 2.6与Python 2.7里面，以下三种形式是等价的：

* 新的str类别表示一个Unicode字串，相当于Python 2.x版本的unicode类别。而位元组序列则用类似b"abc"的语法表示，用bytes类表示，相当于Python 2.x的str类别。现在两种类别不能再隐式地自动转换，因此在Python 3.x里面"fish"+b"panda"是错误。正确的写法是"fish"+b"panda".decode("utf-8")。 Python 2.6可以自动地将位元组序列识别为Unicode字串
* 除法运算符"/"在Python 3.x内总是返回浮点数。而在Python 2.6内会判断被除数与除数是否是整数。如果是整数会返回整数值，相当于整除;浮点数则返回浮点数值。
* 捕获异常的语法由except exc, var改为except exc as var。使用语法except (exc1, exc2) as var可以同时捕获多种类别的异常。 Python 2.6已经支援这两种语法。
* 集合(set) 的新写法：{1,2,3,4}。注意{}仍然表示空的字典(dict) 。
* 字典推导式(Dictionary comprehensions) {expr1: expr2 for k, v in d}，这个语法等价于

		result={}
		for k, v in d.items():
    		result[expr1]=expr2
		return result

* 集合推导式(Set Comprehensions) {expr1 for x in stuff}。这个语法等价于：

		result = set()
		for x in stuff:
    		result.add(expr1)
		return result

* 八进制数必须写成0o777，原来的形式0777不能用了；二进制必须写成0b111。新增了一个bin()函数用于将一个整数转换成二进制字串。 Python 2.6已经支援这两种语法。
* dict.keys(), dict.values​​(), dict.items(), map(), filter(), range(), zip()不再返回列表，而是迭代器。
* 如果两个物件之间没有定义明确的有意义的顺序。使用<, >, <=, >=比较它们会投掷异常。比如1 < ""在Python 2.6里面会返回True，而在Python 3.0里面会投掷异常。现在cmp(), instance.__cmp__()函数已经被删除。
* 可以注释函数的参数与返回值。此特性可方便IDE对原始码进行更深入的分析。例如给参数增加类别讯息，这点和erlang很像了。
		
		def sendMail(from_: str, to: str, title: str, body: str) -> bool:
    		pass

* 合并int与long类型。
* 多个模块被改名（根据PEP8）：

<table class="reference"> <tbody><tr> <th>旧的名字</th> <th>新的名字</th> </tr> <tr> <td>_winreg</td> <td>winreg</td> </tr> <tr> <td>ConfigParser</td> <td>configparser</td> </tr> <tr> <td>copy_reg</td> <td>copyreg</td> </tr> <tr> <td>Queue</td> <td>queue</td> </tr> <tr> <td>SocketServer</td> <td>socketserver</td> </tr> <tr> <td>repr</td> <td>reprlib</td> </tr> </tbody></table>

* StringIO模块现在被合并到新的io模组内。 new, md5, gopherlib等模块被删除。 Python 2.6已经支援新的io模组。
* httplib, BaseHTTPServer, CGIHTTPServer, SimpleHTTPServer, Cookie, cookielib被合并到http包内。
* 取消了exec语句，只剩下exec()函数。 Python 2.6已经支援exec()函数。


