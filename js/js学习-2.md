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
	
# Array 对象

## 概述

`Array`是JavaScript的内置对象，同时也是一个构造函数，可以用它生成新的数组。

作为构造函数时，Array可以接受参数，但是不同的参数，会使得Array产生不同的行为（所以ES6不推荐使用它来创建数组）

	// 无参数时，返回一个空数组
	new Array() // []
	
	// 单个正整数参数，表示返回的新数组的长度
	new Array(1) // [undefined × 1]
	new Array(2) // [undefined x 2]
	
	// 单个非正整数参数（比如字符串、布尔值、对象等），
	// 则该参数是返回的新数组的成员
	new Array('abc') // ['abc']
	new Array([1]) // [Array[1]]
	
	// 多参数时，所有参数都是返回的新数组的成员
	new Array(1, 2) // [1, 2]

从上面代码可以看到，Array作为构造函数，行为很不一致。因此，不建议使用它生成新数组，直接使用数组的字面量是更好的方法。
	
	// bad
	var arr = new Array(1, 2);
	
	// good
	var arr = [1, 2];	

## Array对象的静态方法

### isArray方法

Array.isArray方法用来判断一个值是否为数组。它可以弥补typeof运算符的不足。


## Array实例的方法

Array实例对象的方法，都是数组实例才能使用。如果不想创建实例，只是想单纯调用这些方法，可以写成`[].method.call(调用对象，参数) `的形式，或者`Array.prototype.method.call(调用对象，参数)`的形式。

### valueOf方法，toString方法

* valueOf方法返回数组本身
* toString 方法返回数组的字符串形式

### push方法，pop方法

* `push`方法用于在数组的末端添加一个或多个元素，并返回添加后的数组的长度
* 如果需要合并两个数组，可以这样写

		var a = [1, 2, 3];
		var b = [4, 5, 6];
		
		Array.prototype.push.apply(a, b)
		// 或者
		a.push.apply(a,b)
		
		// 上面两种写法等同于
		a.push(4,5,6)
		
		a // [1, 2, 3, 4, 5, 6]		

* push方法还可以用于向对象添加元素，添加后的对象变成“类似数组的”对象，即新加入元素的键对应数组的索引，并且对象有一个length属性。

		var a = {a: 1};
		
		[].push.call(a, 2);
		a
		// {a:1, 0:2, length: 1}
		
		[].push.call(a, [3]);
		a
		// {a:1, 0:2, 1:[3], length: 2}

* pop方法用于删除数组的最后一个元素，并返回该元素
* 对空数组使用pop方法，不会报错，而是返回undefined

### join方法，concat方法

* `join`方法以参数作为分隔符，将所有数组成员组成一个字符串返回。如果不提供参数，默认用逗号分隔。
* 通过函数的`call`方法，`join`方法（即Array.prototype.join）也可以用于字符串

		Array.prototype.join.call('hello', '-')
		// "h-e-l-l-o"

* `concat`方法用于多个数组的合并。它将新数组的成员，添加到原数组的尾部，然后返回一个新数组
* 如果不提供参数，concat方法返回当前数组的一个浅拷贝。所谓“浅拷贝”，指的是如果数组成员包括复合类型的值（比如对象），则新数组拷贝的是该值的引用
* 只要原数组的成员中包含对象，concat方法不管有没有参数，总是返回该对象的引用
* concat方法也可以用于将对象合并为数组，但是必须借助call方法

		[].concat.call({ a: 1 }, { b: 2 })
		// [{ a: 1 }, { b: 2 }]
		
		[].concat.call({ a: 1 }, [2])
		// [{a:1}, 2]	
		// 等同于
		[2].concat({a:1})

### shift方法，unshift方法

* `shift`方法用于删除数组的第一个元素，并返回该元素
* `shift`方法可以遍历并清空一个数组
* `unshift`方法用于在数组的第一个位置添加元素，并返回添加新元素后的数组长度

### reverse方法

reverse方法用于颠倒数组中元素的顺序，使用这个方法以后，返回改变后的原数组

### slice方法

`slice`方法用于提取原数组的一部分，返回一个新数组，原数组不变。

它的第一个参数为起始位置（从0开始），第二个参数为终止位置（但该位置的元素本身不包括在内）。如果省略第二个参数，则一直返回到原数组的最后一个成员。

	// 格式
	arr.slice(start_index, upto_index);
	
* 如果slice方法的参数是负数，则从尾部开始选择的成员个数；如果参数值大于数组成员的个数，或者第二个参数小于第一个参数，则返回空数组
* slice方法的一个重要应用，是将类似数组的对象转为真正的数组

### splice()

splice方法用于删除原数组的一部分成员，并可以在被删除的位置添加入新的数组成员。它的返回值是被删除的元素。该方法会改变原数组。

splice的第一个参数是删除的起始位置，第二个参数是被删除的元素个数。如果后面还有更多的参数，则表示这些就是要被插入数组的新元素。

	// 格式
	arr.splice(index, count_to_remove, addElement1, addElement2, ...);
	
* 如果只是单纯地插入元素，splice方法的第二个参数可以设为0
* 如果只提供第一个参数，则实际上等同于将原数组在指定位置拆分成两个数组

### sort()

* `sort`方法对数组成员进行排序，默认是按照字典顺序排序。排序后，原数组将被改变	
* 如果想让sort方法按照自定义方式排序，可以传入一个函数作为参数，表示按照自定义方法进行排序。该函数本身又接受两个参数，表示进行比较的两个元素。如果返回值大于0，表示第一个元素排在第二个元素后面；其他情况下，都是第一个元素排在第二个元素前面

## ECMAScript 5 新加入的数组方法

> ECMAScript 5新增了9个数组实例的方法，分别是map、forEach、filter、every、some、reduce、reduceRight、indexOf和lastIndexOf。其中，前7个与函数式（functional）操作有关


### Array.prototype.map()

* `map`方法对数组的所有成员依次调用一个函数，根据函数结果返回一个新数组。
* `map`方法的回调函数依次接受三个参数，分别是当前的数组成员、当前成员的位置和数组本身
* `map`方法不仅可以用于数组，还可以用于字符串，用来遍历字符串的每个字符。但是，不能直接用，而要通过函数的`call`方法间接使用，或者先将字符串转为数组，然后使用
* `map`方法还可以接受第二个参数，表示回调函数执行时`this`所指向的对象
* `map`方法通过键名，遍历数组的所有成员。所以，只要数组的某个成员取不到键名，`map`方法就会跳过它
	
### Array.prototype.forEach()

数组实例的`forEach`方法与`map`方法很相似，也是遍历数组的所有成员，执行某种操作，但是`forEach`方法没有返回值，一般只用来操作数据。如果需要有返回值，一般使用`map`方法

* forEach方法和map方法的参数格式是一样的，第一个参数都是一个函数。该函数接受三个参数，分别是当前元素、当前元素的位置（从0开始）、整个数组
* forEach方法会跳过数组的空位, 不会跳过undefined和null
* forEach方法也可以接受第二个参数，用来绑定回调函数的this关键字

### filter方法

`filter`方法依次对所有数组成员调用一个测试函数，返回结果为true的成员组成一个新数组返回

* `filter`方法的测试函数可以接受三个参数，第一个参数是当前数组成员的值，这是必需的，后两个参数是可选的，分别是当前数组成员的位置和整个数组
* `filter`方法还可以接受第二个参数，指定测试函数所在的上下文对象（即`this`对象）

### some方法，every方法

这两个方法类似“断言”（assert），用来判断数组成员是否符合某种条件。

* `some`方法对所有元素调用一个测试函数，只要有一个元素通过该测试，就返回true，否则返回false。
* `every`方法对所有元素调用一个测试函数，只有所有元素通过该测试，才返回true，否则返回false。

### reduce方法，reduceRight方法

`reduce`方法和`reduceRight`方法的作用，是依次处理数组的每个元素，最终累计为一个值。这两个方法的差别在于，reduce对数组元素的处理顺序是从左到右（从第一个成员到最后一个成员），reduceRight则是从右到左（从最后一个成员到第一个成员），其他地方完全一样。

reduce方法的第一个参数是一个处理函数。该函数接受四个参数，分别是：

* 初始变量，默认为数组的第一个元素值。函数第一次执行后的返回值作为函数第二次执行的初始变量，依次类推。
* 当前变量，如果指定了reduce函数或者reduceRight函数的第二个参数，则该变量为数组的第一个元素的值，否则，为第二个元素的值。
* 当前变量对应的元素在数组中的序号（从0开始）。
* 原数组

		[1, 2, 3, 4, 5].reduce(function(x, y){
		    console.log(x,y)
		    return x+y;
		});
		// 1 2
		// 3 3
		// 6 4
		// 10 5
		//最后结果：15

### indexOf 和 lastIndexOf

* indexOf方法返回给定元素在数组中第一次出现的位置，如果没有出现则返回-1
* indexOf方法还可以接受第二个参数，表示搜索的开始位置
* lastIndexOf方法返回给定元素在数组中最后一次出现的位置，如果没有出现则返回-1
* 注意，如果数组中包含`NaN`，这两个方法不适用

	这是因为这两个方法内部，使用严格相等运算符（`===`）进行比较，而NaN是唯一一个不等于自身的值
	
	
### 链式使用

上面这些数组方法之中，有不少返回的还是数组，所以可以链式使用


	



## 相关链接




## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)