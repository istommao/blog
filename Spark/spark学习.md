title: spark学习
date: 2016-02-05 10:24:24
tags:
- spark
- scala

---


# Spark学习

## Spark运行过程

Spark从开始到结果的运行过程：

* 创建某种数据类型的RDD
* 对RDD中的数据进行转换操作，例如过滤操作
* 在需要重用的情况下，对转换后或过滤后的RDD进行缓存
* 在RDD上进行action操作，例如提取数据、计数、存储数据到Cassandra等。

RDD的部分转换操作清单：

* filter()
* map()
* sample()
* union()
* groupbykey()
* sortbykey()
* combineByKey()
* subtractByKey()
* mapValues()
* Keys()
* Values()

RDD的部分action操作清单：

* collect()
* count()
* first()
* countbykey()
* saveAsTextFile()
* reduce()
* take(n)
* countBykey()
* collectAsMap()
* lookup(key)

关于RDD所有的操作清单和描述，可以参考 [Spark documentation](http://spark.apache.org/docs/latest/programming-guide.html)


### 初始化sparkcontext

最简单初始化context，只需要指定两个参数：

* cluster的URL：*local*
* application的名字：*My APP*

python:

	from pyspark import SparkConf, SparkContext
	conf = SparkConf().setMaster("local").setAppName("MyApp")
	sc = SparkContext(conf = conf)
	
scala:

	import org.apache.spark.SparkConf
	import org.apache.spark.SparkContext
	import org.apache.spark.SparkContext._
	
	val conf = new SparkConf().setMaster("local").setAppName("My App")
	val sc = new SParkContext(conf)
	
java:

	import org.apache.spark.SparkConf;
	import org.apache.spark.api.java.JavaSparkContext;
	
	SparkConf conf = new SparkConf().setMaster("local").setAppName("My App");
			
	JavaSparkContext sc = new JavaSparkContext(conf);
	
### example：统计单词数

scala:

	val conf = new SparkConf().setAppName("wordCount")
	val sc = new SparkContext(conf)
	
	val input = sc.textFile(inputFile)
	val words = input.flatMap(line => line.split(" "))
	// 转换为pairs并计数
	val counts = words.map(word => (word, 1)).reduceByKey{case (x, y) => x + y}
	counts.saveAsTextFile(outputFile)

进行sbt配置：

	name := ""
	version := "0.0.1"
	scalaVersion := "2.11.4"
	
	// additional libraries
	libraryDependencies ++= Seq("org.apache.spark" %%% "spark-core" % "1.2.0" % "provided")
		
	
java:



## RDDs

RDD(Resilient Distributes Data)
		
	







