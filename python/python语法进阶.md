#Python的常见用法

##isinstance


##getattr

##@staticmethod @property


##可变和不可变

> 元组，string，数字做函数参数，在内部改变不了。列表可改变。

	def try_to_change(n):
		n = 'Mr. Right'
	
	name = 'Miss. Right'
	try_to_change(name)
	解析：
	n = name
	n = 'Mr. Right'
	
	def chagne(n):
		n[0] = 'Mr. Right'
	
	names = ['Miss. A', 'Miss. B']
	changes(names)
	解析：
	n = names
	n[0] = 'Mr. Right'
	
	进一步，如果用切片，因为切片生成的是副本，所以也不会改变
	change(names[:])

