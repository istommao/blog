title: python 浅拷贝和深拷贝
date: 2017-02-03 14:40:00
tags:
- python
- copy

# python 浅拷贝和深拷贝

* [python 浅拷贝和深拷贝](https://my.oschina.net/taisha/blog/54741)

Python中的对象之间赋值时是按引用传递的，如果需要拷贝对象，需要使用标准库中的copy模块。

1. copy.copy 浅拷贝 只拷贝父对象，不会拷贝对象的内部的子对象。
2. copy.deepcopy 深拷贝 拷贝对象及其子对象

一个很好的例子：

```
import  copy
a  =  [ 1 ,  2 ,  3 ,  4 , [ ' a ' ,  ' b ' ]]  # 原始对象 
 
b  =  a  # 赋值，传对象的引用 
 c  =  copy.copy(a)  # 对象拷贝，浅拷贝 
 d  =  copy.deepcopy(a)  # 对象拷贝，深拷贝 
 
a.append( 5 )  # 修改对象a 
 a[ 4 ].append( ' c ' )  # 修改对象a中的['a', 'b']数组对象 
 
 print   ' a =  ' , a
 print   ' b =  ' , b
 print   ' c =  ' , c
 print   ' d =  ' , d
```

输出结果： 

```
a = [1, 2, 3, 4, ['a', 'b', 'c'], 5] 
b = [1, 2, 3, 4, ['a', 'b', 'c'], 5] 
c = [1, 2, 3, 4, ['a', 'b', 'c']] 
d = [1, 2, 3, 4, ['a', 'b']]

```

注意：**还有一种浅拷贝的方式**，就是使用类似于 `a = set(a)` 这种格式,即

* 复制列表 L ,使用 list(L),
* 要复制一个字典 d ,使用 dict(d),
* 要复制一个集合 s ,使用 set(s)

	这样,我们总结出一个规律,如果你要复制一个对象 o,它属于内建的类型t ,那么你可以使用 `t(o)` 来获得一个拷贝. dict 也提供了一个复制版本, `dict.copy`, 这个和 `dict(d)` 是一样,我推荐你使用后者,这个使得代码更一致,而且还少几个字符.
	
	

