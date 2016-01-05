#AngularJS入门

四大核心特性：

* MVC
* 模块化
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

			
