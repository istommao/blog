title: numpy常见函数学习
date: 2017-06-22 21:00:00
tags:
- numpy

# numpy常见函数学习

## numpy 数组

* 数组维度称为: axes
* axes的数目: rank
* numpy 的数组类: ndarray, 也即: numpy.array


### ndarray 的基本属性:

* ndarray.ndim: number of axes, 就是 rank
* ndarray.shape: 一个元组，表示数组的维度。比如，对于 `n x m` 矩阵，`shape = (n, m)`, shape 的长度就是 `ndim (rank)`
* ndarray.size: 数组的元素个数，`n x m`
* ndarray.dtype: 描述数组元素类型的对象。如，python 类型，或 numpy提供的类型 `numpy.int32`, `numpy.float32` 等等。类型装换 `astpye(float)`
* ndarray.itemsize: 单个元素的字节。如，`float64` 的 `itemsize` 就是 `8`
* ndarray.data: 数组的元素真实的 buffer。一般用不到，而是通过索引(下标) 去访问

### ndarray 的常见构建方法:

* arange: 类似 python 的 range
* reshape: 改变数组的 `shape`。如：`a = np.arange(15).reshape(3, 5)`
* 数组创建: 

	* 通过 python 的 list 和 tuple: `a = np.array([2,3,4])` 和 `b = np.array([(1.5,2,3), (4,5,6)])`
	* 已知 size: `np.zeros( (3,4) )`, `np.ones( (2,3,4), dtype=np.int16 )`, `np.empty( (2,3) )`
	* `np.arange( 10, 30, 5 )`, 更常用 `np.linspace( 0, 2, 9 )`： 在 [0, 2] 中得到 9 个数字
	* `a = np.random.random((2,3))`
	* 其他: `array, zeros, zeros_like, ones, ones_like, empty, empty_like, arange, linspace, numpy.random.rand, numpy.random.randn, fromfunction, fromfile`
	

### 基本操作:

#### 算术操作是 `elementwise` 的：

```
>>> a = np.array( [20,30,40,50] )
>>> b = np.arange( 4 )
>>> b
array([0, 1, 2, 3])
>>> c = a-b
>>> c
array([20, 29, 38, 47])

```

```
>>> b**2
array([0, 1, 4, 9])
```

```
>>> 10*np.sin(a)
array([ 9.12945251, -9.88031624,  7.4511316 , -2.62374854])
>>> a<35
array([ True, True, False, False], dtype=bool)
```

数组的点乘不是用 `*` 而是用 `dot`

```
>>> A = np.array( [[1,1],
...             [0,1]] )
>>> B = np.array( [[2,0],
...             [3,4]] )
>>> A*B                         # elementwise product
array([[2, 0],
       [0, 4]])
>>> A.dot(B)                    # matrix product
array([[5, 4],
       [3, 4]])
>>> np.dot(A, B)                # another matrix product
array([[5, 4],
       [3, 4]])
```

其他: `+=`, `*=` 等

#### unary 操作一般实现为函数

* a.sum(), a.min(), a.max(), a.cumsum()
* 一般来说，这些函数默认将 array 看成是为元素的列表

	```
	>>> a = np.random.random((2,3))
>>> a
array([[ 0.18626021,  0.34556073,  0.39676747],
       [ 0.53881673,  0.41919451,  0.6852195 ]])
>>> a.sum()
2.5718191614547998
>>> a.min()
0.1862602113776709
>>> a.max()
0.6852195003967595
	```
* 通过指定 `axis` 指定特定的 axis。比如: 0 代表每一列，1表示每一行...

	```
	>>> b = np.arange(12).reshape(3,4)
>>> b
array([[ 0,  1,  2,  3],
       [ 4,  5,  6,  7],
       [ 8,  9, 10, 11]])
>>>
>>> b.sum(axis=0)                            # sum of each column
array([12, 15, 18, 21])
>>>
>>> b.min(axis=1)                            # min of each row
array([0, 4, 8])
>>>
>>> b.cumsum(axis=1)                         # cumulative sum along each row
array([[ 0,  1,  3,  6],
       [ 4,  9, 15, 22],
       [ 8, 17, 27, 38]])
	```

### 索引, 切片, iterating

* 对于一维数组，索引、切片、iterating 和 python 的 list 类似
* 对于多维数组，可以给每一个 axis 指定

	```
	>>> def f(x,y):
...     return 10*x+y
...
>>> b = np.fromfunction(f,(5,4),dtype=int)
>>> b
array([[ 0,  1,  2,  3],
       [10, 11, 12, 13],
       [20, 21, 22, 23],
       [30, 31, 32, 33],
       [40, 41, 42, 43]])
>>> b[2,3]
23
>>> b[0:5, 1]                       # each row in the second column of b
array([ 1, 11, 21, 31, 41])
>>> b[ : ,1]                        # equivalent to the previous example
array([ 1, 11, 21, 31, 41])
>>> b[1:3, : ]                      # each column in the second and third row of b
array([[10, 11, 12, 13],
       [20, 21, 22, 23]])
	```	
	
* 如果给定的索引值不足，缺失的索引默认为: `:`
* 类似的，可以使用 `dots(...)`，如 x.rank = 5,

	```
	x[1,2,...] is equivalent to x[1,2,:,:,:],
	x[...,3] to x[:,:,:,:,3] and
	x[4,...,5,:] to x[4,:,:,5,:].
	```
* 多维矩阵的 `iterating` 操作默认通过第一个 axis 完成，如果想展开，可使用 `flat` 属性:


	```
	>>> for row in b:
	...     print(row)
	...
	[0 1 2 3]
	[10 11 12 13]
	[20 21 22 23]
	[30 31 32 33]
	[40 41 42 43]
	
		>>> for element in b.flat:
	...     print(element)
	...
	0
	1
	2
	3
	10
	11
	12
	13
	20
	21
	22
	23
	30
	31
	32
	33
	40
	41
	42
	43
	```	
	
	
#### 高级索引操作

* 一维数组提供一个索引数组

	```
	a = np.arange(12)**2 
	array([  0,   1,   4,   9,  16,  25,  36,  49,  64,  81, 100, 121])
	i = np.array( [ 1,1,3,8,5 ] )
	a[i]
	array([ 1,  1,  9, 64, 25])
	j = np.array( [ [ 3, 4], [ 9, 7 ] ] )
	a[j]
	array([[ 9, 16],
       [81, 49]])
	```	
	
* 多维数组，每个维度提供的索引数组的 shape 要一样

	```
	>>> a = np.arange(12).reshape(3,4)
	>>> a
	array([[ 0,  1,  2,  3],
	       [ 4,  5,  6,  7],
	       [ 8,  9, 10, 11]])
	>>> i = np.array( [ [0,1],                        # indices for the first dim of a
	...                 [1,2] ] )
	>>> j = np.array( [ [2,1],                        # indices for the second dim
	...                 [3,3] ] )
	>>>
	>>> a[i,j]                                     # i and j must have equal shape
	array([[ 2,  5],
	       [ 7, 11]])
	>>>
	>>> a[i,2]
	array([[ 2,  6],
	       [ 6, 10]])
	>>> a[i, :]
	array([[[ 0,  1,  2,  3],
        [ 4,  5,  6,  7]],

       [[ 4,  5,  6,  7],
        [ 8,  9, 10, 11]]])
	>>> a[:,j]                                     # i.e., a[ : , j]
	array([[[ 2,  1],
	        [ 3,  3]],
	       [[ 6,  5],
	        [ 7,  7]],
	       [[10,  9],
	        [11, 11]]])	
	```
	
* 使用 Boolean 数组选择/赋值元素
* `ix_()` 函数: 得到可组合的多个列向量

	```
>>> a = np.array([2,3,4,5])
>>> b = np.array([8,5,4])
>>> c = np.array([5,4,6,8,3])
>>> ax,bx,cx = np.ix_(a,b,c)
>>> ax
array([[[2]],
       [[3]],
       [[4]],
       [[5]]])
>>> bx
array([[[8],
        [5],
        [4]]])
>>> cx
array([[[5, 4, 6, 8, 3]]])
>>> ax.shape, bx.shape, cx.shape
((4, 1, 1), (1, 3, 1), (1, 1, 5))
>>> result = ax+bx*cx	
	```	


### shape 操作

生成新的数组:

* ravel(): 展平
* reshape(6, 2), reshape((6, 2)), 如果其中一个维度设为 -1, 该维度会自动计算, reshape(6, -1)
* T: 转置

```
a = np.floor(10*np.random.random((3,4)))
a.ravel()
a.reshape(6, 2)
a.T
```

修改自身:

* resize((2, 6))


### stacking 不同的数组

```
a = np.floor(10*np.random.random((2,2)))
b = np.floor(10*np.random.random((2,2)))
```	

* np.vstack((a,b))
* np.hstack((a,b))
* np.column_stack((a,b)): stacks 1D arrays 作为列

> 对于 `维度 > 2` 的数组，hstacks 沿着第二个 axes, vstacks 沿着第一个 axes

其他: `concatenate, c_, r_`


### 切分数组

```
a = np.floor(10*np.random.random((2,12)))
np.hsplit(a,3)   # Split a into 3
np.hsplit(a,(3,4))   # Split a after the third and the fourth column
```

* np.hsplit()
* np.vsplit()
* np.array_split()


### 拷贝

#### 不拷贝

* 简单赋值，不拷贝
* 传递可变对象，不拷贝


#### view 和浅拷贝

* c = a.view(), 改变 c.shape 不影响 a, 但是改变 c 的值会改变a 中的值
* 切片操作就是返回数组的view，因此它与 view 一样

#### 深拷贝

* d = a.copy(), 改变 d 不会对 a 有任何改变


## 全局函数 Universal Functions (ufunc)

`ufunc` 操作数组也是 `elementwise` 的，如:

```
>>> B = np.arange(3)
>>> B
array([0, 1, 2])
>>> np.exp(B)
array([ 1.        ,  2.71828183,  7.3890561 ])
>>> np.sqrt(B)
array([ 0.        ,  1.        ,  1.41421356])
>>> C = np.array([2., -1., 4.])
>>> np.add(B, C)
array([ 2.,  0.,  6.])
```

`ufunc` 函数有：

```
all, any, apply_along_axis, argmax, argmin, argsort, 
average, bincount, ceil, clip, conj, corrcoef, cov, 
cross, cumprod, cumsum, diff, dot, floor, inner, inv,
lexsort, max, maximum, mean, median, min, minimum, 
nonzero, outer, prod, re, round, sort, std, sum, 
trace, transpose, var, vdot, vectorize, where
```


## 线性代数

* 转置: a.transpose()
* 逆: np.linalg.inv(a)
* 单位矩阵: u = np.eye(2)
* 矩阵相乘(点积): np.dot (j, j)
* 迹: np.trace(u)  # trace
* 特征值和特征向量: np.linalg.eig(j)
* 


## 函数和方法的概览

### Array Creation

arange, array, copy, empty, empty_like, eye, fromfile, fromfunction, identity, linspace, logspace, mgrid, ogrid, ones, ones_like, r, zeros, zeros_like

### Conversions
ndarray.astype, atleast_1d, atleast_2d, atleast_3d, mat

### Manipulations
array_split, column_stack, concatenate, diagonal, dsplit, dstack, hsplit, hstack, ndarray.item, newaxis, ravel, repeat, reshape, resize, squeeze, swapaxes, take, transpose, vsplit, vstack

### Questions
all, any, nonzero, where

### Ordering
argmax, argmin, argsort, max, min, ptp, searchsorted, sort

### Operations
choose, compress, cumprod, cumsum, inner, ndarray.fill, imag, prod, put, putmask, real, sum

### Basic Statistics
cov, mean, std, var

### Basic Linear Algebra
cross, dot, outer, linalg.svd, vdot


## 广播

* The first rule of broadcasting is that if all input arrays do not have the same number of dimensions, a “1” will be repeatedly prepended to the shapes of the smaller arrays until all the arrays have the same number of dimensions. 如果输入数组的维度不同，会将小维度的数组不断通过加入 “1”，最终使得所有数组有相同的维度

* The second rule of broadcasting ensures that arrays with a size of 1 along a particular dimension act as if they had the size of the array with the largest shape along that dimension. The value of the array element is assumed to be the same along that dimension for the “broadcast” array. 如果数组特定的维度只有一个元素的数组，那么会将其扩展为该维度中最大维度的 shape



## 常用函数

* np.reshape()
* np.asleast_2d(): 将参数数组变为 2D

	```
	>>> np.atleast_2d(3.0)
	array([[ 3.]])
	
	>>> x = np.arange(3.0)
	>>> np.atleast_2d(x)
	array([[ 0.,  1.,  2.]])
	
	>>> np.atleast_2d(1, [1, 2], [[1, 2]])
	[array([[1]]), array([[1, 2]]), array([[1, 2]])]
	```
	
* np.fromarray()
* 切片
* append
* np.random.rand(k, m, n, ...): 生成 `kxmxnx...` 的矩阵，其元素均匀分布在区间(0, 1)上
* np.random.randn(k, m, n, ...): 生成 `kxmxnx...` 的矩阵，其元素服从正态分布



## 参考

* [Quickstart tutorial](https://docs.scipy.org/doc/numpy-dev/user/quickstart.html)