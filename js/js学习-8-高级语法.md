title: js学习(8)-高级语法
date: 2016-04-16 10:34:05
tags:
- js

# js学习(8)-高级语法
---
没有系统学习过js，觉得基础太薄弱了，参考阮一峰老师的[JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)，希望可以提高自己js的基础。

# 9. 高级语法
------

# Promise


## 异步模式编程的几种方法

### 回调函数

回调函数是异步编程最基本的方法

回调函数的优点是简单、容易理解和部署，缺点是不利于代码的阅读和维护，各个部分之间高度耦合（Coupling），使得程序结构混乱、流程难以追踪（尤其是回调函数嵌套的情况），而且每个任务只能指定一个回调函数。

### 事件监听

另一种思路是采用事件驱动模式。任务的执行不取决于代码的顺序，而取决于某个事件是否发生。

这种方法的优点是比较容易理解，可以绑定多个事件，每个事件可以指定多个回调函数，而且可以”去耦合“（Decoupling），有利于实现模块化。缺点是整个程序都要变成事件驱动型，运行流程会变得很不清晰。

### 发布/订阅

“事件”完全可以理解成”信号”，如果存在一个”信号中心”，某个任务执行完成，就向信号中心”发布”（publish）一个信号，其他任务可以向信号中心”订阅”（subscribe）这个信号，从而知道什么时候自己可以开始执行。这就叫做”发布/订阅模式“（publish-subscribe pattern），又称”观察者模式“（observer pattern）。

## 异步操作的流程控制

如果有多个异步操作，就存在一个流程控制的问题：确定操作执行的顺序，以后如何保证遵守这种顺序。

如果有6个这样的异步任务，需要全部完成后，才能执行下一步的final函数。

### 串行执行

我们可以编写一个流程控制函数，让它来控制异步任务，一个任务完成以后，再执行另一个。这就叫串行执行。

	var items = [ 1, 2, 3, 4, 5, 6 ];
	var results = [];
	function series(item) {
	  if(item) {
	    async( item, function(result) {
	      results.push(result);
	      return series(items.shift());
	    });
	  } else {
	    return final(results);
	  }
	}
	series(items.shift());
	
上面代码中，函数series就是串行函数，它会依次执行异步任务，所有任务都完成后，才会执行final函数。`通过在回调函数中再次调用串行行数`。`items数组`保存每一个异步任务的参数，`results数组`保存每一个异步任务的运行结果。

### 并行执行

流程控制函数也可以是并行执行，即所有异步任务同时执行，等到全部完成以后，才执行final函数。

	var items = [ 1, 2, 3, 4, 5, 6 ];
	var results = [];
	
	items.forEach(function(item) {
	  async(item, function(result){
	    results.push(result);
	    if(results.length == items.length) {
	      final(results);
	    }
	  })
	});

上面代码中，forEach方法会同时发起6个异步任务，等到它们全部完成以后，才会执行final函数。`通过判断results的长度`

并行执行的好处是效率较高，比起串行执行一次只能执行一个任务，较为节约时间。但是问题在于如果并行的任务较多，很容易耗尽系统资源，拖慢运行速度。因此有了第三种流程控制方式。

## 并行与串行的结合

所谓并行与串行的结合，就是设置一个门槛，每次最多只能并行执行n个异步任务。这样就避免了过分占用系统资源。

	var items = [ 1, 2, 3, 4, 5, 6 ];
	var results = [];
	var running = 0;
	var limit = 2;
	
	function launcher() {
	  while(running < limit && items.length > 0) {
	    var item = items.shift();
	    async(item, function(result) {
	      results.push(result);
	      running--;
	      if(items.length > 0) {
	        launcher();
	      } else if(running == 0) {
	        final();
	      }
	    });
	    running++;
	  }
	}
	
	launcher();

上面代码中，最多只能同时运行两个异步任务。变量running记录当前正在运行的任务数，只要低于门槛值，就再启动一个新的任务，如果等于0，就表示所有任务都执行完了，这时就执行final函数。

## Promise对象

Promise对象是CommonJS工作组提出的一种规范，目的是为异步操作提供统一接口

### 什么是Promises？

首先，它是一个对象，也就是说与其他JavaScript对象的用法，没有什么两样；其次，它起到代理作用（proxy），充当异步操作与回调函数之间的中介。它使得异步操作具备同步操作的接口，使得程序具备正常的同步运行的流程，回调函数不必再一层层嵌套。

> 简单说，它的思想是，每一个异步任务立刻返回一个Promise对象，由于是立刻返回，所以可以采用同步操作的流程。这个Promises对象有一个then方法，允许指定回调函数，在异步任务完成后调用。


> 总的来说，传统的回调函数写法使得代码混成一团，变得横向发展而不是向下发展。Promises规范就是为了解决这个问题而提出的，目标是使用正常的程序流程（同步），来处理异步操作。它先返回一个Promise对象，后面的操作以同步的方式，寄存在这个对象上面。等到异步操作有了结果，再执行前期寄放在它上面的其他操作。


### Promise接口

前面说过，Promise接口的基本思想是，异步任务返回一个Promise对象。

Promise对象只有三种状态。

* 异步操作“未完成”（pending）
* 异步操作“已完成”（resolved，又称fulfilled）
* 异步操作“失败”（rejected）

这三种的状态的变化途径只有两种。

* 异步操作从“未完成”到“已完成”
* 异步操作从“未完成”到“失败”。

这种变化只能发生一次，一旦当前状态变为“已完成”或“失败”，就意味着不会再有新的状态变化了。因此，Promise对象的最终结果只有两种。

* 异步操作成功，Promise对象传回一个值，状态变为resolved。
* 异步操作失败，Promise对象抛出一个错误，状态变为
rejected。	

Promise对象使用then方法添加回调函数。then方法可以接受两个回调函数，第一个是异步操作成功时（变为resolved状态）时的回调函数，第二个是异步操作失败（变为rejected）时的回调函数（可以省略）。一旦状态改变，就调用相应的回调函数。

### Promise对象的生成

ES6提供了原生的Promise构造函数，用来生成Promise实例。

下面代码创造了一个Promise实例。

	var promise = new Promise(function(resolve, reject) {
	  // 异步操作的代码
	
	  if (/* 异步操作成功 */){
	    resolve(value);
	  } else {
	    reject(error);
	  }
	});

Promise构造函数接受一个函数作为参数，该函数的两个参数分别是`resolve`和`reject`。它们是两个函数，由JavaScript引擎提供，不用自己部署。

`resolve`函数的作用是，将Promise对象的状态从“未完成”变为“成功”（即从Pending变为Resolved），在异步操作成功时调用，并将异步操作的结果，作为参数传递出去；

reject函数的作用是，将Promise对象的状态从“未完成”变为“失败”（即从Pending变为Rejected），在异步操作失败时调用，并将异步操作报出的错误，作为参数传递出去。

Promise实例生成以后，可以用then方法分别指定Resolved状态和Reject状态的回调函数。

	po.then(function(value) {
	  // success
	}, function(value) {
	  // failure
	});

### 用法辨析

Promise的用法，简单说就是一句话：使用then方法添加回调函数。但是，不同的写法有一些细微的差别，请看下面四种写法，它们的差别在哪里？

	// 写法一
	doSomething().then(function () {
	  return doSomethingElse();
	});
	
	// 写法二
	doSomething().then(function () {
	  doSomethingElse();
	});
	
	// 写法三
	doSomething().then(doSomethingElse());
	
	// 写法四
	doSomething().then(doSomethingElse);

为了便于讲解，这四种写法都再用then方法接一个回调函数`finalHandler`。

写法一的finalHandler回调函数的参数，是doSomethingElse函数的运行结果。

	doSomething().then(function () {
	  return doSomethingElse();
	}).then(finalHandler);

写法二的finalHandler回调函数的参数是undefined。

	doSomething().then(function () {
	  doSomethingElse();
	  return;
	}).then(finalHandler);

写法三的finalHandler回调函数的参数，是doSomethingElse函数返回的回调函数的运行结果。

	doSomething().then(doSomethingElse())
	  .then(finalHandler);

写法四与写法一只有一个差别，那就是doSomethingElse会接收到doSomething()返回的结果。

	doSomething().then(doSomethingElse)
	  .then(finalHandler);

## Promise的应用

* 加载图片
* Ajax操作

### 小结

Promise对象的优点在于，让回调函数变成了规范的链式写法，程序流程可以看得很清楚。它的一整套接口，可以实现许多强大的功能，比如为多个异步操作部署一个回调函数、为多个回调函数中抛出的错误统一指定处理方法等等。

而且，它还有一个前面三种方法都没有的好处：如果一个任务已经完成，再添加回调函数，该回调函数会立即执行。所以，你不用担心是否错过了某个事件或信号。这种方法的缺点就是，编写和理解都相对比较难。








*learning when using*


## 相关链接

    


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)