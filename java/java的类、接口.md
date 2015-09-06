#类、继承、接口
---

##Object类

Object类主要包括clone()、finalize()、equals()、toString()类。

###不可重写的类

* getClass()

	返回对象执行时的Class实例，实例调用getName可以获得类的名字：getClass().getName()
	
	
* notify()

* notifyAll()
* wait()

###其他方法

* toString()

	将对象返回为字符串的形式，返回一个String实例。当类转换为字符串或与字符串连接时，会自动调用toString()方法。
	
* equals()	

	==比较的是两个对象的引用是否相等，而equals方法比较两个对象的实际内容。
	
	
##instanceof操作符

执行向下转型操作时，如果父类对象不是子类对象的实例，就会发生ClassCastException异常，所以在向下转型前使用instanceof。

instanceof可以用来判断是否一个类实现了某个接口，也可以用来判断一个实例对象是否属于一个类。

##方法重载

方法名相同，参数个数或类型不同。注意：返回值不同并不能成为重载。

###不定长参数

	返回值 方法名(参数数据类型...参数名)
	
##多态

将子类对象视为父类的做法称为“向上转型”。

	
##抽象类和接口

	public abstract class Test {
		abstract void testAbstract();
	}
	
只要类中定义有一个抽象方法，此类就被标记为抽象类。

##接口

java中规定，类不能同时继承多个父类，其使用接口解决这一问题。

* 接口中所有方法都没有方法体。
* 接口中定义的方法必须定义为public或abstract。
* 接口中定义的任何字段都自动是static和final的。

		public interface Test{
			void test();
		}	
	
Java中不运行多重继承，但一个类可以实现多个接口，因此可以通过接口实现多重继承。	


