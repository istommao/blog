title: python知识点和易错点
date: 2016-06-13 22:42:00
tags:
- python

# python知识点和易错点

## 变量赋值

	a = 'ABC'
	b = a
	a = 'XYZ'
	print(b)   // 'ABC'. a的指向改变了，而b的指向没变
	
原理：`str`是`不可变`对象。	
	
## 字符串和编码

* 最新的Python 3版本中，字符串是以`Unicode`编码的
* 在计算机内存中，统一使用Unicode编码，当需要保存到硬盘或者需要传输的时候，就转换为`UTF-8`或其他编码
* Python的字符串类型是`str`，在内存中以Unicode表示，一个字符对应若干个字节。
* 如果要在网络上传输，或者保存到磁盘上，就需要把`str`变为以字节为单位的`bytes`。
* Python对`bytes`类型的数据用带`b`前缀的单引号或双引号表示
* `bytes`的每个字符都只占用一个字节
* 以`Unicode`表示的`str`通过`encode()`方法可以编码为指定的bytes

		>>> 'ABC'.encode('ascii')
		b'ABC'
		>>> '中文'.encode('utf-8')
		b'\xe4\xb8\xad\xe6\x96\x87'
		>>> '中文'.encode('ascii')
		Traceback (most recent call last):
		  File "<stdin>", line 1, in <module>
		UnicodeEncodeError: 'ascii' codec can't encode characters in position 0-1: ordinal not in range(128)		

* 在`bytes`中，无法显示为ASCII字符的字节，用`\x##`显示。
* 反过来，如果我们从网络或磁盘上读取了字节流，那么读到的数据就是`bytes`。要把`bytes`变为`str`，就需要用`decode()`方法：

		>>> b'ABC'.decode('ascii')
		'ABC'
		>>> b'\xe4\xb8\xad\xe6\x96\x87'.decode('utf-8')
		'中文'

* 要计算`str`包含多少个`字符`（一个字符对应可以多个字节），可以用`len()`函数。如果换成`bytes`，`len()`函数就计算字节数


## list 和 tuple

**list：**

* list`可变`的`有序`列表
* list是一种`有序的集合`，可以随时添加和删除其中的元素：`append()`, `insert()`, `pop()`

**tuple：**

* tuple：`不可变`的`有序`列表
* `不可变`指tuple的每个元素的`指向`不可变。如果tuple的包含的元素本身是可变，那么可以改变该元素自身，但是其指向不变，即还是指向该元素

## 字典

* 设置: `d['key'] = value`, `d.set()`
* 获取键值：`d['key']`, `d.get('key', 'default')`
* 如果`'key'`不存在，则`d['key']`报错，而`d.get`正确返回`None`或`default值`
* 删除`pop()`
* dict的`key`必须是`不可变对象`。这是因为`dict`根据`key`来计算`value`的存储位置（`hash值`）
* 其他操作：`clear()`, `是否存在：in`，`update()`：注意返回值为`None`, `keys() & values()`

## set

* 创建一个`set`： `s = set([1, 2, 3])`
* 添加元素`add(key)`，删除`remove(key)`
* 交集`&`，并集`|`

## 可变和不可变对象

* 不可变对象：`str`， `tuple`
* 可变对象：`list`


## 函数参数

**默认参数：**

* 默认参数可以简化函数的调用
* 必选参数在前，默认参数在后，否则Python的解释器会报错
* 当函数有多个参数时，把变化大的参数放前面，变化小的参数放后面。变化小的参数就可以作为默认参数
* 有多个默认参数时，调用的时候，既可以按顺序提供默认参数，也可以不按顺序提供部分默认参数。当不按顺序提供部分默认参数时，需要把参数名写上。
* 默认参数有个最大的坑：

		def add_end(L=[]):
		    L.append('END')
		    return L	

	Python函数在定义的时候，默认参数`L`的值就被计算出来了，即`[]`，因为默认参数`L`也是一个变量，它指向对象`[]`，每次调用该函数，如果改变了`L`的内容，则下次调用时，默认参数的内容就变了，不再是函数定义时的`[]`了。

	所以，定义默认参数要牢记一点：**默认参数必须指向不变对象！**

**可变参数：**

* Python允许你在list或tuple前面加一个`*`号，把list或tuple的元素变成可变参数传进去

**关键字参数：**

* 和可变参数类似，也可以先组装出一个`dict`，然后，把该`dict`转换为关键字参数，在`dict`前面加`**`
* 传给函数的字典在函数内部拿到的是一份拷贝，因此在函数内部的改变不会影响到函数外的字典

**命名关键字参数：**

* 要限制关键字参数的名字，就可以用命名关键字参数
* 和关键字参数`**kw`不同，命名关键字参数需要一个特殊分隔符`*`，`*`后面的参数被视为命名关键字参数
* 如果函数定义中已经有了一个可变参数，后面跟着的命名关键字参数就不再需要一个特殊分隔符`*`了
* 命名关键字参数必须传入参数名，这和位置参数不同
* 使用命名关键字参数时，要特别注意，如果没有可变参数，就必须加一个`*`作为特殊分隔符

**参数组合：**

* 在Python中定义函数，可以用必选参数、默认参数、可变参数、关键字参数和命名关键字参数，这5种参数都可以组合使用。但是请注意，参数定义的顺序必须是：必选参数、默认参数、可变参数、命名关键字参数和关键字参数
* 对于任意函数，都可以通过类似`func(*args, **kw)`的形式调用它，无论它的参数是如何定义的

**小结：**

* 可变参数既可以直接传入：`func(1, 2, 3)`，又可以先组装`list`或`tuple`，再通过`*args`传入：`func(*(1, 2, 3))`；
* 关键字参数既可以直接传入：`func(a=1, b=2)`，又可以先组装`dict`，再通过`**kw`传入：`func(**{'a': 1, 'b': 2})`
* `*args`是可变参数，args接收的是一个tuple
* `**kw`是关键字参数，kw接收的是一个dict
* 使用`*args`和`**kw`是Python的习惯写法，当然也可以用其他参数名，但最好使用习惯用法

## 切片

* Python没有针对字符串的截取函数，只需要切片一个操作就可以完成，非常简单

## 迭代

* 给定一个`list`或`tuple`，我们可以通过`for ... in`循环来遍历这个list或tuple，这种遍历我们称为`迭代（Iteration）`
* 只要是可迭代对象，无论有无下标，都可以迭代，比如dict就可以迭代：

		for key in d:
		for value in d.values()
		for k, v in d.items()
		
* 字符串也是可迭代对象
* 判断一个对象是可迭代对象呢？方法是通过`collections`模块的`Iterable`类型判断：

		from collections import Iterable
		isinstance('abc', Iterable)
* Python内置的`enumerate`函数可以把一个`list`变成`索引-元素对`，这样就可以在`for`循环中同时迭代`索引`和`元素`本身:

		for i, value in enumerate(['A', 'B', 'C']):
		
## 列表表达式

* 语法：`[含元素的表达式 for 元素 in 列表]`举例说明：

		[x * x for x in range(1, 11)]
* 运用列表生成式，可以写出非常简洁的代码

## 生成器

* Python中，这种一边循环一边计算的机制，称为生成器：`generator`。	
* 创建一个`generator`：只要把一个列表生成式的`[]`改成`()`
* 通过`next()`函数获得`generator`的下一个返回值
* `generator`保存的是算法，每次调用`next(g)`，就计算出下一个元素的值，直到计算到最后一个元素，没有更多的元素时，抛出`StopIteration`的错误
* 不断调用`next(g)`实在是太变态了，正确的方法是使用`for循环`，因为`generator`也是可迭代对象
* 创建了一个`generator`后，基本上永远不会调用`next()`，而是通过`for循环`来迭代它，并且不需要关心`StopIteration`的错误
* 如果一个函数定义中包含`yield`关键字，那么这个函数就不再是一个普通函数，而是一个`generator`
* 用`for循环`调用`generator函数`时，是拿不到`generator`的`return`语句的返回值。如果想要拿到返回值，必须捕获`StopIteration`错误，返回值包含在`StopIteration`的`value`中

## 迭代器

* 可以直接作用于for循环的数据类型有以下几种：

	* 集合数据类型，如`list`、`tuple`、`dict`、`set`、`str`等
	* `generator`，包括`生成器`和带`yield的generator function`
	
* 可以直接作用于`for循环`的对象统称为`可迭代对象`：`Iterable`
* 可以使用`isinstance()`判断一个对象是否是`Iterable`对象	
* 生成器都是`Iterator`对象，但`list`、`dict`、`str`虽然是`Iterable`，却不是`Iterator`
* 把`list`、`dict`、`str`等`Iterable`变成`Iterator`可以使用`iter()`函数
* 为什么`list`、`dict`、`str`等数据类型不是`Iterator`？

	这是因为Python的`Iterator`对象表示的是一个`数据流`，`Iterator`对象可以被`next()`函数调用并不断返回下一个数据，直到没有数据时抛出`StopIteration`错误。可以把这个数据流看做是一个`有序序列`，但我们却不能提前知道序列的长度，只能不断通过`next()`函数实现按需计算下一个数据，所以`Iterator`的计算是惰性的，只有在需要返回下一个数据时它才会计算。
	
**小结：**	

* 凡是可作用于`for循环`的对象都是`Iterable`类型；
* 凡是可作用于`next()`函数的对象都是`Iterator`类型，它们表示一个惰性计算的序列
* 集合数据类型如`list`、`dict`、`str`等是`Iterable`但不是`Iterator`，不过可以通过`iter()`函数获得一个`Iterator`对象。
* Python的`for循环`本质上就是通过不断调用`next()`函数实现的


## 函数式编程

* 把函数作为参数传入，这样的函数称为高阶函数，函数式编程就是指这种高度抽象的编程范式

### map/reduce

* `map()`函数接收两个参数，一个是`函数`(接收一个参数)，一个是`Iterable`，`map`将传入的函数依次作用到序列的每个元素，并把结果作为新的`Iterator`返回
* `reduce`把一个函数作用在一个`序列`[x1, x2, x3, ...]上，这个函数`必须接收两个参数`，reduce把结果继续和序列的下一个元素做累积计算:

		reduce(f, [x1, x2, x3, x4]) = f(f(f(x1, x2), x3), x4)
		
### filter		

* 和`map()`类似，`filter()`也接收`一个函数`(接收一个参数，返回值为True/False)和`一个序列`。和map()不同的是，`filter()`把传入的函数依次作用于每个元素，然后根据返回值是True还是False决定保留还是丢弃该元素。

### 排序

* Python内置的`sorted()`函数就可以对`list`进行排序
* `sorted()`函数也是一个高阶函数，它还可以接收一个`key函数`来实现自定义的排序

### 函数作为返回值

#### 闭包

* 当一个函数返回了一个函数后，其内部的局部变量还被新函数引用，所以，闭包用起来简单，实现起来可不容易。
* 另一个需要注意的问题是，返回的函数并没有立刻执行

		def count():
		    fs = []
		    for i in range(1, 4):
		        def f():
		             return i*i
		        fs.append(f)
		    return fs
		
		f1, f2, f3 = count()	
		
		>>> f1()
		9
		>>> f2()
		9
		>>> f3()
		9

	全部都是`9`！原因就在于返回的函数引用了变量`i`，但它并非立刻执行。等到3个函数都返回时，它们所`引用的变量i`已经变成了3，因此最终结果为9。

* 返回闭包时牢记的一点就是：**返回函数不要引用任何循环变量，或者后续会发生变化的变量**

* 返回一个函数时，牢记该函数并未执行，返回函数中不要引用任何可能会变化的变量

### 匿名函数

* 匿名函数`lambda x: x * x`
* 关键字`lambda`表示匿名函数，`冒号`前面的`x`表示函数参数
* Python对匿名函数的支持有限，只有一些简单的情况下可以使用匿名函数。


## 装饰器

* 代码运行期间动态增加功能的方式，称之为“`装饰器`”（Decorator）
* 本质上，`decorator`就是一个`返回函数的高阶函数`
* 语法糖`@`，举例：相当于执行`now = log(now)`

		@log
		def now():	

* 如果`decorator`本身不需要参数，则`decorator`定义接收一个`func`，并在内部的`wrapper`返回该`func`。举例：`log`为`decorator`。

		def log(func):
		    def wrapper(*args, **kw):
		        print('call %s():' % func.__name__)
		        return func(*args, **kw)
		    return wrapper	

* 如果`decorator`本身需要传入参数，那就需要编写一个`返回decorator的高阶函数`，该函数接收`decorator需要的参数，并返回decorator函数`，此时的`decorator函数`就可以写成本身不需要参数的形式。举例：`log`为返回decorator的高阶函数。

		def log(text):
		    def decorator(func):
		        def wrapper(*args, **kw):
		            print('%s %s():' % (text, func.__name__))
		            return func(*args, **kw)
		        return wrapper
		    return decorator

	这个3层嵌套的decorator用法如下：

		@log('execute')
		def now():
		    print('2015-3-25')

	和两层嵌套的decorator相比，3层嵌套的效果是这样的：

		>>> now = log('execute')(now)
		
* 经过`decorator`装饰之后的函数，它们的`__name__`已经从原来的'now'变成了'wrapper'。因为返回的那个`wrapper()`函数名字就是'wrapper'，所以，需要把原始函数的`__name__`等属性复制到`wrapper()`函数中，否则，有些依赖函数签名的代码执行就会出错	：

	不需要编写`wrapper.__name__ = func.__name__`这样的代码，Python内置的`functools.wraps`就是干这个事的。只需要在`wrapper()`前面加上`@functools.wraps(func)`。举例：
	
		import functools
		
		def log(func):
		    @functools.wraps(func)
		    def wrapper(*args, **kw):
		        print('call %s():' % func.__name__)
		        return func(*args, **kw)
		    return wrapper
		或者针对带参数的decorator：
		
		import functools
		
		def log(text):
		    def decorator(func):
		        @functools.wraps(func)
		        def wrapper(*args, **kw):
		            print('%s %s():' % (text, func.__name__))
		            return func(*args, **kw)
		        return wrapper
		    return decorator	
	
**小结：**	

* Python的`decorator`可以用函数实现，也可以用类实现。
* `decorator`可以增强函数的功能，定义起来虽然有点复杂，但使用起来非常灵活和方便。

[decorator介绍](http://www.cnblogs.com/rhcad/archive/2011/12/21/2295507.html)

### 偏函数

* 这里的偏函数和数学意义上的偏函数不一样。
* 通过设定参数的默认值，可以降低函数调用的难度。而偏函数也可以做到这一点
* `functools.partial`就是帮助我们创建一个偏函数的：

		int2 = functools.partial(int, base=2)
		
	我们不在需要每次都设置`base=2`，直接得到一个已经设置好的新函数
	
* 简单总结`functools.partial`的作用就是，把一个函数的某些参数给固定住（也就是设置默认值），返回一个新的函数，调用这个新函数会更简单
* 创建偏函数时，实际上可以接收`函数对象`、`*args`和`**kw`这3个参数
* 当函数的参数个数太多，需要简化时，使用`functools.partial`可以创建一个新的函数，这个新函数可以固定住原函数的部分参数，从而在调用时更简单

## 模块

* 一个`.py`文件就称之为一个模块（Module）
* 为了避免模块名冲突，Python又引入了按目录来组织模块的方法，称为包（Package）
* 每一个包目录下面都会有一个`__init__.py`的文件，这个文件是必须存在的，否则，Python就把这个目录当成普通目录，而不是一个包
* `__init__.py`可以是空文件，也可以有Python代码，因为`__init__.py`本身就是一个模块，而它的模块名就是`目录名`
* 可以有多级目录，组成多级层次的包结构
* 正常的函数和变量名是公开的（public），可以被直接引用
* 类似`__xxx__`这样的变量是特殊变量，可以被直接引用，但是有特殊用途
* 类似`_xxx`和`__xxx`这样的函数或变量就是非公开的（private），不应该被直接引用
* 默认情况下，Python解释器会`搜索当前目录`、所有已安装的`内置模块`和`第三方模块`，搜索路径存放在`sys`模块的`path`变量中
* 添加自己的搜索目录: 直接修改`sys.path` 或 设置环境变量`PYTHONPATH`

## 面向对象

### 类

* 通过定义一个特殊的`__init__`方法，在创建实例的时候，就把必要等属性绑上去
* 如果要让内部属性不被外部访问，可以把属性的名称前加上两个下划线`__`。实例的变量名如果以`__`开头，就变成了一个私有变量（private），只有内部可以访问，外部不能访问
* 以一个下划线开头的实例变量名，比如`_name`，这样的实例变量外部是可以访问的，但是，按照约定俗成的规定，当你看到这样的变量时，意思就是，“虽然我可以被访问，但是，请把我视为私有变量，不要随意访问”
* 双下划线开头的实例变量不能直接访问是因为：Python解释器对外把`__name`变量改成了`_xxx__name`，所以，仍然可以通过`_xxx__name`来访问`__name`变量
* 当我们定义了一个class，创建了一个class的实例后，我们可以给该**实例绑定任何属性和方法**，这就是动态语言的灵活性

		>>> s = Student()
		>>> s.name = 'Michael' # 动态给实例绑定一个属性	
		
		>>> def set_age(self, age): # 定义一个函数作为实例方法
		...     self.age = age
		...
		>>> from types import MethodType
		>>> s.set_age = MethodType(set_age, s) # 给实例绑定一个方法

	但是，给一个实例绑定的方法，对另一个实例是不起作用的
	
	为了给所有实例都绑定方法，可以给class绑定方法：
	
		>>> def set_score(self, score):
		...     self.score = score
		...
		>>> Student.set_score = set_score
		
	通常情况下，上面的`set_score`方法可以直接定义在`class`中，但动态绑定允许我们在程序运行的过程中动态给`class`加上功能，这在静态语言中很难实现。

			

### 继承

* 对于静态语言（例如Java）来说，如果需要传入Animal类型，则传入的对象必须是Animal类型或者它的子类，否则，将无法调用run()方法。
* 对于Python这样的动态语言来说，则不一定需要传入Animal类型。我们只需要保证传入的对象有一个run()方法就可以了。这就是动态语言的`鸭子类型`：它并不要求严格的继承体系，一个对象只要“看起来像鸭子，走起路来像鸭子”，那它就可以被看做是鸭子

### 获取对象信息

* 判断对象类型，使用`type()`函数
* 比较两个变量的type类型是否相同：基本数据类型可以直接写`int`，`str`等，其他可以使用`types`模块中定义的常量

		type(fn)==types.FunctionType
		
* 对于`class`的继承关系来说，使用`type()`就很不方便。我们要判断class的类型，可以使用`isinstance()`函数: `isinstance()`判断的是一个对象是否是该类型本身，或者位于该类型的父继承链上

		isinstance(h, Dog)	

* 能用`type()`判断的基本类型也可以用`isinstance()`判断
* 要获得一个对象的所有属性和方法，可以使用`dir()`函数
* 仅仅把属性和方法列出来是不够的，配合`getattr()`、`setattr()`以及`hasattr()`，我们可以直接操作一个对象的状态

		>>> hasattr(obj, 'x') # 有属性'x'吗？
		True
		>>> obj.x
		9
		>>> hasattr(obj, 'y') # 有属性'y'吗？
		False
		>>> setattr(obj, 'y', 19) # 设置一个属性'y'
		>>> hasattr(obj, 'y') # 有属性'y'吗？
		True
		>>> getattr(obj, 'y') # 获取属性'y'
		19
		>>> obj.y # 获取属性'y'
		19

	如果试图获取不存在的属性，会抛出AttributeError的错误：

		>>> getattr(obj, 'z') # 获取属性'z'
		Traceback (most recent call last):
		  File "<stdin>", line 1, in <module>
		AttributeError: 'MyObject' object has no attribute 'z'

	可以传入一个default参数，如果属性不存在，就返回默认值：

		>>> getattr(obj, 'z', 404) # 获取属性'z'，如果不存在，返回默认值404
		404

	也可以获得对象的方法。
	
		>>> hasattr(obj, 'power') # 有属性'power'吗？
		True
		>>> getattr(obj, 'power') # 获取属性'power'
		<bound method MyObject.power of <__main__.MyObject object at 0x10077a6a0>>
		>>> fn = getattr(obj, 'power') # 获取属性'power'并赋值到变量fn
		>>> fn # fn指向obj.power
		<bound method MyObject.power of <__main__.MyObject object at 0x10077a6a0>>
		>>> fn() # 调用fn()与调用obj.power()是一样的
		81

### 实例属性和类属性


### `__slots__`

* 为了达到限制的目的，Python允许在定义class的时候，定义一个特殊的`__slots__`变量，来限制该class实例能添加的属性
* `__slots__`定义的属性仅对当前类实例起作用，对继承的子类是不起作用的


### `@property`

* 在绑定属性时，如果我们直接把属性暴露出去，虽然写起来很简单，但是，没办法检查参数。但是，如果设置为私有属性，并通过`set/get`又显得复杂。*既能检查参数，又可以用类似属性这样简单的方式来访问类的变量*：Python内置的`@property`装饰器就是负责把一个方法变成属性调用的
* 把一个`getter`方法变成属性，只需要加上`@property`就可以了，此时，`@property`本身又创建了另一个装饰器`@xxx.setter`，负责把一个`setter`方法变成属性赋值，于是，我们就拥有一个可控的属性操作
* 定义只读属性，只定义`getter`方法，不定义`setter`方法就是一个只读属性
* `@property`广泛应用在类的定义中，可以让调用者写出简短的代码，同时保证对参数进行必要的检查，这样，程序运行时就减少了出错的可能性

### 定制类

* `__str__`：返回一个好看的字符串
* `__repr__`：返回程序开发者看到的字符串，也就是说，__repr__()是为调试服务的
* 通常`__str__()`和`__repr__()`代码都是一样的
* `__iter__`： 如果一个类想被用于`for ... in`循环，类似list或tuple那样，就必须实现一个`__iter__()`方法，该方法返回一个迭代对象
* `__getitem__`：要表现得像list/dict那样按照下标取出元素，需要实现
* `__setitem__()`方法，把对象视作list或dict来对集合赋
* `__delitem__()`方法，用于删除某个元素
* `__getattr__`: 可以把一个类的所有属性和方法调用全部动态化处理了，不需要任何特殊手段。只有在没有找到属性的情况下，才调用`__getattr__`
* `__call__`：任何类，只需要定义一个`__call__()`方法，就可以直接对实例进行调用


### 枚举

* 枚举：每个常量都是class的一个唯一实例。Python提供了`Enum`类来实现这个功能

		from enum import Enum
		Month = Enum('Month', ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))

### 元类

* 动态语言和静态语言最大的不同，就是函数和类的定义，不是编译时定义的，而是运行时动态创建的

**type():**

* `type()`函数可以查看一个类型或变量的类型
* `type()`函数既可以返回一个对象的类型，又可以创建出新的类型

	比如，我们可以通过type()函数创建出Hello类，而无需通过class Hello(object)...的定义：

		>>> def fn(self, name='world'): # 先定义函数
		...     print('Hello, %s.' % name)
		...
		>>> Hello = type('Hello', (object,), dict(hello=fn)) # 创建Hello class
		>>> h = Hello()
		>>> h.hello()
		Hello, world.
		>>> print(type(Hello))
		<class 'type'>
		>>> print(type(h))
		<class '__main__.Hello'>	
			
* 要创建一个class对象，type()函数依次传入3个参数：

	1. class的名称；
	2. 继承的父类集合，注意Python支持多重继承，如果只有一个父类，别忘了tuple的单元素写法；
	3. class的方法名称与函数绑定，这里我们把函数fn绑定到方法名hello上。	
				
	通过`type()`函数创建的类和直接写`class`是完全一样的，因为Python解释器遇到class定义时，仅仅是扫描一下class定义的语法，然后调用`type()`函数创建出class.
	
					
**metaclass:**

[metaclass](http://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000/0014319106919344c4ef8b1e04c48778bb45796e0335839000)

* 除了使用`type()`动态创建类以外，要控制类的创建行为，还可以使用`metaclass`
* 先定义`metaclass`，就可以创建类，最后创建实例
* `metaclass`允许你创建类或者修改类。换句话说，你可以把类看成是metaclass创建出来的“实例”。
* `metaclass`是类的模板，所以必须从`type`类型派生
* 在定义类的时候还要指示使用`metaclass`来定制
* `__new__()`方法接收到的参数依次是：

	* 	当前准备创建的类的对象；
	* 	类的名字；
	* 	类继承的父类集合；
	* 	类的方法集合。

* 动态修改类的意义？总会遇到需要通过`metaclass`修改类定义的。ORM就是一个典型的例子。

	要编写一个ORM框架，所有的类都只能动态定义，因为只有使用者才能根据表的结构定义出对应的类来。


## 异常

## 测试

* 编写单元测试时，我们需要编写一个测试类，从`unittest.TestCase`继承
* 以`test`开头的方法就是测试方法，不以test开头的方法不被认为是测试方法，测试的时候不会被执行
* 运行单元测试: 

	最简单的运行方式:
	
		if __name__ == '__main__':
    		unittest.main()

	当做正常的python脚本运行：
	
		python3 mydict_test.py
		
	在命令行通过参数-m unittest直接运行单元测试:
	
		python3 -m unittest mydict_test
		
* 单元测试中编写两个特殊的`setUp()`和`tearDown()`方法。这两个方法会分别在*每调用一个测试方法的前后*分别被执行		

## IO编程

* `open()`, `read()`, `write()`, `close()`, `readlines()`
* `with open() as f:`

### StringIO

* `StringIO`顾名思义就是在内存中读写`str`

### BytesIO

* `StringIO`操作的只能是`str`，如果要操作二进制数据，就需要使用`BytesIO`

### 文件和目录

* `os`
* `os.path.abspath`, `os.path.join`, `os.path.split`, `os.path.splitext()`
* `os.mkdir`, `os.rmdir`, `os.rename`, `os.remove`

### 序列化

* Python对象变成一个JSON: `json.dumps(d)`。`dumps()`方法返回一个`str`，内容就是标准的JSON
* `dump()`方法可以直接把JSON写入一个`file-like Object`
* 要把JSON反序列化为Python对象：用`loads()`或者对应的`load()`方法，前者把JSON的字符串反序列化，后者从`file-like Object`中读取字符串并反序列化


## 进程和线程

### 多进程

* `multiprocessing`模块提供了一个`Process`类来代表一个进程对象
* 创建子进程时，只需要传入一个`执行函数`和`函数的参数`，创建一个`Process`实例，用`start()`方法启动，这样创建进程比fork()还要简单
* `join()`方法可以等待子进程结束后再继续往下运行，通常用于进程间的同步
* 对`Pool`对象调用`join()`方法会等待所有子进程执行完毕，调用`join()`之前必须先调用`close()`，调用`close()`之后就不能继续添加新的`Process`了
* `subprocess`模块可以让我们非常方便地启动一个子进程，然后控制其输入和输出
* 进程间通信： Python的`multiprocessing`模块包装了底层的机制，提供了`Queue`、`Pipes`等多种方式来交换数据。


### 多线程

* Python的标准库提供了两个模块：`_thread`和`threading`，`_thread`是低级模块，`threading`是高级模块，对`_thread`进行了封装
* 启动一个线程就是把`一个函数`传入并创建`Thread`实例，然后调用`start()`开始执行
* `threading`模块有个`current_thread()`函数，它永远返回当前线程的实例。主线程实例的名字叫`MainThread`，子线程的名字在`创建时指定`
* 创建一个锁就是通过`threading.Lock()`来实现
* 当多个线程同时执行`lock.acquire()`时, 只有一个成功。获得锁的线程用完后一定要释放锁： `lock.release()`

### GIL

* Python的线程虽然是真正的线程，但解释器执行代码时，有一个GIL锁：`Global Interpreter Lock`，任何Python线程执行前，必须先获得`GIL`锁，然后，每执行100条字节码，解释器就自动释放`GIL`锁，让别的线程有机会执行。这个GIL全局锁实际上把所有线程的执行代码都给上了锁，所以，`多线程在Python中只能交替执行`，即使100个线程跑在100核CPU上，也只能用到1个核。
* 在Python中，可以使用多线程，但不要指望能有效利用多核。如果一定要通过多线程利用多核，那只能通过C扩展来实现，不过这样就失去了Python简单易用的特点。
* Python虽然不能利用多线程实现多核任务，但可以通过`多进程实现多核任务`。多个Python`进程`有各自`独立的GIL锁`，互不影响

### ThreadLocal

* ThreadLocal解决了：

	在多线程环境下，每个线程都有自己的数据。一个线程使用自己的局部变量比使用全局变量好，因为局部变量只有线程自己能看见，不会影响其他线程，而全局变量的修改必须加锁

	但是局部变量也有问题，就是在函数调用的时候，传递起来很麻烦（每个函数要使用的局部变量都要用它，因此必须传进去）
	
	如果用一个全局`dict`存放所有的Student对象，然后以`thread`自身作为`key`获得线程对应的Student对象如何？这种方式理论上是可行的，它最大的优点是消除了局部对象在每层函数中的传递问题，但是，每个函数获取局部的代码有点丑
	
	`ThreadLocal`就是为了解决这个问题
	
* `ThreadLocal`最常用的地方就是为每个线程绑定一个`数据库连接`，`HTTP请求`，`用户身份信息`等，这样一个线程的所有调用到的处理函数都可以非常方便地访问这些资源。
* 一个`ThreadLocal`变量虽然是全局变量，但每个线程都只能读写自己线程的独立副本，互不干扰。`ThreadLocal`解决了参数在一个线程中各个函数之间互相传递的问题

### 进程 vs 线程

* 要实现多任务，通常我们会设计Master-Worker模式，Master负责分配任务，Worker负责执行任务

	* 	用多进程实现Master-Worker，主进程就是Master，其他进程就是Worker
	* 用多线程实现Master-Worker，主线程就是Master，其他线程就是Worker。
	* 多进程模式最大的优点就是稳定性高，因为一个子进程崩溃了，不会影响主进程和其他子进程。（当然主进程挂了所有进程就全挂了，但是Master进程只负责分配任务，挂掉的概率低）著名的Apache最早就是采用多进程模式。
	* 多进程模式的缺点是创建进程的代价大，在Unix/Linux系统下，用fork调用还行，在Windows下创建进程开销巨大。另外，操作系统能同时运行的进程数也是有限的，在内存和CPU的限制下，如果有几千个进程同时运行，操作系统连调度都会成问题
	* 多线程模式通常比多进程快一点，但是也快不到哪去，而且，多线程模式致命的缺点就是任何一个线程挂掉都可能直接造成整个进程崩溃，因为所有线程共享进程的内存。在Windows上，如果一个线程执行的代码出了问题，你经常可以看到这样的提示：“该程序执行了非法操作，即将关闭”，其实往往是某个线程出了问题，但是操作系统会强制结束整个进程。
	* 在Windows下，多线程的效率比多进程要高，所以微软的IIS服务器默认采用多线程模式。由于多线程存在稳定性的问题，IIS的稳定性就不如Apache。为了缓解这个问题，IIS和Apache现在又有多进程+多线程的混合模式
	
### 异步IO

* 现代操作系统对IO操作已经做了巨大的改进，最大的特点就是`支持异步IO`。如果充分利用操作系统提供的异步IO支持，就可以用`单进程单线程模型`来执行多任务，这种全新的模型称为`事件驱动模型`，`Nginx`就是支持异步IO的Web服务器，它在单核CPU上采用单进程模型就可以高效地支持多任务。在多核CPU上，可以运行多个进程（数量与CPU核心数相同），充分利用多核CPU。由于系统总的进程数量十分有限，因此操作系统调度非常高效。用异步IO编程模型来实现多任务是一个主要的趋势。	
* 对应到Python语言，`单进程的异步编程模型`称为`协程`，有了协程的支持，就可以基于事件驱动编写高效的多任务程序

## 分布式进程

* Python的`multiprocessing`模块不但支持多进程，其中`managers`子模块还支持把多进程分布到多台机器上。

## 内建模块

### datetime

* `from datetime import datetime`
* 获取当前日期和时间: `now = datetime.now()`
* 获取指定日期和时间: `dt = datetime(2015, 4, 19, 12, 20)`
* datetime转换为timestamp: `datetime(2015, 4, 19, 12, 20).timestamp()`
* timestamp转换为datetime: `fromtimestamp() 或 utcfromtimestamp()`
* str转换为datetime：`datetime.strptime()`

		cday = datetime.strptime('2015-6-1 18:19:59', '%Y-%m-%d %H:%M:%S')
		
* datetime转换为str: 	`strftime()`

		datetime.now().strftime('%a, %b %d %H:%M')	
* datetime加减: 加减可以直接用`+`和`-`运算符，不过需要导入`timedelta`这个类: `datetime.now() + timedelta(hours=10)`
* 本地时间转换为UTC时间: 
* 时区转换: `utcnow()`拿到当前的UTC时间，再转换为任意时区的时间




	
	

























				
	
		

## 参考

* [廖雪峰python](http://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000)








