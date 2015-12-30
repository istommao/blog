#mongoDB速览

##命令

创建数据库，使用指定的库

	use [databaseName]
	
查看所有数据库

	show dbs
	
给指定数据库（执行了use dbname）添加集合documentName并添加记录

	db.[documentName].insert({bson的kv})
	
查看数据库中所有文档

	show collections	
	
查询指定文档的数据

	查询所有 db.[documentName].find()
	查询第一条数据 db.[documentName].findOne()
	

更新文档数据

	db.[documentName].update({查询条件}, {更新内容})
	e.g.
		var p = db.persons.findOne()
		db.persons.update(p, {name: "bbc"})
		db.persons.update(p, {$set:{name: "bbc"}})
	
删除文档中的数据

	db.[documentName].remove({...})
	
删除数据库中的集合

	db.[documentName].drop()
	
删除数据库

	db.droDatabase()
	
shell的help

	db.help()
	db.[docName].help()
	
mongodb的api

	api.mongodb.org
	
数据库和集合命名规范

mongodb的shell内置js引擎，可直接执行js代码，可以使用eval

bson是json的扩展，新增了诸如日期，浮点等json不支持的数据类型

##详解

### 插入

	db.[docName].insert({})
	
批量插入

	shell不支持批量插入，需要使用循环
	想完成批量插入可以用mongo的应用驱动或是shell的for循环
	
save操作	

	save操作和insert操作区别在于遇到_id相同的情况下，save完成保存操作，而insert会报错
	
### 删除

删除列表中所有数据

	db.[docName].remove()
	集合本身和索引不会删除
	
根据条件删除

	db.[docName].remove({})

小技巧：如果想清楚一个数据量非常大的集合，直接删除该集合并且重建索引的方法比直接用remove的效率要高很多

### 更新

强硬的文档替换式更新操作：会用心的文档替换旧文档

	db.[docName].update({查询器}, {修改器})
	
主键冲突的时候会报错

insertOrUpdate：查询数据并执行更新操作,查不到执行替换操作

	db.[docName].update({查询器}, {修改器}, true)
	
批量更新：默认情况当查询器查到多条数据的时候，默认修改第一条数据，设置第四个参数为true，实现批量修改

	db.[docName].update({查询器}, {$set:修改器}，false, true)		
	
[pic](使用修改器完成局部更新操作)

[pic](使用修改器完成局部更新操作)

6. $addToSet与$each结合完成批量数组更新
	   
	   db.text.update({_id:1000},{$addToSet:{books:{$each:[“JS”,”DB”]}}})
          $each会循环后面的数组把每一个数值进行$addToSet操作

7.存在分配与查询效率
	   
	   当document被创建的时候DB为其分配没存和预留内存当修改操作
          不超过预留内层的时候则速度非常快反而超过了就要分配新的内存
	    则会消耗时间
	
	
 runCommand函数和findAndModify函数
	 
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

### find

* 指定返回的键


* 查询条件

	查询器：$set, $elemMatch, $where
		
		where有性能问题，尽量使用查询器
		
	$slice
		
		
	分页： limit(), skip()
		
		skip有性能问题，没有特殊情况，可以对每次查询操作的时候，前后台传值前把上次的最后一个文档的日期保存下来，分页查询就可以：db.docName.find({date:{$gt:日期数值}}).limit(3)
		
	游标：
	
		var persons = db.persons.find();
		whiel(persons.hasNext()) {
			obj = persons.next();
			print(obj)
		}					
		
		游标销毁：客户端发消息销毁，游标迭代结束，超时10min
		
	查询快照
	
		快照会针对不变的集合进行游标移动
		
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

## count+distinct+group

	find().count()
	
	db.runCommand({distinct:"persons", key:"country"}).values
	
	db.runCommand({group:{ns:集合名字,key:分组的键对象, initial:初始化累加器, $reduce:组分解器, condition:条件, finalize:组完成器}})
	
	函数格式化分组
	

## 数据库命令

	命令执行器
		db.runCommand()
		
	命令
		db.listCommands()
		访问端口:localhost:28017/_commands (启动mongodb指定--rest参数)		

		db.runCommand({buildInfo:1})
		db.runCommand({collStatus:"集合名"})

## 固定集合特性

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

 

		