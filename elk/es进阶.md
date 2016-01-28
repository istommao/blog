title: es进阶
date: 2016-01-28 10:48:12
tags: 
- es
- elk

----


# es进阶

## 数据

### 文档

程序中大多的实体或对象能够被序列化为包含键值对的JSON对象

* **键(key)**是字段(field)或属性(property)的名字
* **值(value)**可以是字符串、数字、布尔类型、另一个对象、值数组或者其他特殊类型

### 文档元数据

一个文档不只有数据。它还包含了元数据(metadata)——关于文档的信息。三个必须的元数据节点是：

* _index	文档存储的地方

	索引(index)类似于关系型数据库里的“数据库”——它是我们存储和索引关联数据的地方。
	
	> 提示：事实上，我们的数据被存储和索引在分片(shards)中，索引只是一个把一个或多个分片分组在一起的逻辑空间。然而，这只是一些内部细节——我们的程序完全不用关心分片。对于我们的程序而言，文档存储在索引(index)中。剩下的细节由Elasticsearch关心既可。
	
	*索引名必须是全部小写，不能以下划线开头，不能包含逗号。*

* _type	文档代表的对象的类

	在关系型数据库中，我们经常将相同类的对象存储在一个表里，因为它们有着相同的结构。同理，在Elasticsearch中，我们使用**相同类型(type)的文档表示相同的“事物”**，因为他们的数据结构也是相同的.
	
	每个**类型(type)**都有自己的**映射(mapping)**或者结构定义，就像传统数据库表中的列一样。所有类型下的文档被存储在同一个索引下，但是类型的映射(mapping)会告诉Elasticsearch不同的文档如何被索引。
	
	*_type的名字可以是大写或小写，不能包含下划线或逗号。*

* _id	 文档的唯一标识

	id仅仅是一个字符串，它与_index和_type组合时，就可以在Elasticsearch中唯一标识一个文档。当创建一个文档，你可以自定义_id，也可以让Elasticsearch帮你自动生成。
	
### 索引

文档通过index API被索引——使数据可以被存储和搜索。

#### 使用自己的ID

如果你的文档有自然的标识符（例如user_account字段或者其他值表示文档），你就可以提供自己的_id，使用这种形式的index API：
	
	PUT /{index}/{type}/{id}
	{
	  "field": "value",
	  ...
	}	
	
*e.g.*: 索引叫做“website”，类型叫做“blog”，我们选择的ID是“123”，那么这个索引请求就像这样：

	PUT /website/blog/123
	{
	  "title": "My first blog entry",
	  "text":  "Just trying this out...",
	  "date":  "2014/01/01"
	}

#### 自增ID

请求结构发生了变化：

* PUT方法 -- “在这个URL中存储文档”
* POST方法 -- "在这个文档下存储文档"。

URL现在只包含**_index**和**_type**两个字段：

	POST /website/blog/
	{
	  "title": "My second blog entry",
	  "text":  "Still trying this out...",
	  "date":  "2014/01/01"
	}	
	
### 检索

想要从Elasticsearch中获取文档，我们使用同样的**\_index、\_type、\_id**，但是HTTP方法改为GET：

	GET /website/blog/123?pretty

响应包含了现在熟悉的元数据节点，增加了**_source**字段，它包含了在创建索引时我们发送给Elasticsearch的原始文档。

	{
	  "_index" :   "website",
	  "_type" :    "blog",
	  "_id" :      "123",
	  "_version" : 1,
	  "found" :    true,
	  "_source" :  {
	      "title": "My first blog entry",
	      "text":  "Just trying this out...",
	      "date":  "2014/01/01"
	  }
	}
	
注意: **found**和**version**字段

* **version**字段可以用来解决并发写和同步引起的先后顺序问题。
* **found**字段可以用来解决批量检索时用来判断哪些文档有找到




#### 检索文档的一部分

多个字段可以使用逗号分隔：

	GET /website/blog/123?_source=title,text	
或者你只想得到_source字段而不要其他的元数据，你可以这样请求：

	GET /website/blog/123/_source
	
### 检查文档是否存在

如果你想做的只是检查文档是否存在——你对内容完全不感兴趣——使用HEAD方法来代替GET。HEAD请求不会返回响应体，只有HTTP头：
	
	curl -i -XHEAD http://localhost:9200/website/blog/123
	
	
### 更新整个文档

文档在Elasticsearch中是不可变的——我们不能修改他们。如果需要更新已存在的文档，**index API **重建索引(reindex) 或者替换掉它。

	PUT /website/blog/123
	{
	  "title": "My first blog entry",
	  "text":  "I am starting to get the hang of this...",
	  "date":  "2014/01/02"
	}

在响应中，我们可以看到Elasticsearch把_version增加了。

	{
	  "_index" :   "website",
	  "_type" :    "blog",
	  "_id" :      "123",
	  "_version" : 2,
	  "created":   false <1>
	}

* <1> created标识为false因为同索引、同类型下已经存在同ID的文档。

### 创建一个新文档

请记住**\_index、\_type、\_id**三者唯一确定一个文档。所以要想保证文档是新加入的，最简单的方式是使用POST方法让Elasticsearch自动生成唯一\_id：	

	POST /website/blog/
	{ ... }
	
如果想使用自定义的\_id:

第一种方法使用**op_type**查询参数：

	PUT /website/blog/123?op_type=create
	{ ... }

或者第二种方法是在URL后加**/\_create**做为端点：

	PUT /website/blog/123/_create
	{ ... }

### 删除文档

删除文档的语法模式与之前基本一致，只不过要使用**DELETE**方法：

	DELETE /website/blog/123
	
### 文档局部更新

文档是不可变的——它们不能被更改，只能被替换。**update API**必须遵循相同的规则。表面看来，我们似乎是局部更新了文档的位置，内部却是像我们之前说的一样简单的使用update API处理相同的**检索-修改-重建索引**流程，我们也减少了其他进程可能导致冲突的修改。	

最简单的**update**请求表单接受一个局部文档参数**doc**，它会合并到现有文档中--**对象合并在一起，存在的标量字段被覆盖，新字段被添加**

	POST /website/blog/1/_update
	{
	   "doc" : {
	      "tags" : [ "testing" ],
	      "views": 0
	   }
	}
	
#### 更新可能不存在的文档

使用**upsert**参数定义文档来使其不存在时被创建	
	
### 使用脚本局部更新

* groovy脚本


### 更新和冲突

为了避免丢失数据，**update API**

* 在**检索(retrieve)**阶段检索文档的当前**\_version**，
* 然后在**重建索引(reindex)**阶段通过index请求提交。如果其他进程在检索(retrieve)和重加索引(reindex)阶段修改了文档，**\_version**将不能被匹配，然后更新失败。


对于多用户的局部更新，文档被修改了并不要紧。例如，两个进程都要增加页面浏览量，增加的顺序我们并不关心——如果冲突发生，我们唯一要做的仅仅是重新尝试更新既可。
这些可以通过retry_on_conflict参数设置重试次数来自动完成，这样update操作将会在发生错误前重试——这个值默认为0。

### 批量操作

* mget api
* bulk api

#### mget api
**mget API**参数是一个**docs**数组，数组的每个节点定义一个文档的**\_index、\_type、\_id元数据**。如果你只想检索一个或几个确定的字段，也可以定义一个**\_source**参数
	
	GET /_mget
	{
	   "docs" : [
	      {
	         "_index" : "website",
	         "_type" :  "blog",
	         "_id" :    2
	      },
	      {
	         "_index" : "website",
	         "_type" :  "pageviews",
	         "_id" :    1,
	         "_source": "views"
	      }
	   ]
	}
	
* 检索的文档在同一个_index中（甚至在同一个_type中），你就可以在URL中定义一个默认的**/\_index或者/\_index/\_type。**	

		GET /website/blog/_mget
		{
		   "docs" : [
		      { "_id" : 2 },
		      { "_type" : "pageviews", "_id" :   1 }
		   ]
		}


* 如果所有文档具有相同**\_index和\_type**，你可以通过简单的ids数组来代替完整的docs数组:

		
		GET /website/blog/_mget
		{
		   "ids" : [ "2", "1" ]
		}
		
**如果有一个文档没有被找到，但HTTP请求状态码还是200。事实上，就算所有文档都找不到，请求也还是返回200，原因是mget请求本身成功了。如果想知道每个文档是否都成功了，你需要检查`found`标志。**		

#### bulk api

**bulk API**允许我们使用单一请求来实现多个文档**的create、index、update或delete**。这对索引类似于日志活动这样的数据流非常有用，它们可以以成百上千的数据为一个批次按序进行索引。

bulk请求体如下，它有一点不同寻常：
	
	{ action: { metadata }}\n
	{ request body        }\n
	{ action: { metadata }}\n
	{ request body        }\n
	...
	
这种格式类似于用"\n"符号连接起来的一行一行的JSON文档流(stream)。两个重要的点需要注意：

* 每行必须以"\n"符号结尾，包括最后一行。这些都是作为每行有效的分离而做的标记。
* 每一行的数据不能包含未被转义的换行符，它们会干扰分析——这意味着JSON不能被美化打印	

**action/metadata**这一行定义了文档行为(what action)发生在哪个文档(which document)之上：

* **action**：create, index, update, delete
* **metadata**: 在索引、创建、更新或删除时必须指定文档的*\_index、\_type、\_id*这些元数据(metadata)

> 整个批量请求需要被加载到接受我们请求节点的内存里，所以请求越大，给其它请求可用的内存就越小。有一个最佳的bulk请求大小。超过这个大小，性能不再提升而且可能降低
> 
> 最佳大小，当然并不是一个固定的数字。它完全取决于你的硬件、你文档的大小和复杂度以及索引和搜索的负载。幸运的是，这个最佳点(sweetspot)还是容易找到的：
> 
> 试着批量索引标准的文档，随着大小的增长，当性能开始降低，说明你每个批次的大小太大了。开始的数量可以在1000~5000个文档之间，如果你的文档非常大，可以使用较小的批次。


## 结构化查询

结构化查询（Query DSL）和结构化过滤（Filter DSL）。 

使用结构化查询，你需要传递**query**参数

e.g: 请求体使用JSON表示，其中使用了**match语句**:

	GET /megacorp/employee/_search
	{
	    "query" : {
	        "match" : {
	            "last_name" : "Smith"
	        }
	    }
	}	
	
### 查询子句

查询子句一般使用这种结构

	{
	    QUERY_NAME: {
	        ARGUMENT: VALUE,
	        ARGUMENT: VALUE,...
	    }
	}

或指向一个指定的字段：

	{
	    QUERY_NAME: {
	        FIELD_NAME: {
	            ARGUMENT: VALUE,
	            ARGUMENT: VALUE,...
	        }
	    }
	}
	
*e.g.*

	GET /_search
	{
	    "query": {
	        "match": {
	            "tweet": "elasticsearch"
	        }
	    }
	}	
	
### 合并多子句

查询子句就像是搭积木一样，可以合并简单的子句为一个复杂的查询语句，比如：

* 叶子子句(leaf clauses)(比如match子句)用以在将查询字符串与一个字段(或多字段)进行比较
* 复合子句(compound)用以合并其他的子句。例如，`bool`子句允许你合并其他的合法子句，`must`，`must_not`或者`should`

		{
		    "bool": {
		        "must":     { "match": { "tweet": "elasticsearch" }},
		        "must_not": { "match": { "name":  "mary" }},
		        "should":   { "match": { "tweet": "full text" }}
		    }
		} 
	
复合子句能合并 任意其他查询子句，包括其他的复合子句。 这就意味着复合子句可以相互嵌套，从而实现非常复杂的逻辑。

### 查询与过滤

#### term 过滤

*term*主要用于精确匹配哪些值或 *not_analyzed*的字符串(未经分析的文本数据类型)：

	{ "term": { "age":    26           }}
	{ "term": { "date":   "2014-09-01" }}
    { "term": { "public": true         }}
    { "term": { "tag":    "full_text"  }}
	
#### terms 过滤

terms 跟 term 有点类似，但 terms 允许指定多个匹配条件。 如果某个字段指定了多个值，那么文档需要一起去做匹配：

	{
	    "terms": {
	        "tag": [ "search", "full_text", "nosql" ]
	        }
	} 	

#### range 过滤

range过滤允许我们按照指定范围查找一批数据：
	
	{
	    "range": {
	        "age": {
	            "gte":  20,
	            "lt":   30
	        }
	    }
	}
 
 
范围操作符包含：**gt, gte, lt, lte**

#### exists 和 missing 过滤 	

exists 和 missing 过滤可以用于查找文档中是否包含指定字段或没有某个字段，类似于SQL语句中的IS_NULL条件

#### bool 过滤

**bool** 过滤可以用来合并多个过滤条件查询结果的布尔逻辑，它包含一下操作符：

* **must** :: 多个查询条件的完全匹配,相当于 and。
* **must_not** :: 多个查询条件的相反匹配，相当于 not。
* **should** :: 至少有一个查询条件匹配, 相当于 or。
这些参数可以分别继承一个过滤条件或者一个过滤条件的数组 	
#### match_all 查询

使用match_all 可以查询到所有文档，是没有查询条件下的默认语句。

#### match 查询

match查询是一个标准查询，不管你需要全文本查询还是精确查询基本上都要用到它。

#### multi_match 查询

multi_match查询允许你做match查询的基础上同时搜索多个字段

#### bool 查询

**bool 查询**与 **bool 过滤**相似，用于合并多个查询子句。不同的是，bool 过滤可以直接给出是否匹配成功， 而bool 查询要计算每一个查询子句的 **_score （相关性分值）**。

* **must**:: 查询指定文档一定要被包含。
* **must_not**:: 查询指定文档一定不要被包含。
* **should**:: 查询指定文档，有则可以为文档相关性加分。


> 提示： 如果bool 查询下没有must子句，那至少应该有一个should子句。但是 如果有must子句，那么没有should子句也可以进行查询。

### 查询与过滤条件的合并

在 ElasticSearch API 中我们会看到许多带有 **query** 或 **filter** 的语句。 这些语句既可以包含单条 **query** 语句，也可以包含一条 **filter** 子句。 换句话说，这些语句需要首先创建**一个query或filter的上下文关系**。

查询语句可以包含过滤子句，反之亦然。 以便于我们切换 query 或 filter 的上下文。这就要求我们在读懂需求的同时构造正确有效的语句。


#### 带过滤的查询语句

search API中只能包含 **query** 语句，所以我们需要用 **filtered** 来同时包含 "query" 和 "filter" 子句：

	{
	    "filtered": {
	        "query":  { "match": { "email": "business opportunity" }},
	        "filter": { "term":  { "folder": "inbox" }}
	    }
	}
	
在外层再加入 **query** 的上下文关系：

	GET /_search
	{
	    "query": {
	        "filtered": {
	            "query":  { "match": { "email": "business opportunity" }},
	            "filter": { "term": { "folder": "inbox" }}
	        }
	    }
	}	

#### 单条过滤语句

在 query 上下文中，如果你只需要一条过滤语句，比如在匹配全部邮件的时候，你可以 省略 query 子句.	

#### 查询语句中的过滤

有时候，你需要在 filter 的上下文中使用一个 query 子句。下面的语句就是一条带有查询功能 的过滤语句， 这条语句可以过滤掉看起来像垃圾邮件的文档：

	GET /_search
	{
	    "query": {
	        "filtered": {
	            "filter":   {
	                "bool": {
	                    "must":     { "term":  { "folder": "inbox" }},
	                    "must_not": {
	                        "query": { <1>
	                            "match": { "email": "urgent business proposal" }
	                        }
	                    }
	                }
	            }
	        }
	    }
	}
	
<1> 过滤语句中可以使用query查询的方式代替 bool 过滤子句。

> 提示： 我们很少用到的过滤语句中包含查询，保留这种用法只是为了语法的完整性。 只有在过滤中用到全文本匹配的时候才会使用这种结构	

### 验证查询

查询语句可以变得非常复杂，特别是与不同的分析器和字段映射相结合后，就会有些难度。

**validate** API 可以验证一条查询语句是否合法。

	GET /gb/tweet/_validate/query
	...
	
	
想知道语句非法的具体错误信息，需要加上 **explain** 参数：
 	
	GET /gb/tweet/_validate/query?explain
	...
	
	
## 排序

* 相关性排序
* 字段值排序

		GET /_search
		{
		    "query" : {
		        "filtered" : {
		            "filter" : { "term" : { "user_id" : 1 }}
		        }
		    },
		    "sort": { "date": { "order": "desc" }}
		}	
		
* 默认排序		
	作为缩写，你可以只指定要排序的字段名称：
    
    	"sort": "number_of_children"
    	
* 多级排序

		...
		"sort": [
		        { "date":   { "order": "desc" }},
		        { "_score": { "order": "desc" }}
		    ]
		... 

* 字符串参数排序

	字符查询也支持自定义排序，在查询字符串使用sort参数就可以：
	
		GET /_search?sort=date:desc&sort=_score&q=search 
  	
### 多值字段字符串排序

为了使一个string字段可以进行排序，它必须只包含一个词：即完整的**not_analyzed**字符串(译者注：未经分析器分词并排序的原字符串)。 当然我们需要对字段进行全文本搜索的时候还必须使用被 **analyzed** 标记的字段。

在 **_source** 下相同的字符串上排序两次会造成不必要的资源浪费。 而我们想要的是同一个字段中同时包含这两种索引方式，我们只需要改变索引(index)的mapping即可。 方法是在所有核心字段类型上，使用通用参数 **fields**对mapping进行修改。 比如，我们原有mapping如下：  	

	"tweet": {
	    "type":     "string",
	    "analyzer": "english"
	}
	
改变后的多值字段mapping如下：
	
	"tweet": { <1>
	    "type":     "string",
	    "analyzer": "english",
	    "fields": {
	        "raw": { <2>
	            "type":  "string",
	            "index": "not_analyzed"
	        }
	    }
	}

* <1> tweet 字段用于全文本的 analyzed 索引方式不变。
* <2> 新增的 tweet.raw 子字段索引方式是 not_analyzed。	

### 数据字段

倒排索引在用于搜索时是非常卓越的，但却不是理想的排序结构。

* 当搜索的时候，我们需要用检索词去遍历所有的文档。
* 当排序的时候，我们需要遍历文档中所有的值，我们需要做反倒序排列操作。

为了提高排序效率，ElasticSearch 会将所有字段的值加载到内存中，这就叫做**"数据字段"**。 

> 重要： ElasticSearch将所有字段数据加载到内存中并不是匹配到的那部分数据。 而是索引下所有文档中的值，包括所有类型。

将所有字段数据加载到内存中是因为从硬盘反向倒排索引是非常缓慢的。尽管你这次请求需要的是某些文档中的部分数据， 但你下个请求却需要另外的数据，所以将所有字段数据一次性加载到内存中是十分必要的。

ElasticSearch中的字段数据常被应用到以下场景：

* 对一个字段进行排序
* 对一个字段进行聚合
* 某些过滤，比如地理位置过滤
* 某些与字段相关的脚本计算
* 毫无疑问，这会消耗掉很多内存，尤其是大量的字符串数据 -- string字段可能包含很多不同的值 
 	
	
## 搜索

很多搜索都是开箱即用的，为了充分挖掘Elasticsearch的潜力，你需要理解以下三个概念：

* 映射(Mapping)：数据在每个字段中的解释说明
* 分析(Analysis)	：全文是如何处理的可以被搜索的
* 领域特定语言查询(Query DSL)：Elasticsearch使用的灵活的、强大的查询语言

*（未完待续）*

### 多索引和多类别

### 分页

> 在集群系统中深度分页
> 
> 为了理解为什么深度分页是有问题的，让我们假设在一个有5个主分片的索引中搜索。当我们请求结果的第一页（结果1到10）时，每个分片产生自己最顶端10个结果然后返回它们给请求节点(requesting node)，它再排序这所有的50个结果以选出顶端的10个结果。
> 
> 现在假设我们请求第1000页——结果10001到10010。工作方式都相同，不同的是每个分片都必须产生顶端的10010个结果。然后请求节点排序这50050个结果并丢弃50040个！
> 
> 你可以看到在分布式系统中，排序结果的花费随着分页的深入而成倍增长。这也是为什么网络搜索引擎中任何语句不能返回多于1000个结果的原因。

## 映射和分析

* **映射(mapping)**机制用于进行字段类型确认，将每个字段匹配为一种确定的数据类型(string, number, booleans, date等)。
* **分析(analysis)**机制用于进行全文文本(Full Text)的分词，以建立供搜索用的反向索引。


*（未完待续）*

	
## 分布式增删改查原理

### 路由	 	
 	
### 分片交互

### 新建、索引和删除

### 检索

### 局部更新

### 批量请求

### 批量格式



## 参考

* [Elasticsearch权威指南（中文版）](https://www.gitbook.com/book/looly/elasticsearch-the-definitive-guide-cn/details)
 	
 		
