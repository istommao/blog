#java核心技术卷一 之一
=================
##1.学习一种语言
###1.数据类型
###2.语法格式
###3.控制流程
###4.运算符
###5.库函数使用


##1.java数据类型
  1.整形
  
    int、short、long、byte
  
  2.浮点型
  
    float、double
  
  3.char类型
  
    表示单个字符
    unicode表示\u0000~\uffff
    代码点表示
   
  4.boolean类型
   
    false和true
     
##2.变量

##3.常量
  final定义常量。常量习惯上用大写。
  
  类常量static final


##4.运算符


  1.算法运算符+ - * / %  
  
  2.自增、自减
  
  3.关系运算符
  
  4.位运算符
  
    java中移位左运算符有>>和>>>两种，前者用符号位填充高位，后者用0填充。
    
  5.数学函数Math与常量
  
  6.类型转换
  
  7.括号和运算符级别
  
  8.枚举类型
  
##5.字符串

  java字符串就是Unicode字符序列。
  
  1.子串substring
  
  2.拼接+
  
  3.不可变字符串
  
    String类没有提供修改字符串的方法，要修改通过substring和+实现。与C++中字符数组修改的方法不同。
  4.检测字符串相等
    
    equals、equalsIgnoreCase。
    ==检测两个字符串是否放在同一个位置。
    
  5.代码点和代码单元
  
  6.字符串API
    
  7.构建字符串
  
    需要将较短的字符串构建字符串的时候，采用字符串连接的方式效率较低，耗费时间空间。使用StringBuilder类可以避免这个问题。
    
  
##6.输入输出

  1.读取输入
    
    import java.util.*;
    首先构造scanner对象:
    Scanner in = new Scanner(System.in);
    接着调用:
    in.nextLine()、in.next()、in.nextInt()...
    p.s：读取密码使用Console类


 2.格式化输出
 
 
 3.文件输入输出
 
    读取文件：使用File对象构造Scanner对象。
    Scanner in = new Scanner(new File("abc.txt"));
    写入文件：构造一个PrintWriter对象。
    PrintWriter out = new PrintWriter("mywife.txt");
    
    
##7.控制流程

###1.块作用域
  块即符合语句是指由一对花括号括起来的若干简单java语句。块确定了变量的作用域。一个块可以嵌套在另一个块中。注意不能在嵌套的两个块中声明同名的变量。
 
###2.条件语句
    if (condition) statement
    if (condition) statement1 else statement2
    if ... else if ... else
    
###3.循环
    while(condition) statement
    do statement while (condition);
    
###4.确定循环
    for(init; conditon; update)
    
###5.多重选择
    switch(choice):
    {
    	case C1:
    	    ...
    	    break;
    	...
    	case CN:
    	    ...
    	    break;
    	default:
    	    ...
    	    break;
    }    
    
###6.带标签的break    
    
  
##8.大数值

  java.math中的BigInteger、BigDecimal
  
  
##9.数组

  int[] a;
  
###1.foreach
    for (variable : collection) statement
    
    
###2.数组初始化和匿名数组

    int[] a = {2, 3, 4};  这时不需要new
    new int[] {2, 3, 4};  匿名数组
    使用匿名数组可以在不创建新变量的情况下重新初始化数组:
    a = new int[]{1, 2, 3};	
###3.数组拷贝
    赋值和copyOf函数


###4.数组排序
    
    Arrays.sort(a);
    
###5.多维数组



###6.不规则数组


##10.对象与类 



###1.构造器
  * 构造器与类同名
  * 每个类可以有1个以上构造器
  * 构造器可以有0、1或1个以上的参数
  * 构造器没有返回值
  * 构造器总是伴随着new操作一起调用
  
  
###2.final实例域
  final修饰符大都应用于基本数据类型或不可变类的域（类中每个方法都不会改变其对象，这种类就是不可变的类）。
  
###3.静态域和静态方法

  将域定义为static，则每个类中只有一个这样的域。
  
####3.1静态常量
    public static final double PI = 3.14159...
  
####3.2静态方法
  可以认为静态方法是没有隐形参数（this）的方法。因此静态方法不能操作对象，不能在静态方法中访问实例域。
  
####3.3Factory方法


####3.4方法参数
  call by value和call by reference：java中使用值传递。
  
  方法参数共有两种类型：
  
    * 基本数据类型
    * 对象引用    
  
  java程序中，方法参数的使用情况：
  
  * 一个方法不能修改一个基本的数据类型的参数；
  * 一个方法可以改变一个对象参数的状态；
  * 一个方法不能实现让对象参数引用一个新的对象。
  
  
  
###4.对象构造

####4.1重载
  签名：函数名和参数，不包括返回值。
  

####4.2默认域初始化
  如果没有在构造器中显示的给域赋予初值，就会自动被赋予默认值。这不是一个好的编程方法。
  
####4.3默认构造函数

  默认构造函数就是：没有参数的构造器。如果在编写一个类的时候没有编写构造器，系统就会提供一个默认构造器。这个默认构造器就会将所有的实例域设为默认值。
  
  如果显示指定了构造器，那么系统就不会提供默认构造器。
  
####4.4显示域初始化


####4.5参数名


####4.6调用另一个构造器
  如果构造器第一个句子形如this(...),这个构造器将调用同一个类的另一个构造器。  
  这在C++中是不可以的。
  
  
####4.7初始化块
  初始化数据域的方法：        
  
  * 在构造器中设置
  * 在声明中赋值；
  * 初始化块
  
  调用构造器的具体处理步骤：
    
    1.
  
         
    
    
      
  
  
  
    


























     
    
    