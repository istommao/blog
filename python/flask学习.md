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
	    


	    