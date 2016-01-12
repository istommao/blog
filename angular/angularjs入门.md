#AngularJS入门

四大核心特性：

* MVC
* 模块化和依赖注入
* 指令系统
* 双向数据绑定

ng-app
ng-controller

[模块]()

[双向数据绑定]()

##前端自动化工具

### 开发、调试、测试

编辑：sublime、webstorm、

断点调试：chrome调试batarang

#### nodejs

安装node

#### 在当前目录安装grunt

	npm install grunt
	npm install -g grunt  (全局)

grunt：代码合并和混淆

	依赖其他创建：grunt-contrib-uglify/concat/watch
	
Gruntfile.js:

#### 依赖管理工具bower

* 自动安装依赖的组件
* 组件之间的依赖检查
* 版本兼容性自动检查

前端组件自动化管理神器

安装

	npm install -g bower
	
安装jquery、bootstrap

	bower install jquery	
	bower install bootstrap
	
#### 轻量级server--http-server

* 一款简单的http-server
* 基于nodejs的http接口

安装

	npm install http-server
	
#### 单元测试--karma和jasmine

* karma：用来跑测试用例的runner
* jasmine: 类似java的JUnit，提供了一套语法，用来编写测试用例。四个核心概念：分组、用例、期望、匹配

	npm install karma
	npm install jasmine


解释：

	describe(string, function)：分组，也就是一组测试用例
	it(string, function): 表示测试用例
	expect(expression): 表示期望expression这个表达式具有某个值或者具有某种行为
	to\*\*\*(arg): 表示匹配
	
karma.config.js:配置文件

执行：karma start
		
#### protractor

专为angularjs的测试工具

[完整目录结构实例]()

## 基本概念和用法
-----
## MVC

MVC只是手段，终极目标是模块化和复用

### controller

ng-controller

控制器通用的部分：通过service实现，不要通过继承

[controller注意点]()


### models

ng-model

### view

通过指令实现

### scope

**angular的mvc通过scope实现**

* $scope是一个POJO
* $scop;e提供了一一些工具方法$watch()、$apply()
* $scope是表达式的执行环境（或者叫作用域）
* $scope是一个树形结构，与DOM标签平行
* 子$scope对象会继承父$scope上的属性和方法
* 根scope一般位于ng-app上
* $scope可以传播事件，类似DOM事件，可以向上、向下
* $scope不仅使MVC的基础，也是后面双向数据绑定的基础
* 可以使用$angular.element($0)(chrome插件 inspect angular)

#### $scope的生命周期

create ==> watcher registraton ==> model mutation ==> mutation obseration ==> scope destruction


## 模块化和依赖注入

	var helloModule = angular.modle('HelloAngular', [])
	helloModule = 
	
目录结构：

	app
		css
		imgs
		js
			app.js： 启动点
			controllers.js： 可以分成多个controller
			directive.js：
			filters.js
			services.js
		tpls：自定义，用于存放html模板文件
			hello.html 
		index.htlm: 主html文件
		framework(自定义的，管理框架，可用bower管理)
			存放框架的文件，比如angular.js
	node_modules：nodejs的包
		package.json	
		
依赖注入：中括号里

	var bookStoreApp = angular.module('bookStoreApp', ['ngRoute', 'ngAnimate', 'bookStoreCtrls', 'bookStoreFilters', 'bookStoreServices', 'bookStoreDirectives'])
	
		
		
	
## 实例

		
### route

app.js

	var bookStoreApp = angular.module('bookStoreApp', ['ngRoute', 'ngAnimate', 'bookStoreCtrls', 'bookStoreFilters', 'bookStoreServices', 'bookStoreDirectives'])
	
	bookStoreApp.config(function($routeProvider) {
		$routeProvider.when('/hello', {
			templateUrl: 'tpls/hello.html',
			controller: 'HelloCtrl'
		}).when('list', {
			templateUrl: 'tpls/bookList.html',
			controller: 'BookListCtrl'
		}).otherwise({
			redirectTo: '/hello'
		})
	});

### controllers.js

	var bookStoreCtrls = angular.module
	
	bookStoreCtrls.controller('HelloCtrl',)
	
	bookStoreCtrols.controller('BookListCtrl',)

### tpls/hello.html


### dirctive.js

### services.js
			
			
## 双向数据绑定

	{{greeting.text}}
	
视图和模型绑定不同的值可以相互影响，这时候不需要通过jquery去操作各种标签去改变

### 取值表达式和ng-bind指令

取值表达式：

	{{greeting.text}}, Angular
	
ng-bind: 解决网络等影响显示，导致页面显示取值表达式：

	<span ng-bind="greeting.text"></span>, Angular	
### 表单


Form.html和Form.js

	标签.样式1.样式2...
	div.panel.panel-primary + 快捷键
	
	自动生成
		<div class="panel panel-primary">
		
		<div>

#### 模块
Form.js

	var userInfoModule = angular.module('UserInfoModle', [])

	userInfoModule.controller('UserInfoCtrl', ['$scope', function($scope){
		$scope.userInfo = {
			email: "aaa@aaa.com",
			password:"111",
			autoLogin:true
		};
	}])
	
对应绑定

	<input type="checkbox" ng-module="userInfo.autoLogin">自动登录	
	
#### 控制器

### 动态切换标签

### ng-show/ng-hide

控制标签的隐藏和显示

### ng-class

接收表达式

	<div ng-class = '{error: isError, warning: isWarning}'>
	</div>

### ngAnimate			
			
动画的支持

## 路由

angular-route.js

	bookStoreApp.config(function($routeProvider) {
			$routeProvider.when('/hello', {
				templateUrl: 'tpls/hello.html',
				controller: 'HelloCtrl'
			}).when('list', {
				templateUrl: 'tpls/bookList.html',
				controller: 'BookListCtrl'
			}).otherwise({
				redirectTo: '/hello'
			})
		});
		
第三方路由：UI-route(AngluarUI Router)

### 前端路由基本原理

* 哈希
* HTML中的新history API
* 路由的核心是给应用定义“状态”
* 路由机制会影响到应用的整体编码方式（需要预先定义好状态）
* 考虑兼容性问题与“优雅降级”

	
## 指令

	var myModule = angular.modle('MyModule', [])
	myModule.directive("hello", function(){
		return {
			restrict: 'E',
			template: '<div>Hi everyone!</div>',
			replace: true
		}
	});
	
restrict: 匹配模式 AEMC(属性、元素、注释、Class)

	<hello></hello> 元素
	<div hello></div> 属性
	<div class="hello"> </div> class
	<!-- directive:hello --> 注释
	<div></div>	
			
模板：

	template：
	templateUrl: 指定模本文件，将模板文件单独放到文件
	templateCache: 缓存
	
replace：

	指令替换

transclue:

	让指令可以互相嵌套		
		
### 指令运行

加载阶段：加载angular.js, 找到ng-app指令，确定应用的边界

编译阶段：遍历DOM，找到所有指令，根据指令代码中的template、replace、transclue转换DOM结构；如果存在compile函数则调用；

链接阶段：每条指令的link被调用；link函数一般用来操作DOM、绑定事件监听器


## 指令和控制器的交互

	link:function(scope, element, attr) {
		element.bind("mouseenter", function(){
			//scope.loadData();
			//scope.$apply("loadData()")
			scope.$apply(attrs.howtoload)
		})
	}
	
## 指令的交互

## 独立scope

绑定策略：

	@：把当前属性值作为字符串传递，还可以绑定来自外层的scope的值，在属性值中插入{{}}即可
	=：与父scope中的属性进行双向绑定
	&：传递一个来自父scope的函数，稍后调用
	
### 内置指令和自定义指令

<http://angular-ui.github.io>

<http://miniui.com> <a >senca</a>

ERP类型系统必备UI组件：

	表单：Form、Button、Calendar、FileUpload...
	布局：Panel、Window、Layout...
	导航：Tree、NavBar、Page、Menu...
	列表：DataGrid、Tree、TreeGrid
	
电商：
<http://gallery.kissyui.com>	


## service

内置service共24个。

* $http
* $locale
* $compile
* $location
* interval
* timeout
* log

### $http服务
	$http({
		method: 'GET',
		url: 'data.json'
	}).success(function(data, status, header,  config) {
		// ...
	}).error(function(data, status, header, config) {
		// ...
	})
	

上面的链式调用称为promise

### 自己的service

### service特性

* 单例
* 由$injector负责实例化
* 在整个生命周期存在，可以用来`共享数据`
* 在需要使用的地方利用`依赖注入`机制注入service
* 自定义的service需要写在内置service后面
* 内置service的命名以$符号开头，自定义的service应该避免




### service、factory、provider本质都是provider

provider模式是`策略模式` + `抽象工厂模式` 的混合体

### $filter服务

* $filter用来数据格式化的专用服务
* 内置9个filter
* 可嵌套
* 自定义filter

## 综合设计：bookstore

### 界面原型设计

archa rp

* 登录
* 书籍列表
* 详情
* 新增书籍

### 切分功能模块并建立目录结构

	dest
	docs
	src
		css
		data
		framework
		image
		js: 主要的代码
		tpls: 界面的模板
	test	
		

### 使用angular-ui和bootstrap编写ui

数据使用假数据，可将数据方法data文件夹下的一些列文件。

#### 路由UIRouter（可实现嵌套路由）


#### nggrid



### 编写controller

### 编写service

### 编写filter

### 单元测试和集成测试


## 核心原理

### 启动过程

源码：angular.js

	用自执行函数让整个代码在加载完后立即执行
	==> 检查是不是多次启动angular
	==> 绑定jQuery, 执行bindJQuery
	==> publishExternalAPI
	==> angularInit
	
启动angular方式：

	自启动:ng-app
	手动启动：angular.bootstrap	
	
publishExternalAPI

	setModuleLoader	
	注册ng内核和内置的指令和provider
	
angularInit

	查找ng-app
	启动bootstrap
		创建注册器injector
		加载rootScope，rootElement，compile

### 依赖注入原理分析：provider和injector
* 推断型注入

	函数参数的名称必须要和被注入的对象相同

* 声明式注入、标注型注入

* 内联式注入

#### 使用injector

$injector.invoke(...)

#### provider

* provider模式是策略模式和工程模式的综合体。
* 目的是为了让接口和实现分离
* 在ng中，所有provider都可以用来注入：provider/factory/service/constant/value

	provider是基础，其余都是调用provider函数实现的：源码中的createInjector可以看得到
	
* 可以接受注入的函数类型：controller/directive/filter/service/factory

* ng中的依赖注入是通过provider和injector这两个机制联合实现的。

### 指令执行过程

* 自定义compile和link函数

		link: function(scope, el, attrs, controller)
	
		compile: function(el, attrs, transclude)	

* compile和link的区别
	
	* compile对指令的模板jinx转换
	* link是在模型和试图之间建立关联，包括在元素上注册事件监听
	* scope在连接阶段才会被绑定到元素上，因此compile阶段操作scope会报错
	* 对同一个指令的多个实例，compile只会执行一次，link每次都会执行一次
	* 一般只需要编写link，做一些事件绑定
	* link和compile同时存在的时候，link不生效
	
* 指令的源码分析

compile阶段：

	ng-app开始，递归子层dom结构，收集指令
	如果有需要，为指令生成childScope
	调用每个指令的compile函数生成compositelinkFn	编译的结果返回一个publicLinkFn函数
	编译完成之后立即调用生成的publicLinkFn
	
### $scope与双向数据绑定分析

## 移动app

开发app的方式：native app，web app，hybrid app

### native app优缺点

* 运行效率高
* 可调用各种设备资源

* 人力成本高
* 发布速度慢
* 更新版本问题
* 实现图文混排等功能有各种坑

### web app

	html,css3,js ==> 打包(phonegap, appcan, appcelarator, intel xdk) ==> .ipa, .apk, .xap

android打包过程

	npm安装phonegap ==> 下载adt ==> phonegap调用adt打包
	
ios打包

	npm安装phonegap ==> 升级ios和xcode ==> ios账号和配置 ==> phonegap调用xcode打包
	
常见web app框架

* jquery mobile(jquerymobile.com)
	
	优点：技术栈统一，学习成本低
	缺点：低端安装机存在性能问题
	
* sencha touch(zeptojs.com)

	优点：各项技术架构都很完善
	缺点：学习成本高，与ejs内核相同
	
* zepto.js

	优点：衍生自jquery，性能更好
	缺点：坑很多
	
* gmu(百度)

* ionic（内核是angularjs）

		
			



