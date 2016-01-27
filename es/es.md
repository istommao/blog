title: es入门
date: 2016-01-26 23:45:13
tags:
- elasticsearch

---

# es入门

## 简介

Elasticsearch是一个实时分布式搜索和分析引擎。它让你以前所未有的速度处理大数据成为可能。它用于**全文搜索、结构化搜索、分析**以及将这三者混合使用。

Elasticsearch是一个基于*Apache Lucene(TM)*的开源搜索引擎。无论在开源还是专有领域，Lucene可以被认为是迄今为止最先进、性能最好的、功能最全的搜索引擎库。

但是，Lucene只是一个库。想要使用它，你必须使用Java来作为开发语言并将其直接集成到你的应用中，更糟糕的是，Lucene非常复杂，你需要深入了解检索的相关知识来理解它是如何工作的。

Elasticsearch也使用Java开发并使用Lucene作为其核心来实现所有索引和搜索的功能，但是它的目的是通过简单的**RESTful API**来隐藏Lucene的复杂性，从而让全文搜索变得简单。

不过，Elasticsearch不仅仅是Lucene和全文搜索，我们还能这样去描述它：

* 分布式的实时文件存储，每个字段都被索引并可被搜索
* 分布式的实时分析搜索引擎
* 可以扩展到上百台服务器，处理PB级结构化或非结构化数据

而且，所有的这些功能被*集成到一个服务*里面，可以通过简单的**RESTful API**、**各种语言的客户端、命令行**与之交互。

上手Elasticsearch非常容易。它提供了许多合理的缺省值，并对初学者隐藏了复杂的搜索引擎理论。它开箱即用（安装即可使用），只需很少的学习既可在生产环境中使用。

## 安装es

### 安装es

	
### 安装Marvel（非必须）

Marvel是Elasticsearch的管理和监控工具，在开发环境下免费使用。它包含了一个叫做Sense的交互式控制台，使用户方便的通过浏览器直接与Elasticsearch进行交互。

在Elasticsearch目录中运行以下命令来下载和安装：

	./bin/plugin -i elasticsearch/marvel/latest
	
禁用监控

	echo 'marvel.agent.enabled: false' >> ./config/elasticsearch.yml
	
### 运行es

	./bin/elasticsearch
	
后台以守护进程模式运行，添加 **-d** 参数	
	
测试：

	curl 'http://localhost:9200/?pretty'
	
### 集群和节点

**节点(node)**是一个运行着的Elasticsearch实例。

**集群(cluster)**是一组具有相同*cluster.name*的节点集合，他们协同工作，共享数据并提供故障转移和扩展功能。

修改*cluster.name*： **config/**目录下的**elasticsearch.yml**文件，然后重启ELasticsearch。

### 查看Marvel和Sense

	http://localhost:9200/_plugin/marvel/
	http://localhost:9200/_plugin/marvel/sense/
	
	
## API

* Java API

	* 节点客户端(node client)：
	
		以无数据节点(none data node)身份加入集群，换言之，它自己不存储任何数据，但是它知道数据在集群中的具体位置，并且能够直接转发请求到对应的节点上。	
		
	* 传输客户端(Transport client)：

		这个更轻量的传输客户端能够发送请求到远程集群。它自己不加入集群，只是简单转发请求给集群中的节点。

	两个Java客户端都通过9300端口与集群交互，使用Elasticsearch传输协议(Elasticsearch Transport Protocol)。集群中的节点之间也通过9300端口进行通信。如果此端口未开放，你的节点将不能组成集群。	
	
* RESTful API	
	
	其他所有程序语言都可以使用RESTful API，通过9200端口的与Elasticsearch进行通信
	
## 面向文档		
	
Elasticsearch是**面向文档(document oriented)的**，这意味着它可以存储整个对象或文档(document)。然而它不仅仅是存储，还会索引(index)每个文档的内容使之可以被搜索。

ELasticsearch使用Javascript对象符号(JavaScript Object Notation)，也就是**JSON**，作为文档序列化格式。JSON现在已经被大多语言所支持，而且已经成为NoSQL领域的标准格式。它简洁、简单且容易阅读。

## 索引

在Elasticsearch中，文档归属于一种**类型(type)**,而这些类型存在于**索引(index)**中，我们可以画一些简单的对比图来类比传统关系型数据库：

	Relational DB -> Databases -> Tables -> Rows -> Columns
	Elasticsearch -> Indices   -> Types  -> Documents -> Fields
	
Elasticsearch集群可以包含多个**索引(indices)**（数据库），每一个索引可以包含多个**类型(types)**（表），每一个类型包含多个**文档(documents)**（行），然后每个文档包含多个**字段(Fields)**（列）。	

### exmaple

为了创建员工目录，我们将进行如下操作：

* 为每个员工的文档(document)建立索引，每个文档包含了相应员工的所有信息。
* 每个文档的类型为employee。
* employee类型归属于索引megacorp。
* megacorp索引存储在Elasticsearch集群中。

		PUT /megacorp/employee/1
		{
		    "first_name" : "John",
		    "last_name" :  "Smith",
		    "age" :        25,
		    "about" :      "I love to go rock climbing",
		    "interests": [ "sports", "music" ]
		}
		
	路径包含：
	* megacorp：索引名	
	* employee：类型名
	* 1：这个员工的ID
	
## 搜索

能够检索单个员工的信息：

	GET /megacorp/employee/1
	
响应的内容中包含一些文档的元信息：

	{
	  "_index" :   "megacorp",
	  "_type" :    "employee",
	  "_id" :      "1",
	  "_version" : 1,
	  "found" :    true,
	  "_source" :  {
	      "first_name" :  "John",
	      "last_name" :   "Smith",
	      "age" :         25,
	      "about" :       "I love to go rock climbing",
	      "interests":  [ "sports", "music" ]
	  }
	}

> 我们通过HTTP方法GET来检索文档，同样的，我们可以使用DELETE方法删除文档，使用HEAD方法检查某文档是否存在。如果想更新已存在的文档，我们只需再PUT一次			
### 简单搜索

搜索全部员工的请求, 使用关键字**_search**来取代原来的文档ID:

	GET /megacorp/employee/_search
	

#### 查询字符串(query string)搜索

在请求中依旧使用**_search**关键字，然后将查询语句传递给参数**q=** : 
	
	GET /megacorp/employee/_search?q=last_name:Smith
	
	
### DSL语句查询

DSL(Domain Specific Language特定领域语言)以JSON请求体的形式出现。

e.g: 请求体使用JSON表示，其中使用了**match语句**:

	GET /megacorp/employee/_search
	{
	    "query" : {
	        "match" : {
	            "last_name" : "Smith"
	        }
	    }
	}	
	
### 更复杂的搜索

添加**过滤器(filter)**

	GET /megacorp/employee/_search
	{
	    "query" : {
	        "filtered" : {
	            "filter" : {
	                "range" : {
	                    "age" : { "gt" : 30 } <1>
	                }
	            },
	            "query" : {
	                "match" : {
	                    "last_name" : "smith" <2>
	                }
	            }
	        }
	    }
	}

* <1> 这部分查询属于区间过滤器(range filter),它用于查找所有年龄大于30岁的数据——gt为"greater than"的缩写。
* <2> 这部分查询与之前的match语句(query)一致。		
### 全文搜索

搜索所有喜欢“rock climbing”的员工：

	GET /megacorp/employee/_search
	{
	    "query" : {
	        "match" : {
	            "about" : "rock climbing"
	        }
	    }
	}

about字段中搜索"rock climbing"，我们得到了两个匹配文档：

	{
	   ...
	   "hits": {
	      "total":      2,
	      "max_score":  0.16273327,
	      "hits": [
	         {
	            ...
	            "_score":         0.16273327, <1>
	            "_source": {
	               "first_name":  "John",
	               "last_name":   "Smith",
	               "age":         25,
	               "about":       "I love to go rock climbing",
	               "interests": [ "sports", "music" ]
	            }
	         },
	         {
	            ...
	            "_score":         0.016878016, <2>
	            "_source": {
	               "first_name":  "Jane",
	               "last_name":   "Smith",
	               "age":         32,
	               "about":       "I like to collect rock albums",
	               "interests": [ "music" ]
	            }
	         }
	      ]
	   }
	}	
	
默认情况下，Elasticsearch根据结果相关性评分来对结果集进行排序，所谓的**「结果相关性评分」**就是文档与查询条件的匹配程度。	

### 短语搜索phrases

将**match**查询变更为**match_phrase**查询即可：

	GET /megacorp/employee/_search
	{
	    "query" : {
	        "match_phrase" : {
	            "about" : "rock climbing"
	        }
	    }
	}
	
### 高亮我们的搜索

高亮(highlight)

## 聚合

**聚合(aggregations)**，它允许你在数据上生成复杂的分析统计。它很像SQL中的`GROUP BY`但是功能更强大。

## 分布式特性
	
Elasticsearch致力于隐藏分布式系统的复杂性。以下这些操作都是在底层自动完成的：

* 将你的文档分区到不同的容器或者分片(shards)中，它们可以存在于一个或多个节点中。
* 将分片均匀的分配到各个节点，对索引和搜索做负载均衡。
* 冗余每一个分片，防止硬件故障造成的数据丢失。
* 将集群中任意一个节点上的请求路由到相应数据所在的节点。
* 无论是增加节点，还是移除节点，分片都可以做到无缝的扩展和迁移。	

	

## 参考
* [es权威指南中文翻译](http://es.xiaoleilu.com/)

