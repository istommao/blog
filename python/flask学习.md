title: flask学习
date: 2016-02-21 22:10:10
tags:
- python
- flask

# flask学习

## 安装

* virtualenv
* pip

## flask应用的结构

* 初始化

		from flask import Flask
		app = Flask(__name__)
* routes和函数

	> 装饰器：
	
	> 路由：不带参数和带参数，如'/'和'/user/\<name\>'
	> 	

	
		@app.route('/')
		def index():
	    	return '<h1>Hello World!</h1>'
	    
	   @app.route('/user/<name>')
			def user(name):
    		return '<h1>Hello, %s!</h1>' % name
    	
    				
* 	server启动

		if __name__ == '__main__':
	    	app.run(debug=True)
		

## Hello world

	from flask import Flask
	app = Flask(__name__)
	
	@app.route('/')
	def index():
	    return '<h1>Hello World!</h1>'
	
	if __name__ == '__main__':
	    app.run(debug=True)
	    
## 请求和响应

### Context和request

为了避免每个函数都需要传递`request`参数，flask通过将request设置为在`context`下的“全局”参数。flask有两种`context`：

* application context: 变量current_app和g
* request context：变量request和session

### request hooks

4个装饰器：

* before_first_request
* before_request
* after_request
* teardown_request

一般可以通过`g`变量在request hook函数和view函数之间共享数据。

### response

view函数返回：

* 字符串[ ,status code [,有关header的字典]]
* response对象

*e.g.*:

	@app.route('/')
	def index():
		return '<h1>Bad Request</h1>', 400	
	
	@app.route('/')
	def index():
	    response = make_response('<h1>This document carries a cookie!</h1>')
	    response.set_cookie('answer', '42')
	    return response


重定向：

	@app.route('/')
	def index():
	    return redirect('http://www.example.com')

404：

	abort(404)
	
## flask扩展

	
	    