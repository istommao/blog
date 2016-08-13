title: npm and package
date: 2016-03-30 12:18:20
tags:
- npm
- node 
- package

# npm and package学习

## 模块和包

模块和包区别是透明的，常常不做区分。

### 模块
**模块和文件意义对应，一个nodejs文件就是一个模块，这个文件可以是js代码，json编译过的c++扩展**

模块创建：

	提供exports和require两个对象，exports是模块公开的接口，require用于从外部获取一个模块的接口，即获取exports对象。
	
require只加载

若想封装：

	在js文件定义一个function hello() {...}
	然后通过module.exports = hello;
	在其他文件引入: require('hello')	var he = new hello();


### 包
**在模块基础上更深一步抽象，类似与C/C++的函数库或java类库**

创建一个包

	commonJS规范包具备特征：
	* package.json必须在包的顶层目录下
		{
			'main': './lib/package.js'
		}
		
		属性
			name： 包名字
			description：描述
			version：版本
			keywords：关键字数据，通常用于搜索
			maintainers：维护者数组，每个元素要包含name，email，web可选字段
			contributors: 贡献者数组，格式与maintainers相同
			bugs：提交bug的地址
			licenses：许可证数组，每个元素包含type和url字段
			repositories：仓库托管地址数组，每个元素包含type，url和path字段
			dependencies：包的依赖，一个关联数组，由包名和版本号组成
	* 二进制代码在bin目录下
	* js代码应该lib目录下
	* 文档应该在doc目录下
	* 单元测试在test目录下
	
	
## 包管理器

	
包安装

	npm [install/i] [-g] [package_name]
	
	e.g

	$ npm install express --save       # save dependency into package.json
	$ npm install gulp --save-dev      # save devDependency into package.json
	$ npm install bower -g      # install global, so can call bower inside terminal
	
	$ npm install express@"4.2.x" --save     # install specific version
	$ npm install underscore@">=1.1.0 <1.4.0" --save
	
	$ npm i express -S    # Shorthands for --save
	$ npm i gulp -D      # for --save-dev
		
	$ npm install -g supervisor
		
卸载包
	
	npm uninstall 包名 [-g]
	
	e.g.
	
	$ npm uninstall [-g] underscore --save  # remove dependency from pkg.json
	$ npm prune                             # add extraneous pkg into pkg.json
	$ npm prune --production                # rm dev dependencies from pkg.json
		
查看当前所有包
		
	npm list
		
更新模块
	
	npm update express	
		
搜索模块

	npm search express
		
帮助：可查看某条命令的详细帮助

		npm help <command>
		e.g npm help install
		
初始包,生成规范的package.json文件

	npm init
	
	npm默认从npmjs.org搜索和下载包，将包安装到当前目录的node_modules

本地模式和全局模式

	本地模式不会安装到PATH环境, 只是将包安装到node_modules子目录下，其中bin目录没有包含在PATH环境变量中，不能直接在命令行调用。
	
	使用全局模式安装的恶报并不能直接在js文件中通过require获得，因为require不会搜索/usr/local/lib/node_modules
	
	一般来说：包作为工程运行时，就使用本地模式获取，当要作为命令行运行就使用全局模式安装
	
包的发布	

	确保符合commonjs标准的package.json
	npm publish
	
	npm unpublish

## 使用 package.json

package.json 位于模块的目录下，用于定义包的属性。

有几部分组成：**basic module info, dependencies, devDependencies, scripts**

Package.json 属性说明：

* name - 包名。
* version - 包的版本号。
* description - 包的描述。
* homepage - 包的官网 url 。
* author - 包的作者姓名。
* contributors - 包的其他贡献者姓名。
* scripts - 命令行指令。比如： `npm test`
* dependencies - 依赖包列表。如果依赖包没有安装，npm 会自动将依赖包安装在 node_module 目录下。
* repository - 包代码存放的地方的类型，可以是 git 或 svn，git 可在 Github 上。
* main - main 字段是一个模块ID，它是一个指向你程序的主要项目。就是说，如果你包的名字叫 express，然后用户安装它，然后require("express")。
* keywords - 关键字

## 发布

* 安装nodeJS
* 注册一个github账户用于托管代码
* 注册一个npm账户
* 开发你的module，更新至github
* 发布module至npm

> 参考：[
发布自己的module](https://segmentfault.com/a/1190000006250554)

## 参考

* [npm doc](https://npmjs.org/doc/)
* [npm playbook](https://linbojin.github.io/2016/01/17/NPM-Playbook/)
* [菜鸟网络](http://www.runoob.com/nodejs/nodejs-npm.html)
* [玩转npm](http://www.alloyteam.com/2016/03/master-npm/)