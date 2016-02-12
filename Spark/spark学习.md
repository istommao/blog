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

RDD(Resilient Distributes Data).

* Spark RDD存储不可变的分布式objects的集合。每个RDD都被分片。
* RDDs可以存储Python，Java，Sacla的任意类型的objects

#### 小结

每个Spark程序工作流程：

* 从外部数据创建RDDs
* 使用*transformations*将其转为新的预定义的RDDs
* persist()需要重用的RDDs
* 启动*actions*进行并行计算


### RDDs的创建

* 从外部数据集中导入

		val lines = sc.textFile("README.md")

* 使用list或者set等分布式对象集合操作进行创建

		val lines = sc.parallelize(List("pandas", "i like pandas"))


### RDD的operations

RDD创建后提供两个操作：

* **transformations**：根据当前的RDD构建一个新的RDD的操作，如*map(), filter()*
* **actions**：返回driver program的结果或者将其写到存储的操作, 如*count(), first()*

> spark计算RDD的方式为：**lazy fashion**

#### transformations

spark记录不同RDDs之间的依赖关系，称为**lineage graph**

![RDD lineage graph of log analysis]()


##### RDD.persist()
RDD.persist(): 如果需要多次进行Action，可以将RDD进行persist到不同地方


#### actions

### spark中的传递函数	
	
python

* lambda: 简单函数


scala

#### 基本的transformations和actions

##### transformations:

* filter()
* map()
* flatMap()
* sample()
* distinct()

集合操作

* union(other)
* intersetion(other)
* subtract(other)
* cartesian(other)

##### actions

* reduce(func): 返回值和操作数一致
* fold(zero)(func): 返回值和操作数一致
* 	aggregate(zeroValue)(seqOp, combOp): 提供初始的返回值和一个函数
* 	foreach(func)
* 	collect()
* 	count()
* 	countByValue()
* 	take(num)
* 	top(num)
* 	takeOrdered(num)(ordering)
* 	takeSample(withReplacement, num, [seed])


## KV pairs

### 创建Pair RDDS

### transformations on Pair RDDs

one pair RDD({(1,2),(3,4),(3,6)})

* reduceByKey(func)
* groupByKey()
* combineByKey(createCombiner, mergeValue, mergeCombiners, partitioner)
* mapValues(func)
* flatMapValues(func)
* keys()
* values()
* sorteByKey()


two pair RDDs(rdd = {(1,2),(3,4),(	3,6)} other = {(3,9)})

* subtractByKey(other)
* join(other)
* rightOuterJoin(other)
* leftOuterJoin(other)
* cogroup(other)

### actions on pair RDDs

one pair RDD({(1,2),(3,4),(3,6)})

* countByKey()
* collectAsMap()
* lookup(key)
* 

two pair RDDs(rdd = {(1,2),(3,4),(	3,6)} other = {(3,9)})


### paritioners


## loading and saving your data

### 文件

支持的文件格式

* text files
* json
* csv
* sequence files
* protocol buffers
* object files

text files：

	// 读取
	val input = sc.textFile(path)
	// 保存
	result.saveAsTextFile(outputFile)

json:

	// 保存
	result.filter(p => P.lovesPandas).map(mapper.writeValueAsString(_)).saveAsTextFile(outputFile)
	

csv:

	// 读取with textFile
	val input = 	sc.textFile(path)
	val result = input.map{ line => 
		val reader = new CSVReader(new StringReader(line));
		reader.readNext();
	}
	
	// 读取with full in
	
	val input = 	sc.wholeTextFile(path)
	val result = input.flatMap{ case(_ txt) =>
		val reader = new CSVReader(new StringReader(line));
		reader.readAll().map(x => Person(x(0), x(1)))
	}
	
	
	// 保存
	
	pandaLovers.map(person => List(person.name, person.favoriteAnimal).toArray)
	.mapPartitions{people => 
	val stringWriter = new StringWriter();
	val csvWriter new CSVWriter(stringWriter);
	csvWriter.writeAll(people.toList)
	Iterator(stringWriter.toString)
	}.saveAsTextFile(outFile)


sequenceFiles:


	// loading
	val data = sc.sequenceFile(inFile, classOf[Text], classOf[IntWritable]).
	map{case (x, y) => (x.toString, y.get())}
	
	// saving
	val data = sc.parallelize(List(("Panda", 3), ("Kay", 6), ("Snail", 2)))
	data.saveAsSequenceFile(outputFile)
	
hadoop input and output formats

	// loading
	val input = sc.hadoopFile[Text, Text, KeyValueTextInputFormat](inputFile).map{
		case(x, y) => (x.toString, y.toString)
	}
	
	// saving
	

file compression


filesystems


spark sql操作结构化数据

* apache hive
* json
* databases：cassandra、hbase、es


## 进阶

共享变量

* accumulators
* broadcast variables


### accumulators

	val sc = new SparkContext()
	val file = sc.textFile("file.txt")
	val blankLines = sc.accumulator(0) // 创建Accumulator[Int] initialized to 0
	
	val callSigns = file.flatMap(line => {
		if (line == "") {
			blankLines += 1
		}
		line.split(" ")
	})
	
	callSigns.saveAsTextFile("output.txt")
	println("Blank lines")



### broadcast


*e.g.*
	
	// Look up the countries for each call sign for the
	// contactCounts RDD.  We load an array of call sign
	// prefixes to country code to support this lookup.
	val signPrefixes = sc.broadcast(loadCallSignTable())
	val countryContactCounts = contactCounts.map{case (sign, count) =>
	  val country = lookupInArray(sign, signPrefixes.value)
	  (country, count)
	}.reduceByKey((x, y) => x + y)
	countryContactCounts.saveAsTextFile(outputDir + "/countries.txt")	
	

### piping to external programs

	

### numeric RDD operations

统计方法

* count()
* mean()
* sum()
* max()
* min()
* variance()
* sampleVariance()
* stdev()
* sampleStdev()


## spark集群

* spark-submit
* spark-submit加载driver并调用main()函数
* driver从cluster manager中获取资源并加载executors
* 


![spark-cluster-concept]()

### driver

运行main方法，处理用户的代码：创建sc，RDDs和执行transformations和actions。

### executors

运行独立的spark job。

### cluster manager


### 使用spark-submit部署


	bin/spark-submit [options] <app jar | python file> [app options]

### 打包依赖

### spark应用程序之间的调度

通过cluster manager进行资源共享。

#### cluster managers

* standalone
* hadoop yarn
* apache mesos
* amazon ec2


## spark调优和调试

### sparkconf

SparkConf包含key/value的配置，使用set()进行设置。

### execution的组成：jobs/tasks/stages

## spark sql

### 在Applications使用Spark SQl

构建HiveContext

	// Import Spark SQL
	import org.apache.spark.sql.hive.HiveContext
	// Or if you can't have the hive dependencies
	import org.apache.spark.sql.SQLContext
	
	val sc = new SparkContext(...)
	val hiveCtx = new HiveContext(sc)
	
	
### 查询例子

	val input = hiveCtx.jsonFile(inputFile)
	input.registerTempTable("tweets")
	
	val topTweets = hiveCtx.sql("SELECT text, retweetCount FROM tweets ORDER BY retweetCount LIMIT 10")
	
### SchemaRDDs

SchemaRDDs类似于关系型数据库中的表。

#### Row objects

**Row objects**表示SchemaRDDs中的记录。在scala中，**Row objects**通过*get*方法可以通过列号获得对应的object类型的值。例如getString(0)以string类型返回field 0的值：

	val topTweetText = topTweets.map(row => row.getString(0))
	
### caching		
	
	
#### apache hive

	import org.apache.spark.sql.hive.HiveContext
	
	val hiveCtx = new HiveContext(sc)
	val rows = hiveCtx.sql("SELECT key, value FROM mytable")
	val keys = rows.map(row => row.getInt(0))
	
#### parquet



#### json

	{"name": "Holden"}
	{"name":"Sparky The Bear", "lovesPandas":true, "knows":{"friends": ["holden"]}}		

	val input = hiveCtx.jsonFile(inputFile)



#### from RDDs

### User-Defined Functions(UDFs)

#### Spark SQL UDFs

#### Hive UDFs

## spark steaming

DStreams(Discretized steams)

### transformations

#### 无状态

	* map()
	* flatMap()
	* filter()
	* repartition()
	* reduceByKey()
	* groupByKey()
	
*e.g.*: map() and reduceByKey()		
		
	// Assumes ApacheAccessLog is a utility class for parsing entries from Apache logs
	val accessLogDStream = logData.map(line => ApacheAccessLog.parseFromLogLine(line))
	val ipDStream = accessLogsDStream.map(entry => (entry.getIpAddress(), 1))
	val ipCountsDStream = ipDStream.reduceByKey((x, y) => x + y)

##### join-related transformations

* cogroup()
* join()
* leftOuterJoin()	
	
*e.g.*: join two DStreams	
	
	val ipBytesDStream =
	  accessLogsDStream.map(entry => (entry.getIpAddress(), entry.getContentSize()))
	val ipBytesSumDStream =
	  ipBytesDStream.reduceByKey((x, y) => x + y)
	val ipBytesRequestCountDStream =
	  ipCountsDStream.join(ipBytesSumDStream)

##### transform()

DStream提供高级操作：transform()直接操作RDDs。

	val outlierDStream = accessLogsDStream.transform { rdd =>
	  extractOutliers(rdd)
	}
	
#### 有状态	

##### Windowed transformations

* count()
* reduceByWindow()
* reduceByKeyAndWindow()
* countByWindow()
* countByValueAndWindow()

*e.g.* count data over a window

	val accessLogsWindow = accessLogsDStream.window(Seconds(30), Seconds(10))
	val windowCounts = accessLogsWindow.count()	
##### UpdateStateByKey

	def updateRunningSum(values: Seq[Long], state: Option[Long]) = {
	  Some(state.getOrElse(0L) + values.size)
	}
	
	val responseCodeDStream = accessLogsDStream.map(log => (log.getResponseCode(), 1L))
	val responseCodeCountDStream = responseCodeDStream.updateStateByKey(updateRunningSum _)

### Output Operations

### Input Sources

* SteamingContext
* steam of files
* akka actor steam
* apache kafka
* apache flume


### 24/7 operation
* checkpointing
* driver fault tolerance


## MLlib

### 数据类型

* Vector
* LabeledPoint
* Rating


### vectors

创建vector

	import org.apache.spark.mllib.linalg.Vectors
	
	// Create the dense vector <1.0, 2.0, 3.0>; Vectors.dense takes values or an array
	
	val denseVec1 = Vectors.dense(1.0, 2.0, 3.0)
	val denseVec2 = Vectors.dense(Array(1.0, 2.0, 3.0))
	
	// Create the sparse vector <1.0, 0.0, 2.0, 0.0>; Vectors.sparse takes the size of
	// the vector (here 4) and the positions and values of nonzero entries
	val sparseVec1 = Vectors.sparse(4, Array(0, 2), Array(1.0, 2.0))


### 算法

#### feature extraction

#### TF-IDF

Term Frequency-Inverse Document Frequency

#### scaling

#### Normalization

#### Word2Vec

#### statistics

#### Classification and Regression

##### Linear regression

##### Logistic regression

##### Support Vector Machines

##### Naive Bayes

#### Clustering

##### K-means

 







