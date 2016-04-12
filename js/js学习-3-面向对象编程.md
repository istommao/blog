title: js学习(3)-面向对象编程
date: 2016-04-12 00:05:05
tags:
- js

# js学习(3)-面向对象编程
---
没有系统学习过js，觉得基础太薄弱了，参考阮一峰老师的[JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)，希望可以提高自己js的基础。

# 4. 面向对象编程
------

# Object对象

## 概述

## 构造函数

JavaScript语言使用构造函数（constructor）作为对象的模板。所谓“构造函数”，就是专门用来生成“对象”的函数。它提供模板，描述对象的基本结构。一个构造函数，可以生成多个对象，这些对象都有相同的结构。

构造函数是一个正常的函数，但是它的特征和用法与普通函数不一样。

构造函数的特点有两个。

* 函数体内部使用了`this`关键字，代表了所要生成的对象实例。
* 生成对象的时候，必需用new命令，调用构造函数。


## new命令

`new`命令的作用，就是执行构造函数，返回一个实例对象

	var Vehicle = function (){
	  this.price = 1000;
	};
	
	var v = new Vehicle();
	v.price // 1000

* `new`命令本身就可以执行构造函数，所以后面的构造函数可以带括号，也可以不带括号
* 如果忘了使用new命令，构造函数就变成了普通函数，并不会生成实例对象。而且由于下面会说到的原因，this这时代表全局对象，将造成一些意想不到的结果。
* 为了保证构造函数必须与new命令一起使用，一个解决办法是，在构造函数内部使用严格模式，即第一行加上`use strict`
* 另一个解决办法，是在构造函数内部判断是否使用new命令，如果发现没有使用，则直接返回一个实例对象

### new命令的原理

> 内部的流程是，先创造一个空对象，作为上下文对象，赋值给函数内部的this关键字。也就是说，this指的是一个新生成的空对象，所有针对this的操作，都会发生在这个空对象上。

构造函数之所以叫“构造函数”，就是说这个函数的目的，就是*操作上下文对象*（即this对象），将其“构造”为需要的样子。

* 如果构造函数的return语句返回的是对象，new命令会返回return语句指定的对象；否则，就会不管return语句，返回构造后的上下文对象。
* 如果return语句返回的是一个跟this无关的新对象，new命令会返回这个新对象，而不是this对象。这一点需要特别引起注意

new命令简化的内部流程，可以用下面的代码表示:

	function _new(/* constructor, param, ... */) {
	  var args = [].slice.call(arguments);
	  var constructor = args.shift();
	  var context = Object.create(constructor.prototype);
	  var result = constructor.apply(context, args);
	  return (typeof result === 'object' && result != null) ? result : context;
	}
	
	var actor = _new(Person, "张三", 28);


## instanceof运算符

instanceof运算符用来确定一个对象是否为某个构造函数的实例

* instanceof运算符的左边放置对象，右边放置构造函数
* 需要注意的是，由于原始类型的值不是对象，所以不能使用instanceof运算符判断类型
* 如果存在继承关系，也就是某个对象可能是多个构造函数的实例，那么instanceof运算符对这些构造函数都返回true

## this关键字

* this就是指当前对象，或者说，指函数当前的运行环境
* 在JavaScript语言之中，所有函数都是在某个运行环境之中运行，this就是这个环境。对于JavaScipt语言来说，一切皆对象，运行环境也是对象，所以可以理解成，所有函数总是在某个对象之中运行，this就指向这个对象
* 但是JavaScript支持运行环境动态切换，也就是说，this的指向是动态的，没有办法事先确定到底指向哪个对象，这才是最让初学者感到困惑的地方
* 所谓“运行环境”就是对象，this指函数运行时所在的那个对象。如果一个函数在全局环境中运行，this就是指顶层对象（浏览器中为window对象）；如果一个函数作为某个对象的方法运行，this就是指那个对象。
* 可以近似地认为，this是所有函数运行时的一个隐藏参数，决定了函数的运行环境


### 使用场合

* 全局环境：在全局环境使用this，它指的就是顶层对象window
* 构造函数：构造函数中的this，指的是实例对象
* 对象的方法：当a对象的方法被赋予b对象，该方法就变成了普通函数，其中的this就从指向a对象变成了指向b对象。这就是this取决于运行时所在的对象的含义，所以要特别小心。如果将某个对象的方法赋值给另一个对象，会改变this的指向

		var o1 = new Object();
		o1.m = 1;
		o1.f = function (){ console.log(this.m);};
		
		o1.f() // 1
		
		var o2 = new Object();
		o2.m = 2;
		o2.f = o1.f
		
		o2.f() // 2	

	有时，某个方法位于多层对象的内部，这时如果为了简化书写，把该方法赋值给一个变量，往往会得到意想不到的结果
	
		var a = {
		  b : {
		    m : function() {
		      console.log(this.p);
		    },
		    p : 'Hello'
		  }
		};
		
		var hello = a.b.m;
		hello() // undefined

	为了避免这个问题，可以只将m所在的对象赋值给hello，这样调用时，this的指向就不会变。

		var hello = a.b;
		hello.m() // Hello

* Node.js

	在Node.js中，`this`的指向又分成两种情况。全局环境中，`this`指向全局对象`global`；模块环境中，`this`指向`module.exports`
	
### 使用注意点

* 避免多层this

	由于this的指向是不确定的，所以切勿在函数中包含多层的this
	
		var o = {
		  f1: function() {
		    console.log(this); 
		    var f2 = function() {
		      console.log(this);
		    }();
		  }
		}
		
		o.f1()
		// Object
		// Window	
		
	上面代码包含两层this，结果运行后，第一层指向该对象，第二层指向全局对象。一个解决方法是在第二层改用一个指向外层this的变量。
	
		var o = {
		  f1: function() {
		    console.log(this); 
		    var that = this;
		    var f2 = function() {
		      console.log(that);
		    }();
		  }
		}
		
		o.f1()
		// Object
		// Object			
	
	上面代码定义了变量`that`，固定指向外层的this，然后在内层使用that，就不会发生this指向的改变

* 避免数组处理方法中的this

	数组的map和foreach方法，允许提供一个函数作为参数。这个函数内部不应该使用this
	
	解决这个问题的一种方法，是使用中间变量`that`
	
	另一种方法是将`this`当作foreach方法的第二个参数，固定它的运行环境
	
* 避免回调函数中的this

	回调函数中的this往往会改变指向，最好避免使用
	
## 固定this的方法

`this`的动态切换，固然为JavaScript创造了巨大的灵活性，但也使得编程变得困难和模糊。有时，需要把`this`固定下来，避免出现意想不到的情况。JavaScript提供了`call`、`apply`、`bind`这三个方法，来切换/固定`this`的指向。	
### call方法

函数的`call`方法，可以指定该函数内部`this`的指向（即函数执行时所在的作用域），然后在所指定的作用域中，调用该函数。
		
call方法的完整使用格式如下。

	func.call(thisValue, arg1, arg2, ...)

它的第一个参数就是this所要指向的那个对象，后面的参数则是函数调用时所需的参数

	var n = 123;
	var o = { n : 456 };
	
	function a() {
	  console.log(this.n);
	}
	
	a.call() // 123
	a.call(null) // 123
	a.call(undefined) // 123
	a.call(window) // 123
	a.call(o) // 456

call方法的一个应用是调用对象的原生方法
	
	var obj = {};
	obj.hasOwnProperty('toString') // false
	
	obj.hasOwnProperty = function (){
	  return true;
	};
	obj.hasOwnProperty('toString') // true
	
	Object.prototype.hasOwnProperty.call(obj, 'toString') // false


### apply方法

apply方法的作用与call方法类似，也是改变this指向，然后再调用该函数。唯一的区别就是，它接收一个数组作为函数执行时的参数，使用格式如下。

	func.apply(thisValue, [arg1, arg2, ...])

apply方法的第一个参数也是this所要指向的那个对象，如果设为null或undefined，则等同于指定全局对象。第二个参数则是一个数组，该数组的所有成员依次作为参数，传入原函数。原函数的参数，在call方法中必须一个个添加，但是在apply方法中，必须以数组形式添加

接受一个数组作为参数，利用这一点，可以做一些有趣的应用。

* 找出数组最大元素

		var a = [10, 2, 4, 15, 9];
		
		Math.max.apply(null, a)
		// 15	

* 将数组的空元素变为undefined

		Array.apply(null, ["a",,"b"])
		
* 转换类似数组的对象

	利用数组对象的slice方法，可以将一个类似数组的对象（比如arguments对象）转为真正的数组
	
		Array.prototype.slice.apply({0:1,length:1})
		// [1]
		
		Array.prototype.slice.apply({0:1})
		// []
		
		Array.prototype.slice.apply({0:1,length:2})
		// [1, undefined]
		
		Array.prototype.slice.apply({length:1})
		// [undefined]		
	
* 绑定回调函数的对象

		var o = new Object();
		
		o.f = function (){
		  console.log(this === o);
		}
		
		var f = function (){
		  o.f.apply(o);
		  // 或者 o.f.call(o);
		};
		
		$("#button").on("click", f);

	由于apply方法（或者call方法）不仅绑定函数执行时所在的对象，还会立即执行函数，因此不得不把绑定语句写在一个函数体内。更简洁的写法是采用下面介绍的bind方法。
	
### bind方法

`bind`方法用于将函数体内的`this`绑定到某个对象，然后返回一个新函数。它的使用格式如下。

	func.bind(thisValue, arg1, arg2,...)
	
**e.g.**
	
	var o1 = new Object();
	o1.p = 123;
	o1.m = function (){
	  console.log(this.p);
	};
	
	o1.m() // 123 
	
	var o2 = new Object();
	o2.p = 456;
	o2.m = o1.m;
	
	o2.m() // 456
	
	o2.m = o1.m.bind(o1);
	o2.m() // 123	
	
`bind`比`call`方法和`apply`方法更进一步的是，除了绑定this以外，还可以绑定原函数的参数		

	var add = function (x,y) {
	  return x*this.m + y*this.n;
	}
	
	var obj = {
	  m: 2,
	  n: 2
	};
	
	var newAdd = add.bind(obj, 5);  // 绑定x为5
	
	newAdd(5) // 新函数运行时，只需指定y参数即可
	// 20

上面代码中，bind方法除了绑定this对象，还绑定了add函数的第一个参数，结果newAdd函数只要一个参数就能运行了。

bind方法有一些使用注意点

* 每一次返回一个新函数

	bind方法每运行一次，就返回一个新函数，这会产生一些问题。比如，监听事件的时候，不能写成下面这样。

		element.addEventListener('click', o.m.bind(o));
	
	上面代码表示，click事件绑定bind方法生成的一个匿名函数。这样会导致无法取消绑定，所以，下面的代码是无效的。

		element.removeEventListener('click', o.m.bind(o));

正确的方法是写成下面这样：

		var listener = o.m.bind(o);
		element.addEventListener('click', listener);
		//  ...
		element.removeEventListener('click', listener);

* bind方法的自定义代码

	对于那些不支持bind方法的老式浏览器，可以自行定义bind方法

		if(!('bind' in Function.prototype)){
		  Function.prototype.bind = function(){
		    var fn = this;
		    var context = arguments[0];
		    var args = Array.prototype.slice.call(arguments, 1);
		    return function(){
		      return fn.apply(context, args);
		    }
		  }
		}

* jQuery的proxy方法

除了用bind方法绑定函数运行时所在的对象，还可以使用jQuery的`$.proxy`方法，它与`bind`方法的作用基本相同。

	$("#button").on("click", $.proxy(o.f, o));

* 结合call方法使用

	利用bind方法，可以改写一些JavaScript原生方法的使用形式，以数组的slice方法为例
	
		[1,2,3].slice(0,1) 
		// [1]
		
		// 等同于
		
		Array.prototype.slice.call([1,2,3], 0, 1)
		// [1]

	上面的代码中，数组的slice方法从[1, 2, 3]里面，按照指定位置和长度切分出另一个数组。这样做的本质是在[1, 2, 3]上面调用`Array.prototype.slice`方法，因此可以用call方法表达这个过程，得到同样的结果。

	call方法实质上是调用`Function.prototype.call`方法，因此上面的表达式可以用bind方法改写。

		var slice = Function.prototype.call.bind(Array.prototype.slice);

		slice([1, 2, 3], 0, 1) // [1]


	如果再进一步，将Function.prototype.call方法绑定到Function.prototype.bind对象，就意味着bind的调用形式也可以被改写。

		function f(){
		  console.log(this.v);
		}
		
		var o = { v: 123 };
		
		var bind = Function.prototype.call.bind(Function.prototype.bind);
		
		bind(f,o)() // 123

	上面代码表示，将`Function.prototype.call`方法绑定`Function.prototype.bind`以后，bind方法的使用形式从f.bind(o)，变成了bind(f, o)。
	
	
# 封装

## prototype对象

### 构造函数的缺点

JavaScript通过构造函数生成新对象，因此构造函数可以视为对象的模板。实例对象的属性和方法，可以定义在构造函数内部。

构造函数内部定义的所有属性，所有实例对象都会生成这些属性。但是，这样做是对系统资源的浪费，因为同一个构造函数的对象实例之间，无法共享属性

### prototype属性的作用

在JavaScript语言中，每一个对象都有一个对应的原型对象，被称为`prototype`对象。定义在原型对象上的所有属性和方法，都能被派生对象继承。这就是JavaScript继承机制的基本设计。

*构造函数是一个函数，同时也是一个对象*，也有自己的属性和方法，其中有一个`prototype`属性指向另一个对象，一般称为`prototype对象`。**该对象非常特别，只要定义在它上面的属性和方法，能被所有实例对象共享。**

**也就是说，构造函数生成实例对象时，自动为实例对象分配了一个prototype属性。**

	function Animal (name) {
	 this.name = name;
	}
	
	Animal.prototype.color = "white";
	
	var cat1 = new Animal('大毛');
	var cat2 = new Animal('二毛');
	
	cat1.color // 'white'
	cat2.color // 'white'


* 更特别的是，只要修改`prototype`对象，变动就立刻会体现在实例对象，这是因为当实例对象本身没有某个属性或方法的时候，它会到构造函数的`prototype`对象去寻找该属性或方法。这就是`prototype`对象的特殊之处。
* 如果实例对象自身就有某个属性或方法，它就不会再去`prototype`对象寻找这个属性或方法

> 总而言之，prototype对象的作用，就是定义所有实例对象共享的属性和方法，所以它也被称为实例对象的原型，而实例对象可以视作从prototype对象衍生出来的

### 原型链

由于JavaScript的所有对象都有构造函数，而所有构造函数都有prototype属性（其实是所有函数都有prototype属性），所以所有对象都有自己的prototype原型对象。

因此，一个对象的属性和方法，有可能是定义它自身上面，也有可能定义在它的原型对象上面。由于原型本身也是对象，又有自己的原型，所以形成了一条`原型链（prototype chain）`。

**“原型链”的作用**在于，当读取对象的某个属性时，JavaScript引擎先寻找对象本身的属性，如果找不到，就到它的原型去找，如果还是找不到，就到原型的原型去找。以此类推，如果直到最顶层的Object.prototype还是找不到，则返回undefined

### constructor属性

prototype对象有一个`constructor`属性，默认指向prototype对象所在的构造函数。

	function P() {}

	P.prototype.constructor === P
	// true
	
由于constructor属性定义在prototype对象上面，意味着可以被所有实例对象继承。

	function P() {}
	
	var p = new P();
	
	p.constructor
	// function P() {}
	
	p.constructor === P.prototype.constructor
	// true
	
	p.hasOwnProperty('constructor')
	// false	
	
constructor属性的作用是分辨prototype对象到底定义在哪个构造函数上面	
	
## Object.getPrototypeOf方法

Object.getPrototypeOf方法返回一个对象的原型。

	// 空对象的原型是Object.prototype
	Object.getPrototypeOf({}) === Object.prototype
	// true
	
	// 函数的原型是Function.prototype
	function f() {}
	Object.getPrototypeOf(f) === Function.prototype
	// true
	
	// 假定F为构造函数，f为F的实例对象
	// 那么，f的原型是F.prototype
	var f = new F();
	Object.getPrototypeOf(f) === F.prototype
	// true
	
## Object.create方法

Object.create方法用于生成新的对象，可以替代new命令。它接受一个对象作为参数，返回一个新对象，后者完全继承前者的属性，即前者成为后者的原型。	

	var o1 = { p: 1 };
	var o2 = Object.create(o1);
	
	o2.p // 1

上面代码中，Object.create方法在o1的基础上生成了o2。此时，o1成了o2的原型，也就是说，o2继承了o1所有的属性的方法。

Object.create方法基本等同于下面的代码，如果老式浏览器不支持Object.create方法，可以用下面代码自己部署。

	if (typeof Object.create !== "function") {
	  Object.create = function (o) {
	    function F() {}
	    F.prototype = o;
	    return new F();
	  };
	}

上面代码表示，Object.create方法实质是新建一个构造函数F，然后让F的prototype属性指向作为原型的对象o，最后返回一个F的实例，从而实现让实例继承o的属性。

下面三种方式生成的新对象是等价的。

	var o1 = Object.create({});
	var o2 = Object.create(Object.prototype);
	var o3 = new Object();

如果想要生成一个不继承任何属性（比如toString和valueOf方法）的对象，可以将Object.create的参数设为null。

	var o = Object.create(null);
	
	o.valueOf()
	// TypeError: Object [object Object] has no method 'valueOf'
	
* 使用Object.create方法的时候，必须提供对象原型，否则会报错
* Object.create方法生成的新对象，动态继承了原型。在原型上添加或修改任何方法，会立刻反映在新对象之上。
* 除了对象的原型，Object.create方法还可以接受第二个参数，表示描述属性的attributes对象，跟用在Object.defineProperties方法的格式是一样的。它所描述的对象属性，会添加到新对象。
* 由于Object.create方法不使用构造函数，所以不能用instanceof运算符判断，对象是哪一个构造函数的实例。这时，可以使用下面的isPrototypeOf方法，判读原型是哪一个对象

## isPrototypeOf方法
isPrototypeOf方法用来判断一个对象是否是另一个对象的原型。

	var o1 = {};
	var o2 = Object.create(o1);
	var o3 = Object.create(o2);
	
	o2.isPrototypeOf(o3) // true
	o1.isPrototypeOf(o3) // true

上面代码表明，只要某个对象处在原型链上，isProtypeOf都返回true。

# 继承

## 概述

JavaScript的所有对象，都有自己的继承链。也就是说，每个对象都继承另一个对象，该对象称为“原型”（prototype）对象。只有null除外，它没有自己的原型对象。

* `Object.getPrototypof`方法用于获取当前对象的原型对象。

		var p = Object.getPrototypeOf(obj);

* `Object.create`方法用于生成一个新的对象，继承指定对象。

		var obj = Object.create(p);

* 非标准的`__proto__`属性（前后各两个下划线），可以改写某个对象的原型对象。但是，应该尽量少用这个属性，而是用`Object.getPrototypeof()`和`Object.setPrototypeOf()`，进行原型对象的读写操作。

		var obj = {};
		var p = {};

		obj.__proto__ = p;
		Object.getPrototypeOf(obj) === p // true
		
* `new`命令通过构造函数新建实例对象，实质就是将实例对象的原型*绑定构造函数*的`prototype`属性，然后在实例对象上执行构造函数

		var o = new Foo();
		
		// 等同于
		var o = new Object();
		o.__proto__ = Foo.prototype;
		Foo.call(o);	
		
### this的动作指向

不管`this`在哪里定义，使用的时候，它总是指向当前对象，而不是原型对象		

## 构造函数的继承

如何让一个构造函数，继承另一个构造函数。

假定有一个`Shape`构造函数。

	function Shape() {
	  this.x = 0;
	  this.y = 0;
	}
	
	Shape.prototype.move = function (x, y) {
	  this.x += x;
	  this.y += y;
	  console.info('Shape moved.');
	};

`Rectangle`构造函数继承`Shape`。

	function Rectangle() {
	  Shape.call(this); // 调用父类构造函数
	}
	// 另一种写法
	function Rectangle() {
	  this.base = Shape;
	  this.base();
	}
	
	// 子类继承父类的方法
	Rectangle.prototype = Object.create(Shape.prototype);
	Rectangle.prototype.constructor = Rectangle;
	
	var rect = new Rectangle();
	
	rect instanceof Rectangle  // true
	rect instanceof Shape  // true
	
	rect.move(1, 1) // 'Shape moved.'
	
上面代码表示，构造函数的继承分成两部分，一部分是子类调用父类的构造方法，另一部分是子类的原型指向父类的原型。

上面代码中，子类是整体继承父类。有时，只需要单个方法的继承，这时可以采用下面的写法。

	ClassB.prototype.print = function() {
	  ClassA.prototype.print.call(this);
	  // some code
	}
	
上面代码中，子类B的print方法先调用父类A的print方法，再部署自己的代码。这就等于继承了父类A的print方法。

## `__proto__`属性

`__proto__`属性指向当前对象的`原型对象`，即构造函数的`prototype属性`

	var obj = new Object();
	
	obj.__proto__ === Object.prototype
	// true
	
	obj.__proto__ === obj.constructor.prototype
	// true

上面代码首先新建了一个对象obj，它的`__proto__`属性，指向构造函数（Object或obj.constructor）的prototype属性。所以，两者比较以后，返回true。

因此，获取实例对象obj的原型对象，有三种方法。

* `obj.__proto__`
* `obj.constructor.prototype`
* `Object.getPrototypeOf(obj)`


有了`__proto__`属性，就可以很方便得设置实例对象的原型了。假定有三个对象machine、vehicle和car，其中machine是vehicle的原型，vehicle又是car的原型，只要两行代码就可以设置。

	vehicle.__proto__ = machine;
	car.__proto__ = vehicle;

下面是一个实例，通过`__proto__`属性与`constructor.prototype`属性两种方法，分别读取定义在原型对象上的属性。

	Array.prototype.p = 'abc';
	var a = new Array();

	a.__proto__.p // abc
	a.constructor.prototype.p // abc

显然，`__proto__`看上去更简洁一些。

通过构造函数生成实例对象时，实例对象的`__proto__`属性自动指向构造函数的`prototype对象`。

	var f = function (){};
	var a = {};
	
	f.prototype = a;
	var o = new f();
	
	o.__proto__ === a
	// true
	
## 属性的继承

属性分成两种。一种是对象自身的原生属性，另一种是继承自原型的继承属性

### 对象的原生属性

* 对象本身的所有属性，可以用`Object.getOwnPropertyNames`方法获得。
* 对象本身的属性之中，有的是可以枚举的（enumerable），有的是不可以枚举的。只获取那些可以枚举的属性，使用`Object.keys`方法
* `hasOwnProperty`方法返回一个布尔值，用于判断某个属性定义在对象自身，还是定义在原型链上
* `hasOwnProperty`方法是JavaScript之中唯一一个处理对象属性时，不会遍历原型链的方法。


### 对象的继承属性

* 用`Object.create`方法创造的对象，会继承所有原型对象的属性。
* 判断一个对象是否具有某个属性（不管是自身的还是继承的），使用`in`运算符
* 获取所有属性: 使用`for-in`循环
* 为了在`for...in`循环中获得对象自身的属性，可以采用`hasOwnProperty`方法判断一下

## 对象的拷贝

如果要拷贝一个对象，需要做到下面两件事情。

* 确保拷贝后的对象，与原对象具有同样的prototype原型对象。
* 确保拷贝后的对象，与原对象具有同样的属性。

下面就是根据上面两点，编写的对象拷贝的函数。

	function copyObject(orig) {
	  var copy = Object.create(Object.getPrototypeOf(orig));
	  copyOwnPropertiesFrom(copy, orig);
	  return copy;
	}
	
	function copyOwnPropertiesFrom(target, source) {
	  Object
	  .getOwnPropertyNames(source)
	  .forEach(function(propKey) {
	    var desc = Object.getOwnPropertyDescriptor(source, propKey);
	    Object.defineProperty(target, propKey, desc);
	  });
	  return target;
	}


## 多重继承

JavaScript不提供多重继承功能，即不允许一个对象同时继承多个对象。但是，可以通过变通方法，实现这个功能

	function M1(prop) {
	  this.hello = prop;
	}
	
	function M2(prop) {
	  this.world = prop;
	}
	
	function S(p1, p2) {
	  this.base1 = M1;
	  this.base1(p1);
	  this.base2 = M2;
	  this.base2(p2);
	}
	S.prototype = new M1();
	
	var s = new S(111, 222);
	s.hello // 111
	s.world // 222

上面代码中，子类`S`同时继承了父类`M1`和`M2`。当然，从继承链来看，`S`只有一个父类`M1`，但是由于在`S`的实例上，同时执行`M1`和`M2`的构造函数，所以它同时继承了这两个类的方法。



	
	

## 相关链接

	


## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)