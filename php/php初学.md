#PHP初学
======
#PHP教程和参考资料
=====
PHP 是一种创建动态交互性站点的强有力的服务器端脚本语言。
PHP 是免费的，并且使用非常广泛。同时，对于像微软 ASP 这样的竞争者来说，PHP 无疑是另一种高效率的选项。

PHP 是服务器端脚本语言。
在继续学习之前，您需要对以下知识有基本的了解：

* HTML
* CSS

##PHP 是什么？
* PHP 代表 PHP: Hypertext Preprocessor
* PHP 是一种使用广泛的开源的脚本语言
* PHP 脚本在服务器上执行
* PHP 可免费下载使用

##PHP能做什么
* PHP 可以生成动态页面内容
* PHP 可以创建、打开、读取、写入、关闭服务器上的文件
* PHP 可以收集表单数据
* PHP 可以发送和接收 cookies
* PHP 可以添加、删除、修改您的数据库中的数据
* PHP 可以限制用户访问您的网站上的一些页面
* PHP 可以加密数据

#PHP基础
====
##PHP基本语法
PHP 脚本可以放在文档中的任何位置。

PHP 脚本以 <?php 开始，以 ?> 结束：

```
<?php
// PHP code goes here
?>
```

PHP 文件的默认文件扩展名是 ".php"。

PHP 文件通常包含 HTML 标签和一些 PHP 脚本代码。

##PHP注释
单行注释：//

多行注释：/\* ... \*/

这点和C++的注释是一致的。

##PHP变量
PHP 变量规则：

* 变量以 $ 符号开始，后面跟着变量的名称
* 变量名必须以字母或者下划线字符开始
* 变量名只能包含字母数字字符以及下划线（A-z、0-9 和 _ ）
* 变量名不能包含空格
* 变量名是区分大小写的（$y 和 $Y 是两个不同的变量）


** PHP 语句和 PHP 变量都是区分大小写的。**

###创建PHP变量
PHP 没有声明变量的命令。

变量在您第一次赋值给它的时候被创建：

```
<?php
$txt="Hello world!";
$x=5;
$y=10.5;
?>
```

###PHP 是一门弱类型语言
在上面的实例中，我们注意到，不必向 PHP 声明该变量的数据类型。   

PHP 会根据变量的值，自动把变量转换为正确的数据类型。

在强类型的编程语言中，我们必须在使用变量前先声明（定义）变量的类型和名称。

###PHP 变量作用域
变量的作用域是脚本中变量可被引用/使用的部分。

####PHP 有四种不同的变量作用域：

* local
* global
* static
* parameter

####局部和全局作用域
在所有函数外部定义的变量，拥有全局作用域。除了函数外，全局变量可以被脚本中的任何部分访问，要在一个函数中访问一个全局变量，需要使用 global 关键字。

在 PHP 函数内部声明的变量是局部变量，仅能在函数内部访问：

####PHP global 关键字
global 关键字用于函数内访问全局变量。

在函数内调用函数外定义的全局变量，我们需要在函数中的变量前加上 global 关键字（这点和C语言不同，C语言使用全局变量不需要global关键字）。

####Static 作用域
当一个函数完成时，它的所有变量通常都会被删除。然而，有时候您希望某个局部变量不要被删除。

要做到这一点，请在您第一次声明变量时使用 static 关键字。（这点和C语言一样）

####参数作用域
参数是通过调用代码将值传递给函数的局部变量。

参数是在参数列表中声明的，作为函数声明的一部分。

##PHP的echo 和 print
###echo 和 print 区别:

* echo - 可以输出一个或多个字符串
* print - 只允许输出一个字符串，返回值总为 1

**提示：echo 输出的速度比 print 快， echo 没有返回值，print有返回值1。**


###PHP echo 语句
echo 是一个语言结构，使用的时候可以不用加括号，也可以加上括号： echo 或 echo()。

```
<?php
echo "<h2>PHP is fun!</h2>";
echo "Hello world!<br>";
echo "I'm about to learn PHP!<br>";
echo "This", " string", " was", " made", " with multiple parameters.";
?>
```
###PHP print 语句
print 同样是一个语言结构，可以使用括号，也可以不使用括号： print 或 print()。

```
<?php
print "<h2>PHP is fun!</h2>";
print "Hello world!<br>";
print "I'm about to learn PHP!";
?>
```

##PHP 5 数据类型
String（字符串）, Integer（整型）, Float（浮点型）, Boolean（布尔型）, Array（数组）, Object（对象）, NULL（空值）。

###PHP 字符串
一个字符串是一串字符的序列，就像 "Hello world!"。

你可以将任何文本放在`单引号`和`双引号`中，这点多数脚本语言是一样的，如python。


###PHP 整型
整数是一个没有小数的数字。

整数规则:

* 整数必须至少有一个数字 (0-9)
* 整数不能包含逗号或空格
* 整数是没有小数点的
* 整数可以是正数或负数
* 整型可以用三种格式来指定：十进制， 十六进制（ 以 0x 为前缀）或八进制（前缀为 0）。


*PHP var_dump() 函数返回变量的数据类型和值.*

###PHP 浮点型
浮点数是带小数部分的数字，或是指数形式。

###PHP 布尔型
布尔型可以是 TRUE 或 FALSE。

###PHP 数组
数组可以在一个变量中存储多个值。

###PHP 对象
对象数据类型也可以用于存储数据。

在 PHP 中，对象必须声明。

首先，你必须使用class关键字声明类对象。类是可以包含属性和方法的结构。

然后我们在类中定义数据类型，然后在实例化的类中使用数据类型：

```
<?php
class Car
{
  var $color;
  function Car($color="green") {
    $this->color = $color;
  }
  function what_color() {
    return $this->color;
  }
}
?>
```

###PHP NULL 值
NULL 值表示变量没有值。NULL 是数据类型为 NULL 的值。

NULL 值指明一个变量是否为空值。 同样可用于数据空值和NULL值的区别。

可以通过设置变量值为 NULL 来清空变量数据

##PHP常量
常量是一个简单值的标识符。该值在脚本中不能改变。

一个常量由英文字母、下划线、和数字组成,但数字不能作为首字母出现。 (常量名不需要加 $ 修饰符)。

注意： 常量在整个脚本中都可以使用。

###设置 PHP 常量
设置常量，使用 define() 函数，函数语法如下：

```
define(string constant_name, mixed value, case_sensitive = true)
该函数有三个参数:

nstant_name：必选参数，常量名称，即标志符。
value：必选参数，常量的值。
case_sensitive：可选参数，指定是否大小写敏感，设定为 true 表示不敏感。
```

##PHP字符串变量
###PHP 中的字符串变量
字符串变量用于包含有字符的值。

在创建字符串之后，我们就可以对它进行操作了。您可以直接在函数中使用字符串，或者把它存储在变量中。

###PHP 并置运算符
在 PHP 中，只有一个字符串运算符。

并置运算符 (.) 用于把两个字符串值连接起来。

###PHP strlen() 函数
有时知道字符串值的长度是很有用的。

strlen() 函数返回字符串的长度（字符数）。

###PHP strpos() 函数
strpos() 函数用于在字符串内查找一个字符或一段指定的文本。

如果在字符串中找到匹配，该函数会返回第一个匹配的字符位置。如果未找到匹配，则返回 FALSE。

##PHP运算符
###PHP 算术运算符
+、-、*、/、%、.
###PHP赋值运算法
=
###递增/递减运算符
++、--
###比较运算法
* ==、===、
* <>、!=、!==
* />、<、>=、<=

###逻辑运算符
and、or、xor、&&、||、!

###数组运算符
集合+、相等==、恒等===、不相等!=、不相等<>、不恒等!==

##控制流程
**基本和C语言没有区别。**
###if else
* if

```
if (条件)
{
条件成立时要执行的代码;
}
```
* if else

```
if (条件)
{
条件成立时执行的代码;
}
else
{
条件不成立时执行的代码;
}
```

* if else if else

```
if (条件)
{
if 条件成立时执行的代码;
}
else if (条件)
{
elseif 条件成立时执行的代码;
}
else
{
条件不成立时执行的代码;
}
```

###switch语句

```
switch (n)
{
case label1:
如果 n=label1，此处代码将执行;
break;
case label2:
如果 n=label2，此处代码将执行;
break;
default:
如果 n 既不等于 label1 也不等于 label2，此处代码将执行;
}
```

###while 循环
```
while (条件)
{
要执行的代码;
}
```
###do...while 语句
```
do
{
要执行的代码;
}
while (条件);
```

###for循环
```
for (初始值; 条件; 增量)
{
要执行的代码;
}
```

###foreach循环
```
foreach ($array as $value)
{
要执行代码;
}
```

##PHP数组
###创建数组
在 PHP 中，array() 函数用于创建数组
在 PHP 中，有三种类型的数组：

* 数值数组 - 带有数字 ID 键的数组
* 关联数组 - 带有指定的键的数组，每个键关联一个值
* 多维数组 - 包含一个或多个数组的数组

###数值数组
有两种创建数值数组的方法：

* 自动分配 ID 键（ID 键总是从 0 开始）:

```
$cars=array("Volvo","BMW","Toyota");
```

* 人工分配 ID 键：

```
$cars[0]="Volvo";
$cars[1]="BMW";
$cars[2]="Toyota";
```

####获取数组的长度 - count() 函数
####遍历数值数组 - 使用for循环

###关联数组
有两种创建关联数组的方法：

```
$age=array("Peter"=>"35","Ben"=>"37","Joe"=>"43");
```

```
$age['Peter']="35";
$age['Ben']="37";
$age['Joe']="43";
```
####遍历关联数组 - 使用foreach

###数组排序

```
sort() - 对数组进行升序排列
rsort() - 对数组进行降序排列
asort() - 根据关联数组的值，对数组进行升序排列
ksort() - 根据关联数组的键，对数组进行升序排列
arsort() - 根据关联数组的值，对数组进行降序排列
krsort() - 根据关联数组的键，对数组进行降序排列
```

##PHP超级全局变量
PHP中预定义了几个超级全局变量（superglobals） ，这意味着它们在一个脚本的全部作用域中都可用。 
PHP 超级全局变量列表:

```
$GLOBALS
$_SERVER
$_REQUEST
$_POST
$_GET
$_FILES
$_ENV
$_COOKIE
$_SESSION
```

##PHP函数
PHP 的真正威力源自于它的函数。

在 PHP 中，提供了超过 1000 个内建的函数。

###创建 PHP 函数
```
function functionName(param1, param2,...)
{
要执行的代码;
}
```
与c语言类似，参数可以为空，不需要指定返回值，如果需要返回一个值，使用return语句即可。


##PHP魔术变量
* \_\_LINE\_\_  
文件中的当前行号
* \_\_FILE\_\_  
文件的完整路径和文件名。如果用在被包含文件中，则返回被包含的文件名。
* \_\_DIR\_\_  
文件所在的目录。如果用在被包括文件中，则返回被包括的文件所在的目录。它等价于 dirname(\_\_FILE\_\_)。除非是根目录，否则目录中名不包括末尾的斜杠。
* \_\_FUNCTION\_\_  
函数名称（PHP 4.3.0 新加）。自 PHP 5 起本常量返回该函数被定义时的名字（区分大小写）。在 PHP 4 中该值总是小写字母的。
* \_\_CLASS\_\_  
类的名称（PHP 4.3.0 新加）。自 PHP 5 起本常量返回该类被定义时的名字（区分大小写）。在 PHP 4 中该值总是小写字母的。类名包括其被声明的作用区域。
* \_\_TRAIT\_\_  
Trait 的名字（PHP 5.4.0 新加）。自 PHP 5.4.0 起，PHP 实现了代码复用的一个方法，称为 traits。Trait 名包括其被声明的作用区域
* \_\_METHOD\_\_  
类的方法名（PHP 5.0.0 新加）。返回该方法被定义时的名字（区分大小写）。
* \_\_NAMESPACE\_\_  
当前命名空间的名称（区分大小写）。此常量是在编译时定义的（PHP 5.3.0 新增）。

##PHP命名空间
###定义命名空间
默认情况下，所有常量、类和函数名都放在全局空间下，就和PHP支持命名空间之前一样。

命名空间通过关键字namespace 来声明。如果一个文件中包含命名空间，它必须在其它所有代码之前声明命名空间。

声明命名空间之前唯一合法的代码是用于定义源文件编码方式的 declare 语句。

命名空间使用
PHP 命名空间中的类名可以通过三种方式引用：

1.非限定名称，或不包含前缀的类名称，例如 $a=new foo(); 或 foo::staticmethod();。如果当前命名空间是 currentnamespace，foo 将被解析为 currentnamespace\foo。如果使用 foo 的代码是全局的，不包含在任何命名空间中的代码，则 foo 会被解析为foo。 警告：如果命名空间中的函数或常量未定义，则该非限定的函数名称或常量名称会被解析为全局函数名称或常量名称。

2.限定名称,或包含前缀的名称，例如 $a = new subnamespace\foo(); 或 subnamespace\foo::staticmethod();。如果当前的命名空间是 currentnamespace，则 foo 会被解析为 currentnamespace\subnamespace\foo。如果使用 foo 的代码是全局的，不包含在任何命名空间中的代码，foo 会被解析为subnamespace\foo。

3.完全限定名称，或包含了全局前缀操作符的名称，例如， $a = new \currentnamespace\foo(); 或 \currentnamespace\foo::staticmethod();。在这种情况下，foo 总是被解析为代码中的文字名(literal name)currentnamespace\foo。



#PHP表单
=======
###获取表单信息
PHP 中的 $_GET 和 $_POST 变量用于检索表单中的信息，比如用户输入。

`有一点很重要的事情值得注意，当处理 HTML 表单时，PHP 能把来自 HTML 页面中的表单元素自动变成可供 PHP 脚本使用。`

###表单验证
* $_SERVER["PHP_SELF"] 可以通过 htmlspecialchars() 函数来避免被利用。
* 使用PHP stripslashes()函数去除用户输入数据中的反斜杠 (\)
* 使用 PHP trim() 函数去除用户输入数据中不必要的字符 (如：空格，tab，换行)。

###必需字段
每个$\_POST变量增加了一个if else语句。 这些语句将检查 $\_POST 变量是 否为空（使用php的 empty() 函数）。如果为空，将显示对应的错误信息。 如果不为空，数据将传递给test_input() 函数


###验证邮件和URL
preg_match — 进行正则表达式匹配。

###PHP $_GET 变量
在 PHP 中，预定义的 $\_GET 变量用于收集来自 method="get" 的表单中的值。
####何时使用 method="get"？
* 在 HTML 表单中使用 method="get" 时，所有的变量名和值都会显示在 URL 中。
* 注释：所以在发送密码或其他敏感信息时，不应该使用这个方法！
* 然而，正因为变量显示在 URL 中，因此可以在收藏夹中收藏该页面。在某些情况下，这是很有用的。
* 注释：HTTP GET 方法不适合大型的变量值。它的值是不能超过 2000 个字符的。


###PHP $_POST 变量
在 PHP 中，预定义的 $\_POST 变量用于收集来自 method="post" 的表单中的值。
####何时使用 method="post"？
* 从带有 POST 方法的表单发送的信息，对任何人都是不可见的，并且对发送信息的量也没有限制。
* 然而，由于变量不显示在 URL 中，所以无法把页面加入书签。

###PHP $_REQUEST 变量
预定义的 $\_REQUEST 变量包含了 $\_GET、$\_POST 和 $\_COOKIE 的内容。

$\_REQUEST 变量可用来收集通过 GET 和 POST 方法发送的表单数据。

#PHP 高级教程
========
##多维数组

##日期Date

##包含文件include 和 require

include 和 require 除了处理错误的方式不同之外，在其他方面都是相同的：

* require 生成一个致命错误（E_COMPILE_ERROR），在错误发生后脚本会停止执行。
* include 生成一个警告（E_WARNING），在错误发生后脚本会继续执行。

##文件操作
和C语言的文件操作类似。
####打开文件
fopen() 函数用于在 PHP 中打开文件。

此函数的第一个参数含有要打开的文件的名称，第二个参数规定了使用哪种模式来打开文件：

####关闭文件
fclose() 函数用于关闭打开的文件。

####检测 End-of-file
feof() 函数检测是否已到达文件末尾（EOF）。

在循环遍历未知长度的数据时，feof() 函数很有用。

####逐行读取文件
fgets() 函数用于从文件中逐行读取文件。

注释：在调用该函数之后，文件指针会移动到下一行。


####逐字符读取文件
fgetc() 函数用于从文件中逐字符地读取文件。

注释：在调用该函数之后，文件指针会移动到下一个字符。

###文件上传
通过使用 PHP 的全局数组 $_FILES，你可以从客户计算机向远程服务器上传文件。

第一个参数是表单的 input name，第二个下标可以是 "name"、"type"、"size"、"tmp_name" 或 "error"。如下所示：

* $\_FILES["file"]["name"] - 被上传文件的名称
* $\_FILES["file"]["type"] - 被上传文件的类型
* $\_FILES["file"]["size"] - 被上传文件的大小，以字节计
* $\_FILES["file"]["tmp_name"] - 存储在服务器的文件的临时副本的名称
* $\_FILES["file"]["error"] - 由文件上传导致的错误代码

这是一种非常简单文件上传方式。基于安全方面的考虑，您应当增加有关允许哪些用户上传文件的限制。

##Cookies
cookie 常用于识别用户。

####Cookie 是什么？
cookie 常用于识别用户。cookie 是一种服务器留在用户计算机上的小文件。每当同一台计算机通过浏览器请求页面时，这台计算机将会发送 cookie。通过 PHP，您能够创建并取回 cookie 的值。

####如何创建 Cookie？
setcookie() 函数用于设置 cookie。

注释：setcookie() 函数必须位于 <html> 标签之前。

```
setcookie(name, value, expire, path, domain);
```

####如何取回 Cookie 的值？
PHP 的 $_COOKIE 变量用于取回 cookie 的值。

####如何删除 Cookie？
当删除 cookie 时，您应当使过期日期变更为过去的时间点。


##Sessions

PHP session 变量用于存储关于用户会话（session）的信息，或者更改用户会话（session）的设置。Session 变量存储单一用户的信息，并且对于应用程序中的所有页面都是可用的。

####PHP Session 变量
您在计算机上操作某个应用程序时，您打开它，做些更改，然后关闭它。这很像一次对话（Session）。计算机知道您是谁。它清楚您在何时打开和关闭应用程序。然而，在因特网上问题出现了：由于 HTTP 地址无法保持状态，Web 服务器并不知道您是谁以及您做了什么。

PHP session 解决了这个问题，它通过在服务器上存储用户信息以便随后使用（比如用户名称、购买商品等）。然而，会话信息是临时的，在用户离开网站后将被删除。如果您需要永久存储信息，可以把数据存储在数据库中。

Session 的工作机制是：为每个访客创建一个唯一的 id (UID)，并基于这个 UID 来存储变量。UID 存储在 cookie 中，或者通过 URL 进行传导。

####开始 PHP Session
在您把用户信息存储到 PHP session 中之前，首先必须启动会话。

注释：session_start() 函数必须位于 <html> 标签之前.

####存储 Session 变量
存储和取回 session 变量的正确方法是使用 PHP $\_SESSION 变量。

####销毁 Session
如果您希望删除某些 session 数据，可以使用 unset() 或 session_destroy() 函数。

* unset() 函数用于释放指定的 session 变量。
* session_destroy() 函数彻底销毁 session。

##发送电子邮件--mail函数

```
mail(to,subject,message,headers,parameters)
```
前三个参数必需，后面两个参数可选。

*防止Emal注入攻击*


##错误处理
不同的错误处理方法：

* 简单的 "die()" 语句
* 自定义错误和错误触发器
自定义错误
```
error_function(error_level,error_message,
error_file,error_line,error_context)
```

设置错误处理程序
```
set_error_handler("customError");
```
触发错误trigger_error函数。


* 错误报告

错误记录
在默认的情况下，根据在 php.ini 中的 error_log 配置，PHP 向服务器的记录系统或文件发送错误记录。通过使用 error_log() 函数，您可以向指定的文件或远程目的地发送错误记录。

通过电子邮件向您自己发送错误消息，是一种获得指定错误的通知的好办法。

##异常处理

####什么是异常
异常处理用于在指定的错误（异常）情况发生时改变脚本的正常流程。这种情况称为异常。

当异常被触发时，通常会发生：

* 当前代码状态被保存
* 代码执行被切换到预定义（自定义）的异常处理器函数
* 根据情况，处理器也许会从保存的代码状态重新开始执行代码，终止脚本执行，或从代码中另外的位置继续执行脚本
* 我们将展示不同的错误处理方法：

异常的基本使用
* 创建自定义的异常处理器
* 多个异常
* 重新抛出异常
* 设置顶层异常处理器

####Try、throw 和 catch
要避免上面实例中出现的错误，我们需要创建适当的代码来处理异常。

适当的处理异常代码应该包括：

1. Try - 使用异常的函数应该位于 "try" 代码块内。如果没有触发异常，则代码将照常继续执行。但是如果异常被触发，会抛出一个异常。
2. Throw - 里规定如何触发异常。每一个 "throw" 必须对应至少一个 "catch"。
3. Catch - "catch" 代码块会捕获异常，并创建一个包含异常信息的对象。

和C++，java中的异常处理类似。

####创建一个自定义的 Exception 类
创建自定义的异常处理程序非常简单。我们简单地创建了一个专门的类，当 PHP 中发生异常时，可调用其函数。该类必须是 exception 类的一个扩展。

这个自定义的 exception 类继承了 PHP 的 exception 类的所有属性，您可向其添加自定义的函数。

####异常的规则
* 需要进行异常处理的代码应该放入 try 代码块内，以便捕获潜在的异常。
* 每个 try 或 throw 代码块必须至少拥有一个对应的 catch 代码块。
* 使用多个 catch 代码块可以捕获不同种类的异常。
* 可以在 try 代码块内的 catch 代码块中抛出（再次抛出）异常。

简而言之：如果抛出了异常，就必须捕获它。


##过滤器
####什么是 PHP 过滤器？
PHP 过滤器用于验证和过滤来自非安全来源的数据。

测试、验证和过滤用户输入或自定义数据是任何 Web 应用程序的重要组成部分。

PHP 的过滤器扩展的设计目的是使数据过滤更轻松快捷。

####为什么使用过滤器？
几乎所有的 Web 应用程序都依赖外部的输入。这些数据通常来自用户或其他应用程序（比如 web 服务）。通过使用过滤器，您能够确保应用程序获得正确的输入类型。

您应该始终对外部数据进行过滤！

输入过滤是最重要的应用程序安全课题之一。

####什么是外部数据？

* 来自表单的输入数据
* Cookies
* Web services data
* 服务器变量
* 数据库查询结果

####函数和过滤器
如需过滤变量，请使用下面的过滤器函数之一：

filter_var() - 通过一个指定的过滤器来过滤单一的变量
filter_var_array() - 通过相同的或不同的过滤器来过滤多个变量
filter_input - 获取一个输入变量，并对它进行过滤
filter_input_array - 获取多个输入变量，并通过相同的或不同的过滤器对它们进行过滤

####Validating 和 Sanitizing
有两种过滤器：

Validating 过滤器：

* 用于验证用户输入
* 严格的格式规则（比如 URL 或 E-Mail 验证）
* 如果成功则返回预期的类型，如果失败则返回 FALSE

Sanitizing 过滤器：

* 用于允许或禁止字符串中指定的字符Are used to allow or disallow specified characters in a string
* 无数据格式规则
* 始终返回字符串

####选项和标志
选项和标志用于向指定的过滤器添加额外的过滤选项。

不同的过滤器有不同的选项和标志。

####使用 Filter Callback
通过使用 FILTER_CALLBACK 过滤器，可以调用自定义的函数，把它作为一个过滤器来使用。这样，我们就拥有了数据过滤的完全控制权。

您可以创建自己的自定义函数，也可以使用已存在的 PHP 函数。

将您准备用到的过滤器的函数，按指定选项的规定方法进行规定。在关联数组中，带有名称 "options"。


##PHP JSON
###JSON 函数
####json_encode
PHP json_encode() 用于对变量进行 JSON 编码，该函数如果执行成功返回 JSON 数据，否则返回 FALSE 。

###json_decode
PHP json_decode() 函数用于对 JSON 格式的字符串进行解码，并转换为 PHP 变量。


#PHP 和 MySQL
=========
##MySQL简介
MySQL 是什么？

* MySQL 是一种在 Web 上使用的数据库系统。
* MySQL 是一种在服务器上运行的数据库系统。
* MySQL 不管在小型还是大型应用程序中，都是理想的选择。
* MySQL 是非常快速，可靠，且易于使用的。
* MySQL 支持标准的 SQL。
* MySQL 在一些平台上编译。
* MySQL 是免费下载使用的。
* MySQL 是由 Oracle 公司开发、发布和支持的。
* MySQL 是以公司创始人 Monty Widenius's daughter: My 命名的。

MySQL 中的数据存储在表中。表格是一个相关数据的集合，它包含了列和行。


##PHP连接MySQL

PHP 5 及以上版本建议使用以下方式连接 MySQL :

* MySQLi extension ("i" 意为 improved)
* PDO (PHP Data Objects)

##MySQLi ，还是 PDO?
如果你需要一个简短的回答，即 "你习惯哪个就用哪个"。

MySQLi 和 PDO 有它们自己的优势：

PDO 应用在 12 种不同数据库中， MySQLi 只针对 MySQL 数据库。

所以，如果你的项目需要在多种数据库中切换，建议使用 PDO ，这样你只需要修改连接字符串和部门查询语句即可。 使用 MySQLi, 如果不同数据库，你需要重新所有代码，包括查询。

两者都是面向对象, 但 MySQLi 还提供了 API 接口。

两者都支持预处理语句。 预处理语句可以防止 SQL 注入，对于 web 项目的安全性是非常重要的。



##MySQLi 和 PDO 连接 MySQL 实例
使用以下三种方式来演示 PHP 操作 MySQL:

* MySQLi (面向对象)
* MySQLi (面向过程)
* PDO

###实例 (MySQLi - 面向对象)

```
<?php
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "myDB";

// 创建连接
$conn = new mysqli($servername, $username, $password, $dbname);
// 检测连接
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

// sql to create table
$sql = "CREATE TABLE MyGuests (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
firstname VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL,
email VARCHAR(50),
reg_date TIMESTAMP
)";

if ($conn->query($sql) === TRUE) {
    echo "Table MyGuests created successfully";
} else {
    echo "Error creating table: " . $conn->error;
}

$conn->close();
?>
```

###实例 (MySQLi - 面向过程)
```
<?php
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "myDB";

// 创建连接
$conn = mysqli_connect($servername, $username, $password, $dbname);
// 检测连接
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// sql to create table
$sql = "CREATE TABLE MyGuests (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
firstname VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL,
email VARCHAR(50),
reg_date TIMESTAMP
)";

if (mysqli_query($conn, $sql)) {
    echo "Table MyGuests created successfully";
} else {
    echo "Error creating table: " . mysqli_error($conn);
}

mysqli_close($conn);
?>
```


###实例 (PDO)

```
<?php
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "myDBPDO";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // sql to create table
    $sql = "CREATE TABLE MyGuests (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(30) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    email VARCHAR(50),
    reg_date TIMESTAMP
    )";

    // use exec() because no results are returned
    $conn->exec($sql);
    echo "Table MyGuests created successfully";
    }
catch(PDOException $e)
    {
    echo $sql . "<br>" . $e->getMessage();
    }

$conn = null;
?>
```

##预处理

预处理语句用于执行多个相同的 SQL 语句，并且执行效率更高。

预处理语句的工作原理如下：

1. 预处理：创建 SQL 语句模板并发送到数据库。预留的值使用参数 "?" 标记 。例如：INSERT INTO MyGuests (firstname, lastname, email) VALUES(?, ?, ?)
2. 数据库解析，编译，对SQL语句模板执行查询优化，并存储结果不输出
3. 执行：最后，将应用绑定的值传递给参数（"?" 标记），数据库执行语句。应用可以多次执行语句，如果参数的值不一样。

相比于直接执行SQL语句，预处理语句有两个主要优点：

* 预处理语句大大减少了分析时间，只做了一次查询（虽然语句多次执行）
* 绑定参数减少了服务器带宽，你只需要发送查询的参数，而不是整个语句
* 预处理语句针对SQL注入是非常有用的，因为 参数值发送后使用不同的协议，保证了数据的合法性。

###MySQLi 预处理语句
```
<?php
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "myDB";

// 创建连接
$conn = new mysqli($servername, $username, $password, $dbname);

// 检测连接
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// prepare and bind
$stmt = $conn->prepare("INSERT INTO MyGuests (firstname, lastname, email) VALUES(?, ?, ?)");
$stmt->bind_param("sss", $firstname, $lastname, $email);

// 设置参数并执行
$firstname = "John";
$lastname = "Doe";
$email = "john@example.com";
$stmt->execute();

$firstname = "Mary";
$lastname = "Moe";
$email = "mary@example.com";
$stmt->execute();

$firstname = "Julie";
$lastname = "Dooley";
$email = "julie@example.com";
$stmt->execute();

echo "New records created successfully";

$stmt->close();
$conn->close();
?>
```

###PDO 中的预处理语句
```
<?php
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "myDBPDO";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    // 设置 PDO 错误模式为异常
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // 预处理 SQL 并绑定参数
    $stmt = $conn->prepare("INSERT INTO MyGuests (firstname, lastname, email) 
    VALUES (:firstname, :lastname, :email)");
    $stmt->bindParam(':firstname', $firstname);
    $stmt->bindParam(':lastname', $lastname);
    $stmt->bindParam(':email', $email);

    // 插入行
    $firstname = "John";
    $lastname = "Doe";
    $email = "john@example.com";
    $stmt->execute();

    // 插入其他行
    $firstname = "Mary";
    $lastname = "Moe";
    $email = "mary@example.com";
    $stmt->execute();

    // 插入其他行
    $firstname = "Julie";
    $lastname = "Dooley";
    $email = "julie@example.com";
    $stmt->execute();

    echo "New records created successfully";
    }
catch(PDOException $e)
    {
    echo $sql . "<br>" . $e->getMessage();
    }
$conn = null;
?>
```

##MySQL语句
###增删改查

```
SELECT column_name(s) FROM table_name

INSERT INTO table_name (column1, column2, column3,...)
VALUES (value1, value2, value3,...)

UPDATE table_name
SET column1=value, column2=value2,...
WHERE some_column=some_value

DELETE FROM table_name
WHERE some_column = some_value

```

###创建
```
CREATE TABLE MyGuests (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
firstname VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL,
email VARCHAR(50),
reg_date TIMESTAMP
)

CREATE DATABASE myDB

```


##数据库ODBC
ODBC 是一种应用程序编程接口（Application Programming Interface，API），使我们有能力连接到某个数据源（比如一个 MS Access 数据库）。


#PHP和XML
=======
##XML 是什么？
XML 用于描述数据，其焦点是数据是什么。XML 文件描述了数据的结构。

在 XML 中，没有预定义的标签。您必须定义自己的标签。

##Expat 是什么？
如需读取和更新 - 创建和处理 - 一个 XML 文档，您需要 XML 解析器。

有两种基本的 XML 解析器类型：

* 基于树的解析器：这种解析器把 XML 文档转换为树型结构。它分析整篇文档，并提供了对树中元素的访问，例如文档对象模型 (DOM)。
* 基于时间的解析器：将 XML 文档视为一系列的事件。当某个具体的事件发生时，解析器会调用函数来处理。
Expat 解析器是基于事件的解析器。

基于事件的解析器集中在 XML 文档的内容，而不是它们的结构。正因为如此，基于事件的解析器能够比基于树的解析器更快地访问数据。

##实例
XML文件

```
<?xml version="1.0" encoding="ISO-8859-1"?>
<note>
<to>Tove</to>
<from>Jani</from>
<heading>Reminder</heading>
<body>Don't forget me this weekend!</body>
</note>
```

XML解析器

```
<?php
//Initialize the XML parser
$parser=xml_parser_create();

//Function to use at the start of an element
function start($parser,$element_name,$element_attrs)
{
switch($element_name)
{
case "NOTE":
echo "-- Note --<br>";
break;
case "TO":
echo "To: ";
break;
case "FROM":
echo "From: ";
break;
case "HEADING":
echo "Heading: ";
break;
case "BODY":
echo "Message: ";
}
}

//Function to use at the end of an element
function stop($parser,$element_name)
{
echo "<br>";
}

//Function to use when finding character data
function char($parser,$data)
{
echo $data;
}

//Specify element handler
xml_set_element_handler($parser,"start","stop");

//Specify data handler
xml_set_character_data_handler($parser,"char");

//Open XML file
$fp=fopen("test.xml","r");

//Read data
while ($data=fread($fp,4096))
{
xml_parse($parser,$data,feof($fp)) or 
die (sprintf("XML Error: %s at line %d", 
xml_error_string(xml_get_error_code($parser)),
xml_get_current_line_number($parser)));
}

//Free the XML parser
xml_parser_free($parser);
?>
```

工作原理：

1. 通过 xml_parser_create() 函数初始化 XML 解析器
2. 创建配合不同事件处理程序的的函数
3. 添加 xml_set_element_handler() 函数来定义，当解析器遇到开始和结束标签时执行哪个函数
4. 添加 xml_set_character_data_handler() 函数来定义，当解析器遇到字符数据时执行哪个函数
5. 通过 xml_parse() 函数来解析文件 "test.xml"
6. 万一有错误的话，添加 xml_error_string() 函数把 XML 错误转换为文本说明
7. 调用 xml_parser_free() 函数来释放分配给 xml_parser_create() 函数的内存



##DOM 是什么？
W3C DOM 提供了针对 HTML 和 XML 文档的标准对象集，以及用于访问和操作这些文档的标准接口。

W3C DOM 被分为不同的部分（Core, XML 和 HTML）和不同的级别（DOM Level 1/2/3）：

* Core DOM - 为任何结构化文档定义标准的对象集
* XML DOM - 为 XML 文档定义标准的对象集
* HTML DOM - 为 HTML 文档定义标准的对象集

###实例

```
<?php
$xmlDoc = new DOMDocument();
$xmlDoc->load("note.xml");

$x = $xmlDoc->documentElement;
foreach ($x->childNodes AS $item)
{
print $item->nodeName . " = " . $item->nodeValue . "<br>";
}
?>
```

##什么是 PHP SimpleXML？
SimpleXML 是 PHP 5 中的新特性。

SimpleXML 扩展提供了一种获取 XML 元素的名称和文本的简单方式。

与 DOM 或 Expat 解析器相比，SimpleXML 仅仅用几行代码就可以从 XML 元素中读取文本数据。

SimpleXML 可把 XML 文档（或 XML 字符串）转换为对象，比如：

* 元素被转换为 SimpleXMLElement 对象的单一属性。当同一级别上存在多个元素时，它们会被置于数组中。
* 属性通过使用关联数组进行访问，其中的索引对应属性名称。
* 元素内部的文本被转换为字符串。如果一个元素拥有多个文本节点，则按照它们被找到的顺序进行排列。

当执行类似下列的基础任务时，SimpleXML 使用起来非常快捷：

* 读取/提取 XML 文件/字符串的数据
* 编辑文本节点或属性

然而，在处理高级 XML 时，比如命名空间，最好使用 Expat 解析器或 XML DOM。



#PHP和AJAX
=====
##AJAX 是什么？
AJAX = Asynchronous JavaScript and XML.

AJAX 是一种用于创建快速动态网页的技术。

AJAX 通过在后台与服务器进行少量数据交换，使网页实现异步更新。这意味着可以在不重载整个页面的情况下，对网页的某些部分进行更新。

传统的网页（不使用 AJAX）如果需要更新内容，必须重载整个页面。
`AJAX 是一种在无需重新加载整个网页的情况下，能够更新部分网页的技术。`

##AJAX工作原理
![Alt AJAX工作原理](http://www.w3cschool.cc/wp-content/uploads/2013/08/ajax.gif)

##AJAX 基于因特网标准
AJAX 基于因特网标准，并使用以下技术组合：

* XMLHttpRequest 对象（与服务器异步交互数据）
* JavaScript/DOM（显示/取回信息）
* CSS（设置数据的样式）
* XML（常用作数据传输的格式）


##AJAX和PHP


##AJAX和MySQL



##AJAX和XML



##AJAX实时搜索



##AJAX RSS阅读器


































