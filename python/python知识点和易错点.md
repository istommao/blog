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


















				
	
		

## 参考

* [廖雪峰python](http://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000)








