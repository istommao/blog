# scala入门

## 表达式和值

scala中几乎所有东西都是表达式：

	println("hello world")
	"hello" + " world"
	
常量和变量定义分别使用关键字:`val`和`var`
	
	var helloWorld = "hello" + " world"	val again = " again"
	helloWorld = helloWorld + again	
## 函数

使用`def`创建，函数体是表达式，并且使用`=`相连，总是返回最后一行的表达式的值，所以不需要返回值。

	def square(a: Int) = a*a
	def squareWithBlock(a: Int) = {
		a * a
	}	
	
函数可作为参数，所以可将其赋值给`var`或`val`, 匿名函数使用 `=>`而不是使用`=`

	val squareVal = (a: Int) => a * a
	def addOne(f: Int => Int, arg: Int) = f(arg) + 1	
## Call by name

在参数的类型声明时将`:` 变为 `: =>`

Call-by-name means that the argument will be calculated when it is actually called.

Call-by-name can reduce the useless calculation and exception.

	def log(msg: String)
	
	call-by-name: def log(msg: => String)
	
## 定义类

关键字`class`定义类，`new`关键字创建类的实例。

	class Person(val firstName: String, val lastName: String) {
	
	    private var _age = 0
	    def age = _age
	    def age_=(newAge: Int) = _age = newAge
	
	    def fullName() = firstName + " " + lastName
	
	    override def toString() = fullName()
	}
	
	val obama: Person = new Person("Barack", "Obama")
	
	println("Person: " + obama)
	println("firstName: " + obama.firstName)
	println("lastName: " + obama.lastName)
	obama.age_=(51)
	println("age: " + obama.age)
	obama.age=51
	println("age: " + obama.age)
	
* firstName和lastName构造参数	
* 使用obama.age=51看起来像访问一个变量。

## currying

普通函数

	def add(x:Int, y:Int) = x + y

currying

	def add(x:Int) = (y:Int) => x + y
	
	返回值为函数表达式	
	
	syntactic sugar	：
		def add(x:Int)(y:Int) = x + y
	
## generic


## traits

traits就好像java中的interfaces，但其支持函数块。一个class可以扩展多个traits，通过关键字`with`

## pattern matching

和erlang中的模式匹配类似。

	def fibonacci(in: Any): Int = in match {
	    case 0 => 0
	    case 1 => 1
	    case n: Int if(n > 1) => fibonacci(n - 1) + fibonacci(n - 2)
	    case n: String => fibonacci(n.toInt)
	    case _ => 0
	}
	
	println(fibonacci(3))
	println(fibonacci(-3))
	println(fibonacci("3"))

## case class

Case classes are used to conveniently store and match on the contents of a class。

创建实例的时候，可以省略new。

	abstract class Expr
	
	case class FibonacciExpr(n: Int) extends Expr {
	  require(n >= 0)
	}
	
	case class SumExpr(a: Expr, b: Expr) extends Expr
	
	def value(in: Expr): Int = in match {
	  case FibonacciExpr(0) => 0
	  case FibonacciExpr(1) => 1
	  case FibonacciExpr(n) => 
	    value(SumExpr(FibonacciExpr(n - 1), FibonacciExpr(n - 2)))
	  case SumExpr(a, b) => value(a) + value(b)
	  case _ => 0
	}
	println(value(FibonacciExpr(3)))


## 函数作为参数

	list.exists((x: Int) => x % 2 ==1)
	list.exists(_ % 2 == 1)

## word count

Word Count is a classic use case for Map Reduce. Map Reduce with functional programming is an intuitive solution to the Word Count problem.

The example shows two important functions 'map' and 'reduceLeft' in List。

	val file = List("warn 2013 msg", "warn 2012 msg",
	  "error 2013 msg", "warn 2013 msg")
	
	def wordcount(str: String): Int = str.split(" ").count("msg" == _)
	  
	val num = file.map(wordcount).reduceLeft(_ + _)
	
	println("wordcount:" + num)
	
## 尾递归

列表匹配可以使用双冒号`::`，和erlang中的列表操作类似。比如

	head :: tail
	val file = List("warn 2013 msg", "warn 2012 msg", "error 2013 msg", "warn 2013 msg")
	
	def wordcount(str: String): Int = str.split(" ").count("msg" == _)
	
	def foldLeft(list: List[Int])(init: Int)(f: (Int, Int) => Int): Int = {
	  list match {
	    case List() => init
	    case head :: tail => foldLeft(tail)(f(init, head))(f)
	  }
	}
	
	val num = foldLeft(file.map(wordcount))(0)(_ + _)
	
	println("wordcount:" + num)
	
	
## yield

for-loop结合yield，yield产生的结果被追加到一个列表里，作为结果返回。

	val file = List("warn 2013 msg", "warn 2012 msg",
	  "error 2013 msg", "warn 2013 msg")
	
	def wordcount(str: String): Int = str.split(" ").count("msg" == _)
	
	val counts =
	  for (line <- file)
	    yield wordcount(line)
	
	val num = counts.reduceLeft(_ + _)
	
	println("wordcount:" + num)	
	
	
## option

与swift中的option类似。

Using pattern matching is a common way to get the value of Option. Use getOrElse() to set a default value when Option is None.

Another important thing is that Option contains lots of functions in List, so it can be used like a list most of time.


	def getProperty(name: String): Option[String] = {
	  val value = System.getProperty(name)
	  if (value != null) Some(value) else None
	}
	
	val osName = getProperty("os.name")
	
	osName match {
	  case Some(value) => println(value)
	  case _ => println("none")
	}
	
	println(osName.getOrElse("none"))
	
	osName.foreach(print _)	
	
## lazy initialization

关键字`lazy`,常常用在那些需要花费很多资源的变量。

	lazy val source = {...}
	
## using actor

actors是scala的并发模型。scala现在使用akka作为actor。

An Actor is a like a thread instance with a mailbox. It can be created with `system.actorOf`: use `receive` to get a message, and `!` to send a message.

* system.actorOf
* receive
* !

其实非常类似erlang语言中的进程和并发原语。

	import akka.actor.{ Actor, ActorSystem, Props }
	
	val system = ActorSystem()
	
	class EchoServer extends Actor {
	  def receive = {
	    case msg: String => println("echo " + msg)
	  }
	}
	
	val echoServer = system.actorOf(Props[EchoServer])
	echoServer ! "hi"
	
	system.shutdown
	
### simple actor

在akka.actor.ActorDSL中有actor函数接受一个actor作为参数，并返回一个启动的actor。

	import akka.actor.ActorDSL._
	import akka.actor.ActorSystem
	
	implicit val system = ActorSystem()
	
	val echoServer = actor(new Act {
	  become {
	    case msg => println("echo " + msg)
	  }
	})
	echoServer ! "hi"
	system.shutdown
	
### actor实现

actor比线程轻量的多，这是因为Actor can reuse a thread.

两者之间的映射关系取决于Dispatcher。一个actor可能使用多个thread，一个thread可能被多个actor使用。

### synchronized return

`sender !`

### asynchonous return 

A Future in Scala is very powerful, it can execute asynchronously.

The Future will call the 'onComplete' function when it is finished.

It can also set a TIMEOUT when specified.


	import akka.actor.ActorDSL._
	import akka.pattern.ask
	
	implicit val ec = scala.concurrent.ExecutionContext.Implicits.global
	implicit val system = akka.actor.ActorSystem()
	
	val versionUrl = "https://raw.github.com/scala/scala/master/starr.number"
	
	val fromURL = actor(new Act {
	  become {
	    case url: String => sender ! scala.io.Source.fromURL(url)
	      .getLines().mkString("\n")
	  }
	})
	
	val version = fromURL.ask(versionUrl)(akka.util.Timeout(5 * 1000))
	version onComplete {
	  case msg => println(msg); system.shutdown
	}
	
### remote actor

	import akka.actor.{ Actor, ActorSystem, Props }
	import com.typesafe.config.ConfigFactory
	
	implicit val system = akka.actor.ActorSystem("RemoteSystem",
	  ConfigFactory.load.getConfig("remote"))
	class EchoServer extends Actor {
	  def receive = {
	    case msg: String => println("echo " + msg)
	  }
	}
	
	val server = system.actorOf(Props[EchoServer], name = "echoServer")
	
	val echoClient = system
	  .actorFor("akka://RemoteSystem@127.0.0.1:2552/user/echoServer")
	echoClient ! "Hi Remote"
	
	system.shutdown	
	
	
	
	
## Parallel Collection

It's exciting to combine functional and concurrent programming!

例子： `.map` to `.par.map`

	val file = List("warn 2013 msg", "warn 2012 msg",
	  "error 2013 msg", "warn 2013 msg")
	
	def wordcount(str: String): Int = str.split(" ").count("msg" == _)
	
	val num = file.par.map(wordcount).par.reduceLeft(_ + _)
	
	println("wordcount:" + num)	



## 实践

### scala和java

### extractor	

## scala学习（IBM）


函数语言中的公共主题：创建一个只做一件事情的高级抽象函数，让它接受一个代码块（匿名函数）作为参数，并从这个高级函数中调用这个代码块。




	

	
	
	