title: python知识点和易错点(part2)
date: 2016-06-13 22:42:00
tags:
- python

# python知识点和易错点-part2

* [python面试题](https://github.com/zhuwei05/interview_python)

## python内存管理和垃圾回收

[Python的内存管理以及垃圾回收](http://blog.csdn.net/onlyanyz/article/details/45605773)

* 对象和引用分离
* 对于简单的Python对象，例如数值、字符串，元组（tuple不允许被更改)采用的是复制的方式(深拷贝?)

	也就是说当将另一个变量B赋值给变量A时，虽然A和B的内存空间仍然相同，但当A的值发生变化时，会重新给A分配空间，A和B的地址变得不再相同
* 对于像字典(dict)，列表(List)等，改变一个就会引起另一个的改变，也称之为浅拷贝	
* Python GC主要使用`引用计数（reference counting）`来跟踪和回收垃圾
* 回收算法：标记-清除机制 和 分代技术
* 标记清除

	先按需分配，等到没有空闲内存的时候从寄存器和程序栈上的引用出发，`遍历以对象为节点、以引用为边构成的图`，把所有可以访问到的对象打上标记，然后清扫一遍内存空间，把所有没标记的对象释放。
	
* 分代技术：

	Python将所有的对象分为`0`，`1`，`2`三代。所有的新建对象都是0代对象。当某一代对象经`历过垃圾回收，依然存活`，那么它就`被归入`下一代对象。垃圾回收启动时，一定会扫描所有的0代对象。如果0代经过一定`次数`垃圾回收，那么就启动对0代和1代的扫描清理。当1代也经历了一定次数的垃圾回收后，那么会启动对0，1，2，即对所有对象进行扫描。

* 垃圾回收机制还有一个循环垃圾回收器, 确保释放循环引用对象(a引用b, b引用a, 导致其引用计数永远不为0)
* 内存池机制：

	* Python的内存机制以金字塔（-2 ~ 3共6层）
	* -1，-2层主要有操作系统进行操作
	* 第0层是C中的malloc，free等内存分配和释放函数进行操作；
	* 第1层和第2层是内存池，有Python的接口函数PyMem_Malloc函数实现，当对象小于256K时有该层直接分配内存；
	* 第3层是最上层，也就是我们对Python对象的直接操作
	
	在 C 中如果频繁的调用 malloc 与 free 时,是会产生性能问题的.再加上频繁的分配与释放小块的内存会产生内存碎片. Python 在这里主要干的工作有:
	
	* 请求分配的内存在`1~256字节`之间就使用自己的内存管理系统,否则直接使用 `malloc`
	* 还是会调用 `malloc` 分配内存,但每次会分配一块大小为256k的大块内存



## python的特殊属性和用法

### 变量前缀和后缀

* `_xxx` 不能用 `from module import *`导入
* `__xxx__` 系统定义名字
* `__xxx` 类中的私有变量名

### 系统定义保留属性

	>>> Class1.__doc__ # 类型帮助信息 'Class1 Doc.' 
	>>> Class1.__name__ # 类型名称 'Class1' 
	>>> Class1.__module__ # 类型所在模块 '__main__' 
	>>> Class1.__bases__ # 类型所继承的基类 (<type 'object'>,) 
	>>> Class1.__dict__ # 类型字典，存储所有类型成员信息。 <dictproxy object at 0x00D3AD70> 
	>>> Class1().__class__ # 类型 <class '__main__.Class1'> 
	>>> Class1().__module__ # 实例类型所在模块 '__main__' 
	>>> Class1().__dict__ # 对象字典，存储所有实例成员信息。 {'i': 1234}

### 系统定义保留方法

#### 类基础方法

	序号	目的	所编写代码	Python 实际调用
	①	初始化一个实例	x = MyClass()	x.__init__()
	②	字符串的“官方”表现形式	repr(x)	x.__repr__()
	③	字符串的“非正式”值	str(x)	x.__str__()
	④	字节数组的“非正式”值	bytes(x)	x.__bytes__()
	⑤	格式化字符串的值	format(x, format_spec)	x.__format__(format_spec)
	
* 对 `__init__()` 方法的调用发生在实例被创建 之后 。如果要控制实际创建进程，请使用 `__new__()` 方法。
* 按照约定， `__repr__()`方法所返回的字符串为合法的 Python 表达式。
* 在调用 print(x) 的同时也调用了 `__str__()`方法。
* 由于 bytes 类型的引入而从 Python 3 开始出现。	

#### 行为方式与迭代器类似的类

	序号	目的	所编写代码	Python 实际调用
	①	遍历某个序列	iter(seq)	seq.__iter__()
	②	从迭代器中获取下一个值	next(seq)	seq.__next__()
	③	按逆序创建一个迭代器	reversed(seq)	seq.__reversed__()

* 无论何时创建迭代器都将调用 `__iter__()`方法。这是用初始值对迭代器进行初始化的绝佳之处。
* 无论何时从迭代器中获取下一个值都将调用 `__next__()`方法。
* `__reversed__()` 方法并不常用。它以一个现有序列为参数，并将该序列中所有元素从尾到头以逆序排列生成一个新的迭代器。

#### 计算属性
 
	序号	目的	所编写代码	Python 实际调用
	①	获取一个计算属性（无条件的）	x.my_property	x.__getattribute__('my_property')
	②	获取一个计算属性（后备）	x.my_property	x.__getattr__('my_property')
	③	设置某属性	x.my_property = value	x.__setattr__('my_property',value)
	④	删除某属性	del x.my_property	x.__delattr__('my_property')
	⑤	列出所有属性和方法	dir(x)	x.__dir__()

* 如果某个类定义了 `__getattribute__()` 方法，在 每次引用属性或方法名称时Python 都调用它（特殊方法名称除外，因为那样将会导致讨厌的无限循环）。
* 如果某个类定义了 `__getattr__()` 方法，Python 将只在`正常的位置查询属性`时才会调用它。如果实例 x 定义了属性color，x.color 将不会 调用`x.__getattr__('color')`；而只会返回x.color已定义好的值。
* 无论何时给属性赋值，都会调用 `__setattr__()`方法。
* 无论何时删除一个属性，都将调用 `__delattr__()`方法。
* 如果定义了 `__getattr__()` 或 `__getattribute__()` 方法， `__dir__()` 方法将非常有用。通常，调用 dir(x) 将只显示正常的属性和方法。如果 `__getattr()__`方法动态处理color 属性，dir(x) 将不会将color 列为可用属性。可通过覆盖 `__dir__()` 方法允许将color 列为可用属性，对于想使用你的类但却不想深入其内部的人来说，该方法非常有益。

#### 行为方式与函数类似的类

可以让类的实例变得可调用——就像函数可以调用一样——通过定义 `__call__()` 方法。

#### 行为方式与序列类似的类

如果类作为一系列值的容器出现——也就是说如果对某个类来说，是否“包含”某值是件有意义的事情——那么它也许应该定义下面的特殊方法已，让它的行为方式与序列类似。

	序号	目的	所编写代码	Python 实际调用
	①	序列的长度	len(seq)	seq.__len__()
	②	了解某序列是否包含特定的值	x in seq	seq.__contains__(x)
	
#### 行为方式与字典类似的类

	序号	目的	所编写代码	Python 实际调用
	①	通过键来获取值	x[key]	x.__getitem__(key)
	②	通过键来设置值	x[key] = value	x.__setitem__(key, value)
	③	删除一个键值对	del x[key]	x.__delitem__(key)
	④	为缺失键提供默认值	x[nonexistent_key]	x.__missing__(nonexistent_key)	
#### 可比较的类

	序号	目的	所编写代码	Python 实际调用
	①	相等	x == y	x.__eq__(y)
	②	不相等	x != y	x.__ne__(y)
	③	小于	x < y	x.__lt__(y)
	④	小于或等于	x <= y	x.__le__(y)
	⑤	大于	x > y	x.__gt__(y)
	⑥	大于或等于	x >= y	x.__ge__(y)
	⑦	布尔上上下文环境中的真值	if x:	x.__bool__()	
#### 可序列化的类

Python 支持 任意对象的序列化和反序列化。（多数 Python 参考资料称该过程为 “pickling” 和 “unpickling”）。该技术对与将状态保存为文件并在稍后恢复它非常有意义。所有的内置数据类型 均已支持 pickling 。如果创建了自定义类，且希望它能够 pickle，阅读pickle 协议 了解下列特殊方法何时以及如何被调用。

	序号	目的	所编写代码	Python 实际调用
	①	自定义对象的复制	copy.copy(x)	x.__copy__()
	②	自定义对象的深度复制	copy.deepcopy(x)	x.__deepcopy__()
	③	在 pickling 之前获取对象的状态	pickle.dump(x, file)	x.__getstate__()
	④	序列化某对象	pickle.dump(x, file)	x.__reduce__()
	⑤	序列化某对象（新 pickling 协议）	pickle.dump(x, file, protocol_version)	x.__reduce_ex__(protocol_version)
	⑥	控制 unpickling 过程中对象的创建方式	x = pickle.load(file)	x.__getnewargs__()
	⑦	在 unpickling 之后还原对象的状态	x = pickle.load(file)	

#### 可在 with 语块中使用的类

	序号	目的	所编写代码	Python 实际调用
	①	在进入 with 语块时进行一些特别操作	with x:	x.__enter__()
	②	在退出 with 语块时进行一些特别操作	with x:	x.__exit__()

#### 类的控制

	序号	目的	所编写代码	Python 实际调用
	①	类构造器	x = MyClass()	x.__new__()
	②	类析构器	del x	x.__del__()
	③	只定义特定集合的某些属性	 	x.__slots__()
	④	自定义散列值	hash(x)	x.__hash__()
	⑤	获取某个属性的值	x.color	type(x).__dict__['color'].__get__(x, type(x))
	⑥	设置某个属性的值	x.color = 'PapayaWhip'	type(x).__dict__['color'].__set__(x, 'PapayaWhip')
	⑦	删除某个属性	del x.color	type(x).__dict__['color'].__del__(x)
	⑧	控制某个对象是否是该对象的实例 your class	isinstance(x, MyClass)	MyClass.__instancecheck__(x)
	⑨	控制某个类是否是该类的子类	issubclass(C, MyClass)	MyClass.__subclasscheck__(C)
	⑩	控制某个类是否是该抽象基类的子类	issubclass(C, MyABC)	MyABC.__subclasshook__(C)
	
### 小结

* `Class1.__doc__`：帮助信息
* `Class1.__name__`：类型名称
* `Class1.__module__`： 模块名
* `Class1.__dict__`： 类型字典，存储所有类型成员信息
* `Class1().__dict__`: 对象字典，存储所有实例成员信息
* `Class1().__class__`：	
* `__init__()`： 初始化实例
* `__new__()`: 类构造器
* `__del__()`: 类析构器
* `__slots__()`: 特定属性
* `__repr__() 和 __str__()`: 字符串表现形式
*  `__iter__()`: 迭代器需要的方法
*  `__next__()`: 迭代器取值
*  `__getattribute__()`: 获取计算属性
*  `__getattr__()`: 获取计算属性
*  `__setattr__()`: 设置某属性
*  `__delattr__()`: 删除某属性
*  `__dir__()`: 显示所有属性
*  ` __call__()`: 实例可被调用
*  `__len__()`: 像序列一样具有长度`len(x)`
*  `__contains__()`: 像序列一样`x in seq`
*  `__getitem__(key), __setitem__(key, value), __delitem__(key)`: 像字典操作键值
*  `__eq__(), __ne__(), __lt__(), __gt__(), __ge__()...`: 可用比较操作符
*  `__enter()__, __exit__()`: `with`语句







## 参考

* [python面试题](https://github.com/zhuwei05/interview_python)
* [Python的特殊属性和用法](http://blog.csdn.net/qq_30175203/article/details/51704636)
