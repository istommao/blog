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

