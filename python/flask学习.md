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

	from flask import Flask, render_template
	
	# ...
	
	@app.route('/index')
	def index():
	    return render_template('index.html')
	    
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
	
### 自定义错误页面

	@app.errorhandler(404)
	def page_not_found(e):
	    return render_template('404.html'), 404
	
	@app.errorhandler(500)
	def internal_server_error(e):
	    return render_template('500.html'), 500	
### 链接

	url_for('view function name'[, 动态参数kv])

### 静态文件

	/static/<filename>
	
*e.g.:*favicon定义

	{% block head %}
	{{ super() }}
	<link rel="shortcut icon" href="{{ url_for('static', filename = 'favicon.ico') }}"
	    type="image/x-icon">
	<link rel="icon" href="{{ url_for('static', filename = 'favicon.ico') }}"
	    type="image/x-icon">
	{% endblock %}

### 时间处理:flask-moment

	pip install flask-moment
	
初始化：

	from flask.ext.moment import Moment
	moment = Moment(app)

加载moment.js

	{% block scripts %}
	{{ super() }}
	{{ moment.include_moment() }}
	{% endblock %}	

moment.js实现的函数：

* format
* fromNow
* fromeTime
* calendar
* valueOf
* unix

[moment文档](http://momentjs.com/docs/#/displaying/)

*e.g.*:

	<p>The local date and time is {{ moment(current_time).format('LLL') }}.</p>
	<p>That was {{ moment(current_time).fromNow(refresh=True) }}</p>

### 小结

> flask通过jinja2可以实现模板的渲染，并且可以通过扩展插件，如flask-bootstrap等，可以完成友好的web页面。

## Web表单

表单处理扩展插件：

	pip install flask-wtf
	
### CSRF:跨域保护

flask-wtf防止CSRF攻击，通过产生加密的tokens去认证来自表单的请求：

	app = Flask(__name__)
	app.config['SECRET_KEY'] = 'hard to guess string

app.config用于存储配置，字典类型。

### 表单类

Flask-WTF的web表单继承自`Form`类。

`Form`类定义一系列表单的字段，这些字段是类变量。

WTFForms定义了一些标准的HTML标签对应字段：

|Field type|描述|
|-:-|-:-|
|StringField|Text field|
|...|...|

WTFForms还定义了validators：

* Email
* EqualTo
* IPAddress
* Length
* NumberRange
* Optional
* Required
* Regexp
* URL
* AnyOf
* NoneOf

*e.g.*:

	from flask.ext.wtf import Form
	from wtforms import StringField, SubmitField
	from wtforms.validators import Required

	sclass NameForm(Form):
	    name = StringField('What is your name?', validators=[Required()])
	    submit = SubmitField('Submit')

### 表单渲染

简单：

	<form method="POST">
	    {{ form.name.label }} {{ form.name() }}
	    {{ form.submit() }}
	</form>

通过定义id进行CSS样式设置：

	<form method="POST">
	    {{ form.name.label }} {{ form.name(id='my-text-field') }}
	    {{ form.submit() }}
	</form>		
	
使用bootstrap提供的wft样式：

	{% import "bootstrap/wtf.html" as wtf %}
	{{ wtf.quick_form(form) }}

### 表单处理函数

	@app.route('/', methods=['GET', 'POST'])
	def index():
	    name = None
	    form = NameForm()
	    if form.validate_on_submit():
	        name = form.name.data
	        form.name.data = ''
	    return render_template('index.html', form=form, name=name)


### 重定向和session

#### 重定向

Post/Redirect/Get pattern

*e.g.*: redirect和session进行名字的保存

	from flask import Flask, render_template, session, redirect, url_for
	
	@app.route('/', methods=['GET', 'POST'])
	def index():
	    form = NameForm()
	    if form.validate_on_submit():
	        session['name'] = form.name.data
	        return redirect(url_for('index'))
	    return render_template('index.html', form=form, name=session.get('name'))


### flashing消息

Flask提供flash函数（产生消息）和get_flashed_messages函数（在模板中获取函数）。

`flash('Looks like you have changed your name!')`
和

``

*e.g.:*

hello.py

	from flask import Flask, render_template, session, redirect, url_for, flash
	
	@app.route('/', methods=['GET', 'POST'])
	def index():
	    form = NameForm()
	    if form.validate_on_submit():
	        old_name = session.get('name')
	        if old_name is not None and old_name != form.name.data:
	           	flash('Looks like you have changed your name!')
	        session['name'] = form.name.data
	        form.name.data = ''
	        return redirect(url_for('index'))
	    return render_template('index.html',
	        form = form, name = session.get('name'))

templates/base.html

	{% block content %}
	<div class="container">
	    {% for message in get_flashed_messages() %}
	    <div class="alert alert-warning">
	        <button type="button" class="close" data-dismiss="alert">&times;</button>
	        {{ message }}
	    </div>
	    {% endfor %}
	
	    {% block page_content %}{% endblock %}
	</div>
	{% endblock %}








	

	    