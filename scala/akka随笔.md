#akka随笔

## akka的例子

### 安装和配置

[安装](http://doc.akka.io/docs/akka/2.4.1/intro/getting-started.html)

### hello world

[hello world](http://www.typesafe.com/activator/template/hello-akka?_ga=1.177969765.1195530331.1451189579#code/src/main/scala/HelloAkkaScala.scala)


此处有个中文的例子，由于文档比较旧，程序需要适当修改（SBT配置安装最新的官方文档修改，以及import的导入包名做改动）才能跑的通：

<http://www.gtan.com/akka_doc/intro/getting-started-first-scala.html>

##创建Actor

###定义一个 Actor 类

要定义自己的Actor类，需要继承 Actor 并实现receive 方法. receive 方法需要定义一系列 case 语句(类型为 PartialFunction[Any, Unit]) 来描述你的Actor能够处理哪些消息（使用标准的Scala模式匹配），以及实现对消息如何进行处理的代码。

	class MyActor extends Actor {
	  val log = Logging(context.system, this)
	  def receive = {
	    case "test" => log.info("received test")
	    case _      => log.info("received unknown message")
	  }
	}
	
请注意 Akk Actor receive 消息循环是“穷尽的(exhaustive)”, 这与Erlang和Scala的Actor行为不同。 这意味着你需要提供一个对它所能够接受的所有消息的模式匹配规则，如果你希望处理未知的消息，你需要象上例一样提供一个缺省的case分支。否则会有一个 akka.actor.UnhandledMessage(message, sender, recipient) 被发布到 Actor系统（ActorSystem）‘的 事件流（EventStream）中。


###使用缺省构造方法创建 Actor

	object Main extends App {
	  val system = ActorSystem("MySystem")
	  val myActor = system.actorOf(Props[MyActor], name = "myactor")	
	  
对 `actorOf` 的调用返回一个 `实例`。 这是一个 `Actor` 实例的句柄(handle)，你可以用它来与实际的 `Actor`进行交互。 The `ActorRef` 是不可变量，与它所代表的Actor之间是一对一的关系。 The `ActorRef` 还是可序列化的（serializable），并且携带网络信息。这意味着你可以将它序列化以后，通过网络进行传送，在远程主机上它仍然代表原结点上的同一个Actor。

也可以从其它的actor使用actor `上下文（context）` 来创建. 其中的区别在于监管树是如何组织的。使用上下文时当前的actor将成为所创建的子actor的监管者。而使用系统时创建的actor将成为顶级actor，它由系统（内部监管actor）来监管。

	class FirstActor extends Actor {
  		val myActor = context.actorOf(Props[MyActor], name = "myactor")	
  		
name 参数是可选的, 但建议你为你的actor起一个合适的名字，因为它将在日志信息中被用于标识各个actor. 名字不可以为空或以 $开头。如果给定的名字已经被赋给了同一个父actor的其它子actor，将会抛出 InvalidActorNameException 。

Actor 在创建后将自动异步地启动。当你创建 Actor 时它会自动调用 `Actor trait` 的`preStart` 回调方法。这是一个非常好的用来添加actor初始化代码的位置。  

	override def preStart() = {
  		... // 初始化代码
	}		
	
###使用非缺省构造方法创建 Actor
如果你的Actor的构造方法带参数，那么你不能使用 `actorOf(Props[TYPE])` 来创建它。 这时你可以用 `actorOf 的带有传名调用`的块的变体，这样你可以用任意方式来创建actor。

如下例:	

	// 允许传参数给 MyActor 构造方法
	val myActor = system.actorOf(Props(new MyActor("...")), name = "myactor")


###Props
`Props` 是一个用来在创建actor时指定选项的配置类。 以下是使用如何创建 `Props` 实例的示例.

	import akka.actor.Props
	val props1 = Props()
	val props2 = Props[MyActor]
	val props3 = Props(new MyActor)
	val props4 = Props(
	  creator = { () => new MyActor },
	  dispatcher = "my-dispatcher")
	val props5 = props1.withCreator(new MyActor)
	val props6 = props5.withDispatcher("my-dispatcher")

###使用Props创建Actor
Actor可以通过将 Props 实例传入 actorOf 工厂方法来创建。

	import akka.actor.Props
	val myActor = system.actorOf(Props[MyActor].withDispatcher("my-dispatcher"), name = "myactor2")

###使用匿名类创建Actor
在从某个actor中派生新的actor来完成特定的子任务时，可能使用匿名类来包含将要执行的代码会更方便。

> 采用这种方式时，你需要小心地避免捕捉外层actor的引用，i.e. 不要在匿名的Actor类中调用外层actor的方法。这会破坏actor的封装，可能会引入同步bug和资源竞争，因为其它的actor可能会与外层actor同时进行调度。不幸的是目前还没有一种方法能够在编译阶段发现这种非法访问。

	def receive = {
	  case m: DoIt =>
	    context.actorOf(Props(new Actor {
	      def receive = {
	        case DoIt(msg) =>
	          val replyMsg = doSomeDangerousWork(msg)
	          sender ! replyMsg
	          context.stop(self)
	      }
	      def doSomeDangerousWork(msg: ImmutableMessage): String = { "done" }
	    })) forward m
	}
	
	
	
## 总结

1. 创建akka system，由其创建actor
2. 由某个actor的context去创建其子actor
3. 创建actor可指定配置，通过Props完成
4. actor具备receive方法和sender变量
5. 更详细的akka在用到的时候可以去参考akka官方文档
6. 

##参考	  
	
[Akka 2.0 官方文档中文版](http://www.gtan.com/akka_doc/index.html)

[akka官方文档](http://akka.io/docs/?_ga=1.169794657.1958474716.1449820697)	