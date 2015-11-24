#javascript

js是基于对象和事件驱动的脚本，应用在客户端。

特点：

* 交互性
* 安全性
* 跨平台

##java和js的不同

* js基于对象，java是面向对象
* js只需解释就可以执行，java需要先编译
* js是弱类型，java是强类型

##js和html结合

1. js代码存放在标签对<script>...</script>

		<script type="text/javascript">...
		</script>

2. js文件, 导入js文件

		<script type="text/javascript" src="x.js">
		</script> 
		
		
##语法
高级程序语言通常具备

* 关键字
* 标示符
* 注释
* 变量
* 运算法
* 语句
* 函数
* 数组
* 对象

###变量

	<script>
		var x = 3; 数字,字符串, 小数, boolean
		
	</script>

###运算法

1. 算术: +, -, *, /, %, ++, --
2. 赋值: =, +=, -=, /=, %=
3. 比较: >, <, >=, <=, /=, ==
4. 逻辑: &&, !, ||
5. 位: &, |, ^, >>, <<, >>>
6. 三元: ? :

###小细节
1. undefined: 未定义, 其实它就是一个常量
2. 具体值类型: typeof, string, number, bool, object


###语句
1. 顺序结构
2. 判断结构：if-else if-else
3. 选择结构：switch-case-break-default
4. 循环结构：while，do-while，for
5. 其他语句：break，continue

###数组
特点：

1. 长度可变
2. 元素类型任意
3. 

数组定义

1. var arr = []; var arr1 = [1, 2, 3]
2. 使用js中的Array对象: 

		var arr = new Array()
		var arr = new Array(5) // 长度
		var arr = new Array(5, 6, 7) //元素5，6，7

###函数

定义：

	function 函数名(参数列表){
		函数体;
		return 返回值; (可省略)
	}		
	
细节：

1. 只要使用函数名称就是这个函数
2. 函数中有一个数组对传入的参数进行存储：arguments
3. 调用函数和赋值函数对象： a = sum(); b = sum;

动态函数：使用js的内置对象function

	var add = new Funtion("...");
	var sum = add(2, 3);
	
匿名函数

	var add = function(a, b){
		return a+b;
	}
	
	
###全局变量和局部变量

* 在脚本标签定义的变量为全局变量
* 在函数内部定义的局部变量

###object对象

* toString
* valueOf

###string对象

* length属性
* constuct属性
* prototype属性
* bold方法
* fontcolor方法
* link方法
* substr、substring
* 自定义函数

####prototype属性
原型：就是该对象的一种描述。该描述如果添加了新功能，那么该对象都会具有这些新功能。而prototype旧可以获取到这个原型对象，通过prototype就可以对对象jinx扩展。

###array对象

###Date对象

###with语句

	with(对象)
	{
		直接使用对象的内容，不需要指定对象
	}
	
	
###math对象

对象中的方法都是静态的，不需要new。

###global方法

* parseInt

###number对象

代表数值数据类型和提供数值常数的对象。

###forin语句

	for(变量 in 对象)
	{
	
	}

###自定义对象

首先对对象进行描述，但是js基于对象，不具备面向对象的描述事物的能力。在js可以用函数来进行对象的描述。

	1. 描述对象
		(1).
		function Person(){ // 相当于构造器
			
		}
		
		(2). new
		var p = new Person()
		(3). 动态给对象添加属性和方法
		p.name = "abc";
		p.age = 22;
		p.show = function() {
			...
		}
	
	2.
		function Person(name, age){ // 相当于构造器
			this.name = name;
			this.age = age;
			this.setName = function(name){
				this.name = name;
			}
		}
	
	3. 使用{}和键值对，键与键之间用逗号隔开
	
		var p = {
			"name": "xiao", 
			"age": "11",
			name2: "xiao2",
			names: ["li", "wang"],
			names2: [{li:"li1"}, {wang: "wang1"}],
			"getName": function {
				return this.name;
			}
		}
		
		对象调用成员: 对象.属性名，对象["属性名"]
	
		
		
	





			





		