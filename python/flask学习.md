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

### flask-script

命令行选项

## 模板

### Jinja2模板引擎

flask默认查找**templates**子目录的模板文件

#### 渲染模板

templates/user.html

	<h1>Hello, {{name}}!<h1>
	
hello.py

	@app.route('/user/	<name>')
	def user(name):
		return render_template('user.html', name=name)
		
第一个参数指定模板文件，其余参数为key/value类型，可以在模板中作为变量和变量值使用。

#### 变量

	{{ name }}
	
支持多种类型：

	<p>A value from a dictionary: {{ mydict['key'] }}.</p>
	<p>A value from a list: {{ mylist[3] }}.</p>
	<p>A value from a list, with a variable index: {{ mylist[myintvar] }}.</p>
	<p>A value from an object's method: {{ myobj.somemethod() }}.</p>
	
#### 过滤

* safe
* capitalize
* lower
* upper
* title
* trim
* striptags

*e.g.*	

	{{ name|captalize }}
			
#### 控制结构

条件

	{% if user %}
    Hello, {{ user }}!
	{% else %}
	    Hello, Stranger!
	{% endif %}

循环

	<ul>
	    {% for comment in comments %}
	        <li>{{ comment }}</li>
	    {% endfor %}
	</ul>	

宏定义

	{% macro render_comment(comment) %}
	    <li>{{ comment }}</li>
	{% endmacro %}
	
	<ul>
	    {% for comment in comments %}
	        {{ render_comment(comment) }}
	    {% endfor %}
	</ul>


导入

	{% import 'macros.html' as macros %}
	<ul>
	    {% for comment in comments %}
	        {{ macros.render_comment(comment) }}
	    {% endfor %}
	</ul>

include

	{% include 'common.html' %}
	
模板继承

*base.html*

	<html>
	<head>
	    {% block head %}
	    <title>{% block title %}{% endblock %} - My Application</title>
	    {% endblock %}
	</head>
	<body>
	    {% block body %}
	    {% endblock %}
	</body>
	</html>		

**block中的tag在继承的模本中可以修改**

	{% extends "base.html" %}
	{% block title %}Index{% endblock %}
	{% block head %}
	    {{ super() }}
	    <style>
	    </style>
	{% endblock %}
	{% block body %}
	<h1>Hello, World!</h1>
	{% endblock %}

### 集成Bootstrap with Flask-Bootstrap

	pip install flask-bootstrap

初始化：

	from flask.ext.bootstrap import Bootstrap
	# ...
	bootstrap = Bootstrap(app)	
	
bootstrap/base.html定义的一些block：

* doc
* html_attribs
* html
* head
* title
* metas
* styles
* body_attribs
* body
* navbar
* content
* scripts

如果要增加和bootstrap预定义的block，可以通过调用super()实现：

	{% block scripts %}
	{{ super() }}
	<script type="text/javascript" src="my-script.js"></script>
	{% endblock %}

使用了bootstrap的user.html

*e.g.*:	templates/user.html

	{% extends "bootstrap/base.html" %}
	
	{% block title %}Flasky{% endblock %}
	
	{% block navbar %}
	<div class="navbar navbar-inverse" role="navigation">
	    <div class="container">
	        <div class="navbar-header">
	            <button type="button" class="navbar-toggle"
	             data-toggle="collapse" data-target=".navbar-collapse">
	                <span class="sr-only">Toggle navigation</span>
	                <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	            </button>
	            <a class="navbar-brand" href="/">Flasky</a>
	        </div>
	        <div class="navbar-collapse collapse">
	            <ul class="nav navbar-nav">
	                <li><a href="/">Home</a></li>
	            </ul>
	        </div>
	    </div>
	</div>
	{% endblock %}
	
	{% block content %}
	<div class="container">
	    <div class="page-header">
	        <h1>Hello, {{ name }}!</h1>
	    </div>
	</div>
	{% endblock %}
	
	
	
	
	    