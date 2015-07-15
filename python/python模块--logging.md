#python模块--logging
===

日志模块

##4个主要的组件

logger对象: 日志类，应用程序往往通过调用它提供的api来记录日志；

handler: 对日志信息处理，可以将日志发送(保存)到不同的目标域中；

filter: 对日志信息进行过滤；

formatter:日志的格式化；

##logging模块的API
###模块级函数
===
* logging.getLogger([name]) 
	
	返回一个logger实例，如果没有指定name，返回root logger。
	
	只要name相同，返回的logger实例都是同一个而且只有一个。无需把logger实例在各个模块中传递。
	
* logging.debug()、logging.info()、logging.warning()、logging.error()、logging.critical()

	设定root logger的日志级别	。
	
	参数(msg [ ,\*args [, \*\*kwargs]])：msg是信息的格式，args与kwargs分别是格式参数。
	
* 	logging.basicConfig([**kwargs])
	为日志模块配置基本信息。kwargs 支持如下几个关键字参数：

		filename ：日志文件的保存路径。如果配置了些参数，将自动创建一个FileHandler作为Handler；
		filemode ：日志文件的打开模式。 默认值为'a'，表示日志消息以追加的形式添加到日志文件中。如果设为'w', 那么每次程序启动的时候都会创建一个新的日志文件；
		format ：设置日志输出格式；
		datefmt ：定义日期格式；
		level ：设置日志的级别.对低于该级别的日志消息将被忽略；
		stream ：设置特定的流用于初始化StreamHandler；

	如果调用logging.debug()、logging.info()、logging.warning()、logging.error()、logging.critical() 函数时，发现root logger没有任何handler， 会自动调用basicConfig添加一个handler。反之，如果root logger已有handler，不做任何事情


	

###logger对象
===
* Logger.setLevel(lvl)

	设置logger的level，level有以下几个级别：

	NOTSET < DEBUG < INFO < WARNING < ERROR < CRITICAL

	可以给日志对象(Logger Instance)设置日志级别，低于该级别的日志消息将会被忽略，也可以给Hanlder设置日志级别，对于低于该级别的日志消息, Handler也会忽略。

* Logger.debug()、Logger.info()、Logger.warning()、Logger.error()、Logger.critical()：可以设置的日志级别

* Logger.addFilter(filt)、Logger.removeFilter(filt):添加或删除指定的filter

* Logger.addHandler(hdlr)、Logger.removeHandler(hdlr)：增加或删除指定的handler 

###handler
===
####Logger.addHandler(hdlr)
logger可以添加handler来帮它处理日志， handler主要有以下几种：

* StreamHandler: 输出到控制台
* FileHandler:   输出到文件

handler还可以设置自己的level以及输出格式。

* Handler.setLevel(lel):指定被处理的信息级别，低于lel级别的信息将被忽略。所以handler的级别可以logger.setLevel不一致。

* Handler.setFormatter()：给这个handler选择一个格式

* Handler.addFilter(filt)、Handler.removeFilter(filt)：新增或删除一个filter对象

####Logger.removeHandler(hdlr)

###Formatter
====
Formatters

Formatter对象设置日志信息最后的规则、结构和内容，默认的时间格式为%Y-%m-%d %H:%M:%S，下面是Formatter常用的一些信息

<table cellpadding="0" cellspacing="0" border="1">
<tbody>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(name)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">Logger的名字</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(levelno)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">数字形式的日志级别</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(levelname)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">文本形式的日志级别</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(pathname)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">调用日志输出函数的模块的完整路径名，可能没有</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(filename)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">调用日志输出函数的模块的文件名</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(module)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">调用日志输出函数的模块名</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(funcName)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">调用日志输出函数的函数名</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(lineno)d</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">调用日志输出函数的语句所在的代码行</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(created)f</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">当前时间，用UNIX标准的表示时间的浮 点数表示</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(relativeCreated)d</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">输出日志信息时的，自Logger创建以 来的毫秒数</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(asctime)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">字符串形式的当前时间。默认格式是 &ldquo;2003-07-08 16:49:45,896&rdquo;。逗号后面的是毫秒</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(thread)d</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">线程ID。可能没有</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(threadName)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">线程名。可能没有</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(process)d</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">进程ID。可能没有</span></p>
</td>
</tr>
<tr>
<td valign="top" width="189">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">%(message)s</span></p>
</td>
<td valign="top" width="358">
<p style="margin-top: 1em; margin-right: 0px; margin-bottom: 0.5em; margin-left: 0px; padding: 0px;" align="left"><span style="font-size: 13px;">用户输出的消息</span></p>
</td>
</tr>
</tbody>
</table>

###filter
====
####Logger.addFilter(filt)
####Logger.removeFilter(filt)
　　添加/移除日志消息过滤器。
　　
##例子
	#!/usr/bin/python2.6
	# -*- coding:utf8 -*-
	import logging
	
	# 配置logging
	# logging.basicConfig(level=logging.DEBUG,
	#                     format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
	#                     # datefmt='%m-%d %H:%M',
	#                     filename='test.log',
	#                     filemode='w')
	
	# 创建一个logger
	logger = logging.getLogger('mylogger')
	logger.setLevel(logging.DEBUG)
	
	# 创建一个handler，用于写入日志文件
	fh = logging.FileHandler('test.log')
	fh.setLevel(logging.DEBUG)
	
	# 再创建一个handler，用于输出到控制台
	ch = logging.StreamHandler()
	ch.setLevel(logging.INFO)
	
	# 定义handler的输出格式
	formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
	fh.setFormatter(formatter)
	ch.setFormatter(formatter)
	
	# 给logger添加handler
	logger.addHandler(fh)
	logger.addHandler(ch)
	
	# 记录一条日志
	logger.debug("debug message")
	logger.info("info message")
	logger.warn("warn message")
	logger.error("error message")
	logger.critical("critical message")
	
	输出结果：
	终端：
	2015-07-15 18:45:03,528 - mylogger - INFO - info message
	2015-07-15 18:45:03,528 - mylogger - WARNING - warn message
	2015-07-15 18:45:03,528 - mylogger - ERROR - error message
	2015-07-15 18:45:03,528 - mylogger - CRITICAL - critical message
	
	test.log文件：
	2015-07-15 18:45:03,528 - mylogger - DEBUG - debug message
	2015-07-15 18:45:03,528 - mylogger - INFO - info message
	2015-07-15 18:45:03,528 - mylogger - WARNING - warn message
	2015-07-15 18:45:03,528 - mylogger - ERROR - error message
	2015-07-15 18:45:03,528 - mylogger - CRITICAL - critical message
	
	