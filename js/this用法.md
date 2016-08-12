title: this用法
date: 2016-08-12 14:36:00
tags:
- js
- this


# this 用法

由于其运行期绑定的特性，JavaScript 中的 this 含义要丰富得多，它可以是全局对象、当前对象或者任意对象，这**完全取决于函数的调用方式**。

JavaScript 中函数的调用有以下几种方式：

* 作为函数调用;
* 作为对象方法调用
* 作为构造函数调用
* 使用 apply 或 call 调用。

## 纯粹的函数调用

此时 this 绑定到全局对象

	function makeNoSense(x) { 
	    this.x = x; 
	} 
	makeNoSense(5); 
	console.log(x);// x 已经成为一个值为 5 的全局变量
	
## 作为对象方法的调用

这时this指代对象内部属性被调用。
	
	var myObject = {
	　　value :0,
	　　increment:function (inc){
	　　　　this.value += typeof inc ==='number' ? inc:1;
	　　}
	};
	myObject.increment();
	console.log(myObject.value);  //1
	myObject.increment(2);
	console.log(myObject.value);  //3	
	
## 作为构造函数调用

JavaScript 中的构造函数也很特殊，如果不使用 new 调用，则和普通函数一样。作为又一项约定俗成的准则，构造函数以大写字母开头，提醒调用者使用正确的方式调用。如果调用正确，this 绑定到新创建的对象上。

	var x = 4;
	function Point(x, y){ 
	    this.x = x; 
	    this.y = y; 
	 }
	var p1 = new Point(3,2);
	console.log(p1.x+","+p1.y);//3,2	
## apply或call调用

在 JavaScript 中函数也是对象，对象则有方法，apply 和 call 就是函数对象的方法。这两个方法异常强大，他们允许切换函数执行的上下文环境（context），即 this 绑定的对象

	function Point(x, y){ 
	    this.x = x; 
	    this.y = y; 
	    this.moveTo = function(x, y){ 
	        this.x = x; 
	        this.y = y; 
	        console.log(this.x+","+this.y);
	    } 
	} 
	var p1 = new Point(0, 0); 
	var p2 = {x: 0, y: 0}; 
	p1.moveTo(1, 1); //1,1
	p1.moveTo.apply(p2, [10, 10]);//10,10
	

## 参考

* [解析this在不同应用场景的作用](http://www.cnblogs.com/wdlhao/p/5764456.html)