title: python中 i+=x 和 i = i + x
date: 2017-02-04 21:00:00
tags:
- python
- iadd
- add

# python中 i+=x 和 i=i+x

* http://mp.weixin.qq.com/s/jluii9YIvfhKd_tPecfTaw


> 整数操作时两者没什么异同，但是对于列表操作（可变对象与不可变对象后）就不一样了，`+=` 会有副作用

代码1:

```
>>> l1 = range(3)
>>> l2 = l1
>>> l2 += [3]  # 使用__iadd__，l2的值原地修改
>>> l1
[0, 1, 2, 3]
>>> l2
[0, 1, 2, 3]

```

代码2:

```
>>> l1 = range(3)
>>> l2 = l1
>>> l2 = l2 + [3] # 调用 __add__，创建了一个新的列表，赋值给了l2
>>> l1
[0, 1, 2]
>>> l2
[0, 1, 2, 3]
```

> ，回到问题本身，+= 与 +的区别在哪里呢？

> `+=` 操作首先会尝试调用对象的 `__iadd__` 方法，如果没有该方法，那么尝试调用 `__add__` 方法，先来看看这两个方法有什么区别:

* `__add__` 方法接收两个参数，返回它们的和，两个参数的值均不会改变。
* `__iadd__` 方法同样接收两个参数，但它是属于 **in-place** 操作，就是说它会改变第一个参数的值，因为这需要对象是可变的，所以对于不可变对象没有 `__iadd__` 方法。

```
>>> hasattr(int, '__iadd__')
False
>>> hasattr(list, '__iadd__')
True
```