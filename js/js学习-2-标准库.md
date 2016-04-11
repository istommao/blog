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



# 包装对象

所谓“包装对象”，就是分别与数值、字符串、布尔值相对应的Number、String、Boolean三个原生对象。这三个原生对象可以把原始类型的值变成（包装成）对象。

### 包装对象的构造函数

Number、String和Boolean这三个原生对象，既可以当作构造函数使用（即加上new关键字，生成包装对象实例），也可以当作工具方法使用（即不加new关键字，直接调用），这相当于生成实例后再调用valueOf方法，常常用于将任意类型的值转为某种原始类型的值。

	var v1 = new Number(123);
	var v2 = new String("abc");
	var v3 = new Boolean(true);

	Number(123) // 123
	String("abc") // "abc"
	Boolean(true) // true


### 包装对象实例的方法

包装对象实例可以使用Object对象提供的原生方法，主要是 `valueOf` 方法和 `toString` 方法

* valueOf方法: valueOf方法返回包装对象实例对应的原始类型的值
* toString方法: toString方法返回该实例对应的原始类型值的字符串形式

### 原始类型的自动转换

原始类型可以自动调用定义在包装对象上的方法和属性。比如String对象的实例有一个length属性，返回字符串的长度。所有原始类型的字符串，都可以直接使用这个length属性

### 自定义方法

三种包装对象还可以在原型上添加自定义方法和属性，供原始类型的值直接调用。

但是，这种自定义方法和属性的机制，只能定义在包装对象的原型上，如果直接对原始类型的变量添加属性，则无效。

**e.g.**

	String.prototype.double = function (){
		return this.valueOf() + this.valueOf();
	};

# Boolean对象

Boolean对象是JavaScript的三个包装对象之一。作为构造函数，它主要用于生成布尔值的包装对象的实例。

特别要注意的是，所有对象的布尔运算结果都是true。因此，false对应的包装对象实例，布尔运算结果也是true

	if (new Boolean(false)) {
	    console.log("true"); 
	} // true
	
	if (new Boolean(false).valueOf()) {
	    console.log("true"); 
	} // 无输出

## Number对象

Number对象是数值对应的包装对象，可以作为构造函数使用，也可以作为工具函数使用。

* 作为构造函数时，它用于生成值为数值的对象。
* 作为工具函数时，它可以将任何类型的值转为数值

### Number对象的属性

* Number.POSITIVE_INFINITY：正的无限，指向Infinity。
* Number.NEGATIVE_INFINITY：负的无限，指向-Infinity。
* Number.NaN：表示非数值，指向NaN。
* Number.MAX_VALUE：表示最大的正数，相应的，最小的负数为-Number.MAX_VALUE。
* Number.MIN_VALUE：表示最小的正数（即最接近0的正数，在64位浮点数体系中为5e-324），相应的，最接近0的负数为-Number.MIN_VALUE。
* Number.MAX_SAFE_INTEGER：表示能够精确表示的最大整数，即9007199254740991。
* Number.MIN_SAFE_INTEGER：表示能够精确表示的最小整数，即-9007199254740991。

### Number对象实例的方法

* Number.prototype.toString(): 将一个数字转化成某个进制的字符串

		(10).toString() // "10"
		(10).toString(2) // "1010"
		(10).toString(8) // "12"
		(10).toString(16) // "a"

	加括号：后面的点表示调用对象属性。如果不加括号，这个点会被JavaScript引擎解释成小数点，从而报错
	
	不加括号的话，使用两个点，JavaScript会把第一个点理解成小数点（即10.0），把第二个点理解成调用对象属性，从而得到正确结果
	
		10..toString(2) 
		// 1010
		
* 方括号运算符也可以调用toString方法: `10['toString'](2) // "1010"`
* 将其他进制的数，转回十进制，需要使用parseInt方法		
### Number.prototype.toFixed()

用于将一个数转为指定位数的小数

	(10).toFixed(2)
	(10.005).toFixed(2)
	
### Number.prototype.toExponential()

toExponential方法用于将一个数转为科学计数法形式

	(10).toExponential(1)
	// "1.0e+1"

### Number.prototype.toPrecision()

* toPrecision方法用于将一个数转为指定位数的有效数字
* toPrecision方法的参数为有效数字的位数，范围是1到21，超出这个范围会抛出RangeError错误。
* toPrecision方法用于四舍五入时不太可靠，跟浮点数不是精确储存有关。	
	
### 自定义方法

与其他对象一样，Number.prototype对象上面可以自定义方法，被Number的实例继承。		
		 

# String对象

* String对象是JavaScript原生提供的三个包装对象之一，用来生成字符串的包装对象实例。
* 除了用作构造函数，String还可以当作工具方法使用，将任意类型的值转为字符串

### String.fromCharCode()

* 该方法根据Unicode编码，生成一个字符串。
* 注意，该方法不支持编号大于0xFFFF的字符

### 实例对象的属性和方法

* `length`属性: 该属性返回字符串的长度
* `charAt`

	* 返回一个字符串的给定位置的字符，位置从0开始编号
	* 这个方法完全可以用数组下标替代
	
*  `charCodeAt`: 返回给定位置字符的Unicode编码（十进制表示）

	`charCodeAt`方法返回的Unicode编码不大于65536（0xFFFF），也就是说，只返回两个字节。因此如果遇到Unicode大于65536的字符（根据UTF-16的编码规则，第一个字节在U+D800到U+DBFF之间），就必需连续使用两次charCodeAt，不仅读入charCodeAt(i)，还要读入charCodeAt(i+1)，将两个16字节放在一起，才能得到准确的字符。

* 如果给定位置为负数，或大于等于字符串的长度，则`charAt`和`charCodeAt`返回NaN。	

* concat方法: 用于连接两个字符串
* substring方法，substr方法和slice方法: 这三个方法都用来返回一个字符串的子串，而不会改变原字符串。

	* substring方法的第一个参数表示子字符串的开始位置，第二个位置表示结束结果。因此，第二个参数应该大于第一个参数。如果出现第一个参数大于第二个参数的情况，substring方法会自动更换两个参数的位置。
	* substr方法的第一个参数是子字符串的开始位置，第二个参数是子字符串的长度。
	* slice方法的第一个参数是子字符串的开始位置，第二个参数是子字符串的结束位置。与substring方法不同的是，如果第一个参数大于第二个参数，slice方法并不会自动调换参数位置，而是返回一个空字符串。
	* 对这三个方法来说，第一个参数都是子字符串的开始位置，如果省略第二个参数，则表示子字符串一直持续到原字符串结束。
	* 如果提供第二个参数，对于slice和substring方法，表示子字符串的结束位置；对于substr，表示子字符串的长度。
	* 如果参数为负，对于slice方法，表示字符位置从尾部开始计算。
	* 对于substring方法，会自动将负数转为0
	* 对于substr方法，负数出现在第一个参数，表示从尾部开始计算的字符位置；负数出现在第二个参数，将被转为0

* indexOf 和 lastIndexOf 方法

	* 这两个方法用于确定一个字符串在另一个字符串中的位置，如果返回-1，就表示不匹配。两者的区别在于，indexOf从字符串头部开始匹配，lastIndexOf从尾部开始匹配。
	* 它们还可以接受第二个参数，对于indexOf，表示从该位置开始向后匹配；对于lastIndexOf，表示从该位置起向前匹配。
	
* trim 方法: 该方法用于去除字符串两端的空格
* toLowerCase 和 toUpperCase 方法

	toLowerCase用于将一个字符串转为小写，toUpperCase则是转为大写。	
	
* localeCompare方法

	该方法用于比较两个字符串。它返回一个数字，如果小于0，表示第一个字符串小于第二个字符串；如果等于0，表示两者相等；如果大于0，表示第一个字符串大于第二个字符串。	
* 搜索和替换

	与搜索和替换相关的有4个方法，它们都允许使用正则表达式。
	
	* 	match：用于确定原字符串是否匹配某个子字符串，返回匹配的子字符串数组。
		match方法返回一个数组，成员为匹配的第一个字符串。如果没有找到匹配，则返回null。返回数组还有index属性和input属性，分别表示匹配字符串开始的位置（从0开始）和原始字符串。
		
	* 	search：等同于match，但是返回值不一样。
	
		search方法的用法等同于match，但是返回值为匹配的第一个位置。如果没有找到匹配，则返回-1
		
	* 	replace：用于替换匹配的字符串。
	
		replace方法用于替换匹配的子字符串，一般情况下只替换第一个匹配（除非使用带有g修饰符的正则表达式）。
		
	* 	split：将字符串按照给定规则分割，返回一个由分割出来的各部分组成的新数组。
	
		split方法按照给定规则分割字符串，返回一个由分割出来的各部分组成的新数组。
		
		* 如果分割规则为空字符串，则返回数组的成员是原字符串的每一个字符。
		* 如果省略分割规则，则返回数组的唯一成员就是原字符串。
		* 如果满足分割规则的两个部分紧邻着（即中间没有其他字符），则返回数组之中会有一个空字符串。
		* 如果满足分割规则的部分处于字符串的开头或结尾（即它的前面或后面没有其他字符），则返回数组的第一个或最后一个成员是一个空字符串。
		* split方法还可以接受第二个参数，限定返回数组的最大成员数。


# Math对象
	
Math对象是JavaScript的内置对象，提供一系列数学常数和数学方法。该对象不是构造函数，所以不能生成实例，所有的属性和方法都必须在Math对象上调用

### 属性

* E：常数e。
* LN2：2的自然对数。
* LN10：10的自然对数。
* LOG2E：以2为底的e的对数。
* LOG10E：以10为底的e的对数。
* PI：常数Pi。
* SQRT1_2：0.5的平方根。
* SQRT2：2的平方根。	
		
### 方法

* Math.round()
* Math.abs()，Math.max()，Math.min()
* Math.floor()，Math.ceil()
* Math.pow(), Math.sqrt()
* log方法，exp方法
* random方法
* 三角函数方法: sin, cos, tan, asin, acos, atan

# Date对象

## 概述

`Date`对象是JavaScript提供的日期和时间的操作接口。它有多种用法。

JavaScript内部，所有日期和时间都储存为一个整数，表示当前时间距离1970年1月1日00:00:00的毫秒数，正负的范围为基准时间前后各1亿天。

### Date()

作为一个函数，Date对象可以直接调用，返回一个当前日期和时间的字符串。

	Date()
	// "Tue Dec 01 2015 09:34:43 GMT+0800 (CST)"
	
	Date(2000, 1, 1)
	// "Tue Dec 01 2015 09:34:43 GMT+0800 (CST)"

Date对象还是一个构造函数，对它使用new命令，会返回一个Date对象的实例。如果不加参数，生成的就是代表当前时间的对象。

	var today = new Date();
	
	today
	// "Tue Dec 01 2015 09:34:43 GMT+0800 (CST)"
	
	// 等同于
	today.toString()
	// "Tue Dec 01 2015 09:34:43 GMT+0800 (CST)"

* new Date(milliseconds)
* new Date(datestring)

	所有可以被`Date.parse()`方法解析的日期字符串，都可以当作Date对象的参数
	
* new Date(year, month [, day, hours, minutes, seconds, ms])

### 日期的运算

类型转换时，Date对象的实例如果转为数值，则等于对应的毫秒数；如果转为字符串，则等于对应的日期字符串。所以，两个日期对象进行减法运算，返回的就是它们间隔的毫秒数；进行加法运算，返回的就是连接后的两个字符串。

## Date对象的静态方法

* Date.now()

	Date.now方法返回当前距离1970年1月1日 00:00:00 UTC的毫秒数（Unix时间戳乘以1000）	
	
* Date.parse()

	解析日期字符串，返回距离1970年1月1日 00:00:00的毫秒数
	
* Date.UTC()

	默认情况下，Date对象返回的都是当前时区的时间。Date.UTC方法可以返回UTC时间（世界标准时间）。
	
## Date实例对象的方法

Date的实例对象，有几十个自己的方法，分为以下三类。

* to类：从Date对象返回一个字符串，表示指定的时间。
* get类：获取Date对象的日期和时间。
* set类：设置Date对象的日期和时间。		
### to类方法

* Date.prototype.toString()： 返回一个完整的日期字符串
* Date.prototype.toUTCString()：返回对应的UTC时间，也就是比北京时间晚8个小时
* Date.prototype.toISOString()：返回对应时间的ISO8601写法
* Date.prototype.toJSON()：返回一个符合JSON格式的ISO格式的日期字符串，与toISOString方法的返回结果完全相同。
* Date.prototype.toDateString()：返回日期的字符串形式
* Date.prototype.toTimeString()：返回时间的字符串形式
* Date.prototype.toLocalDateString()：返回一个字符串，代表日期的当地写法
* Date.prototype.toLocalTimeString()：返回一个字符串，代表时间的当地写法

### get类方法

`get*`方法，用来获取实例对象某个方面的值

* getTime()：返回实例对象距离1970年1月1日00:00:00对应的毫秒数，等同于valueOf方法。
* getDate()：返回实例对象对应每个月的几号（从1开始）。
* getDay()：返回星期几，星期日为0，星期一为1，以此类推。
* getYear()：返回距离1900的年数。
* getFullYear()：返回四位的年份。
* getMonth()：返回月份（0表示1月，11表示12月）。
* getHours()：返回小时（0-23）。
* getMilliseconds()：返回毫秒（0-999）。
* getMinutes()：返回分钟（0-59）。
* getSeconds()：返回秒（0-59）。
* getTimezoneOffset()：返回当前时间与UTC的时区差异，以分钟表示，返回结果考虑到了夏令时因素。

UTC版本：

* getUTCDate()
* getUTCFullYear()
* getUTCMonth()
* getUTCDay()
* getUTCHours()
* getUTCMinutes()
* getUTCSeconds()
* getUTCMilliseconds()

### set类方法

一系列`set*`方法，用来设置实例对象的各个方面。
	
* setDate(date)：设置实例对象对应的每个月的几号（1-31），返回改变后毫秒时间戳。
* setYear(year): 设置距离1900年的年数。
* setFullYear(year [, month, date])：设置四位年份。
* setHours(hour [, min, sec, ms])：设置小时（0-23）。
* setMilliseconds()：设置毫秒（0-999）。
* setMinutes(min [, sec, ms])：设置分钟（0-59）。
* setMonth(month [, date])：设置月份（0-11）。
* setSeconds(sec [, ms])：设置秒（0-59）。
* setTime(milliseconds)：设置毫秒时间戳。

这些方法基本是跟`get*`方法一一对应的，但是没有`setDay`方法，因为星期几是计算出来的，而不是设置的。另外，需要注意的是，凡是涉及到设置月份，都是从`0`开始算的，即0是1月，11是12月。

`set*`系列方法除了`setTime()`和`setYear()`，都有对应的UTC版本，即设置UTC时区的时间。

* setUTCDate()
* setUTCFullYear()
* setUTCHours()
* setUTCMilliseconds()
* setUTCMinutes()
* setUTCMonth()
* setUTCSeconds()

### Date.prototype.valueOf()

valueOf方法返回实例对象距离1970年1月1日00:00:00 UTC对应的毫秒数，该方法等同于getTime方法。

	var d = new Date();
	
	d.valueOf() // 1362790014817
	d.getTime() // 1362790014817

# RegExp对象

## 概述

新建正则表达式有两种方法。一种是使用字面量，以斜杠表示开始和结束。

	var regex = /xyz/;

另一种是使用RegExp构造函数。

	var regex = new RegExp('xyz');
	
上面两种写法是等价的，都新建了一个内容为xyz的正则表达式对象。它们的主要区别是，第一种方法在编译时新建正则表达式，第二种方法在运行时新建正则表达式

考虑到书写的便利和直观，实际应用中，基本上都采用字面量的写法。

正则对象生成以后，有两种使用方式：

* 正则对象的方法：将字符串作为参数，比如regex.test(string)。
* 字符串对象的方法：将正则对象作为参数，比如string.match(regex)。

## 正则对象的属性和方法

### 属性

正则对象的属性分成两类。

一类是修饰符相关，返回一个布尔值，表示对应的修饰符是否设置。

* ignoreCase：返回一个布尔值，表示是否设置了i修饰符，该属性只读。
* global：返回一个布尔值，表示是否设置了g修饰符，该属性只读。
* multiline：返回一个布尔值，表示是否设置了m修饰符，该属性只读。

		var r = /abc/igm;
		
		r.ignoreCase // true
		r.global // true
		r.multiline // true

另一类是与修饰符无关的属性，主要是下面两个。

* lastIndex：返回下一次开始搜索的位置。该属性可读写，但是只在设置了g修饰符时有意义。
* source：返回正则表达式的字符串形式（不包括反斜杠），该属性只读。

		var r = /abc/igm;
	
		r.lastIndex // 0
		r.source // "abc"

### 方法

* test()：正则对象的test方法返回一个布尔值，表示当前模式是否能匹配参数字符串
* exec()：正则对象的exec方法，可以返回匹配结果。如果发现匹配，就返回一个数组，每个匹配成功的子字符串，就是数组成员，否则返回null


## 字符串对象的方法

字符串对象的方法之中，有4种与正则对象有关

* match()：返回一个数组，成员是所有匹配的子字符串。
* search()：按照给定的正则表达式进行搜索，返回一个整数，表示匹配开始的位置。
* replace()：按照给定的正则表达式进行替换，返回替换后的字符串。

	字符串对象的replace方法可以替换匹配的值。它接受两个参数，第一个是搜索模式，第二个是替换的内容。
	
	replace方法的第二个参数可以使用美元符号$，用来指代所替换的内容。
	
	* $& 指代匹配的子字符串。
	* $\` 指代匹配结果前面的文本。
	* $' 指代匹配结果后面的文本。
	* $n 指代匹配成功的第n组内容，n是从1开始的自然数。
	* $$ 指代美元符号$。	
	
	replace方法的第二个参数还可以是一个函数，将匹配内容替换为函数返回值	

* split()：按照给定规则进行字符串分割，返回一个数组，包含分割后的各个成员。


## 匹配规则

正则表达式对字符串的匹配有很复杂的规则。基本和Linux的正则表达式规则一样。

可参考[匹配规则](http://javascript.ruanyifeng.com/stdlib/regexp.html#toc10)

# JSON对象

## 概述

JSON格式（JavaScript Object Notation的缩写）是一种用于数据交换的文本格式，目的是取代繁琐笨重的XML格式。

简单说，JSON格式就是一种表示一系列的“值”的方法，这些值包含在数组或对象之中，是它们的成员。对于这一系列的“值”，有如下几点格式规定：

* 数组或对象的每个成员的值，可以是简单值，也可以是复合值。
* 简单值分为四种：字符串、数值（必须以十进制表示）、布尔值和null（NaN, Infinity, -Infinity和undefined都会被转为null）。
* 复合值分为两种：符合JSON格式的对象和符合JSON格式的数组。
* 数组或对象最后一个成员的后面，不能加逗号。
* 数组或对象之中的字符串必须使用双引号，不能使用单引号。
* 对象的成员名称必须使用双引号。

需要注意的是，空数组和空对象都是合格的JSON值，null本身也是一个合格的JSON值。

## JSON对象

ES5新增了JSON对象，用来处理JSON格式数据。它有两个方法：`JSON.stringify`和`JSON.parse`

### JSON.stringify

* `JSON.stringify`方法用于将一个值转为字符串。该字符串符合JSON格式，并且可以被`JSON.parse`方法还原。
* 如果原始对象中，有一个成员的值是undefined、函数或XML对象，这个成员会被省略。如果数组的成员是undefined、函数或XML对象，则这些值被转成null。
* 正则对象会被转成空对象	
* 忽略对象的不可遍历属性
* JSON.stringify方法还可以接受一个数组参数，指定需要转成字符串的属性
* JSON.stringify方法还可以接受一个函数作为参数，用来更改默认的字符串化的行为
* JSON.stringify还可以接受第三个参数，用于增加返回的JSON字符串的可读性。如果是数字，表示每个属性前面添加的空格（最多不超过10个）；如果是字符串（不超过10个字符），则该字符串会添加在每行前面。
* 如果JSON.stringify方法处理的对象，包含一个toJSON方法，则它会使用这个方法得到一个值，然后再将这个值转成字符串，而忽略其他成员

### JSON.parse()

* JSON.parse方法用于将JSON字符串转化成对象
* 如果传入的字符串不是有效的JSON格式，JSON.parse方法将报错
* 为了处理解析错误，可以将JSON.parse方法放在try…catch代码块中。
* JSON.parse方法可以接受一个处理函数，用法与JSON.stringify方法类似	



## 相关链接




## 参考

* [JavaScript 标准参考教程](http://javascript.ruanyifeng.com/)