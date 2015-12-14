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




	