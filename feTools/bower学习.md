title: bower学习
date: 2016-01-30 20:15:44
tags: 
- bower
- js

---


# bower学习

## 什么bower

Bower是一个客户端技术的软件包管理器，它可用于搜索、安装和卸载如JavaScript、HTML、CSS之类的网络资源。

## bower的好处

* 节省时间。使用bower会为你节省寻找客户端的依赖关系的时间，通过命令既可以安装好需要的包及其依赖，不用关注版本号、依赖等。
* 脱机工作。Bower会在用户主目录下创建一个.bower的文件夹，这个文件夹会下载所有的资源、并安装一个软件包使它们可以离线使用。Bower即是一个类似于现在流行的Maven构建系统的.m2仓库。
* 可以很容易地展现客户端的依赖关系。你可以创建一个名为bower.json的文件，在这个文件里你可以指定所有客户端的依赖关系，任何时候你需要弄清楚你正在使用哪些库，你可以参考这个文件。
* 让升级变得简单。假设某个库的新版本发布了一个重要的安全修补程序，为了安装新版本，你只需要运行一个命令，bower会自动更新所有有关新版本的依赖关系。


## 安装bower

* 下载安装最新nodejs
* 安装npm（安装nodejs会自动装好）
* 安装git
* 安装bower

		npm install -g bower
		
## 使用bower

* 帮助

		bower help
	
* 包的安装

		bower install 
	比如： 
	
		bower install jquery			
	
	命令完成以后，你会在你刚才创建的目录下看到一个**bower_components**的文件夹
	
* 包的使用

	直接引用**bower_components**对应文件即可，比如：
	
		<script type="text/javascript" src="bower_components/jquery/jquery.min.js"></script>	
		
* 所有包的列表

		bower list	
		
* 包的搜索

		bower search bootstrap
		
* 包的信息

		bower info bootstrap	
		bower info bootstrap#3.0.0
		
* 包的更新

		bower update

		
* 包的卸载

		bower uninstall jquery
		
## bower.json

bower.json文件的使用可以让包的安装更容易，你可以在应用程序的根目录下创建一个名为“bower.json”的文件，并定义它的依赖关系。使用`bower init `命令来创建bower.json文件。

这和npm非常类似

	{
	  "name": "blog",
	  "version": "0.0.1",
	  "authors": [
	    "Shekhar Gulati <shekhargulati84@gmail.com>"
	  ],
	  "license": "MIT",
	  "ignore": [
	    "**/.*",
	    "node_modules",
	    "bower_components",
	    "test",
	    "tests"
	  ],
	  "dependencies": {
	    "jquery": "~2.0.3"
	  }
	}
	
现在假设也想用twitter bootstrap，我们可以用下面的命令安装twitter bootstrap并更新bower.json文件：

	bower install bootstrap --save
	
它会自动安装最新版本的bootstrap并更新bower.json文件。


## 自定义包的安装目录

**.bowerrc文件是自定义bower下载的代码包的目录**

*e.g.*	

**.bowerrc**文件内容如下：

	{
	  "directory" : "js/lib"
	}	


## bower和npm

> 与NPM最大的区别在于，NPM主要运用于Node.js项目的内部依赖包管理，安装的模块位于项目根目录下的node_modules文件夹内。而**Bower大部分情况下用于前端开发，对于CSS/JS/模板等内容进行依赖管理，依赖的下载目录结构可以自定义**。
> 
> 有人可能会问，为何不用NPM一个工具对前后端进行统一的依赖管理呢？ 实际上，因为npm设计之初就采用了的是嵌套的依赖关系树，这种方式显然对前端不友好；而**Bower则采用扁平的依赖关系管理方式，使用上更符合前端开发的使用习惯**。
> 
> 不过，现在越来越多出名的js依赖包可以跨前后端共同使用，所以Bower和NPM上面有不少可以通用的内容。实际项目中，我们可以采用NPM作用于后端；Bower作用于前端的组合使用模式。让前后端公用开发语言的同时，不同端的开发工程师能够更好地利用手上的工具提升开发效率。			



	
	
	
	
	




## 参考

* <http://segmentfault.com/a/1190000000349555>