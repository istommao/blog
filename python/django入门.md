#Django入门

1. django-admin startproject projectname
2. 修改settings.py，主要添加appname
2. django-admin startapp appname
3. 修改urls.py：路径，视图函数
4. 修改appname/view.py函数，添加视图函数
5. 启动服务器python manager.py runserver


##模板文件

创建模板目录

	cd appname
	mkdir templates
	增加html文件
		
appname/view.py函数
	
	加载
	from django.template import loader, Context
	from djagno.Http import HttpResponse
	def index(req):
		# 模板
		t = loader.get_template('index.html')
		# 数据
		c = Context({'uname': 'alan'})
		# 数据渲染到模板中
		html = t.render(c)
		return HttpResponse(html)
		
	模板导入也可以通过Template类进行导入
		t = Teplate('index.html')
		
	合并render_to_response
		from django.shortcuts import render_to_response
		return render_to_response('模板文件.html', 字典方式给出需要渲染的数据)	
		

模板变量

	{{}}
	可以为普通变量、字典、对象、列表、方法(没有参数，且有确定返回值)
	{{title}}
	{{dict.key}}
	{{object.attr}}
	{{object.method}}
	{{list.index}}
	
	引用关系：字典、对象、列表
	
在views.py的对应函数

	return render_to_response('模板文件.html', 字典类型的参数)
	
	
模板标签

	{% if 条件%}
	{% else %}
	{% endif %}	

	
##URL配置

urls.py

使用方式

	1.
	url(正则表达式, 视图处理方法)
	2.通过导入对象的方式
	from appname.views import 方法
	3. 可在patterns的第一个参数可以指定视图的前缀，如'appname.views'
	
通过url传到参数

	通过url某一部分作为参数传递：正则表达式分组
	参数名为id，
	url(r'^blog/index/(?P<id>\d{2})/$), 'blog.views.index'),
	
	def index(req, id):
		return render_to_respone('id': id)
		
	如果没有指定参数名，可以在index函数中作为位置参数		
##数据库的使用

* 启动mysql
* 安装MySql-python
* 在settings.py中设置DATABASES：数据库引擎，数据库名，用户，密码
* 表的使用models.py

ORM通过类

	from django.db import models
	class Employee(models.Model):
		name = models.CharField(max_length=20)
		
		def __unicode__(self):
			return self.name
		
数据库同步

	python manage.py syncdb
	
	检查应用下的model，并以此创建数据库表，一些系统表，同时还有appname_表名		

	
创建记录的方式	

	通过对象
		emp = Employee()
		emp.name = 'Alan'
		emp.save()
	在构造方法
		emp = Employee(name='Tom')
	类的管理器
		emp = Employee.objects.create(name='Max')		
记录的查询

	emps = Employee.objects.all()
	
应用到视图中

	修改views.py
	
	def index(req):
		emps = 	Employee.objects.all()
		return render_to_response('index.html', 'emps':emps)
	
	
		
		