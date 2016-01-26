title: scala
date: 2016-01-26 07:35:47
tags:
- scala

---

# scala进阶

## 视图界定view bounds

	<%

## 上下文界定context bounds

	[T: Ordering]
	
## ClassTag,Manifest,ClassManifest,Typetag

Manifest的上下文界定

	[T: Mainfest]
	
创建泛型数组

	var r = new Array[T](2);	
	
ClassTag是对Manifest的改进


## 多重界定

	T <: A with B
	T >: A with B
	T >: A <: B
	T : A : B
	T <% A <% B
	
## 类型约束

	A =:= B A类型等同于B类型
	A <:< B A类型是B类型的子类型
	
## variance

## 链式调用

## 路径依赖

			
				
	