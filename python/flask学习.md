title: Flask学习
date: 2016-02-21 22:10:10
tags:
- python
- flask

# Flask学习

[Flask Web Development](http://flaskbook.com/)分为三部分：

* Flask框架基础：Flask web应用框架和一些扩展
* 项目：[Flasky](https://github.com/miguelgrinberg/flasky)
* 发布Application前的准备：单测、性能分析、部署

## Flask框架基础


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

	(venv) $ pip install flask-bootstrap

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

	(venv) $ pip install flask-moment
	
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

	(venv) $ pip install flask-wtf
	
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


## 数据库

选择数据库框架：

* 易用
* 性能
* 可移植性性

### Flask-SQLAlchemy

SQLAlchemy一个支持多种数据库的ORM框架。

安装Flask-SQLAlchemy

	(venv) $ pip install flask-sqlalchemy

在Flask-SQLAlchemy中，数据库通过URL表示

* MySQL: *mysql://username:password@hostname/database*
* Postgres: *postgrequl://username:password@hostname/database*
* SQLite(Unix): *sqlite:////absulte/path/to/database*
* SQLite(Windows): *sqlite:///c:/absulte/path/to/database*

在Flask中使用，需要配置`SQLALCHEMY_DATABASE_URI`和`SQLALCHEMY_COMMIT_ON_TEARDOWN`

*e.g.:*

	from flask.ext.sqlalchemy import SQLAlchemy
	
	basedir = os.path.abspath(os.path.dirname(__file__))
	
	app = Flask(__name__)
	app.config['SQLALCHEMY_DATABASE_URI'] =\
	    'sqlite:///' + os.path.join(basedir, 'data.sqlite')
	app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True
	
	db = SQLAlchemy(app)

### 模型定义

ORM简单说来就是一个Python类，它具有一些属性，这些属性与数据库中表中的列对应。

Flask-SQLAlchemy提供基类：`db.Model`。

类变量`__tablename__`指定表名。

类`db.Column`可以定义类的属性（表中列）。

db.Column构造器第一个参数指定类型：

* 参数: python类型（说明）
* Integer：int(32bit)
* Small-Integer: int(16bit)
* Big-Integer: int/long
* Float: float
* Numberic: decimal.Decimal
* String: str(可变字符串)
* Text: str（可变字符串，会优化）
* Unicode: unicode(可变unicode字符串)
* Unicode-Text: unicode(可变字符串, 会优化)
* Boolean: bool
* Date: datetime.date
* Time: datetime.time
* Date-Time: datetime.datetime
* Interval: datetime.timedelta
* Enum: str
* Pickle-Type: 任意python对象
* LargeBinary: str(Binary blob)

其他参数属性的选项：

* primary_key
* unique
* index
* nullable
* default

虽然并不是必要，但是通常都会给模型定义`__repr__()`函数用来生成可读的字符串表示。


*e.g.*：

	class Role(db.Model):
	    __tablename__ = 'roles'
	    id = db.Column(db.Integer, primary_key=True)
	    name = db.Column(db.String(64), unique=True)
	
	    def __repr__(self):
	        return '<Role %r>' % self.name
	
	class User(db.Model):
	    __tablename__ = 'users'
	    id = db.Column(db.Integer, primary_key=True)
	    username = db.Column(db.String(64), unique=True, index=True)
	
	    def __repr__(self):
	        return '<User %r>' % self.username

### 关系

#### one-to-many

一个role属于多个user，每个user都只有一个角色。

`db.realationship`第一个参数指定对象模型。

其他参数：

* backref: 反向关系
* primaryjoin: 指定两个模型的join条件。一般有多个外键的时候，SQLAlchemy不能自己决定关系时，需要指定
* lazy：指定相关联的items什么时候加载, *select, immediate,joined,subquery,noload,dynamic* 
* userlist：为Flase时，使用标量
* order_by：
* secondary: 指定关联表的名称，用于many-to-many
* secondaryjoin: 指定第二个join条件，当SQLAlchemy不能自己决定时关系时，需要使用

*e.g.*:

	class Role(db.Model):
	    # ...
	    users = db.relationship('User', backref='role')
	
	class User(db.Model):
	    # ...
	    role_id = db.Column(db.Integer, db.ForeignKey('roles.id'))

#### one-to-one

`ono-to-one`的使用类似`one-to-many`,只是将`userlist`设置为`Flase`。

#### many-to-many

需要提供额外的`association table`。

### 数据库操作

#### 创建表

	SQLAlchemy基于model类来创建表
	
	(venv) $ python hello.py shell
	>>> from hello import db
	>>> db.create_all()

#### 更新表

重新创建，弊端：旧数据被删除。更好的方法通过Flask-Migrate

	db.drop_all()
	db.create_all()	
	
#### 插入

构建对象

	>>> from hello import Role, User
	>>> admin_role = Role(name='Admin')
	>>> mod_role = Role(name='Moderator')
	>>> user_role = Role(name='User')
	>>> user_john = User(username='john', role=admin_role)
	>>> user_susan = User(username='susan', role=user_role)
	>>> user_david = User(username='david', role=user_role)

> 构造器模型接受模型属性的关键字参数作为初始值。主键的指定由Flask-SQLAlchemy自动指定。

添加到session中：

	>>> db.session.add(admin_role)
	>>> db.session.add(mod_role)
	>>> db.session.add(user_role)
	>>> db.session.add(user_john)
	>>> db.session.add(user_susan)
	>>> db.session.add(user_david)

	或：
	
	>>> db.session.add_all([admin_role, mod_role, user_role,
	...     user_john, user_susan, user_david])

提交：commit()

	>>> db.session.commit()
	
#### 修改


	>>> admin_role.name = 'Administrator'
	>>> db.session.add(admin_role)
	>>> db.session.commit()	

#### 删除

删除：delete()

	>>> db.session.delete(mod_role)
	>>> db.session.commit()

#### 查询

每个模型类都有一个`query`对象

*e.g.:*

	>>> Role.query.all()
	[<Role u'Administrator'>, <Role u'User'>]
	>>> User.query.all()
	[<User u'john'>, <User u'susan'>, <User u'david'>]

过滤器:

* filter():
* filter_by():
* limit(): 
* offset():
* order_by():
* group_by():

执行器：

* all():
* first():
* first_or_404():
* get():
* get_or_404():
* count():
* paginate():


*e.g.*


	>>> User.query.filter_by(role=user_role).all()
	[<User u'susan'>, <User u'david'>]

使用SQL语句：转换query对象为字符串

	>>> str(User.query.filter_by(role=user_role))
	'SELECT users.id AS users_id, users.username AS users_username,
	users.role_id AS users_role_id FROM users WHERE :param_1 = users.role_id'

##### 完善关系：（没明白）

由于不指定lazy的话，`user_role.users`表达式会内部调用all()返回结果，因为`query`对象被隐藏，这样就不能添加过滤器，因此最好添加上`lazy`字段：

	class Role(db.Model):
	    # ...
	    users = db.relationship('User', backref='role', lazy='dynamic')
	    # ... 

这样修改后，`user_role.users`不会马上执行，就可以添加过滤器了：

	>>> user_role.users.order_by(User.username).all()
	[<User u'david'>, <User u'susan'>]
	>>> user_role.users.count()
	2
	
#### 在View Functions中使用数据库

直接使用前面学习的数据库的操作	

*e.g.:*

hello.py

	@app.route('/', methods=['GET', 'POST'])
	def index():
	    form = NameForm()
	    if form.validate_on_submit():
	        user = User.query.filter_by(username=form.name.data).first()
	        if user is None:
	            user = User(username = form.name.data)
	            db.session.add(user)
	            session['known'] = False
	        else:
	            session['known'] = True
	        session['name'] = form.name.data
	        form.name.data = ''
	        return redirect(url_for('index'))
	    return render_template('index.html',
	        form = form, name = session.get('name'),
	        known = session.get('known', False))

templates/index.html

	{% extends "base.html" %}
	{% import "bootstrap/wtf.html" as wtf %}
	
	{% block title %}Flasky{% endblock %}
	
	{% block page_content %}
	<div class="page-header">
	    <h1>Hello, {% if name %}{{ name }}{% else %}Stranger{% endif %}!</h1>
	    {% if not known %}
	    <p>Pleased to meet you!</p>
	    {% else %}
	    <p>Happy to see you again!</p>
	    {% endif %}
	</div>
	{{ wtf.quick_form(form) }}
	{% endblock %}
	
#### 使用Flask-Script集成

每次都要导入数据库实例很麻烦，通过Flask-Script

	from flask.ext.script import Shell
	
将要导入的对象在`make_context`中注册：

hello.py

	from flask.ext.script import Shell
	
	def make_shell_context():
	    return dict(app=app, db=db, User=User, Role=Role)
	    
	manager.add_command("shell", Shell(make_context=make_shell_context))
	

### 数据库迁移

Flask-Migrate
	
	(venv) $ pip install flask-migrate
	
配置：导出MigrateCommand类

hello.py:

	from flask.ext.migrate import Migrate, MigrateCommand
	
	# ...
	
	migrate = Migrate(app, db)
	manager.add_command('db', MigrateCommand)
	
迁移前，创建一个迁移库：

	(venv) $ python hello.py db init
	
创建migration脚本：upgrade()和downgrade()

	(venv) $ python hello.py db migrate -m "initial migration"

更新数据库：第一次执行时，类似于执行`db.create_all()`，但是后来执行时，会更新表而不影响对应的内容。

	(venv) $ python hello.py db upgrade

	
## Email

python自带smtplib支持邮件的发送。Flask-Mail对其进行了封装并与Flask集成。

	(venv) $ pip install flask-mail
	
SMTP服务配置：

* MAIL_HOSTNAME: localhost
* MAIL_PORT: 25	
* MAIL_USE_TLS: False
* MAIL_USE_SSL: False
* MAIL_USERNAME: None
* MAIL_PASSWORD: None

*e.g.:*配置外部服务器机初始化：

hello.py

	# 配置
	import os
	# ...
	app.config['MAIL_SERVER'] = 'smtp.googlemail.com'
	app.config['MAIL_PORT'] = 587
	app.config['MAIL_USE_TLS'] = True
	app.config['MAIL_USERNAME'] = os.environ.get('MAIL_USERNAME')
	app.config['MAIL_PASSWORD'] = os.environ.get('MAIL_PASSWORD')

	# 初始化
	
	from flask.ext.mail import Mail
	mail = Mail(app)
	
MAIL_USERNAME和MAIL_PASSWORD都需要在系统环境变量中设置：

	Linux or Mac
	(venv) $ export MAIL_USERNAME=<Gmail username>
	(venv) $ export MAIL_PASSWORD=<Gmail password>

	Windows
	(venv) $ set MAIL_USERNAME=<Gmail username>
	(venv) $ set MAIL_PASSWORD=<Gmail password>

### 发送邮件

	from flask.ext.mail import Message
	
	app.config['FLASKY_MAIL_SUBJECT_PREFIX'] = '[Flasky]'
	app.config['FLASKY_MAIL_SENDER'] = 'Flasky Admin <flasky@example.com>'
	
	def send_email(to, subject, template, **kwargs):
	    msg = Message(app.config['FLASKY_MAIL_SUBJECT_PREFIX'] + subject,
	                  sender=app.config['FLASKY_MAIL_SENDER'], recipients=[to])
	    msg.body = render_template(template + '.txt', **kwargs)
	    msg.html = render_template(template + '.html', **kwargs)
	    mail.send(msg)
	    
template不用给指定扩展名，这样可以传递不同的内容，`**kwargs`传递给template使用

### 异步发送

	from threading import Thread
	
	def send_async_email(app, msg):
	    with app.app_context():
	        mail.send(msg)
	
	def send_email(to, subject, template, **kwargs):
	    msg = Message(app.config['FLASKY_MAIL_SUBJECT_PREFIX'] + subject,
	                  sender=app.config['FLASKY_MAIL_SENDER'], recipients=[to])
	    msg.body = render_template(template + '.txt', **kwargs)
	    msg.html = render_template(template + '.html', **kwargs)
	    thr = Thread(target=send_async_email, args=[app, msg])
	    thr.start()
	    return thr    
	
注意：大部分Flask的扩展都在active的application和request context中，而上面代码使用多线程时，就需要调用`app.app_context()`手动构建application context。


## Flask构建大型应用的结构

Flask没有要求应用的结构。下面给出一种可能的应用结构。

### 目录结构

	|-app_name
	  |-app/
	    |-templates/
	    |-static/
	    |-main/
	      |-__init__.py
	      |-errors.py
	      |-forms.py
	      |-views.py
	    |-__init__.py
	    |-email.py
	    |-models.py
	  |-migrations/
	  |-tests/
	    |-__init__.py
	    |-test*.py
	  |-venv/
	  |-requirements.txt
	  |-config.py
	  |-manage.py
	
	
* app/：Flask应用
* migrations/: 数据库migration的脚本
* tests/: 测试包
* venv/: virtualenv	  
* requirements.txt: 列出依赖的包（可以改成文件夹，里面分别存放生产环境、开发环境所需要的依赖文件，可以将公共部分提出到common.txt文件，然后在对应的dev.txt头部添加`-r common.txt`）
* config.py: 配置文件
* manage.py: 启动应用和其他任务

	  
	  
### config.py

配置文件。

定义**开发、测试、生成**的配置文件。

	import os
	basedir = os.path.abspath(os.path.dirname(__file__))
	
	class Config:
		# ...
		@staticmethod
	    def init_app(app):
	        pass
		# ...
		  
		  
	class DevelopmentConfig(Config):
		# ...
	
	class TestingConfig(Config):
		# ...
		
	class ProductionConfig(Config):
		# ...
		
	config = {
		'development': DevelopmentConfig,
		'testing': TestingConfig,
		'production': ProductionConfig,
		
		'default': DevelopmentConfig
	}

### App包

#### 使用一个app工厂

* 使用无参数构造器初始化flask扩展应用
* 根据配置文件，使用flask提供的config.from_object()读取配置
* 调用init_app()?

*e.g:*

app/\_\_init\_\_.py
 
	from flask import Flask, render_template
	from flask.ext.bootstrap import Bootstrap
	from flask.ext.mail import Mail
	from flask.ext.moment import Moment
	from flask.ext.sqlalchemy import SQLAlchemy
	from config import config
	
	bootstrap = Bootstrap()
	mail = Mail()
	moment = Moment()
	db = SQLAlchemy()
	
	def create_app(config_name):
	    app = Flask(__name__)
	    app.config.from_object(config[config_name])
	    config[config_name].init_app(app)
	
	    bootstrap.init_app(app)
	    mail.init_app(app)
	    moment.init_app(app)
	    db.init_app(app)
	
	    # attach routes and custom error pages here
	
	    return app

#### 实现app的功能：blueprint

在单个脚本的应用中，app实例在全局变量中，所以路由的设置通过app.route装饰器可以很容易实现。

但是，现在的app在运行时在被创建，所以`app.route`和`app.errorhandler`都不能再使用了。

因此，Flask提供给了一个叫`blueprints`的解决方案。

`blueprints`定义路由类似于`app.route`，但是blueprint直到应用注册才变成可用。

*e.g.:*

app/main/\_\_init\_\_.py
	
	from flask import Blueprint
	
	main = Blueprint('main', __name__)
	
	from . import views, errors	
	
**注意：由于views和errors依赖main，因此要放在main之后，不然出现相互依赖的问题**	
	
在包中定义的：

* app/main/views.py：处理应用路由
* app/main/errors.py: 处理错误

##### 注册blueprint

app/\_\_init\_\_.py


	def create_app(config_name):
	    # ...
	
	    from main import main as main_blueprint
	    app.register_blueprint(main_blueprint)
	
	    return app	
	
##### app/main/errors.py

	from flask import render_template
	from . import main
	
	@main.app_errorhandler(404)
	
	def page_not_found(e):
	    return render_template('404.html'), 404
	
	@main.app_errorhandler(500)
	def internal_server_error(e):
	    return render_template('500.html'), 500

与app.errorhandler的区别为main.app_errorhandler	
	
##### app/main/errors.py

	from datetime import datetime
	from flask import render_template, session, redirect, url_for
	from . import main
	from .forms import NameForm
	from .. import db
	from ..models import User
	
	@main.route('/', methods=['GET', 'POST'])
	def index():
	    form = NameForm()
	    if form.validate_on_submit():
	        # ...
	        return redirect(url_for('.index'))
	    return render_template('index.html',
	                           form=form, name=session.get('name'),
	                           known=session.get('known', False),
	                           current_time=datetime.utcnow())	
	
区别：

* app.route变为main.route
* url_for函数：由于使用blueprint其构建了一个命名空间（blueprint的名字），因此原来`url_for('index)`就要改为`url_for('main.index')`或简写为`url_for('.index')`
。在不同的blueprint，不能使用简写的方式。

### 启动脚本

manage.py

	#!/usr/bin/env python
	import os
	from app import create_app, db
	from app.models import User, Role
	from flask.ext.script import Manager, Shell
	from flask.ext.migrate import Migrate, MigrateCommand
	
	app = create_app(os.getenv('FLASK_CONFIG') or 'default')
	manager = Manager(app)
	migrate = Migrate(app, db)
	
	def make_shell_context():
	    return dict(app=app, db=db, User=User, Role=Role)
	manager.add_command("shell", Shell(make_context=make_shell_context))
	manager.add_command('db', MigrateCommand)
	
	if __name__ == '__main__':
	    manager.run()
		

### requirements文件

记录依赖的特定版本的包

	(venv) $ pip freeze > requirements.txt
	
根据requirements.txt重新构建：

	(venv) $ pip install -r requirements.txt
	
### 单元测试

tests/test_basic.py

	import unittest
	from flask import current_app
	from app import create_app, db
	
	class BasicsTestCase(unittest.TestCase):
	    def setUp(self):
	        self.app = create_app('testing')
	        self.app_context = self.app.app_context()
	        self.app_context.push()
	        db.create_all()
	        
	    def tearDown(self):
	        db.session.remove()
	        db.drop_all()
	        self.app_context.pop()
	
	    def test_app_exists(self):
	        self.assertFalse(current_app is None)
	
	    def test_app_is_testing(self):
	        self.assertTrue(current_app.config['TESTING'])
	        

Python单测包：

* setUp(): 每个测试前执行
* tearDown(): 每个测试后执行
* test_前缀: 测试函数

#### 运行单测

manage.py

	@manager.command
	def test():
	    """Run the unit tests."""
	    import unittest
	    tests = unittest.TestLoader().discover('tests')
	    unittest.TextTestRunner(verbosity=2).run(tests)
    		

manager.command装饰器可以很容易实现自己的命令，被它修饰的函数名作为自定义的命令，函数的docstring作为help messages。

	(venv) $ python manage.py test
	
### 设置数据库

	(venv) $ python manage.py db upgrade
    			
	
## 博客小项目Flasky

[flask学习2]()

## 发布应用前准备


## 资料

* [Flask Extention](http://flask.pocoo.org/extensions/)
* [Python Package Index](http://pypi.python.org/)
* [Github](github.com)
* 


## 参考
* [Flask Web Development](http://flaskbook.com/)
* [Flasky](https://github.com/miguelgrinberg/flasky)





	

	    