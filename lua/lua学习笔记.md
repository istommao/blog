#Lua学习笔记

#什么是Lua

Lua 是一种轻量小巧的脚本语言，用标准C语言编写并以源代码形式开放， 其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。

#Lua特性

* 轻量级: 它用标准C语言编写并以源代码形式开放，编译后仅仅一百余K，可以很方便的嵌入别的程序里。
* 可扩展: Lua提供了非常易于使用的扩展接口和机制：由宿主语言(通常是C或C++)提供这些功能，Lua可以使用它们，就像是本来就内置的功能一样。
* 其它特性:
  * 支持面向过程(procedure-oriented)编程和函数式编程(functional programming)；
  * 自动内存管理；只提供了一种通用类型的表（table），用它可以实现数组，哈希表，集合，对象；
  * 语言内置模式匹配；闭包(closure)；函数也可以看做一个值；提供多线程（协同进程，并非操作系统所支持的线程）支持；
  * 通过闭包和table可以很方便地支持面向对象编程所需要的一些关键机制，比如数据抽象，虚函数，继承和重载等。


#Lua 应用场景
* 游戏开发
* 独立应用脚本
* Web 应用脚本
* 扩展和数据库插件如：MySQL Proxy 和 MySQL WorkBench
* 安全系统，如入侵检测系统

#Lua 基本语法

* 交互式编程
* 脚本式编程

##注释
> 单行注释
	
	两个减号是单行注释:--

> 多行注释
	
	--[[
 	多行注释
 	多行注释
 	--]]

##标示符
Lua 标示符用于定义一个变量，函数获取其他用户定义的项。标示符以一个字母 A 到 Z 或 a 到 z 或下划线 _ 开头后加上0个或多个字母，下划线，数字（0到9）。

最好不要使用下划线加大写字母的标示符，因为Lua的保留字也是这样的。

Lua 不允许使用特殊字符如 @, $, 和 % 来定义标示符。 Lua 是一个区分大小写的编程语言。

##关键词
以下列出了 Lua 的保留关键字。保留关键字不能作为常量或变量或其他用户自定义标示符:

<table class="reference"> <tbody><tr> <td style="width:25%">and</td> <td style="width:25%">break</td> <td style="width:25%">do</td> <td style="width:25%">else</td> </tr> <tr> <td>elseif</td> <td>end</td> <td>false</td> <td>for</td> </tr> <tr> <td>function</td> <td>if</td> <td>in</td> <td>local</td> </tr> <tr> <td>nil</td> <td>not</td> <td>or</td> <td>repeat</td> </tr> <tr> <td>return</td> <td>then</td> <td>true</td> <td>until</td> </tr> <tr> <td>while</td> <td></td> <td></td> <td></td> </tr> </tbody></table>

##全局变量
在默认情况下，变量总是认为是全局的。

全局变量不需要声明，给一个变量赋值后即创建了这个全局变量，访问一个没有初始化的全局变量也不会出错，只不过得到的结果是：nil。

如果你想删除一个全局变量，只需要将变量赋值为nil。

#Lua 数据类型

Lua是动态类型语言，变量不要类型定义,只需要为变量赋值。 值可以存储在变量中，作为参数传递或结果返回。

Lua中有8个基本类型分别为：nil、boolean、number、string、userdata、function、thread和table。

<table class="reference"> <tbody><tr><th style="width:20%">数据类型</th><th>描述</th></tr> <tr><td>nil</td><td>这个最简单，只有值nil属于该类，表示一个无效值（在条件表达式中相当于false）。</td></tr> <tr><td>boolean</td><td>包含两个值：false和true。</td></tr> <tr><td>number</td><td>表示双精度类型的实浮点数</td></tr> <tr><td>string</td><td>字符串由一对双引号或单引号来表示</td></tr> <tr><td>function</td><td>由 C 或 Lua 编写的函数</td></tr> <tr><td>userdata</td><td>表示任意存储在变量中的C数据结构</td></tr> <tr><td>thread</td><td> 表示执行的独立线路，用于执行协同程序</td></tr> <tr><td>table</td><td> Lua 中的表（table）其实是一个"关联数组"（associative arrays），数组的索引可以是数字或者是字符串。在 Lua 里，table 的创建是通过"构造表达式"来完成，最简单构造表达式是{}，用来创建一个空表。</td></tr> </tbody></table>

##number（数字）
Lua 默认只有一种 number 类型 -- double（双精度）类型（默认类型可以修改 luaconf.h 里的定义）

##table（表）
在 Lua 里，table 的创建是通过"构造表达式"来完成，最简单构造表达式是{}，用来创建一个空表。也可以在表里添加一些数据，直接初始化表:

	-- 创建一个空的 table
	local tbl1 = {}
 
	-- 直接初始表
	local tbl2 = {"apple", "pear", "orange", "grape"}

	a = {}
	a["key"] = "value"
	key = 10
	a[key] = 22
	a[key] = a[key] + 11
	for k, v in pairs(a) do
    	print(k .. " : " .. v)
	end


##function（函数）
在 Lua 中，函数是被看作是"第一类值（First-Class Value）"，函数可以存在变量里。

function 可以以匿名函数（anonymous function）的方式通过参数传递。


##thread（线程）
在 Lua 里，最主要的线程是协同程序（coroutine）。它跟线程（thread）差不多，拥有自己独立的栈、局部变量和指令指针，可以跟其他协同程序共享全局变量和其他大部分东西。

线程跟协程的区别：线程可以同时多个运行，而协程任意时刻只能运行一个，并且处于运行状态的协程只有被挂起（suspend）时才会暂停。


##userdata（自定义类型）
userdata 是一种用户自定义数据，用于表示一种由应用程序或 C/C++ 语言库所创建的类型，可以将任意 C/C++ 的任意数据类型的数据（通常是 struct 和 指针）存储到 Lua 变量中调用。


#Lua 变量

变量在使用前，必须在代码中进行声明，即创建该变量。编译程序执行代码之前编译器需要知道如何给语句变量开辟存储区，用于存储变量的值。

Lua 变量有三种类型：全局变量、局部变量、表中的域。

函数外的变量默认为全局变量，除非用 local 显示声明。函数内变量与函数的参数默认为局部变量。

局部变量的作用域为从声明位置开始到所在语句块结束（或者是直到下一个同名局部变量的声明）。

变量的默认值均为 nil。

##赋值语句
赋值是改变一个变量的值和改变表域的最基本的方法。

Lua可以对多个变量同时赋值，变量列表和值列表的各个元素用逗号分开，赋值语句右边的值会依次赋给左边的变量。

遇到赋值语句Lua会先计算右边所有的值然后再执行赋值操作，所以我们可以这样进行交换变量的值：

	x, y = y, x                     -- swap 'x' for 'y'
	a[i], a[j] = a[j], a[i]         -- swap 'a[i]' for 'a[i]'
	
当变量个数和值的个数不一致时，Lua会一直以变量个数为基础采取以下策略：

	a. 变量个数 > 值的个数             按变量个数补足nil
	b. 变量个数 < 值的个数             多余的值会被忽略
	
多值赋值经常用来交换变量，或将函数调用返回给变量：

	a, b = f()  --f()返回两个值，第一个赋给a，第二个赋给b
	
##索引
对 table 的索引使用方括号 \[\]。Lua 也提供了 \. 操作。	

	t[i]
	t.i                 -- 当索引为字符串类型时的一种简化写法
	gettable_event(t,i) -- 采用索引访问本质上是一个类似这样的函数调用
	


#Lua 循环
<table class="reference"> <tbody><tr><th style="width:30%">循环类型</th><th>描述</th></tr> <tr><td><a href="lua-while-loop.html" title="Lua while 循环">while 循环</a></td><td>在条件为 true 时，让程序重复地执行某些语句。执行语句前会先检查条件是否为 true。</td></tr> <tr><td><a href="lua-for-loop.html" title="Lua for 循环">for 循环</a></td><td>重复执行指定语句，重复次数可在 for 语句中控制。</td></tr> <tr><td><a href="lua-repeat-until-loop.html" title="Lua repeat...until 循环">Lua repeat...until </a></td><td>重复执行循环，直到 指定的条件为真时为止</td></tr> <tr><td><a href="lua-nested-loops.html" title="Lua 循环嵌套">循环嵌套</a></td><td>可以在循环内嵌套一个或多个循环语句（while、for、do..while）</td></tr> </tbody></table>

##循环控制语句break

#Lua 流程控制

Lua 编程语言流程控制语句通过程序设定一个或多个条件语句来设定。在条件为 true 时执行指定程序代码，在条件为 false 时执行其他指定代码。

<table class="reference"> <tbody><tr><th style="width:28%">语句</th><th>描述</th></tr> <tr><td><a href="if-statement-in-lua.html" title="Lua if 语句">if 语句</a></td><td> <b>if 语句</b> 由一个布尔表达式作为条件判断，其后紧跟其他语句组成。</td></tr> <tr><td><a href="if-else-statement-in-lua.html" title="Lua if...else 语句">if...else 语句</a></td><td> <b>if 语句</b> 可以与 <b>else 语句</b>搭配使用, 在 if 条件表达式为 false 时执行 else 语句代码。</td></tr> <tr><td><a href="nested-if-statements-in-lua.html" title="Lua if 嵌套语句">if 嵌套语句</a></td><td>你可以在<b>if</b> 或 <b>else if</b>中使用一个或多个 <b>if</b> 或 <b>else if</b> 语句 。</td></tr> </tbody></table>

#Lua 函数

在Lua中，函数是对语句和表达式进行抽象的主要方法。既可以用来处理一些特殊的工作，也可以用来计算一些值。

Lua 提供了许多的内建函数，你可以很方便的在程序中调用它们，如print()函数可以将传入的参数打印在控制台上。

Lua 函数主要有两种用途：

1. 完成指定的任务，这种情况下函数作为调用语句使用；
2. 计算并返回值，这种情况下函数作为赋值语句的表达式使用。

**函数定义**
	
	optional_function_scope function function_name( argument1, argument2, argument3..., argumentn)
		function_body
		return result_params_comma_separated
	end

**解析**：

* optional_function_scope
: 该参数是可选的制定函数是全局函数还是局部函数，未设置该参数末尾为全局函数，如果你需要设置函数为局部函数需要使用关键字 local。
* function_name:
指定函数名称。
* argument1, argument2, argument3..., argumentn:
函数参数，多个参数以逗号隔开，函数也可以不带参数。
* function_body:
函数体，函数中需要执行的代码语句块。
* result_params_comma_separated:
函数返回值，Lua语言函数可以返回多个值，每个值以逗号隔开。


**e.g.**
最简单：
	
	--[[ 函数返回两个值的最大值 --]]
	function max(num1, num2)

   		if (num1 > num2) then
      		result = num1;
   		else
      		result = num2;
   		end

   		return result; 
	end

将函数作为参数：

	myprint = function(param)
   		print("这是打印函数 -   ##",param,"##")
	end

	function add(num1,num2,functionPrint)
   		result = num1 + num2
   		-- 调用传递的函数参数
   		functionPrint(result)
	end
	-- myprint 函数作为参数传递
	add(2,5,myprint)

多返回值：

	function maximum (a)
    	local mi = 1             -- 最大值索引
    	local m = a[mi]          -- 最大值
    	for i,val in ipairs(a) do
       	if val > m then
           	mi = i
           	m = val
       	end
    	end
    	return m, mi
	end


##可变参数
Lua函数可以接受可变数目的参数，和C语言类似在函数参数列表中使用三点（...) 表示函数有可变的参数。

Lua将函数的参数放在一个叫arg的表中，#arg 表示传入参数的个数。

	function average(...)
   		result = 0
   		local arg={...}
   		for i,v in ipairs(arg) do
      		result = result + v
   		end
   		print("总共传入 " .. #arg .. " 个数")
   		return result/#arg
	end

	print("平均值为",average(10,5,3,4,5,6))



#Lua运算符

运算符是一个特殊的符号，用于告诉解释器执行特定的数学或逻辑运算。Lua提供了以下几种运算符类型：

* 算术运算符
* 关系运算符
* 逻辑运算符
* 其他运算符

##算术运算符
下表列出了 Lua 语言中的常用算术运算符，设定 A 的值为10，B 的值为 20：

<table class="reference"> <tbody><tr><th style="width:10%">操作符</th><th style="width:55%;">描述</th><th>实例</th></tr> <tr><td>+</td><td>加法</td><td> A + B 输出结果 30</td></tr> <tr><td>-</td><td>减法</td><td> A - B 输出结果 -10</td></tr> <tr><td>*</td><td>乘法</td><td> A * B 输出结果 200</td></tr> <tr><td>/</td><td>除法</td><td> B / A w输出结果 2</td></tr> <tr><td>%</td><td>取余</td><td> B % A 输出结果 0</td></tr> <tr><td>^</td><td>乘幂</td><td> A^2 输出结果 100</td></tr> <tr><td>-</td><td>负号</td><td> -A 输出结果v -10</td></tr> </tbody></table>

##关系运算符
下表列出了 Lua 语言中的常用关系运算符，设定 A 的值为10，B 的值为 20：


<table class="reference"> <tbody><tr><th style="width:10%">操作符</th><th style="width:55%;">描述</th><th>实例</th></tr> <tr><td>==</td><td> 等于，检测两个值是否相等，相等返回 true，否则返回 false</td><td> (A == B) 为 false。 </td></tr> <tr><td>~=</td><td> 不等于，检测两个值是否相等，相等返回 false，否则返回 true&lt;</td><td> (A ~= B) 为 true。 </td></tr> <tr><td>&gt;</td><td> 大于，如果左边的值大于右边的值，返回 true，否则返回 false</td><td> (A &gt; B) 为 false。 </td></tr> <tr><td>&lt;</td><td> 小于，如果左边的值大于右边的值，返回 false，否则返回 true</td><td> (A &lt; B) 为 true。 </td></tr> <tr><td>&gt;=</td><td> 大于等于，如果左边的值大于等于右边的值，返回 true，否则返回 false</td><td> (A &gt;= B) is not true. </td></tr> <tr><td>&lt;=</td><td> 小于等于， 如果左边的值小于等于右边的值，返回 true，否则返回 false</td><td> (A &lt;= B) is true. </td></tr> </tbody></table>



##逻辑运算符
下表列出了 Lua 语言中的常用逻辑运算符，设定 A 的值为10，B 的值为 20：

<table class="reference"> <tbody><tr><th style="width:10%">操作符</th><th style="width:55%;">描述</th><th>实例</th></tr> <tr><td>and</td><td> 逻辑与操作符。 如果两边的操作都为 true 则条件为 true。</td><td> (A and B) 为 false。</td></tr> <tr><td>or</td><td>逻辑或操作符。 如果两边的操作任一一个为 true 则条件为 true。</td><td> (A or B) 为 true。 </td></tr> <tr><td>not</td><td>逻辑非操作符。与逻辑运算结果相反，如果条件为 true，逻辑非为 false。</td><td> !(A and B) 为 false。 </td></tr> </tbody></table>

##其他运算符
下表列出了 Lua 语言中的连接运算符与计算表或字符串长度的运算符：

<table class="reference"> <tbody><tr><th style="width:10%">操作符</th><th style="width:55%;">描述</th><th>实例</th></tr> <tr> <td>..</td><td>连接两个字符串</td><td> a..b ，其中 a 为 "Hello " ， b 为 "World", 输出结果为 "Hello World"。</td> </tr> <tr> <td>#</td><td>一元运算符，返回字符串或表的长度。</td><td>#"Hello" 返回 5</td> </tr> </tbody></table>

##运算符优先级
从高到低的顺序：

	^
	not    - (unary)
	*      /
	+      -
	..
	<      >      <=     >=     ~=     ==
	and
	or

除了^和..外所有的二元运算符都是左连接的。

#Lua 字符串

字符串或串(String)是由数字、字母、下划线组成的一串字符。

Lua 语言中字符串可以使用以下三种方式来表示：

* 单引号间的一串字符。
* 双引号间的一串字符。
* [[和]]间的一串字符。

**转义字符用于表示不能直接显示的字符.**

##字符串操作
Lua 提供了很多的方法来支持字符串的操作：

<table class="reference"> <tbody><tr><th style="width:5%">序号</th><th>方法 &amp; 用途</th></tr> <tr><td>1</td><td><b>string.upper(argument):</b><br>字符串全部转为大写字母。</td></tr> <tr><td>2</td><td><b>string.lower(argument):</b><br>字符串全部转为小写字母。</td></tr> <tr><td>3</td><td><b>string.gsub(mainString,findString,replaceString,num)</b><br>在字符串中替换,mainString为要替换的字符串， findString 为被替换的字符，replaceString 要替换的字符，num 替换次数（可以忽略，则全部替换），如： <pre class="prettyprint prettyprinted"><span class="pun">&gt;</span><span class="pln"> </span><span class="kwd">string</span><span class="pun">.</span><span class="pln">gsub</span><span class="pun">(</span><span class="str">"aaaa"</span><span class="pun">,</span><span class="str">"a"</span><span class="pun">,</span><span class="str">"z"</span><span class="pun">,</span><span class="lit">3</span><span class="pun">);</span><span class="pln">
zzza	</span><span class="lit">3</span></pre> </td></tr> <tr><td>4</td><td><b>string.strfind (str, substr, [init, [end]])</b><br> 在一个指定的目标字符串中搜索指定的内容(第三个参数为索引),返回其具体位置。不存在则返回 nil。 <pre class="prettyprint prettyprinted"><span class="pun">&gt;</span><span class="pln"> </span><span class="kwd">string</span><span class="pun">.</span><span class="pln">find</span><span class="pun">(</span><span class="str">"Hello Lua user"</span><span class="pun">,</span><span class="pln"> </span><span class="str">"Lua"</span><span class="pun">,</span><span class="pln"> </span><span class="lit">1</span><span class="pun">)</span><span class="pln"> 
</span><span class="lit">7</span><span class="pln">	</span><span class="lit">9</span></pre> </td></tr> <tr><td>5</td><td><b>string.reverse(arg)</b><br>字符串反转<pre class="prettyprint prettyprinted"><span class="pun">&gt;</span><span class="pln"> </span><span class="kwd">string</span><span class="pun">.</span><span class="pln">reverse</span><span class="pun">(</span><span class="str">"Lua"</span><span class="pun">)</span><span class="pln">
auL</span></pre></td></tr> <tr><td>6</td><td><b>string.format(...)</b><br>返回一个类似printf的格式化字符串 <pre class="prettyprint prettyprinted"><span class="pun">&gt;</span><span class="pln"> </span><span class="kwd">string</span><span class="pun">.</span><span class="pln">format</span><span class="pun">(</span><span class="str">"the value is:%d"</span><span class="pun">,</span><span class="lit">4</span><span class="pun">)</span><span class="pln">
the value </span><span class="kwd">is</span><span class="pun">:</span><span class="lit">4</span></pre></td></tr> <tr><td>7</td><td><b>string.char(arg) 和 string.byte(arg[,int])</b><br>char 将整型数字转成字符并连接， byte 转换字符为整数值(可以指定某个字符，默认第一个字符)。 <pre class="prettyprint prettyprinted"><span class="pun">&gt;</span><span class="pln"> </span><span class="kwd">string</span><span class="pun">.</span><span class="kwd">char</span><span class="pun">(</span><span class="lit">97</span><span class="pun">,</span><span class="lit">98</span><span class="pun">,</span><span class="lit">99</span><span class="pun">,</span><span class="lit">100</span><span class="pun">)</span><span class="pln">
abcd
</span><span class="pun">&gt;</span><span class="pln"> </span><span class="kwd">string</span><span class="pun">.</span><span class="kwd">byte</span><span class="pun">(</span><span class="str">"ABCD"</span><span class="pun">,</span><span class="lit">4</span><span class="pun">)</span><span class="pln">
</span><span class="lit">68</span><span class="pln">
</span><span class="pun">&gt;</span><span class="pln"> </span><span class="kwd">string</span><span class="pun">.</span><span class="kwd">byte</span><span class="pun">(</span><span class="str">"ABCD"</span><span class="pun">)</span><span class="pln">
</span><span class="lit">65</span><span class="pln">
</span><span class="pun">&gt;</span></pre></td></tr> <tr><td>8</td><td><b>string.len(arg)</b><br>计算字符串长度。 <pre class="prettyprint prettyprinted"><span class="kwd">string</span><span class="pun">.</span><span class="pln">len</span><span class="pun">(</span><span class="str">"abc"</span><span class="pun">)</span><span class="pln">
</span><span class="lit">3</span></pre></td></tr> <tr><td>9</td><td><b>string.rep(string, n))</b><br>返回字符串string的n个拷贝 <pre class="prettyprint prettyprinted"><span class="pun">&gt;</span><span class="pln"> </span><span class="kwd">string</span><span class="pun">.</span><span class="pln">rep</span><span class="pun">(</span><span class="str">"abcd"</span><span class="pun">,</span><span class="lit">2</span><span class="pun">)</span><span class="pln">
abcdabcd</span></pre> </td></tr> <tr><td>10</td><td><b>..</b><br>链接两个字符串 <pre class="prettyprint prettyprinted"><span class="pun">&gt;</span><span class="pln"> </span><span class="kwd">print</span><span class="pun">(</span><span class="str">"www.w3cschool"</span><span class="pun">..</span><span class="str">"cc"</span><span class="pun">)</span><span class="pln">
www</span><span class="pun">.</span><span class="pln">w3cschoolcc</span></pre> </td></tr> </tbody></table>


#Lua 数组

数组，就是相同数据类型的元素按一定顺序排列的集合，可以是一维数组和多维数组。

Lua 数组的索引键值可以使用整数表示，数组的大小不是固定的。

#Lua 迭代器

迭代器（iterator）是一种对象，它能够用来遍历标准模板库容器中的部分或全部元素，每个迭代器对象代表容器中的确定的地址

在Lua中迭代器是一种支持指针类型的结构，它可以遍历集合的每一个元素。

##泛型 for 迭代器
泛型 for 在自己内部保存迭代函数，实际上它保存三个值：迭代函数、状态常量、控制变量。

泛型 for 迭代器提供了集合的 key/value 对，语法格式如下：
	
	k, v为变量列表；pair(t)为表达式列表。
	for k, v in pairs(t) do
    	print(k, v)
	end

**e.g.**
	
	array = {"Lua", "Tutorial"}

	for key,value in ipairs(array) 
	do
   		print(key, value)
	end

输出：

	Lua
	Tutorial

范性for的执行过程：

* 首先，初始化，计算in后面表达式的值，表达式应该返回范性for需要的三个值：迭代函数、状态常量、控制变量；与多值赋值一样，如果表达式返回的结果个数不足三个会自动用nil补足，多出部分会被忽略。
* 第二，将状态常量和控制变量作为参数调用迭代函数（注意：对于for结构来说，状态常量没有用处，仅仅在初始化时获取他的值并传递给迭代函数）。
* 第三，将迭代函数返回的值赋给变量列表。
* 第四，如果返回的第一个值为nil循环结束，否则执行循环体。
* 第五，回到第二步再次调用迭代函数

在Lua中我们常常使用函数来描述迭代器，每次调用该函数就返回集合的下一个元素。Lua 的迭代器包含以下两种类型：

* 无状态的迭代器
* 多状态的迭代器


##无状态的迭代器
无状态的迭代器是指不保留任何状态的迭代器，因此在循环中我们可以利用无状态迭代器避免创建闭包花费额外的代价。

每一次迭代，迭代函数都是用两个变量（状态常量和控制变量）的值作为参数被调用，一个无状态的迭代器只利用这两个值可以获取下一个元素。

这种无状态迭代器的典型的简单的例子是ipairs，他遍历数组的每一个元素。


##多状态的迭代器
很多情况下，迭代器需要保存多个状态信息而不是简单的状态常量和控制变量，最简单的方法是使用闭包，还有一种方法就是将所有的状态信息封装到table内，将table作为迭代器的状态常量，因为这种情况下可以将所有的信息存放在table内，所以迭代函数通常不需要第二个参数。


#Lua table(表)

table 是 Lua 的一种数据结构用来帮助我们创建不同的数据类型，如：数字、字典等。

Lua table 使用关联型数组，你可以用任意类型的值来作数组的索引，但这个值不能是 nil。

Lua table 是不固定大小的，你可以根据自己需要进行扩容。

Lua也是通过table来解决模块（module）、包（package）和对象（Object）的。 例如string.format表示使用"format"来索引table string。

##table(表)的构造
构造器是创建和初始化表的表达式。表是Lua特有的功能强大的东西。最简单的构造函数是{}，用来创建一个空表。可以直接初始化数组。

##Table 操作
以下列出了 Table 操作常用的方法：

<table class="reference"> <tbody><tr><th style="width:5%">序号</th><th>方法 &amp; 用途</th></tr> <tr><td>1</td><td><b>table.concat (table [, step [, start [, end]]]):</b><p>concat是concatenate(连锁, 连接)的缩写. table.concat()函数列出参数中指定table的数组部分从start位置到end位置的所有元素, 元素间以指定的分隔符(sep)隔开。</p></td></tr> <tr><td>2</td><td><b>table.insert (table, [pos,] value):</b><p>在table的数组部分指定位置(pos)插入值为value的一个元素. pos参数可选, 默认为数组部分末尾.</p></td></tr> <tr><td>3</td><td><b>table.maxn (table)</b><p>指定table中所有正数key值中最大的key值. 如果不存在key值为正数的元素, 则返回0。(<b style="color:red;">Lua5.2之后该方法已经不存在了,本文使用了自定义函数实现</b>)</p></td></tr> <tr><td>4</td><td><b>table.remove (table [, pos])</b><p>返回table数组部分位于pos位置的元素. 其后的元素会被前移. pos参数可选, 默认为table长度, 即从最后一个元素删起。</p></td></tr> <tr><td>5</td><td><b>table.sort (table [, comp])</b><p>对给定的table进行升序排序。 </p></td></tr> </tbody></table>


#Lua 模块与包


模块类似于一个封装库，从 Lua 5.1 开始，Lua 加入了标准的模块管理机制，可以把一些公用的代码放在一个文件里，以 API 接口的形式在其他地方调用，有利于代码的重用和降低代码耦合度。

Lua 的模块是由变量、函数等已知元素组成的 table，因此创建一个模块很简单，就是创建一个 table，然后把需要导出的常量、函数放入其中，最后返回这个 table 就行。



**e.g.**

	-- 文件名为 module.lua
	-- 定义一个名为 module 的模块
	module = {}
 
	-- 定义一个常量
	module.constant = "这是一个常量"
 
	-- 定义一个函数
	function module.func1()
    	io.write("这是一个公有函数！\n")
	end
 
	local function func2()
    	print("这是一个私有函数！")
	end
 
	function module.func3()
    	func2()
	end
 
	return module
由上可知，模块的结构就是一个 table 的结构，因此可以像操作调用 table 里的元素那样来操作调用模块里的常量或函数。

上面的 func2 声明为程序块的局部变量，即表示一个私有函数，因此是不能从外部访问模块里的这个私有函数，必须通过模块里的公有函数来调用.

##require 函数
Lua提供了一个名为require的函数用来加载模块。要加载一个模块，只需要简单地调用就可以了。
	
	require("<模块名>")
	require "<模块名>"
	
###加载机制

对于自定义的模块，模块文件不是放在哪个文件目录都行，函数 require 有它自己的文件路径加载策略，它会尝试从 Lua 文件或 C 程序库中加载模块。

require 用于搜索 Lua 文件的路径是存放在全局变量 package.path 中，当 Lua 启动后，会以环境变量 LUA_PATH 的值来初始这个环境变量。如果没有找到该环境变量，则使用一个编译时定义的默认路径来初始化。

当然，如果没有 LUA_PATH 这个环境变量，也可以自定义设置，在当前用户根目录下打开 .profile 文件（没有则创建，打开 .bashrc 文件也可以），例如把 "~/lua/" 路径加入 LUA_PATH 环境变量里：

##C 包
Lua和C是很容易结合的，使用C为Lua写包。

与Lua中写包不同，C包在使用以前必须首先加载并连接，在大多数系统中最容易的实现方式是通过动态连接库机制。

Lua在一个叫loadlib的函数内提供了所有的动态连接的功能。这个函数有两个参数:库的绝对路径和初始化函数。

	local path = "/usr/local/lua/lib/libluasocket.so"
	local f = loadlib(path, "luaopen_socket")


#Lua 元表(Metatable)

在 Lua table 中我们可以访问对应的key来得到value值，但是却无法对两个 table 进行操作。

因此 Lua 提供了元表(Metatable)，允许我们改变table的行为，每个行为关联了对应的元方法。

有两个很重要的函数来处理元表：

1. setmetatable(table,metatable): 对指定table设置元表(metatable)，如果元表(metatable)中存在__metatable键值，setmetatable会失败 。
2. getmetatable(table): 返回对象的元表(metatable)。

	
##__index 元方法
\_\_index 元方法查看表中元素是否存在，如果不存在，返回结果为nil；如果存在则由\_\_index 返回结果。

##__newindex 元方法
__newindex 元方法用来对表更新，__index则用来对表访问 。

当你给表的一个缺少的索引赋值，解释器就会查找__newindex 元方法：如果存在则调用这个函数而不进行赋值操作。

##为表添加操作符

<table class="reference"> <tbody><tr><th style="width:20%">模式</th><th>描述</th></tr> <tr><td>__add</td><td>对应的运算符 '+'.</td></tr> <tr><td>__sub</td><td>对应的运算符 '-'.</td></tr> <tr><td>__mul</td><td>对应的运算符 '*'.</td></tr> <tr><td>__div</td><td>对应的运算符 '/'.</td></tr> <tr><td>__mod</td><td>对应的运算符 '%'.</td></tr> <tr><td>__unm</td><td>对应的运算符 '-'.</td></tr> <tr><td>__concat</td><td>对应的运算符 '..'.</td></tr> <tr><td>__eq</td><td>对应的运算符 '=='.</td></tr> <tr><td>__lt</td><td>对应的运算符 '&lt;'.</td></tr> <tr><td>__le</td><td>对应的运算符 '&lt;='.</td></tr> </tbody></table>

##\_\_call 元方法
\_\_call 元方法在 Lua 调用一个值时调用。

##\_\_tostring 元方法
\_\_tostring 元方法用于修改表的输出行为。


#Lua 协同程序(coroutine)

##什么是协同(coroutine)？
Lua 协同程序(coroutine)与线程比较类似：拥有独立的堆栈，独立的局部变量，独立的指令指针，同时又与其它协同程序共享全局变量和其它大部分东西。

协同是非常强大的功能，但是用起来也很复杂。

###线程和协同程序区别

线程与协同程序的主要区别在于，一个具有多个线程的程序可以同时运行几个线程，而协同程序却需要彼此协作的运行。

在任一指定时刻只有一个协同程序在运行，并且这个正在运行的协同程序只有在明确的被要求挂起的时候才会被挂起。

协同程序有点类似同步的多线程，在等待同一个线程锁的几个线程有点类似协同。

###基本语法

<table class="reference"> <tbody><tr><th>方法</th><th> 描述</th></tr> <tr><td>coroutine.create()</td><td> 创建coroutine，返回coroutine， 参数是一个函数，当和resume配合使用的时候就唤醒函数调用</td></tr><tr><td> coroutine.resume()</td><td> 重启coroutine，和create配合使用</td></tr><tr><td> coroutine.yield()</td><td> 挂起coroutine，将coroutine设置为挂起状态，这个和resume配合使用能有很多有用的效果</td></tr><tr><td> coroutine.status()</td><td> 查看coroutine的状态<br> 注：coroutine的状态有三种：dead，suspend，running，具体什么时候有这样的状态请参考下面的程序</td></tr><tr><td> coroutine.wrap（）</td><td> 创建coroutine，返回一个函数，一旦你调用这个函数，就进入coroutine，和create功能重复</td></tr><tr><td> coroutine.running()</td><td> 返回正在跑的coroutine，一个coroutine就是一个线程，当使用running的时候，就是返回一个corouting的线程号</td></tr></tbody></table>


#Lua 文件 I/O

Lua I/O 库用于读取和处理文件。分为简单模式（和C一样）、完全模式。

简单模式（simple model）拥有一个当前输入文件和一个当前输出文件，并且提供针对这些文件相关的操作。
完全模式（complete model） 使用外部的文件句柄来实现。它以一种面对对象的形式，将所有的文件操作定义为文件句柄的方法
简单模式在做一些简单的文件操作时较为合适。但是在进行一些高级的文件操作的时候，简单模式就显得力不从心。例如同时读取多个文件这样的操作，使用完全模式则较为合适。

##简单模式
简单模式使用标准的 I/O 或使用一个当前输入文件和一个当前输出文件。

###io 方法有：
* io.read()

* io.write()

* io.tmpfile():返回一个临时文件句柄，该文件以更新模式打开，程序结束时自动删除

* io.type(file): 检测obj是否一个可用的文件句柄

* io.flush(): 向文件写入缓冲中的所有数据

* io.lines(optional file name): 返回一个迭代函数,每次调用将获得文件中的一行内容,当到文件尾时，将返回nil,但不关闭文件

##完全模式
通常我们需要在同一时间处理多个文件。我们需要使用 file:function_name 来代替 io.function_name 方法。

#Lua 错误处理

程序运行中错误处理是必要的，在我们进行文件操作，数据转移及web service 调用过程中都会出现不可预期的错误。如果不注重错误信息的处理，就会照成信息泄露，程序无法运行等情况。

任何程序语言中，都需要错误处理。错误类型有：

* 语法错误
* 运行错误

##语法错误
语法错误通常是由于对程序的组件（如运算符、表达式）使用不当引起的。

##运行错误
运行错误是程序可以正常执行，但是会输出报错信息。


##错误处理
我们可以使用两个函数：assert 和 error 来处理错误。

##pcall 和 xpcall、debug
Lua中处理错误，可以使用函数pcall（protected call）来包装需要执行的代码。

pcall接收一个函数和要传递个后者的参数，并执行，执行结果：有错误、无错误；返回值true或者或false, errorinfo。

语法格式如下

	if pcall(function_name, ….) then
		-- 没有错误
	else
		-- 一些错误
	end


#Lua 调试(Debug)

Lua 提供了 debug 库用于提供创建我们自定义调速器的功能。Lua 本身并未有内置的调速器，但很多开发者共享了他们的 Lua 调速器代码。

Lua 中 debug 库包含以下函数：

sethook ([thread,] hook, mask [, count]):

<table class="reference"> <tbody><tr><th style="width:5%">序号</th><th>方法 &amp; 用途</th></tr> <tr><td>1.</td><td><b>debug(): </b><p>进入一个用户交互模式，运行用户输入的每个字符串。 使用简单的命令以及其它调试设置，用户可以检阅全局变量和局部变量， 改变变量的值，计算一些表达式，等等。 <br>输入一行仅包含 cont 的字符串将结束这个函数， 这样调用者就可以继续向下运行。</p></td></tr> <tr><td>2.</td><td><b>getfenv(object): </b><p>返回对象的环境变量。</p></td></tr> <tr><td>3.</td><td><b>gethook(optional thread): </b><p>返回三个表示线程钩子设置的值： 当前钩子函数，当前钩子掩码，当前钩子计数</p></td></tr> <tr><td>4.</td><td><b>getinfo ([thread,] f [, what]): </b><p>返回关于一个函数信息的表。 你可以直接提供该函数， 也可以用一个数字 f 表示该函数。 数字 f 表示运行在指定线程的调用栈对应层次上的函数： 0 层表示当前函数（getinfo 自身）； 1 层表示调用 getinfo 的函数 （除非是尾调用，这种情况不计入栈）；等等。 如果 f 是一个比活动函数数量还大的数字， getinfo 返回 nil。 </p></td></tr> <tr><td>5.</td><td><b>debug.getlocal ([thread,] f, local): </b><p>此函数返回在栈的 f 层处函数的索引为 local 的局部变量 的名字和值。 这个函数不仅用于访问显式定义的局部变量，也包括形参、临时变量等。 </p></td></tr> <tr><td>6.</td><td><b>getmetatable(value): </b><p>把给定索引指向的值的元表压入堆栈。如果索引无效，或是这个值没有元表，函数将返回 0 并且不会向栈上压任何东西。</p></td></tr> <tr><td>7.</td><td><b>getregistry(): </b><p> 返回注册表表，这是一个预定义出来的表， 可以用来保存任何 C 代码想保存的 Lua 值。</p></td></tr> <tr><td>8.</td><td><b>getupvalue (f, up)</b><p>此函数返回函数 f 的第 up 个上值的名字和值。 如果该函数没有那个上值，返回 nil 。 <br> 以 '(' （开括号）打头的变量名表示没有名字的变量 （去除了调试信息的代码块）。</p></td></tr> <tr><td>10.</td><td>将一个函数作为钩子函数设入。 字符串 mask 以及数字 count 决定了钩子将在何时调用。 掩码是由下列字符组合成的字符串，每个字符有其含义：<p></p> <ul> <li><b>'<code>c</code>': </b> 每当 Lua 调用一个函数时，调用钩子；</li> <li><b>'<code>r</code>': </b> 每当 Lua 从一个函数内返回时，调用钩子；</li> <li><b>'<code>l</code>': </b> 每当 Lua 进入新的一行时，调用钩子。</li> </ul> </td></tr> <tr><td>11.</td><td><b>setlocal ([thread,] level, local, value): </b><p>这个函数将 value 赋给 栈上第 level 层函数的第 local 个局部变量。 如果没有那个变量，函数返回 nil 。 如果 level 越界，抛出一个错误。</p></td></tr> <tr><td>12.</td><td><b>setmetatable (value, table): </b><p>将 value 的元表设为 table （可以是 nil）。 返回 value。</p></td></tr> <tr><td>13.</td><td><b>setupvalue (f, up, value): </b><p>这个函数将 value 设为函数 f 的第 up 个上值。 如果函数没有那个上值，返回 nil 否则，返回该上值的名字。</p></td></tr> <tr><td>14.</td><td><b>traceback ([thread,] [message [, level]]):</b><p>如果 message 有，且不是字符串或 nil， 函数不做任何处理直接返回 message。 否则，它返回调用栈的栈回溯信息。 字符串可选项 message 被添加在栈回溯信息的开头。 数字可选项 level 指明从栈的哪一层开始回溯 （默认为 1 ，即调用 traceback 的那里）。</p></td></tr> </tbody></table>


##调试类型
* 命令行调试
* 图形界面调试

命令行调试器有：RemDebug、clidebugger、ctrace、xdbLua、LuaInterface - Debugger、Rldb、ModDebug。

图形界调试器有：SciTE、Decoda、ZeroBrane Studio、akdebugger、luaedit。


#Lua 垃圾回收

Lua 采用了自动内存管理。 这意味着你不用操心新创建的对象需要的内存如何分配出来， 也不用考虑在对象不再被使用后怎样释放它们所占用的内存。

Lua 运行了一个垃圾收集器来收集所有死对象 （即在 Lua 中不可能再访问到的对象）来完成自动内存管理的工作。 Lua 中所有用到的内存，如：字符串、表、用户数据、函数、线程、 内部结构等，都服从自动管理。

Lua 实现了一个增量标记-扫描收集器。 它使用这两个数字来控制垃圾收集循环： 垃圾收集器间歇率和垃圾收集器步进倍率。 这两个数字都使用百分数为单位 （例如：值 100 在内部表示 1 ）。

垃圾收集器间歇率控制着收集器需要在开启新的循环前要等待多久。 增大这个值会减少收集器的积极性。 当这个值比 100 小的时候，收集器在开启新的循环前不会有等待。 设置这个值为 200 就会让收集器等到总内存使用量达到 之前的两倍时才开始新的循环。

垃圾收集器步进倍率控制着收集器运作速度相对于内存分配速度的倍率。 增大这个值不仅会让收集器更加积极，还会增加每个增量步骤的长度。 不要把这个值设得小于 100 ， 那样的话收集器就工作的太慢了以至于永远都干不完一个循环。 默认值是 200 ，这表示收集器以内存分配的"两倍"速工作。

如果你把步进倍率设为一个非常大的数字 （比你的程序可能用到的字节数还大 10% ）， 收集器的行为就像一个 stop-the-world 收集器。 接着你若把间歇率设为 200 ， 收集器的行为就和过去的 Lua 版本一样了： 每次 Lua 使用的内存翻倍时，就做一次完整的收集。

##垃圾回收器函数
Lua 提供了以下函数collectgarbage ([opt [, arg]])用来控制自动内存管理:

* collectgarbage("collect"): 做一次完整的垃圾收集循环。通过参数 opt 它提供了一组不同的功能：

* collectgarbage("count"): 以 K 字节数为单位返回 Lua 使用的总内存数。 这个值有小数部分，所以只需要乘上 1024 就能得到 Lua 使用的准确字节数（除非溢出）。

* collectgarbage("restart"): 重启垃圾收集器的自动运行。

* collectgarbage("setpause"): 将 arg 设为收集器的 间歇率 （参见 §2.5）。 返回 间歇率 的前一个值。

* collectgarbage("setstepmul"): 返回 步进倍率 的前一个值。

* collectgarbage("step"): 单步运行垃圾收集器。 步长"大小"由 arg 控制。 传入 0 时，收集器步进（不可分割的）一步。 传入非 0 值， 收集器收集相当于 Lua 分配这些多（K 字节）内存的工作。 如果收集器结束一个循环将返回 true 。

* collectgarbage("stop"): 停止垃圾收集器的运行。 在调用重启前，收集器只会因显式的调用运行。

#Lua 面向对象

##Lua 中面向对象
我们知道，对象由属性和方法组成。LUA中最基本的结构是table，所以需要用table来描述对象的属性。

lua中的function可以用来表示方法。那么LUA中的类可以通过table + function模拟出来。

至于继承，可以通过metetable模拟出来（不推荐用，只模拟最基本的对象大部分时间够用了）。

Lua中的表不仅在某种意义上是一种对象。像对象一样，表也有状态（成员变量）；也有与对象的值独立的本性，特别是拥有两个不同值的对象（table）代表两个不同的对象；一个对象在不同的时候也可以有不同的值，但他始终是一个对象；与对象类似，表的生命周期与其由什么创建、在哪创建没有关系。对象有他们的成员函数，表也有

##Lua 继承
继承是指一个对象直接使用另一对象的属性和方法。可用于扩展基础类的属性和方法。

##函数重写
Lua 中我们可以重写基础类的函数，在派生类中定义自己的实现方式：

#Lua 数据库访问

本文主要为大家介绍 Lua 数据库的操作库：LuaSQL。他是开源的，支持的数据库有：ODBC, ADO, Oracle, MySQL, SQLite 和 PostgreSQL。











