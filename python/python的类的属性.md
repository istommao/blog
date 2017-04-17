#Python类的相关知识
===

`object.__class__`:


**Python 有两个用于继承的函数：**

* 函数 `isinstance()` 用于检查实例类型：`isinstance(obj, int)` 只有在 `obj.__class__` 是 int 或其它从 int 继承的类型

* 函数 `issubclass()` 用于检查类继承：`issubclass(bool, int)` 为 True，因为 bool 是 int 的子类。

	但是，issubclass(unicode, str) 是 False，因为 unicode 不是 str 的子类(它们只是共享一个通用祖先类 basestring )。

###私有变量和类本地引用

只能从对像内部访问的“私有”实例变量，在 Python 中不存在。

不过：

*以一个下划线开头的命名*(例如 _spam )会被处理为 API 的非公开部分(无论它是一个函数、方法或数据成员)。它会被视为一个实现细节，无需公开。

*任何形如 __spam 的标识(前面至少两个下划线，后面至多一个)*，被替代为 _classname__spam ，去掉前导下划线的 classname 即当前的类名。

> 要注意的是代码传入 exec， eval() 或 execfile() 时不考虑所调用的类的类名，视其为当前类，这类似于 global 语句的效应，已经按字节编译的部分也有同样的限制。这也同样作用于 getattr()， setattr() 和 delattr()，像直接引用 \_\_dict\_\_ 一样。

### `__slots__`

* <http://stackoverflow.com/questions/472000/usage-of-slots>
* <https://www.ibm.com/developerworks/cn/linux/l-python-elegance-2.html>

使用 Python 2.2，我们获得了一种创建 “限制” 类的新机制。新式类 `_slots_` 属性的具体用途并不十分明了。大部分情况下，Python 文档建议只有对具有大量实例的类进行性能优化时使用 .`__slots__` —— 但这绝不是 一种声明属性的方法。但是，后者正是 slot 的作用：它们将创建一个不具备 `.__dict__` 属性的类，其中的属性都经过显式命名（然而，在类主体内仍按常规声明方法）。这有一点特别，但是这种方法可以确保在访问属性时调用方法代码：
清单 3. 确保方法执行使用 `.__slots__`

	>>> class Foo2(object):
	...     __slots__ = ('just_this')
	...     def __getattr__(self, name):
	...         return "Value of %s" % name
	>>> foo2 = Foo2()
	>>> foo2.just_this = "I'm slotted"
	>>> foo2.just_this
	"I'm slotted"
	>>> foo2.something_else = "I'm not slotted"
	AttributeError: 'Foo' object has no attribute 'something_else'
	>>> foo2.something_else
	'Value of something_else'

声明 `.__slots__` 可确保只能直接访问您指定的那些属性；所有属性都将经过 `.__getattr__()` 调用。如果您还创建了一个 `.__setattr__()` 方法，您可以指定执行一些其他工作，而不是引发一个 AttributeError（但要确保在指定中使用经过 “slot” 处理的值）。例如：
清单 4. 结合使用 `.__setattr__` 和 `.__slots__`
	
	>>> class Foo3(object):
	...     __slots__ = ('x')
	...     def __setattr__(self, name, val):
	...         if name in Foo.__slots__:
	...             object.__setattr__(self, name, val)
	...     def __getattr__(self, name):
	...         return "Value of %s" % name
	...
	>>> foo3 = Foo3()
	>>> foo3.x
	'Value of x'
	>>> foo3.x = 'x'
	>>> foo3.x
	'x'
	>>> foo3.y
	'Value of y'
	>>> foo3.y = 'y'   # Doesn't do anything, but doesn't raise exception
	>>> foo3.y
	'Value of y'