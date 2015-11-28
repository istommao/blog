#Spark学习

##Spark运行过程

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






