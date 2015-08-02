#RabbitMQ学习
====

主要通过学习[CSDN博客](http://blog.csdn.net/column/details/rabbitmq.html)，他以MQ的python的pika库进行分析。本文就是将阅读过程中一些重要的点摘录，以便后续使用。

##基础知识

该文写的很清楚：
<http://blog.csdn.net/anzhsoft/article/details/19563091>

此处作为简要笔记进行摘录：

![MQ-ARCH](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/erlang-mq-arch.jpg)

* RabbitMQ Server： 也叫broker server，而是一种传输服务。而是一种传输服务。

* Client A & B： 也叫Producer，数据的发送方。一个Message有两个部分：payload（有效载荷）和label（标签）。payload顾名思义就是传输的数据。label是exchange的名字或者说是一个tag，它描述了payload，而且RabbitMQ也是通过这个label来决定把这个Message发给哪个Consumer。AMQP仅仅描述了label，而RabbitMQ决定了如何使用这个label的规则。

* Client 1，2，3：也叫Consumer，数据的接收方。当有Message到达某个邮箱后，RabbitMQ把它发送给它的某个订阅者即Consumer。当然可能会把同一个Message发送给很多的Consumer。在这个Message中，只有payload，label已经被删掉了。对于Consumer来说，它是不知道谁发送的这个信息的。就是协议本身不支持。但是当然了如果Producer发送的payload包含了Producer的信息就另当别论了。

* Exchanges are where producers publish their messages. Producer发送的Message实际上是发到了Exchange中。它的功能也很简单：从Producer接收Message，然后投递到queue中。Exchange需要知道如何处理Message，是把它放到那个queue中，还是放到多个queue中？这个rule是通过Exchange 的类型定义的。

* Queuesare where the messages end up and are received by consumers

* Bindings are how the messages get routed from the exchange to particular queues.


* Connection： 就是一个TCP的连接。Producer和Consumer都是通过TCP连接到RabbitMQ Server的。以后我们可以看到，程序的起始处就是建立这个TCP连接。

* Channels： 虚拟连接。它建立在上述的TCP连接中。数据流动都是在Channel中进行的。也就是说，一般情况是程序起始建立TCP连接，第二步就是建立这个Channel。

###细节Q&A
> * 那么，为什么使用Channel，而不是直接使用TCP连接？
> 
对于OS来说，建立和关闭TCP连接是有代价的，频繁的建立关闭TCP连接对于系统的性能有很大的影响，而且TCP的连接数也有限制，这也限制了系统处理高并发的能力。但是，在TCP连接中建立Channel是没有上述代价的。

> * 使用ack确认Message的正确传递。 

> 默认情况下，如果Message 已经被某个Consumer正确的接收到了，那么该Message就会被从queue中移除。当然也可以让同一个Message发送到很多的Consumer。

> * 创建Queue。 
> 
> Consumer和Procuder都可以通过 queue.declare 创建queue。如果queue不存在，当然Consumer不会得到任何的Message。但是如果queue不存在，那么Producer Publish的Message会被丢弃。所以，还是为了数据不丢失，Consumer和Producer都try to create the queue！queue对load balance的处理是完美的。对于多个Consumer来说，RabbitMQ 使用循环的方式（round-robin）的方式均衡的发送给不同的Consumer。

> * Exchanges。 
> 
> 有三种类型的Exchanges：direct, fanout,topic。 每个实现了不同的路由算法（routing algorithm）。
> 
> Direct exchange: 如果 routing key 匹配, 那么Message就会被传递到相应的queue中。其实在queue创建时，它会自动的以queue的名字作为routing key来绑定那个exchange。
> 
> Fanout exchange: 会向响应的queue广播。
> 
> Topic exchange: 对key进行模式匹配，比如ab\*可以传递到所有ab\*的queue。


> * Virtual hosts
> 
每个virtual host本质上都是一个RabbitMQ Server，拥有它自己的queue，exchagne，和bings rule等等。这保证了你可以在多个不同的application中使用RabbitMQ。


##例子

###生产者
1. 建立连接
2. 创建channel：

		channel = connection.channel()
3. 声明queue：

		channel.queue_declare(queue='hello') 
		
	可以在参数中制定名字，没有指定的话，系统自动生成。（命令查看队列rabbitmqctl list_queues）
	
	该函数还可制定持久化参数：durable=True。设置持久化以后，即使Consumer异常退出，Message也不会丢失。但是如果RabbitMQ，要想不丢失数据，就需要持久化queue和Message。Message的持久化在basic_publish中设置参数（见第4）
	
		
	
	
4. 发送数据：
		
		channel.basic_publish(exchange='',  
                      		 routing_key='hello',  
                      		 body='Hello World!')  
    
    从架构图可以看出，Producer只能发送到exchange，它是不能直接发送到queue的。现在我们使用默认的exchange（名字是空字符）。这个默认的exchange允许我们发送给指定的queue。routing_key就是指定的queue名字。可以通过设置exchanges，这样就不需要设置routing_key为制定的queue名字。  
    
    如果要设置message的持久化，在basic_publish函数设置properties参数：
    	
    	properties=pika.BasicProperties(delivery_mode = 2, 
											# make message persistent
											)               	
                      		 
 
5. 退出前别忘了关闭connection：connection.close()                       		 
                      		 
###消费者

1. 还是创建connection
2. 还是创建channel
3. 声明queue
4. 订阅subscribe

	声明一个回调函数来处理接收到的数据：
		
		def callback(ch, method, properties, body):  
    		print " [x] Received %r" % (body,)  
    		
  	订阅：
  
  		channel.basic_consume(callback,  
                      			queue='hello',  
                      			no_ack=True)  
                      			
  	默认no_ack是关闭的，只有consumer发送了ack，RabbitMQ才会认为该消息成功投递。
                      			
5. 无限循环监听

		channel.start_consuming()  
 
##publisher-subscribe模式

> 将同一个Message deliver到多个Consumer中。这个模式也被成为 "publish / subscribe"。                     


要使用该模式需要：

1. 设置exchanges模式为fanout。
			
			channel.exchange_declare(exchange='logs',  
                         type='fanout') 

	可以通过exchange，而不是routing_key来publish Message了。basic_publish是就不需要设置routing_key了
	
			channel.basic_publish(exchange='logs',  
                      routing_key='',  
                      body=message)
                      
2. 使用temporary queues。

	即在decalre_queue时，不设置名字参数，由RabbitMQ为我们设置queue的名字。并通过返回值去获取queue的名字。设置exclusive为true，可以在Cosumer关闭连接时，将这个queue删除掉。

		result = channel.queue_declare(exclusive=True)    
                    
3. 在Consumer进行binding绑定

	已经创建了fanout类型的exchange和没有名字的queue（实际上是RabbitMQ帮我们取了名字）。那exchange怎么样知道它的Message发送到哪个queue呢？答案就是通过bindings：绑定。queue_bind函数将exchange和queue绑定在一起，当Publish发送消息给exchange，消息通过该binding就可以到达制定的queue了。
	
		channel.queue_bind(exchange='logs',  
                   queue=result.method.queue) 


##Routing消息路由

绑定其实就是关联了exchange和queue。或者这么说：queue对exchagne的内容感兴趣，exchange要把它的Message deliver到queue中。前面，在Consumer中进行binding的时候：

	channel.queue_bind(exchange='logs',  
                   queue=queue_name)

实际上，绑定可以带routing_key(这里的routing_key并不是basic_publish中的routing_key)这个参数。其实这个参数的名称和basic_publish的参数名是相同了。为了避免混淆，我们把它成为binding key。对于fanout的exchange来说，这个参数是被忽略的。

	channel.queue_bind(exchange=exchange_name,  
                   queue=queue_name,  
                   routing_key='black') 

p.s routing_key是有限制的，稍后会讲到。

###对于Direct exchange

Direct exchange的路由算法非常简单：通过routing key的完全匹配。

Multiple bindings（多绑定）:只要设置多个queue绑定同一个key是可以的。


###对于Topic exchange

对于Message的routing_key是有限制的，不能使任意的。格式是以点号“."分割的字符表。你可以放任意的key在routing_key中，当然最长不能超过255 bytes。

对于routing_key，有两个特殊字符（在正则表达式里叫元字符）：

* \* (星号) 代表任意 一个单词
* \# (hash) 0个或者多个单词

####Topic exchange和其他exchange

> 由于有"*" (star) and "#" (hash)， Topic exchange 非常强大并且可以转化为其他的exchange：

> 如果binding_key 是 "#" - 它会接收所有的Message，不管routing_key是什么，就像是fanout exchange。

> 如果 "*" (star) and "#" (hash) 没有被使用，那么topic exchange就变成了direct exchange。


*Producer发送消息时需要设置routing_key，该routing_key在basic_publish
中指定消息带有的routing_key格式，之后在exchange发该消息给queue的时候，就可以通过该routing_key去匹配在queue中设置的routing_key，如果符合规则，该queue就可以接收到该消息了。*

	channel.basic_publish(exchange='topic_logs',  
                      routing_key=routing_key,  
                      body=message)  

*在Consumer中可以也需要设置相应queue的routing_key格式*

	channel.queue_bind(exchange='topic_logs',  
                       queue=queue_name,  
                       routing_key=binding_key)  

**需要注意的是，如果不是faout模式，消息只会被一个consumer接受。**










