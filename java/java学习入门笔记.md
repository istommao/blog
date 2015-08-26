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
	
二维数组创建

1. 先声明在创建

	声明：
	
	数组元素类型 数组名[][]
	
	数组元素类型[][] 数组名
	
	创建
	
	数组名 = new 元素类型[][]
	
	e.g 
		
		a = new int[2][4];
		也可以：
		a = new int[2][];
		a[0] = new int[3];
		a[1]  = new int[2];
	
2. 声明的同时分配内存

	初始化

		type arrayname[][] = {value1, ..., valueN};

数组基本操作

* 遍历：for和foreach
* 填充

		fill(int[] a, int value)
		fill(int[] a, int fromIndex, int toIndex, int value)
	
* 排序

		Arrays.sort(object)
		
* 复制

		copyOf(arr, int newLength)
		copyOfRange(arr, fromIndex, toIndex)
		
* 查询

		binarySearch(Object[] a, Object key) // 数组要已序
		binarySearch(a, fromIndex, toIndex, key)
		
		
##类

###成员变量



###成员方法			
	
###构造方法

* 和类同名
* 对象的创建通过构造方法完成
* 没有返回值
* 如果类中没有明确定义构造方法，编译器会自动创建一个不带参数的默认构造方法

###静态变量、常量、方法

声明为static的变量、常量和方法称为静态成员。静态成员属于类所有，区别于个别对象，可在本类或其他类中使用`类名.静态成员`调用。当然也可以通过`对象	.静态成员`调用，但是不建议这么作。

* 静态方法不可调用非静态的东西，因为其没有this

###类的主方法

主方法是类的入口，定义了程序从何处开始，java编译器通过主方法来执行程序。

	public static void main(String[] args)
	
* 主方法是静态的
* 主方法没有返回值
* 主方法形参为数组

###对象和引用


###对象销毁

垃圾回收器：主要回收由new操作符创建的对象。不是有new创建的，可以在类中定义finalize()方法，该方法在Object类中，声明为protected。如果在类中定义了该方法，在垃圾回收时，会先去调用该方法。

主要回收：

* 对象引用超过其作用范围
* 将对象赋值给null

	
	



		
		
	


		
	


		
	
	
		
	













































