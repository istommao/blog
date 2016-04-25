title: python的main函数新写法
date: 2016-04-25 10:45:20
tags:
- python

# python的main函数新写法

## 添加可选的 `argv` 参数

	def main(argv=None):
	    if argv is None:
	        argv = sys.argv
	    # etc., replacing sys.argv with argv in the getopt() call.

这样做，我们就可以动态地提供 `argv` 的值，这比下面这样写更加的灵活：

	def main(argv=sys.argv):
	    # etc.

这是因为在调用函数时，`sys.argv` 的值可能会发生变化； 可选参数的默认值都是在定义`main()`函数时，就已经计算好的 。

但是现在 `sys.exit()` 函数调用会产生问题：当 `main()` 函数调用 `sys.exit()` 时，交互式解释器就会推出！解决办法是让 `main()` 函数的返回值指示退出状态（exit status）。因此，最后面的那行代码就变成了这样：

	if __name__ == "__main__":
	    sys.exit(main())

并且，`main()`函数中的 `sys.exit(n)` 调用全部变成 `return n`

## 定义一个Usage()异常

另一个改进之处，就是定义一个`Usage()`异常，可以在 `main()` 函数最后的 `except` 子句捕捉该异常

	import sys
	import getopt
	
	class Usage(Exception):
	    def __init__(self, msg):
	        self.msg = msg
	
	def main(argv=None):
	    if argv is None:
	        argv = sys.argv
	    try:
	        try:
	            opts, args = getopt.getopt(argv[1:], "h", ["help"])
	        except getopt.error, msg:
	             raise Usage(msg)
	        # more code, unchanged
	    except Usage, err:
	        print >>sys.stderr, err.msg
	        print >>sys.stderr, "for help use --help"
	        return 2
	
	if __name__ == "__main__":
	    sys.exit(main())

这样 `main()` 函数就只有一个退出点（exit）了，这比之前两个退出点的做法要好。而且，参数解析重构起来也更容易：在辅助函数中引发 `Usage` 的问题不大，但是使用 `return 2` 却要求仔细处理返回值传递的问题。


## 参考

* [Python之父教你Python入门](http://www.techug.com/python-father-teach-you-learn-python) 