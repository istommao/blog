#node-blog


##环境

环境的配置和使用，参考[node-blog](https://github.com/zhuwei05/blog/blob/master/nodejs/node-blog.md)##需求分析和设计方案

###功能分析
rest api

* / 主页
* /onlineusers  在线用户列表
* /onlineusers/{user_number} 指定号码用户
* /onlineusers/id/{user_id} 指定id的用户
* /onlineusers/nodes/{node_name} 指定节点的信息
###页面构成和设计

* index.ejs 主页
* onlineusers.ejs  在线用户


页面构成文件都放在views目录下###路由设计

由功能分析中，正好对应：

* 首页：/ GET
* /onlineusers  在线用户列表 GET/POST
* /onlineusers/{user_number} 指定号码用户 GET/PUT/DELETE
* /onlineusers/id/{user_id} 指定id的用户  GET/PUT/DELETE
* /onlineusers/nodes/{node_name} 指定节点的信息 GET/DELETE

路由控制通过app.js的
	app.use('/', routes);
都指向routes目录的index.js，因此所有的路由逻辑都添加到index.js文件中	

##实现

### 路由实现

修改route/index.js文件，根据上一节的路由设计编写对应的路由函数，同时在views中添加对应的ejs文件。

	router.get('/', function(req, res, next) {
	    res.render('index', {
	        title: '首页'
	    });
	});
	
上面的路由表示：
	
**GET方法访问主页`/`，render的第一个参数表示该页面对应的ejs文件，即路径/的页面是views/index.ejs，第二个参数表示index.ejs里可以使用title对象**



###页面具体设计

上一步中把路由实现好了，下面通过bootstap和编写对应的ejs就可以进行页面的测试了。

**（这个时候可以测试路由实现是否正确，以及进行页面的初步设计）**

#### 样式

使用bootstrap

将bootstrap相关文件分别复制到public目录下对应的文件夹里

#### 页首和页尾

添加header.ejs和footer.ejs



## 总结

* 首先，需求分析，得出具体包含的页面和rest api接口
* 然后，完成每个页面的设计（MVC的`V`），结合express可以很好的查看到效果，这个过程不需要实现具体的页面逻辑和真实数据的展示
* 接着，根据业务逻辑，实现MVC的`C`和`M`，控制器主要在routes/index.js实现，模型通过在models目录下新建对应的js文件，完成单测。
* 最后，整体测试，调整。

## 实现

<https://github.com/zhuwei05/thrift-demo>

## 参考

<https://github.com/zhuwei05/blog/blob/master/nodejs/node-blog.md>






	
	
	
	
	
			
