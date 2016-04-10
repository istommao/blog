title: js学习(2)
date: 2016-04-05 12:05:05
tags:
- js

# js学习(2)
---
没有系统学习过js，觉得基础太薄弱了，参考阮一峰老师的[JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)，希望可以提高自己js的基础。

# 3. 标准库
------

# Object对象

## 概述

JavaScript原生提供一个Object对象（注意起首的O是大写），所有其他对象都继承自这个对象。Object本身也是一个构造函数，可以直接通过它来生成新对象。

	var o = new Object();
	
Object作为构造函数使用时，可以接受一个参数。如果该参数是一个对象，则直接返回这个对象；如果是一个原始类型的值，则返回该值对应的包装对象。	

**注意**，通过`new Object()` 的写法生成新对象，与字面量的写法` o = {}` 是等价的

与其他构造函数一样，如果要在Object对象上面部署一个方法，有两种做法:

* 部署在Object对象本身

		Object.print = function(o){ console.log(o) };
		
* 部署在Object.prototype对象

	所有构造函数都有一个prototype属性，指向一个原型对象。凡是定义在Object.prototype对象上面的属性和方法，将被所有实例对象共享。
	
		Object.prototype.print = function(){ console.log(this)};
		
## Object对象的方法

### Object()

Object本身当作工具方法使用时，可以将任意值转为对象。其中，原始类型的值转为对应的包装对象

### Object.keys()，Object.getOwnPropertyNames()			
一般用来遍历对象的属性。它们的参数都是一个对象，都返回一个数组，该数组的成员都是对象自身的（而不是继承的）所有属性名。它们的区别在于，`Object.keys`方法只返回可枚举的属性（关于可枚举性的详细解释见后文），`Object.getOwnPropertyNames`方法还返回不可枚举的属性名。	

### Object.observe()

Object.observe方法用于观察对象属性的变化

	Object.observe(o, function(changes) {
	  changes.forEach(function(change) {
	    console.log(change.type, change.name, change.oldValue);
	  });
	});

### 其他方法

#### 对象属性模型的相关方法

* Object.getOwnPropertyDescriptor()：获取某个属性的attributes对象。
* Object.defineProperty()：通过attributes对象，定义某个属性。
* Object.defineProperties()：通过attributes对象，定义多个属性。
* Object.getOwnPropertyNames()：返回直接定义在某个对象上面的全部属性的名称。

#### 控制对象状态的方法

* Object.preventExtensions()：防止对象扩展。
* Object.isExtensible()：判断对象是否可扩展。
* Object.seal()：禁止对象配置。
* Object.isSealed()：判断一个对象是否可配置。
* Object.freeze()：冻结一个对象。
* Object.isFrozen()：判断一个对象是否被冻结。

#### 原型链相关方法

* Object.create()：生成一个新对象，并该对象的原型。
* Object.getPrototypeOf()：获取对象的Prototype对象。

## Object实例对象的方法

除了Object对象本身的方法，还有不少方法是部署在Object.prototype对象上的，所有Object的实例对象都继承了这些方法。

Object实例对象的方法，主要有以下六个:

* valueOf()：返回当前对象对应的值。
* toString()：返回当前对象对应的字符串形式。
* toLocalString()：返回当前对象对应的本地字符串形式。
* hasOwnProperty()：判断某个属性是否为当前对象自身的属性，还是继承自原型对象的属性。
* isPrototypeOf()：判断当前对象是否为另一个对象的原型。
* propertyIsEnumerable()：判断某个属性是否可枚举。

## 对象的属性模型

### 属性的attributes对象，Object.getOwnPropertyDescriptor()

在JavaScript内部，每个属性都有一个对应的`attributes`对象，保存该属性的一些元信息。使用`Object.getOwnPropertyDescriptor`方法，可以读取`attributes`对象

`attributes`对象包含如下元信息。

* `value`：表示该属性的值，默认为`undefined`。
* `writable`：表示该属性的值（value）是否可以改变，默认为`true`。
* `enumerable`： 表示该属性是否可枚举，默认为true。如果设为false，会使得某些操作（比如`for...in`循环、`Object.keys()`）跳过该属性。
* `configurable`：表示“可配置性”，默认为`true`。如果设为false，将阻止某些操作改写该属性，比如，无法删除该属性，也不得改变该属性的`attributes`对象（value属性除外），也就是说，`configurable`属性控制了`attributes`对象的可写性。
* `get`：表示该属性的取值函数（getter），默认为`undefined`。
* `set`：表示该属性的存值函数（setter），默认为`undefined`。

### Object.defineProperty()，Object.defineProperties()

`Object.defineProperty`方法允许通过定义attributes对象，来定义或修改一个属性，然后返回修改后的对象。

	Object.defineProperty(object, propertyName, attributesObject)
	
* 需要注意的是，`Object.defineProperty`方法和后面的`Object.defineProperties`方法，都有性能损耗，会拖慢执行速度，不宜大量使用。
* Object.defineProperty的一个用途，是设置动态属性名。	

### 可枚举性（enumerable）

可枚举性（enumerable）用来控制所描述的属性，是否将被包括在`for...in`循环之中。具体来说，如果一个属性的enumerable为false，下面三个操作不会取到该属性。

* for..in循环
* Object.keys方法
* JSON.stringify方法

### Object.getOwnPropertyNames()

`Object.getOwnPropertyNames`方法返回直接定义在某个对象上面的全部属性的名称，而不管该属性是否可枚举。


### Object.prototype.propertyIsEnumerable()

对象实例的`propertyIsEnumerable`方法用来判断一个属性是否可枚举

### 可配置性（configurable）

可配置性（configurable）决定了是否可以修改属性的描述对象。也就是说，当configurable为false的时候，value、writable、enumerable和configurable都不能被修改了

### 可写性（writable）
	
可写性（writable）决定了属性的值（value）是否可以被改变。

### 存取器（accessor）

除了直接定义以外，属性还可以用存取器（accessor）定义。其中，存值函数称为setter，使用set命令；取值函数称为getter，使用get命令。

	var o = {
	  get p() {
	    return "getter";
	  },
	  set p(value) {
	    console.log("setter: "+value);
	  }
	};

上面代码中，o对象内部的get和set命令，分别定义了p属性的取值函数和存值函数。定义了这两个函数之后，对p属性取值时，取值函数会自动调用；对p属性赋值时，存值函数会自动调用。

* 存取器往往用于，某个属性的值需要依赖对象内部数据的场合

另一个存取器的例子。

	var d = new Date();
	
	Object.defineProperty(d, 'month', {
	  get: function() {
	    return d.getMonth();
	  },
	  set: function(v) {
	    d.setMonth(v);
	  }
	});

上面代码为Date的实例对象d，定义了一个可读写的month属性

* 存取器也可以使用Object.create方法定义
* 利用存取器，可以实现数据对象与DOM对象的双向绑定

		Object.defineProperty(user, 'name', {
		  get: function() {
		    return document.getElementById("foo").value;
		  },
		  set: function(newValue) {
		    document.getElementById("foo").value = newValue;
		  },
		  configurable: true
		});

上面代码使用存取函数，将DOM对象foo与数据对象user的name属性，实现了绑定。两者之中只要有一个对象发生变化，就能在另一个对象上实时反映出来。	

### 对象的拷贝

有时，我们需要将一个对象的所有属性，拷贝到另一个对象。ES5没有提供这个方法，必须自己实现: 对于简单属性，就直接拷贝，对于那些通过描述对象设置的属性，则使用`Object.defineProperty`方法拷贝

## 控制对象状态

JavaScript提供了三种方法，精确控制一个对象的读写状态，防止对象被改变。最弱一层的保护是preventExtensions，其次是seal，最强的freeze。


### Object.preventExtensions方法

`Object.preventExtensions`方法可以使得一个对象无法再添加新的属性

不过，对于使用了`preventExtensions`方法的对象，可以用`delete`命令删除它的现有属性

### Object.isExtensible方法

`Object.isExtensible`方法用于检查一个对象是否使用了`preventExtensions`方法。也就是说，该方法可以用来检查是否可以为一个对象添加属性。

### Object.seal方法

* `Object.seal`方法使得一个对象既无法添加新属性，也无法删除旧属性
* `Object.seal`还把现有属性的attributes对象的configurable属性设为false，使得attributes对象不再能改变。
* 可写性（writable）有点特别。如果writable为false，使用Object.seal方法以后，将无法将其变成true；但是，如果writable为true，依然可以将其变成false。

### Object.isSealed方法

Object.isSealed方法用于检查一个对象是否使用了Object.seal方法

### Object.freeze方法

`Object.freeze`方法可以使得一个对象无法添加新属性、无法删除旧属性、也无法改变属性的值，使得这个对象实际上变成了常量

### Object.isFrozen方法

`Object.isFrozen`方法用于检查一个对象是否使用了`Object.freeze()`方法

### 局限性

需要注意的是，使用上面这些方法锁定对象的可写性，但是依然可以通过改变该对象的原型对象，来为它增加属性。

	var o = new Object();
	
	Object.preventExtensions(o);
	
	var proto = Object.getPrototypeOf(o);
	
	proto.t = "hello";
	
	o.t
	// hello

一种解决方案是，把原型也冻结

	var o = Object.seal(
	  Object.create(Object.freeze({x:1}),
	    {y: {value: 2, writable: true}})
	);
	
	Object.getPrototypeOf(o).t = "hello";
	o.hello // undefined


## 相关链接




## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)