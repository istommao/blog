#scala基础

##类

	class Point(xc: Int, yc: Int) {
	  var x: Int = xc
	  var y: Int = yc
	  def move(dx: Int, dy: Int) {
	    x = x + dx
	    y = y + dy
	  }
	  override def toString(): String = "(" + x + ", " + y + ")";
	}
	
	
* 可以知道变量的定义，函数定义，函数参数，函数返回值等
* xc和yc称为构造器参数，在整个类中都可见

##traits

类似java中的接口，但是scala运行traits被partially implemented。

traits不同于类，它没有构造器参数。

	trait Similarity {
	  def isSimilar(x: Any): Boolean
	  def isNotSimilar(x: Any): Boolean = !isSimilar(x)
	}
	
* isSimilar没有具体的实现，类似java中的抽象方法。而
* 而isNotSimilar是有具体实现的，因此classes集成该traits只需要提供isSimilar的具体实现即可。
	
Traits are typically integrated into a class (or other traits) with a mixin class composition。

	class Point(xc: Int, yc: Int) extends Similarity {
	  var x: Int = xc
	  var y: Int = yc
	  def isSimilar(obj: Any) =
	    obj.isInstanceOf[Point] &&
	    obj.asInstanceOf[Point].x == x
	}
	object TraitsTest extends App {
	  val p1 = new Point(2, 3)
	  val p2 = new Point(2, 4)
	  val p3 = new Point(3, 3)
	  println(p1.isNotSimilar(p2))
	  println(p1.isNotSimilar(p3))
	  println(p1.isNotSimilar(2))
	}		
	
extends关键字
	
##Mixin Class Compositon	

为了更好的复用，Mixin Class可以将多个不同的lei或traits的不同特定结合在一起。通过关键字`with`

	abstract class AbsIterator {
	  type T
	  def hasNext: Boolean
	  def next: T
	}
	
	trait RichIterator extends AbsIterator {
	  def foreach(f: T => Unit) { while (hasNext) f(next) }
	}	
	
	class StringIterator(s: String) extends AbsIterator {
	  type T = Char
	  private var i = 0
	  def hasNext = i < s.length()
	  def next = { val ch = s charAt i; i += 1; ch }
	}
	
	
	object StringIteratorTest {
	  def main(args: Array[String]) {
	    class Iter extends StringIterator(args(0)) with RichIterator
	    val iter = new Iter
	    iter foreach println
	  }
	}

Iter类就是从StringIterator and RichIterator 构建出来的。定义个类称为*superclass*, 剩下的称之为*mixin*。


##匿名函数语法

	匿名函数定义
		(x: Int) => x + 1
		(x: Int, y: Int) => "(" + x + ", " + y + ")"
		() => { System.getProperty("user.dir") }
	
	匿名类定义
	
		new Function1[Int, Int] {
		  def apply(x: Int): Int = x + 1
		}
		
	函数类型
	
		Int => Int
		(Int, Int) => String
		() => String	
	等效于下面的类型定义
		Function1[Int, Int]
		Function2[Int, Int, String]
		Function0[String]	
		
		
##高阶函数

	class Decorator(left: String, right: String) {
	  def layout[A](x: A) = left + x.toString() + right
	}
	object FunTest extends App {
	  def apply(f: Int => String, v: Int) = f(v)
	  val decorator = new Decorator("[", "]")
	  println(apply(decorator.layout, 7))
	}		
	
	结果： [7]
	
##嵌套函数

	object FilterTest extends App {
	  def filter(xs: List[Int], threshold: Int) = {
	    def process(ys: List[Int]): List[Int] =
	      if (ys.isEmpty) ys
	      else if (ys.head < threshold) ys.head :: process(ys.tail)
	      else process(ys.tail)
	    process(xs)
	  }
	  println(filter(List(1, 9, 2, 8, 3, 7, 4), 5))
	}
	
	结果：List(1,2,3,4)
	
可以发现列表带有操作head和tail。


##Currying

方法定义为多个参数，调用的时候传的参数少于定义的参数。
	
	object CurryTest extends App {
	  def filter(xs: List[Int], p: Int => Boolean): List[Int] =
	    if (xs.isEmpty) xs
	    else if (p(xs.head)) xs.head :: filter(xs.tail, p)
	    else filter(xs.tail, p)
	  def modN(n: Int)(x: Int) = ((x % n) == 0)
	  val nums = List(1, 2, 3, 4, 5, 6, 7, 8)
	  println(filter(nums, modN(2)))
	  println(filter(nums, modN(3)))
	}

	结果：
	
		List(2,4,6,8)
		List(3,6)

modN(n)生成一个函数类型：*Int => Boolean*

##Case Classes

将构造参数导出的类，并可以通过模式匹配进行分解。

 a class hierarchy which consists of an abstract super class Term and three concrete case classes Var, Fun, and App.
 
	abstract class Term
	case class Var(name: String) extends Term
	case class Fun(arg: String, body: Term) extends Term
	case class App(f: Term, v: Term) extends Term
	
为了方便使用，对于实例化case classes，scala支持省略new关键字：

	Fun("x", Fun("y", App(Var("x"), Var("y"))))	
构造参数访问属性为*public*

	val x = Var("x")
	println(x.name)	
	
对于case class，scala编译器会生成*equals*方法和*toString*方法	

	val x1 = Var("x")
	val x2 = Var("x")
	val y1 = Var("y")
	println("" + x1 + " == " + x2 + " => " + (x1 == x2))
	println("" + x1 + " == " + y1 + " => " + (x1 == y1))

	结果：
	Var(x) == Var(x) => true
	Var(x) == Var(y) => false
	
*使用pattern matching去解析数据结构的时候，使用case class才真正有意义*

	object TermTest extends scala.App {
	  def printTerm(term: Term) {
	    term match {
	      case Var(n) =>
	        print(n)
	      case Fun(x, b) =>
	        print("^" + x + ".")
	        printTerm(b)
	      case App(f, v) =>
	        print("(")
	        printTerm(f)
	        print(" ")
	        printTerm(v)
	        print(")")
	    }
	  }
	  def isIdentityFun(term: Term): Boolean = term match {
	    case Fun(x, Var(y)) if x == y => true
	    case _ => false
	  }
	  val id = Fun("x", Var("x"))
	  val t = Fun("x", Fun("y", App(Var("x"), Var("y"))))
	  printTerm(t)
	  println
	  println(isIdentityFun(id))
	  println(isIdentityFun(t))
	}	
	
关键字*match 和case Pattern => Body*表明进行pattern match。

##Pattern Matching

	object MatchTest1 extends App {
	  def matchTest(x: Int): String = x match {
	    case 1 => "one"
	    case 2 => "two"
	    case _ => "many"
	  }
	  println(matchTest(3))
	}	
 
The *match* keyword provides a convenient way of applying a function (like the pattern matching function above) to an object.

##singleton objects

使用`object`关键字而不是`class`关键字，表明是一个单例。

###伴生对象

	class IntPair(val x: Int, val y: Int)
	object IntPair {
	  import math.Ordering
	  implicit def ipord: Ordering[IntPair] =
	    Ordering.by(ip => (ip.x, ip.y))
	}

单例对象IntPair是类IntPair的伴生对象。

**scala没有static关键字，所有类中的static对象都应该写到单例对象里**

	class X {
	  import X._
	  def blah = foo
	}
	object X {
	  private def foo = 42
	}

类和其伴生类是友元的关系：类X可以访问其伴生对象的私有函数foo。若果要使某个成员真正成为私有，应该定义为：`private[this]`

单例对象里的每个vars、vals或方法在伴生类中都有一个静态方法（static forwarder）。

##处理XML

##正则表达式模式

##Extractor对象

##Sequence Comprehensive

*yield*


	object ComprehensionTest1 extends App {
	  def even(from: Int, to: Int): List[Int] =
	    for (i <- List.range(from, to) if i % 2 == 0) yield i
	  Console.println(even(0, 20))
	}
	
	结果：
		List(0, 2, 4, 6, 8, 10, 12, 14, 16, 18)


##泛型类

	class Stack[T] {
	  var elems: List[T] = Nil
	  def push(x: T) { elems = x :: elems }
	  def top: T = elems.head
	  def pop() { elems = elems.tail }
	}
	
	object GenericsTest extends App {
	  val stack = new Stack[Int]
	  stack.push(1)
	  stack.push('a')
	  println(stack.top)
	  stack.pop()
	  println(stack.top)
	}	
	
##Variances

**+**

**-**

	class Stack[+A] {
	  def push[B >: A](elem: B): Stack[B] = new Stack[B] {
	    override def top: B = elem
	    override def pop: Stack[B] = Stack.this
	    override def toString() = elem.toString() + " " +
	                              Stack.this.toString()
	  }
	  def top: A = sys.error("no element on stack")
	  def pop: Stack[A] = sys.error("no element on stack")
	  override def toString() = ""
	}
	object VariancesTest extends App {
	  var s: Stack[Any] = new Stack().push("hello");
	  s = s.push(new Object())
	  s = s.push(7)
	  println(s)
	}	
	
##Upper/Lower Type Bounds 

###uppper

**T <: A**	: type variable T refers to a subtype of type A. 

	trait Similar {
	  def isSimilar(x: Any): Boolean
	}
	case class MyInt(x: Int) extends Similar {
	  def isSimilar(m: Any): Boolean =
	    m.isInstanceOf[MyInt] &&
	    m.asInstanceOf[MyInt].x == x
	}
	object UpperBoundTest extends App {
	  def findSimilar[T <: Similar](e: T, xs: List[T]): Boolean =
	    if (xs.isEmpty) false
	    else if (e.isSimilar(xs.head)) true
	    else findSimilar[T](e, xs.tail)
	  val list: List[MyInt] = List(MyInt(1), MyInt(2), MyInt(3))
	  println(findSimilar[MyInt](MyInt(4), list))
	  println(findSimilar[MyInt](MyInt(2), list))
	}

如果没有Upper type bound语法，findSimilar是不能调用isSimilar方法的。

###lower

**T <: A**	: the type parameter T or the abstract type T refer to a supertype of type A

	case class ListNode[+T](h: T, t: ListNode[T]) {
	  def head: T = h
	  def tail: ListNode[T] = t
	  def prepend[U >: T](elem: U): ListNode[U] =
	    ListNode(elem, this)
	}	
	
##Inner Classes

##Abstract Types


##Compound Types

	A with B with C ... { refinement }	
	