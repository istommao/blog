# python模块-arrow

* [arrow docs](http://arrow.readthedocs.io/en/latest/)

当前时间: 

	arrow.now()

字符串转成 arrow 时间:

	arrow.get('2017-03-10')
	
arrow 时间 格式化为时间字符串:

	arrow.get('2017-03-10').strftime("%Y-%m-%d %H:%M:%S")
	
arrow 时间得到 datetime:

	arrow.now().datetime


