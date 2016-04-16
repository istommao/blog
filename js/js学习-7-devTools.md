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


# JavaScript 程序测试

## 测试的类型

### 单元测试

> 单元测试（unit testing）指的是以软件的单元（unit）为单位，对软件进行测试。单元可以是一个函数，也可以是一个模块或组件。它的基本特征就是，只要输入不变，必定返回同样的输出。

“单元测试”这个词，本身就暗示，软件应该以模块化结构存在。每个模块的运作，是独立于其他模块的。一个软件越容易写单元测试，往往暗示着它的模块化结构越好，各模块之间的耦合就越弱；越难写单元测试，或者每次单元测试，不得不模拟大量的外部条件，很可能暗示软件的模块化结构越差，模块之间存在较强的耦合。

单元测试的要求是，每个模块都必须有单元测试，而软件由模块组成。

单元测试通常采取断言（assertion）的形式，也就是测试某个功能的返回结果，是否与预期结果一致。如果与预期不一致，就表示测试失败。

单元测试应该避免依赖性问题，比如不存取数据库、不访问网络等等，而是使用工具虚拟出运行环境。这种虚拟使得测试成本最小化，不用花大力气搭建各种测试环境。

一般来说，单元测试的步骤如下。

* 准备所有的测试条件
* 调用（触发）所要测试的函数
* 验证运行结果是否正确
* 还原被修改的记录

## 其他测试类型

### 集成测试

> 集成测试（Integration test）指的是多个部分在一起测试，比如测试一个数据库连接模块，是否能够连接数据库。

### 功能测试

> 功能测试（Functional test）指的是，自动测试整个应用程序的某个功能，比如使用Selenium工具自动打开浏览器运行程序。

### 端对端测试

> 端对端测试（End-to-End testing）指的是全链路测试，即从开始端到终止端的测试，比如测试从用户界面、通过网络、经过应用程序处理、到达数据库，是否能够返回正确结果。端对端测试的目的是，确保整个系统能够正常运行，各个子系统之间依赖关系正常，数据能够在子系统之间、模块之间正确传递。

### 冒烟测试

冒烟测试（smoke testing）指的是，正式的全面测试开始之前，对主要功能进行的预测试。它的主要目的是，确认主要功能能否满足需要，软件是否能运行。冒烟测试可以是手工测试，也可以是自动化测试。

这个名字最早来自对电子元件的测试，第一次对电子元件通电，看看它是否会冒烟。如果没有冒烟，说明通过了测试；如果电流达到某个临界点之后，才出现冒烟，这时可以评估是否能够接受这个临界点。

## 开发模式

测试不仅能够验证软件功能、保证代码质量，也能够影响软件开发的模式。

### TDD

TDD是“测试驱动的开发”（Test-Driven Development）的简称，指的是先写好测试，然后再根据测试完成开发。使用这种开发方式，会有很高的测试覆盖率。

TDD的开发步骤如下。

* 先写一个测试。
* 写出最小数量的代码，使其能够通过测试。
* 优化代码。
* 重复前面三步。

TDD接口提供以下四个方法。

* suite()
* test()
* setup()
* teardown()

下面代码是测试计数器是否加1。

	suite('Counter', function() {
	  test('tick increases count to 1', function() {
	    var counter = new Counter();
	    counter.tick();
	    assert.equal(counter.count, 1);
	  });
	});



### BDD

BDD是“行为驱动的开发”（Behavior-Driven Development）的简称，指的是写出优秀测试的最佳实践的总称。

BDD认为，不应该针对代码的实现细节写测试，而是要针对行为写测试。BDD测试的是行为，即软件应该怎样运行。

BDD接口提供以下六个方法。

* describe()
* it()
* before()
* after()
* beforeEach()
* afterEach()

下面是测试计数器是否加1的BDD写法。

	describe('Counter', function() {
	  it('should increase count by 1 after calling tick', function() {
	    var counter = new Counter();
	    var expectedCount = counter.count + 1;
	    counter.tick();
	    assert.equal(counter.count, expectedCount);
	  });
	});

### BDD术语

#### 测试套件

测试套件（test suite）指的是，一组针对软件规格的某个方面的测试用例。也可以看作，对软件的某个方面的描述（describe）。

测试套件由一个`describe`函数构成，它接受两个参数：第一个参数是字符串，表示测试套件的名字或标题，表示将要测试什么；第二个参数是函数，用来实现这个测试套件。

	describe("A suite", function() {
	  // ...
	});

#### 测试用例

测试用例（test case）指的是，针对软件一个功能点的测试，是软件测试的最基本单位。一组相关的测试用例，构成一个测试套件。测试用例由`it`函数构成，它与describe函数一样，接受两个参数：第一个参数是字符串，表示测试用例的标题；第二个参数是函数，用来实现这个测试用例。

	describe("A suite", function() {
	  it("contains spec with an expectation", function() {
	    // ...
	  });
	});

#### 断言

断言（assert）指的是对代码行为的预期。一个测试用例内部，包含一个或多个断言（assert）。

断言会返回一个布尔值，表示代码行为是否符合预期。测试用例之中，只要有一个断言为false，这个测试用例就会失败，只有所有断言都为true，测试用例才会通过。

	describe("A suite", function() {
	  it("contains spec with an expectation", function() {
	    expect(true).toBe(true);
	  });
	});

## 断言
断言是判断实际值与预期值是否相等的工具。

断言有assert、expext、should三种风格，或者称为三种写法。

	// assert风格
	assert.equal(event.detail.item, '(item)‘);
	
	// expect风格
	expect(event.detail.item).to.equal('(item)');
	
	// should风格
	event.detail.item.should.equal('(item)');

`Chai.js`是一个很流行的断言库，同时支持上面三种风格。


## Mocha.js


### 概述

Mocha（发音“摩卡”）是现在最流行的前端测试框架之一，此外常用的测试框架还有Jasmine、Tape、zuul等。所谓“测试框架”，就是运行测试的工具。

Mocha使用下面的命令安装。

	# 全局安装
	$ npm install -g mocha chai
	
	# 项目内安装
	$ npm i -D mocha chai

上面代码中，除了安装`Mocha`以外，还安装了断言库`chai`，这是因为Mocha自身不带断言库，必须安装外部断言库。

测试套件文件一般放在`test`子目录下面，配置文件`mocha.opts`也放在这个目录里面。

### 浏览器测试

使用浏览器测试时，先用mocha init命令在指定目录生成初始化文件。

	$ mocha init <path>

运行上面命令，就会在该目录下生成一个`index.html`文件，以及配套的脚本和样式表。

然后在该文件中，加入你要测试的文件（比如app.js）、测试脚本（app.spec.js）和断言库（chai.js）。

	<script src="app.js"></script>
	<script src="http://chaijs.com/chai.js"></script>
	<script src="app.spec.js"></script>


各个文件的内容如下。

	// app.js
	function add(x, y){
	  return x + y;
	}
	
	// app.spec.js
	var expect = chai.expect;
	
	describe('测试add函数', function () {
	  it('1加1应该等于2', function () {
	    expect(add(1, 1)).to.equal(2);
	  });
	});


### 命令行测试
Mocha除了在浏览器运行，还可以在命令行运行。

还是使用上面的文件，作为例子，但是要改成CommonJS格式。

	// app.js
	function add(x, y){
	  return x + y;
	}
	
	module.exports = add;
	
	// app.spec.js
	var expect = require('chai').expect;
	var add = require('../app');
	
	describe('测试add函数', function () {
	  it('1加1应该等于2', function () {
	    expect(add(1, 1)).to.equal(2);
	  });
	});
	
然后，在命令行下执行mocha，就会执行测试。

	$ mocha

上面的命令等同于下面的形式。

	$ mocha test --reporter spec --recursive --growl

### mocha.opts
所有Mocha的命令行参数，都可以写在test目录下的配置文件mocha.opts之中。

下面是一个典型的配置文件。

	--reporter spec
	--recursive
	--growl

上面三个设置的含义如下。

* 使用spec报告模板
* 包括子目录
* 打开桌面通知插件growl


### 生成规格文件
Mocha支持从测试用例生成规格文件。

	$ mocha test/app.spec.js -R markdown > spec.md

上面命令生成单个app.spec.js规格。

生成HTML格式的报告，使用下面的命令。

	$ mocha test/app.spec.js -R doc > spec.html
	
如果要生成整个test目录，对应的规格文件，使用下面的命令。

	$ mocha test -R markdown > spec.md --recursive

只要提供测试脚本的路径，Mocha就可以运行这个测试脚本。

	$ mocha -w src/index.test.js

上面命令运行测试脚本src/index.test.js，参数-w表示watch，即当这个脚本一有变动，就会运行。

指定测试脚本时，可以使用通配符，同时指定多个文件。

	$ mocha --reporter spec spec/{my,awesome}.js
	$ mocha --ui tdd test/unit/*.js etc

上面代码中，参数--reporter指定生成的报告格式（上面代码是spec格式），-ui指定采用哪一种测试模式（上面代码是tdd模式）。

除了使用shell通配符，还可以使用node通配符。

	$ mocha --compilers js:babel-core/register 'test/**/*.@(js|jsx)'

上面代码指定运行test目录下面任何子目录中，文件后缀名为js或jsx的测试脚本。注意，Node的通配符要放在单引号之中，因为否则星号（`*`）会先被shell解释。

如果要改用shell通配符，执行test目录下面任何子目录的测试脚本，要写成下面这样。

	$ mocha test/**.js

* `--recursive`参数可以指定运行子目录之中的测试脚本
* `--grep`参数用于搜索测试用例的名称（即it方法的第一个参数），然后只执行匹配的测试用例
* `--invert`参数表示只运行不符合条件的测试脚本
* 如果测试脚本用到了ES6语法，还需要用`--compiler`参数指定babel进行转码
* `--require`参数指定测试脚本默认包含的文件

### 测试脚本的写法

如果测试用例包含异步操作，可以done方法显式指定测试用例的运行结束时间

## Promise的测试

对于异步的测试，测试用例之中，通常必须调用done方法，显式表明异步操作的结束。

	var expect = require('chai').expect;
	
	it('should do something with promises', function(done) {
	  var result = asyncTest();
	
	  result.then(function(data) {
	    expect(data).to.equal('foobar');
	    done();
	  }, function(error) {
	    assert.fail(error);
	    done();
	  });
	});

上面代码之中，Promise对象的`then`方法之中，必须指定reject时的回调函数，并且使用`assert.fail`方法抛出错误，否则这个错误就不会被外界感知。

使用Mocha时，Promise的测试可以简化成下面的写法。

	var expect = require('chai').expect;
	
	it('should do something with promises', function() {
	  var result = asyncTest();
	
	  return result.then(function(data) {
	    expect(data).to.equal('foobar');
	  });
	});

## 模拟数据

单元测试时，很多时候，测试的代码会请求HTTP服务器。这时，我们就需要模拟服务器的回应，不能在单元测试时去请求真实服务器数据，否则就不叫单元测试了，而是连同服务器一起测试了。

一些工具库可以模拟服务器回应。

* nock
* sinon
* faux-jax
* MITM

## 覆盖率

测试的覆盖率需要安装istanbul模块。

	$ npm i -D istanbul

然后，在package.json设置运行覆盖率检查的命令。

	"scripts": {
	  "test:cover": "istanbul cover -x *.test.js _mocha -- -R spec src/index.test.js",
	  "check-coverage": "istanbul check-coverage --statements 100 --branches 100 --functions 100 --lines 100"
	}

上面代码中，`test:cover`是生成覆盖率报告，`check-coverage`是设置覆盖率通过的门槛。

然后，将`coverage`目录写入`.gitignore`防止连这个目录一起提交。

如果希望在git commit提交之前，先运行一次测试，可以安装`ghooks`模块，配置pre-commit钩子。

安装ghooks。

	$ npm i -D ghooks

在package.json之中，配置pre-commit钩子。

	"config": {
	  "ghooks": {
	    "pre-commit": "npm run test:cover && npm run check-coverage"
	  }
	}

还可以把覆盖率检查，加入`.travis.yml`文件。

	script:
	  - npm run test:cover
	  - npm run check-coverage

如果测试脚本使用ES6，scripts字段还需要加入Babel转码。

	"scripts": {
	  "test": "mocha src/index.test.js -w --compilers js:babel/register",
	  "test:cover": "istanbul cover -x *.test.js _mocha -- -R spec src/index.test.js --compilers js:babel/register"
	}

覆盖率报告可以上传到`codecov.io`。先安装这个模块。

	$ npm i -D codecov.io

然后在package.json增加一个字段。

	"scripts": {
	  "report-coverage": "cat ./coverage/lcov.info | codecov"
	}

最后，在CI的配置文件`.travis.yml`之中，增加运行这个命令。

	after_success:
	  - npm run report-coverage
	  - npm run semantic-release

## WebDriver

WebDriver是一个浏览器的自动化框架。它在各种浏览器的基础上，提供一个统一接口，将接收到的指令转为浏览器的原生指令，驱动浏览器。

WebDriver由Selenium项目演变而来。Selenium是一个测试自动化框架，它的1.0版叫做Selenium RC，通过一个代理服务器，将测试脚本转为JavaScript脚本，注入不同的浏览器，再由浏览器执行这些脚本后返回结果。WebDriver就是Selenium 2.0，它对每个浏览器提供一个驱动，测试脚本通过驱动转换为浏览器原生命令，在浏览器中执行。

*learning when using*


## 相关链接

* [js学习-1-基本语法](js学习-1-基本语法.md)
* [js学习-2-标准库](js学习-2-标准库.md)
* [js学习-3-面向对象编程](js学习-3-面向对象编程.md)
* [js学习-4-DOM](js学习-4-DOM.md)
* [js学习-5-BOM](js学习-5-BOM.md)
* [js学习-6-HTML_API](js学习-6-HTML_API.md)
* [js学习-7-devTools](js学习-7-devTools.md)
* [js学习-8-高级语法](js学习-8-高级语法.md)    


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)