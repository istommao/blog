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

## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)