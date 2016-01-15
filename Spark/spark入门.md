# spark入门

## spark部署

### 源码编译

SBT编译

	SPARk_HADOOP_VERSION=2.2.0 SPARK_YARN=true sbt/sbt compile assembly
	
Maven编译

	export MAVEN_OPTS=
	
spark部署包生成命令`make-distribution.sh`(调用了Maven)

	参数：
	--hadoop VERSION
	--with-yarn
	--with-hiv	e
	--skip-java-test
	--with-tachyon
	--tgz
	--name NAME
	
	e.g
		./make-distribution.sh --hadoop 2.2.0 --with-yarn --tgz
	
	根目录生成spark-x.x.x-bin-x.x.x-tgz
	assembly/target/scala-x.x.x/spark-assembly.xxx.jar
	
### 集群部署

* java安装
* ssh无密码登录
* spark安装包解压

		tar zxf spark-x.x.x-bin-x.x.x-tgz
		mv spark-x.x.x-bin-x.x.x sparkxxx
		
* spark配置文件
		
		cd sparkxxx
		cd conf
		vim slaves 把集群的hostname添加进去
		cp spark-env.sh-template spark-env.sh
			export SPARK_MASTER_IP=hadoop1
			export SPARK_MASTER_PORT=7077
			export SPARK_WORKER_CORES=1
			export SPARK_WORKER_INSTANCES=1
			export SPARK_WORKER_MEMORY=3g
		
* 把sparkxxx目录拷贝到集群其他机器相应目录

* 浏览器访问hadoop1:8080	

* 拷贝sparkxxx到客户端机器，使用	shell应用程序

		cd sparkxxx
		bin/spark-shell --master spark://hadoop1:7077
		
### standalone HA部署

#### 基于文件系统的HA
	
spark-env.sh增加

	export SPARK_DAEMON_JAVA_OPTS="-Dspark.deploy......=FILESYSTEM ......"
	
拷贝到各个节点

启动、停止

	sbin/start-all.sh			
	sbin/stop-all.sh
	
#### 基于zookeeper的HA

spark-env.sh增加

	export SPARK_DAEMON_JAVA_OPTS="......"
	内容包括：
		spark.deploy.recoverryMode=ZOOKEEPER
		spark.deploy.zookeeper.url=xxx
		spark.deploy.zookeeper.dir=xxx

同时删除master的配置参数，因为是从zookeeper中获取master参数

	export SPARK_MASTER_IP=hadoop1
	export SPARK_MASTER_PORT=7077
		
### 伪分布式部署

* java安装
* 自己对自己的ssh无密码
* 配置

		cd spark/conf
		vim slaves
		vim spakr-env.sh
* 启动spark

		sbin/start-all.sh
		
## spark使用工具

交互工具：spark-shell
应用部署工具：spark-submit

## spark快不仅使基于内存计算，还和其原理相关

* DAG
* Schedule
* Cache()		

## spark编程模型

spark应用程序组成：`Driver`和`Executor`

* application：基于spark的应用程序
* Driver program：运行application的main函数并创建sparkcontext
* Executor：application运行在worker node上的一个进程，该进程负责运行task，并负责将数据存在内存或磁盘
* Cluster manager：在集群上获取资源的外部服务，如standalone、mesos、yarn
* worker node：集群中任何可以运行application的节点
* task：被送到某个Executor的工作单元
* job：包含多个task组成的并行计算，往往有spark action催生
* stage：每个job会被拆分多组task，每组任务被称为stage或TaskSet
* RDD：spark基本计算单元，可以通过一系列算子进行操作，主要由transformation和action操作

### driver program
* 导入spark类和隐式转换
* 构建spark应用程序运行环境SparkConf
* 初始化SparkContext
* 关闭SparkContext

Spark-shell在启动的时候会自动构建SparkContext，名称为sc

#### 输入

* 并行化Scala结合

		Spark使用parallelize方法转换为RDD
		val rdd1 = sc.Parallelize(Array(1, 2, 3, 4, 5))
		val rdd2 = sc.Parallelize(List(0 to 10), 5)
		参数slice是对数据集切片，每一个slice启动一个task进行处理
		
* Hadoop数据集

Spark可以将任何Hadoop支持的存储资源转换为RDD，如本地文件、hdfs、cassandra、hbase、Amazon s3

		使用textFile()方法可以将本地文件或HDFS文件
		使用wholeTextFiles()读取目录里面小文件，返回（文件名，内容）对
		使用sequenceFile[K,V]()方法可将SequenceFile转换为RDD
		使用hadoopRDD()方法可以将任何Hadoop输入类型转换为RDD
		
#### transfomation

* 在一个已有的RDD上创建一个新的RDD
* 延迟执行
		
	算子：
	* map(func)
	* filter(func)
	* flatMap(func)	
	* sample(withReplacement, fraction, seed)
	* union(otherDataset)
	* distinct([numTask])
	* groupByKey([numTasks])
	* reduceByKey(func, [numTasks])
	* sortByKey([ascending], [numTasks])
	* join(otherDataset, [numTasks])
	* cogroup(otherDataset, [numTasks])
	* cartesian(otherDataset)
	
#### action特点

* 对RDD数据集进行运算后，将结果传给驱动程序或写入存储系统，触发job
	
算子：
	
* reduce(func)
* collect()
* count()
* first()
* take(n)
* takeSample(withReplacement, fraction, seed)
* saveAsTextFile(path)
* saveAsSequenceFile(path)
* countByKey()
* foreach(func)	

#### 缓存

缓存特点

* 使用gpersist和cache将rdd缓存到内存中
* 缓存是容错的，可通过transformation自动筹够
* 被换成的rdd被使用时，存取速度加速10x

缓存等级
	
> storagelevel -- DISK_ONLY、MEMORY_ONLY、MEMORY_AND_DISK、OFF_HEAP......

cache：是persist的特例

Executor中60%做cache，40%做task

#### 广播变量和累加器

广播变量

* 广播变量缓存到各个节点的内存中
* 广播变量能在集群中任何函数调用
* 广播变量只读
* 使用方法

		val broadcastVar = sc.broadcast(Array(1, 2, 3))
		broadcastVal.value
		
累加器

* 累加器只支持加法操作
* 累加器可以高效并行，实现计算器和变量求和
* spark原生支持数值类型和标准可变集合计数器，但用户可添加新的类型
* 只有驱动程序才能获取累加器的值
* 使用方法

		val accum = sc.accumulator(0)
		sc.parralelize(Array(1, 2, 3, 4)).foreach(x => accum += x)
		accum.value	
	
## RDD


## spark-shell调试程序

示例：

	//parallelize演示
	val num=sc.parallelize(1 to 10)
	val doublenum = num.map(_*2)
	val threenum = doublenum.filter(_ % 3 == 0)
	threenum.collect
	threenum.toDebugString
	
	val num1=sc.parallelize(1 to 10,6)
	val doublenum1 = num1.map(_*2)
	val threenum1 = doublenum1.filter(_ % 3 == 0)
	threenum1.collect
	threenum1.toDebugString
	
	threenum.cache()
	val fournum = threenum.map(x=>x*x)
	fournum.collect
	fournum.toDebugString
	threenum.unpersist()
	
	num.reduce (_ + _)
	num.take(5)
	num.first
	num.count
	num.take(5).foreach(println)
	
	//K-V演示
	val kv1=sc.parallelize(List(("A",1),("B",2),("C",3),("A",4),("B",5)))
	kv1.sortByKey().collect //注意sortByKey的小括号不能省
	kv1.groupByKey().collect
	kv1.reduceByKey(_+_).collect
	
	val kv2=sc.parallelize(List(("A",4),("A",4),("C",3),("A",4),("B",5)))
	kv2.distinct.collect
	kv1.union(kv2).collect
	
	val kv3=sc.parallelize(List(("A",10),("B",20),("D",30)))
	kv1.join(kv3).collect
	kv1.cogroup(kv3).collect
	
	val kv4=sc.parallelize(List(List(1,2),List(3,4)))
	kv4.flatMap(x=>x.map(_+1)).collect
	
	//文件读取演示
	val rdd1 = sc.textFile("hdfs://hadoop1:8000/dataguru/week2/directory/")
	rdd1.toDebugString
	val words=rdd1.flatMap(_.split(" "))
	val wordscount=words.map(x=>(x,1)).reduceByKey(_+_)
	wordscount.collect
	wordscount.toDebugString
	
	val rdd2 = sc.textFile("hdfs://hadoop1:8000/dataguru/week2/directory/*.txt")
	rdd2.flatMap(_.split(" ")).map(x=>(x,1)).reduceByKey(_+_).collect
	
	//gzip压缩的文件
	val rdd3 = sc.textFile("hdfs://hadoop1:8000/dataguru/week2/test.txt.gz")
	rdd3.flatMap(_.split(" ")).map(x=>(x,1)).reduceByKey(_+_).collect
	
	//日志处理演示
	//http://download.labs.sogou.com/dl/q.html 完整版(2GB)：gz格式
	//访问时间\t用户ID\t[查询词]\t该URL在返回结果中的排名\t用户点击的顺序号\t用户点击的URL
	//SogouQ1.txt、SogouQ2.txt、SogouQ3.txt分别是用head -n 或者tail -n 从SogouQ数据日志文件中截取
	
	//搜索结果排名第1，但是点击次序排在第2的数据有多少?
	val rdd1 = sc.textFile("hdfs://hadoop1:8000/dataguru/data/SogouQ1.txt")
	val rdd2=rdd1.map(_.split("\t")).filter(_.length==6)
	rdd2.count()
	val rdd3=rdd2.filter(_(3).toInt==1).filter(_(4).toInt==2)
	rdd3.count()
	rdd3.toDebugString
	
	//session查询次数排行榜
	val rdd4=rdd2.map(x=>(x(1),1)).reduceByKey(_+_).map(x=>(x._2,x._1)).sortByKey(false).map(x=>(x._2,x._1))
	rdd4.toDebugString
	rdd4.saveAsTextFile("hdfs://hadoop1:8000/dataguru/week2/output1")
	
	
	//cache()演示
	//检查block命令：bin/hdfs fsck /dataguru/data/SogouQ3.txt -files -blocks -locations
	val rdd5 = sc.textFile("hdfs://hadoop1:8000/dataguru/data/SogouQ3.txt")
	rdd5.cache()
	rdd5.count()
	rdd5.count()  //比较时间
	
	
	//join演示
	val format = new java.text.SimpleDateFormat("yyyy-MM-dd")
	case class Register (d: java.util.Date, uuid: String, cust_id: String, lat: Float,lng: Float)
	case class Click (d: java.util.Date, uuid: String, landing_page: Int)
	val reg = sc.textFile("hdfs://hadoop1:8000/dataguru/week2/join/reg.tsv").map(_.split("\t")).map(r => (r(1), Register(format.parse(r(0)), r(1), r(2), r(3).toFloat, r(4).toFloat)))
	val clk = sc.textFile("hdfs://hadoop1:8000/dataguru/week2/join/clk.tsv").map(_.split("\t")).map(c => (c(1), Click(format.parse(c(0)), c(1), c(2).trim.toInt)))
	reg.join(clk).take(2)
	
## 在IDEA中的调试

	
	
	
	
	
	
	


		
	



	
	
	
	