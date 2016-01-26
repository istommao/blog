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
	
## 文档		
				


## 参考
* [es权威指南中文翻译](http://es.xiaoleilu.com/)

