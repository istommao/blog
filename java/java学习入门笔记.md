#JAVA学习入门笔记

#JAVA基础语法

##java数据类型

byte, short, int, long, float, double

###数据类型转换
隐式类型转换

显示类型转换
	
	(类型名)要转换的值


##java运算符

##java变量和常量

###标识符和关键字

###常量

	final 数据类型 常量名称[=值]
	
###变量

* 成员变量

	在类体中所定义的变量称为成员变量，成员变量在整个类中都有效。
	
	类的成员变量有分为静态变量和实例变量。
	
* 局部变量

	位于方法内部定义，在`{}`之间的	声明的变量。
	
	
##流程控制

if, if-else, if-elif-else, while, do-while, for都和C、C++一样。

有foreach语句，是for的简化版，不能完全替代for语句，但所有foreach都可以转化为for循环。

	for (元素变量x: 遍历对象 obj) {
		引用了x的java语句;
	}	
	
##字符串	

###字符串创建

	String s1, s2;
	s1 = "abc";
	String s = new String("abc");

###字符串常用函数

	str.length();
	str.indexOf(substr);
	str.lastIndexOf(substr);
	str.charAt(int index);
	substring(int beginIndex);
	str.trim();
	str.replace(char oldChar, char newChar);
	str.startsWith(String prefix);
	str.endsWith(String suffix);
	str.equals(String otherstr);
	str.equalsIgnoreCase(String otherstr);
	str.compareTo(String otherstr);
	str.toLowerCase();
	str.toUpperCase();
	str.split(String sign);
	str.split(String sign, int limit);
	str.format(String format, Object ... args);
	str.format(Local l, String format, Object ...args);

###日期和时间

###正则表达式

###字符串生成器StringBuilder

创建成功的字符串对象, 其长度是固定的, 内容不能被改变和编译。虽然使用“+”可以实现附加新字符或字符串的目的，但“+”会产生新的String实例，会在内存中创建新的字符串对象。这就是StringBuilder类用来解决的问题，提高频繁操作字符串的效率。

* append(content)
* insert(int offset, arg)
* delete(int start, int end)


##数组

声明数组：

	数组元素类型 数组名 = new 数组元素类型[数组元素个数]

初始化一维数组

	int arr[]	= new int[]{1, 2, 3};
	int arr2[] = {1, 2, 3};
	
	
	


		
	
	
		
	













































