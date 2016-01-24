#mongoDB速览

## 命令速览

创建数据库，使用指定的库

	use [databaseName]
	
查看所有数据库

	show dbs
	
给指定数据库（执行了use dbname）添加集合collName并添加记录

	db.[collName].insert({bson的kv})
	
查看数据库中所有文档

	show collections	
	
查询指定文档的数据

	查询所有 db.[collName].find()
	查询第一条数据 db.[collName].findOne()
	

更新文档数据

	db.[collName].update({查询条件}, {更新内容})
	e.g.
		var p = db.persons.findOne()
		db.persons.update(p, {name: "bbc"})
		db.persons.update(p, {$set:{name: "bbc"}})
	
删除文档中的数据

	db.[collName].remove({...})
	
删除数据库中的集合

	db.[collName].drop()
	
删除数据库

	db.dropDatabase()
	
shell的help

	db.help()
	db.[collName].help()
	
mongodb的api

	api.mongodb.org
	
数据库和集合命名规范

mongodb的shell内置js引擎，可直接执行js代码，可以使用eval

bson是json的扩展，新增了诸如日期，浮点等json不支持的数据类型

##详解

* 增：insert/save
* 删：
* 改：
* 查： find
* 其他：find到的结果结合sort, limit, skip

### 插入

语法：

	db.[collName].insert({})
	
* 第一个参数指定插入的doc, 类型为bson	
	
批量插入

	shell不支持批量插入，需要使用循环
	想完成批量插入可以用mongo的应用驱动或是shell的for循环
	
save操作	

	save操作和insert操作区别在于遇到_id相同的情况下，save完成保存操作，而insert会报错
	

	db.[docName].remove()
	集合本身和索引不会删除
	
根据条件删除

	db.[docName].remove({})

小技巧：如果想清楚一个数据量非常大的集合，直接删除该集合并且重建索引的方法比直接用remove的效率要高很多

### 查找find

语法

	db.[collName].find()
	
参数：

	第一个参数指定：查询条件	
		db.media.find({Artist: "Nirvana"})
	第二个参数(可选)：指定查询返回的键的名称，可设置为0或1
		db.media.find({Artist: "Nirvana"}, {"Title": 1})
		
		
获取单个文档可使用函数`findOne()`
		
#### 使用sort, limit, skip

对于查询的结果，通过sort，limit，skip可以更精准控制查询。如实现排序，分页等

	db.media.find().sort({Title: 1})
	db.me	dia.find().limit(10)
	db.media.find().skip(20)
	
*skip有性能问题，没有特殊情况，可以对每次查询操作的时候，前后台传值前把上次的最后一个文档的日期保存下来，分页查询就可以：db.docName.find({date:{$gt:日期数值}}).limit(3)*	

#### 固定集合、自然顺序和$natural

#### 聚集框架命令

mongodb提供了基本的聚集命令：count, distinct, group。除此之外，还提供了一个聚集框架。聚集框架比较复杂，暂不学习。

* count()

		db.media.count()
		db.media.find({Publisher: "Apress", Type: "Book"}).count()
		
* distinct	()

		db.media.distinct("Title")

* 分组group()

	group()函数接受3个参数：
	* key: 指定希望使用哪个键对进行分组
	* initial: 为每个已分组的结果提供基数（元素开始统计的起始基数）
	* reduce：函数，将接受两个参数：正在遍历的当前文档和聚集计数对象
	
			db.media.group({
				key: {Title: true},
				initial: {Totoal: 0},
				reduce: function(items, prev) {
					prev.Total += 13
				}
			})		

	可选参数：
	
	* keyf：不希望使用key进行分组，使用该参数指定一个函数用于分组
	* cond: 指定一个额外的语句条件
	* finalize：可以使用该参数指定一个参数， 用于在最终结果返回之前执行。例如可用于计算平均数或计数等。
	
#### 查询条件

find()的第一个参数处理指定键对外，还可以使用mongodb提供的条件操作符

* $gt, $lt, $gte, $lte

		db.media.find({Released: {$gt: 2000}})

* $ne
* $in, $nin: 指定一组可能的匹配值
	
		db.media.find({Released: {$in: [1999, 2008, 2009]}})	

* $all
* $or

		db.media.find({"Type": "DVD", $or: [{"Title": "Toy Story 3"}, {"ISBN": "123-4"}]})

* $slice: 获取的文档只包含数组中特定范围的值，结合了limit()和skip()函数功能

		db.media.find({"Title": "Maxtrix, The"}, {"Cast": {$slice: 3}})


* $mod		
* $size: 过滤出文档中数组大小符合条件的结果
* $exists
* $type: 可以基于数据BSON的类型匹配结果
* $elemMatch: 匹配数组的完整文档
* $not
* $where: where有性能问题，尽量使用查询器
* 使用js指定额外的查询表达式

		db.media.find({"Type": "DVD", "Released": {$lt: 1995}})
		db.media.find({"Type": "DVD", $where: "this.Released M 1995"})
		db.media.find("this.Released < 1995")
		
		f = function() {return this.Released < 1995}
		db.media.find(f)
* 使用正则表达式

		db.media.find({Title: /Matrix*/i})

			
		
	游标：
	
		var persons = db.persons.find();
		whiel(persons.hasNext()) {
			obj = persons.next();
			print(obj)
		}					
		
		游标销毁：客户端发消息销毁，游标迭代结束，超时10min
		
	查询快照
	
		快照会针对不变的集合进行游标移动
	

### 更新

强硬的文档替换式更新操作：会用新的文档替换旧文档

	db.[collName].update({查询器}, {修改器})
	
	第一个参数: 指定一个查询
	第二个参数：指定更新信息，也可使用操作符完成
	第三个参数，可选：用于指定更新文档时的选项
	
#### 自动更新信息
可以使用**修改操作符**以简单的方式对文档进行快速更新，不需要手动输入任何信息。

* $inc: 为指定的键执行（原子）更新操作

		db.media.update({"Title": "One Piece"}, {$inc: {"Read": 4}})
* $set: 设置字段值

		db.media.update({"Title": "Matrix, The"}, {$set: {Genre: "Sci-Fi"}})
		
* $unset: 删除指定字段
	
		db.media.update({"Title": "Matrix, The"}, {$unset: {"Genre": 1}})
			
	
* $push: 指定字段添加某个值
		
		db.media.update({"ISBN": "111"}, {$push: {Author: "Griffin, Stewie"}})
		
* $each结合$push: 指定字段中多个值

		db.media.update({"ISBN": "111"}, {$push: {Author: {$each: ["Griffin, Peter", "Griffin, Biran"]}}})	
	
* $addToSet与$each结合完成批量数组更新

$addToSet不同于$push，只有数据不存在时，该操作符才将数据添加到数组。在使用$addToSet时，默认接受一个参数，但是可以使用$each指定额外的参数	   
	   
	   db.media.update({"ISBN": "111"}, {$addToSet:{Author: {$each: ["Griffin, Brian", "Griffin, Meg"]}}})
         
* $pop, $pull, $pullALl: 从数组中删除元素

		db.media.update({"ISBN": "111"}, {$pop:{Author: 1}})
		
* $: 指定查询中匹配数组元素的位置。该操作符可用于在搜索到一个数组元素之后，对它进行数据操作		

#### 原子操作

* $set, $unset, $inc, $push, $pull, $pullAll
* update ifcurrent
* findAndModify命令实现对文档的原子操作
	
主键冲突的时候会报错

insertOrUpdate：查询数据并执行更新操作,查不到执行替换操作

	db.[docName].update({查询器}, {修改器}, true)
	
批量更新：默认情况当查询器查到多条数据的时候，默认修改第一条数据，设置第四个参数为true，实现批量修改

	db.[docName].update({查询器}, {$set:修改器}，false, true)		
	
[pic](http://image17-c.poco.cn/mypoco/myphoto/20160124/20/17349718220160124204510037_640.jpg?1950x1212_130)

[pic](http://image17-c.poco.cn/mypoco/myphoto/20160124/20/17349718220160124204833023_640.jpg?1908x1136_130)

### 重命名集合

	db.media.renameCollection("newname")
	
### 删除
删除文档

	db.newname.remove({"Title": "Differenct Title"})
	db.newname.remove({})

删除集合

	db.newname.drop()
	
删除db

	db.dropDatabase()	

## 引用数据库

手动引用或者使用DBRef标准

### 手动引用

将另一个文档中**_id**存储在该文档中的某个字段中。

	apress = ({"_id": "Apress", ....})
	
	book = ({..., "Publisher": "Apress", ...})

### 自动引用DBRef

	{ $ref: <collectionname>, $id: <id value>[, $db: <databasename>]}
	
	book = ({..., "Publisher": [new DBRef('publisherscollection', apress._id)]}, ...)

		
## 索引					

	ensureIndex({要索引字段名:1}) : 1是正序，-1为倒序，索引对插入性能影响
	ensureIndex({}, {unique:true}) ：唯一索引
	ensureIndex({}, {unique:true, dropDups:true}) : 剔除重复值	
	
	ensureIndex({}).hint({}) : 强制指定索引
	
	find({}).explain() : 查看查询信息
	
	system.indexes
	
		db.system.indexes.find()
		db.system.namespaces.find()
		
	后台
		
		db.docName.ensureIndex({索引}, {background:true})
		
	删除索引：
	
		db.runCommand({dropIndexes:"集合名"}, index:"索引名")		
	
	二维索引
	
		ensureIndex({"gis":"2d"})	
		
		$near、$within、$box	

## 高级查询（未完待续）

## 其他		
		
### runCommand函数和findAndModify函数
	 
	 runCommand可以执行mongoDB中的特殊函数
	 findAndModify就是特殊函数之一他的用于是返回update或remove后的文档
	 runCommand({“findAndModify”:”processes”,
	 	query:{查询器},
		sort{排序},
	   new:true,
		update:{更新器},
		remove:true
	  }).value		
	  ps = db.runCommand({
	  "findAndModify":"persons",
    "query":{"name":"text"},
    "update":{"$set":{"email":"1221"}},
    "new":true 
    }).value
    do_something(ps)	
		

### count+distinct+group

	find().count()
	
	db.runCommand({distinct:"persons", key:"country"}).values
	
	db.runCommand({group:{ns:集合名字,key:分组的键对象, initial:初始化累加器, $reduce:组分解器, condition:条件, finalize:组完成器}})
	
	函数格式化分组
	

### 数据库命令

	命令执行器
		db.runCommand()
		
	命令
		db.listCommands()
		访问端口:localhost:28017/_commands (启动mongodb指定--rest参数)		

		db.runCommand({buildInfo:1})
		db.runCommand({collStatus:"集合名"})

### 固定集合特性

创建固定集合

	创建一个新的固定集合要求大小是100个字节,可以存储文档10个
	db.createCollection("mycoll",{size:100,capped:true,max:10})
	
把一个普通集合转换成固定集合
	
	db.runCommand({convertToCapped:”persons”,size:100000})
	
反向排序,默认是插入顺序排序.

	db.mycoll.find().sort({$natural:-1})
	
尾部游标概念：这是个特殊的只能用到固定级和身上的游标,他在没有结果的时候也不回自动销毁他是一直等待结果的到来		
	

## gridfs

GridFS是mongoDB自带的文件系统他用二进制的形式存储文件

使用GridFS

	查看GridFS的所有功能：mongofiles
	
上传一个文件

	mongofiles -d foobar -l "E:\a.txt" put "a.txt“
	
查看GridFS的文件存储状态

	集合查看
	db.fs.chunks.find() 和db.fs.files.find() 存储了文件系统的所有文件信息
	
	查看文件内容
	VUE可以查看,shell无法打开文件
	
	查看所有文件
	mongofiles -d foobar list
	
	删除已经存在的文件VUE中操作	
	mongofiles -d foobar delete 'a.txt'	

## 服务器端脚本：类似存储过程	

Eval

	服务器端运行eval
	
	db.eval("function(name){ return name}","aaa")
	
Javascript的存储

	在服务上保存js变量活着函数共全局调用
	
	1.把变量加载到特殊集合system.js中
	db.system.js.insert({_id:name,value:”uspcat”})	
	2. 调用
	db.eval("return  name;")
	
	System.js相当于Oracle中的存储过程,因为value不单单可以写变量还可以写函数体也就是javascript代码	
## mongoDB 启动配置

启动项 mongod --help

[启动项]()	

停止mongodb

	admin方式：
	use admin
	db.shutdownServer()
	
## 导入导出备份	
### 导出数据

	mongoexport -d foobar -c persons -o D:/persons.json
	mongoexport --host 192.168.0.16 --port 37017
	
	-d 指明使用的库
	-c 指明要导出的表
	-o 指明要导出的文件名
	-csv 制定导出的csv格式
	-q 过滤导出
	--type <json|csv|tsv>
		
### 导入数据

	mongoimport --db foobar --collection persons --file d:/persons.json
	
### 备份

运行时备份mongodump

	mongodump --host 127.0.0.1:27017 -d foobar -o d:/foobar
	
运行时恢复mongorestore

	db.dropDatabase()
	mongorestore --host 127.0.0.1:27017 -d foobar -directoryperdb d:/foobar/foobar
	
懒人备份

	mongoDB是文件数据库这其实就可以用拷贝文件的方式进行备份
	
## Fsync

上锁和解锁				

	上锁: db.runCommand({fsync:1,lock:1});
	解锁: db.currentOp()			

数据修复

	当停电等不可逆转灾难来临的时候,由于mongodb的存储结构导致会产生垃圾数据,在数据恢复以后这垃圾数据依然存在,这是数据库提供一个自我修复的能力.使用起来很简单
	db.repairDatabase()

## 用户管理

添加一个用户

	为admin添加uspcat用户和foobar数据库的yunfengcheng用户
	use admin
	db.addUser(“uspcat”,”123”);
	use foobar
	db.addUser(“yunfengcheng”,”123”);

启用用户

	db.auth(“名称”,”密码”)
	
安全检查 --auth

用户删除操作

	db.system.users.remove({user:"yunfengcheng"});
	
## 主从复制

	1.1在数据库集群中要明确的知道谁是主服务器,主服务器只有一台.
	1.2从服务器要知道自己的数据源也就是对于的主服务是谁.
	1.3--master用来确定主服务器,--slave 和 –source 来控制曾服务器
	
[主从复制案例]()	

## 副本集

[副本集概念]()

## 分片

什么时候用到分片呢?

* 机器的磁盘空间不足
* 单个的mongoDB服务器已经不能满足大量的插入操作
* 想通过把大数据放到内存中来提高性能				
[分片与副本集]()

 

		