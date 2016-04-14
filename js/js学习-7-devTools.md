title: js学习(7)-devTools
date: 2016-04-14 23:56:05
tags:
- js

# js学习(7)-devTools
---
没有系统学习过js，觉得基础太薄弱了，参考阮一峰老师的[JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)，希望可以提高自己js的基础。

# 8. 开发工具
------

# console对象

`console`对象是`JavaScript`的原生对象，它有点像Unix系统的标准输出stdout和标准错误stderr，可以输出各种信息用来调试程序，而且还提供了很多额外的方法，供开发者调用。它的常见用途有两个。

* 显示网页代码运行时的错误信息。
* 提供了一个命令行接口，用来与网页代码互动。


# Gulp：任务自动管理工具

Gulp与Grunt一样，也是一个自动任务运行器。它充分借鉴了Unix操作系统的管道（pipe）思想，很多人认为，在操作上，它要比Grunt简单。

## 安装

Gulp需要全局安装，然后再在项目的开发目录中安装为本地模块。

	npm install -g gulp
	npm install --save-dev gulp

除了安装gulp以外，不同的任务还需要安装不同的gulp插件模块。比如：

	npm install --save-dev gulp-uglify

## gulpfile.js

项目根目录中的gulpfile.js，是Gulp的配置文件。

	var gulp = require('gulp');
	var uglify = require('gulp-uglify');
	
	gulp.task('minify', function () {
	 gulp.src('js/app.js')
	   .pipe(uglify())
	   .pipe(gulp.dest('build'))
	});

上面代码中，gulpfile.js加载gulp和gulp-uglify模块之后，使用gulp模块的task方法指定任务minify。task方法有两个参数，第一个是任务名，第二个是任务函数。在任务函数中，使用gulp模块的src方法，指定所要处理的文件，然后使用pipe方法，将上一步的输出转为当前的输入，进行链式处理。

task方法的回调函数使用了两次pipe方法，也就是说做了两种处理。第一种处理是使用gulp-uglify模块，压缩源码；第二种处理是使用gulp模块的dest方法，将上一步的输出写入本地文件，这里是build.js（代码中省略了后缀名js）。

执行minify任务时，就在项目目录中执行下面命令就可以了。

	$ gulp minify

从上面的例子中可以看到，gulp充分使用了“管道”思想，就是一个数据流（stream）：src方法读入文件产生数据流，dest方法将数据流写入文件，中间是一些中间步骤，每一步都对数据流进行一些处理。

## gulp模块的方法

### src()

gulp模块的src方法，用于产生数据流。它的参数表示所要处理的文件，这些指定的文件会转换成数据流。参数的写法一般有以下几种形式。

* `js/app.js`：指定确切的文件名。
* `js/*.js`：某个目录所有后缀名为js的文件。
* `js/**/*.js`：某个目录及其所有子目录中的所有后缀名为js的文件。
* `!js/app.js`：除了js/app.js以外的所有文件。
* `*.+(js | css)`：匹配项目根目录下，所有后缀名为js或css的文件。

src方法的参数还可以是一个数组，用来指定多个成员。

### dest()

dest方法将管道的输出写入文件，同时将这些输出继续输出，所以可以依次调用多次dest方法，将输出写入多个目录。如果有目录不存在，将会被新建。

dest方法还可以接受第二个参数，表示配置对象。

### task()

task方法用于定义具体的任务。它的第一个参数是任务名，第二个参数是任务函数。

task方法还可以指定按顺序运行的一组任务。

	gulp.task('build', ['css', 'js', 'imgs']);

上面代码先指定build任务，它由css、js、imgs三个任务所组成，task方法会并发执行这三个任务。注意，由于每个任务都是异步调用，所以没有办法保证js任务的开始运行的时间，正是css任务运行结束。

如果希望各个任务严格按次序运行，可以把前一个任务写成后一个任务的依赖模块

	gulp.task('css', ['greet'], function () {
	   // Deal with CSS here
	});

如果一个任务的名字为default，就表明它是“默认任务”，在命令行直接输入gulp命令，就会运行该任务。


	gulp.task('default', function () {
	  // Your default task
	});
	
	// 或者
	
	gulp.task('default', ['styles', 'jshint', 'watch']);

执行的时候，直接使用gulp，就会运行styles、jshint、watch三个任务。

### watch()

watch方法用于指定需要监视的文件。一旦这些文件发生变动，就运行指定任务。

	gulp.task('watch', function () {
	   gulp.watch('templates/*.tmpl.html', ['build']);
	});

上面代码指定，一旦templates目录中的模板文件发生变化，就运行build任务。

watch方法也可以用回调函数，代替指定的任务。

另一种写法是watch方法所监控的文件发生变化时（修改、增加、删除文件），会触发change事件。可以对change事件指定回调函数。

## gulp-load-plugins模块

一般情况下，gulpfile.js中的模块需要一个个加载。

	var gulp = require('gulp'),
	    jshint = require('gulp-jshint'),
	    uglify = require('gulp-uglify'),
	    concat = require('gulp-concat');
	
	gulp.task('js', function () {
	   return gulp.src('js/*.js')
	      .pipe(jshint())
	      .pipe(jshint.reporter('default'))
	      .pipe(uglify())
	      .pipe(concat('app.js'))
	      .pipe(gulp.dest('build'));
	});


这种一一加载的写法，比较麻烦。使用gulp-load-plugins模块，可以加载package.json文件中所有的gulp模块。

	var gulp = require('gulp'),
	    gulpLoadPlugins = require('gulp-load-plugins'),
	    plugins = gulpLoadPlugins();
	
	gulp.task('js', function () {
	   return gulp.src('js/*.js')
	      .pipe(plugins.jshint())
	      .pipe(plugins.jshint.reporter('default'))
	      .pipe(plugins.uglify())
	      .pipe(plugins.concat('app.js'))
	      .pipe(gulp.dest('build'));
	});


## gulp-livereload模块

gulp-livereload模块用于自动刷新浏览器，反映出源码的最新变化。它除了模块以外，还需要在浏览器中安装插件，用来配合源码变化。

	var gulp = require('gulp'),
	    less = require('gulp-less'),
	    livereload = require('gulp-livereload'),
	    watch = require('gulp-watch');
	
	gulp.task('less', function() {
	   gulp.src('less/*.less')
	      .pipe(watch())
	      .pipe(less())
	      .pipe(gulp.dest('css'))
	      .pipe(livereload());
	});

上面代码监视less文件，一旦编译完成，就自动刷新浏览器。

# Browserify：浏览器加载Node.js模块

随着JavaScript程序逐渐模块化，在ECMAScript 6推出官方的模块处理方案之前，有两种方案在实践中广泛采用：一种是AMD模块规范，针对模块的异步加载，主要用于浏览器端；另一种是CommonJS规范，针对模块的同步加载，主要用于服务器端，即node.js环境。

Browserify是一个node.js模块，主要用于改写现有的CommonJS模块，使得浏览器端也可以使用这些模块。使用下面的命令，在全局环境下安装Browserify。

	$ npm install -g browserify
	
## 基本用法

先看一个例子。假定有一个很简单的CommonJS模块文件foo.js。

	// foo.js
	
	module.exports = function(x) {
	  console.log(x);
	};

然后，还有一个main.js文件，用来加载foo模块。

	// main.js
	
	var foo = require("./foo");
	foo("Hi");

使用Browserify，将main.js转化为浏览器可以加载的脚本compiled.js。

	browserify main.js > compiled.js
	
	# 或者
	browserify main > compiled.js
	
	# 或者
	browserify main.js -o compiled.js

之所以转化后的文件叫做compiled.js，是因为该文件不仅包括了main.js，还包括了它所依赖的foo.js。两者打包在一起，保证浏览器加载时的依赖关系。

	<script src="compiled.js"></script>

使用上面的命令，在浏览器中运行compiled.js，控制台会显示Hi。	

## 管理前端模块

Browserify的主要作用是将CommonJS模块转为浏览器可以调用的格式，但是纯粹的前端模块，也可以用它打包。

## 生成前端模块

有时，我们只是希望将node.js的模块，移植到浏览器，使得浏览器端可以调用。这时，可以采用browserify的-r参数（–require的简写）

	browserify -r through -r ./my-file.js:my-module > bundle.js

上面代码将through和my-file.js（后面的冒号表示指定模块名为my-module）都做成了模块，可以在其他script标签中调用。

	<script src="bundle.js"></script>
	<script>
	  var through = require('through');
	  var myModule = require('my-module');
	  /* ... */
	</script>

可以看到，-r参数的另一个作用，就是为浏览器端提供require方法。

## 脚本文件的实时生成

Browserify还可以实时生成脚本文件。

	var browserify = require('browserify');
	var http = require('http');
	
	http.createServer(function (req, res) {
	  if (req.url === '/bundle.js') {
	    res.setHeader('content-type', 'application/javascript');
	    var b = browserify(__dirname + '/main.js').bundle();
	    b.on('error', console.error);
	    b.pipe(res);
	  }
	  else res.writeHead(404, 'not found')
	});

## browserify-middleware模块

上面是将服务器端模块直接转为客户端脚本，然后在网页中调用这个转化后的脚本文件。还有一种思路是，在运行时动态转换模块，这就需要用到browserify-middleware模块

如，网页中需要加载app.js，它是从main.js转化过来的。

	<!-- index.html -->

	<script src="app.js"></script>

你可以在服务器端静态生成一个app.js文件，也可以让它动态生成。这就需要用browserify-middleware模块，服务器端脚本要像下面这样写。

	var browserify = require('browserify-middleware');
	var express = require('express');
	var app = express();
	
	app.get('/app.js', browserify('./client/main.js'));
	
	app.get('/', function(req, res){
	  res.render('index.html');
	});
	
# Source Map

随着JavaScript脚本变得越来越复杂，大部分源码（尤其是各种函数库和框架）都要经过转换，才能投入生产环境。

常见的源码转换，主要是以下三种情况：

* 压缩，减小体积。比如jQuery 1.9的源码，压缩前是252KB，压缩后是32KB。
* 多个文件合并，减少HTTP请求数。
* 其他语言编译成JavaScript。最常见的例子就是CoffeeScript。

这三种情况，都使得实际运行的代码不同于开发代码，除错（debug）变得困难重重。

这就是Source map想要解决的问题。

> 简单说，Source map就是一个信息文件，里面储存着位置信息。也就是说，转换后的代码的每一个位置，所对应的转换前的位置。

有了它，出错的时候，除错工具将直接显示原始代码，而不是转换后的代码。这无疑给开发者带来了很大方便。

目前，暂时只有Chrome浏览器支持这个功能。在Developer Tools的Setting设置中，确认选中”Enable source maps”。


## 生成和启用

生成Source Map的最常用方法，是使用Google的`Closure`编译器

生成命令的格式如下：

	java -jar compiler.jar \ 
	　　--js script.js \
	　　--create_source_map ./script-min.js.map \
	　　--source_map_format=V3 \
	　　--js_output_file script-min.js

各个参数的意义如下：

* js： 转换前的代码文件
* create_source_map： 生成的source map文件
* source_map_format：source map的版本，目前一律采用V3。
* js_output_file： 转换后的代码文件。

启用Source map的方法很简单，只要在转换后的代码头部或尾部，加上一行就可以了。

	//# sourceMappingURL=/path/to/file.js.map

或者

	/*# sourceMappingURL=/path/to/file.js.map */

map文件可以放在网络上，也可以放在本地文件系统。	
格式
打开Source map文件，它大概是这个样子：

	　　{
	　　　　version : 3,
	　　　　file: "out.js",
	　　　　sourceRoot : "",
	　　　　sources: ["foo.js", "bar.js"],
	　　　　names: ["src", "maps", "are", "fun"],
	　　　　mappings: "AAgBC,SAAQ,CAAEA"
	　　}

整个文件就是一个JavaScript对象，可以被解释器读取。它主要有以下几个属性：

* version：Source map的版本，目前为3。
* file：转换后的文件名。
* sourceRoot：转换前的文件所在的目录。如果与转换前的文件在同一目录，该项为空。
* sources：转换前的文件。该项是一个数组，表示可能存在多个文件合并。
* names：转换前的所有变量名和属性名。
* mappings：记录位置信息的字符串。	


## mappings属性

转换前后的代码一一对应的关键，就是map文件的mappings属性。这是一个很长的字符串，它分成三层。

第一层是行对应，以分号（;）表示，每个分号对应转换后源码的一行。所以，第一个分号前的内容，就对应源码的第一行，以此类推。

第二层是位置对应，以逗号（,）表示，每个逗号对应转换后源码的一个位置。所以，第一个逗号前的内容，就对应该行源码的第一个位置，以此类推。

第三层是位置转换，以VLQ编码表示，代表该位置对应的转换前的源码位置。

举例来说，假定mappings属性的内容如下：

	mappings:"AAAAA,BBBBB;CCCCC"

它表示，转换后的源码分成两行，第一行有两个位置，第二行有一个位置。

每个位置使用五位，表示五个字段。(VLQ编码)



## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)