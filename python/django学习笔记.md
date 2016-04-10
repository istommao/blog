#Django学习笔记
===
## Django 全貌
* urls.py
	
	网址入口，关联到对应的views.py中的一个函数（或者generic类），访问网址就对应一个函数。

* views.py

	处理用户发出的请求，从urls.py中对应过来, 通过渲染templates中的网页可以将显示内容，比如登陆后的用户名，用户请求的数据，输出到网页。

* models.py

	与数据库操作相关，存入或读取数据时用到这个，当然用不到数据库的时候 你可以不使用。

* forms.py
	
	表单，用户在浏览器上输入数据提交，对数据的验证工作以及输入框的生成等工作，当然你也可以不使用。

* templates 文件夹

	views.py 中的函数渲染templates中的Html模板，得到动态内容的网页，当然可以用缓存来提高速度。

* admin.py

	后台，可以用很少量的代码就拥有一个强大的后台。

* settings.py

	Django 的设置，配置文件，比如 DEBUG 的开关，静态文件的位置等。
	
## Django基本命令

1. 新建一个 django-project

		django-admin.py startproject project-name
	一个 project 一般为一个项目

2. 新建 app
	
		python manage.py startapp app-name
		或 django-admin.py startapp app-name

	一般一个项目有多个app, 当然通用的app也可以在多个项目中使用。

3. 同步数据库

		python manage.py syncdb
 
		注意：Django 1.7.1及以上的版本需要用以下命令
		python manage.py makemigrations
		python manage.py migrate

	这种方法可以创建表，当你在models.py中新增了类时，运行它就可以自动在数据库中创建表了，不用手动创建。

	备注：对已有的 models 进行修改，Django 1.7之前的版本的Django都是无法自动更改表结构的，不过有第三方工具 south,详见 Django 数据库迁移 一节。

4. 使用开发服务器

		python manage.py runserver
 
		# 当提示端口被占用的时候，可以用其它端口：
		python manage.py runserver 8001
		python manage.py runserver 9999
 
		# 监听所有可用 ip
		python manage.py runserver 0.0.0.0:8000
		# 如果是外网或者局域网电脑上可以用其它电脑查看开发服务器
		# 访问对应的 ip加端口，比如 http://172.16.20.2:8000
		
5. 清空数据库

		python manage.py flush
	
	此命令会询问是 yes 还是 no, 选择 yes 会把数据全部清空掉，只留下空表。

6. 创建超级管理员

		python manage.py createsuperuser

7. 导出数据 导入数据

		python manage.py dumpdata appname > appname.json
		python manage.py loaddata appname.json

	

8. django 项目环境终端

		python manage.py shell

	如果你安装了 bpython 或 ipython 会自动用它们的界面，强烈推荐用 bpython

9. 数据库命令行

		python manage.py dbshell

	Django 会自动进入在settings.py中设置的数据库，如果是 MySQL 或 postgreSQL,会要求输入数据库用户密码。

	在这个终端可以执行数据库的SQL语句。如果您对SQL比较熟悉，可能喜欢这种方式。

10. 更多命令

	终端上输入 python manage.py 可以看到详细的列表，在忘记了名称的时候特别有用。	
	
	
## Django视图和网址

Django中网址是写在 urls.py 文件中，用正则表达式对应 views.py 中的一个函数(或者generic类)。

* 新建一个项目(project), 名称为 mysite

		django-admin startproject mysite
		出错的话，用django-admin.py
		
		运行后,如果成功的话, 我们会看到如下的目录样式   (没有成功的请参见环境搭建一节)：

		mysite
		├── manage.py
		└── mysite
		    ├── __init__.py
		    ├── settings.py
		    ├── urls.py
		    └── wsgi.py

	新建了一个 mysite 目录，其中还有一个 mysite 目录，这个子目录 mysite 中是一些项目的设置 settings.py 文件，总的urls配置文件 urls.py 以及部署服务器时用到的 wsgi.py 文件， \_\_init\_\_.py 是python包的目录结构必须的，与调用有关。

* 新建一个应用(app), 名称叫 learn

		python manage.py startapp learn # learn 是一个app的名称
		
	以看到mysite中多个一个 learn 文件夹，其中有以下文件:
	
		learn/
		├── __init__.py
		├── admin.py
		├── models.py
		├── tests.py
		└── views.py		

	**把我们新定义的app加到settings.py中的INSTALL_APPS中**:
	修改 mysite/mysite/settings.py
	
		INSTALLED_APPS = (
		    'django.contrib.admin',
		    'django.contrib.auth',
		    'django.contrib.contenttypes',
		    'django.contrib.sessions',
		    'django.contrib.messages',
		    'django.contrib.staticfiles',
		    
		    'learn',
		)
		
	新建的 app 如果不加到 INSTALL_APPS 中的话, django 就不能自动找到app中的模板文件(app-name/templates/下的文件)和静态文件(app-name/static/中的文件)	
	
* 定义视图函数

	在learn目录中，views.py里，修改其中源码为：
	
		#coding:utf-8
		from django.http import HttpResponse
		 
		def index(request):
		    return HttpResponse(u"欢迎光临 自强学堂!")
		    
	第一行是声明编码为utf-8, 因为我们在代码中用到了中文,如果不声明就报错.

	第二行引入HttpResponse，它是用来向网页返回内容的，就像Python中的 print 一样，只不过 HttpResponse 是把内容显示到网页上。

	我们定义了一个index()函数，第一个参数必须是request,，与网页发来的请求有关，可以包含get或post的内容,函数返回一行字到网页。

	**那我们访问什么网址才能看到刚才写的这个函数呢？怎么让网址和函数关联起来呢？ 继续往下⬇️**
	
* 定义视图函数相关的URL(网址)	

	打开 mysite/mysite/urls.py 这个文件, 修改其中的代码:
	
		urlpatterns = [
	    	# 添加此行
	    	url(r'^$', 'learn.views.index', name='home'),
	
	    	url(r'^admin/', include(admin.site.urls)),
		]
	
	
	Django中的urls.py用的是正则进行匹配的，所以上面的应该是表示原始url，映射的函数为learn目录下的views文件的index函数。

	name的作用就是一个标示，这样在网页代码时，使用它来标示，这样即使后面修改网址，比如learn.views.index2后，只要name没改变，网页代码也不需要改变。
	
##Django模板

* 同上的，先创建django project和app

		django-admin.py startproject zw_tmpl
		cd zw_tmpl
		python manage.py start app learn

* 添加learn到setting.INSTALLED_APPS

* 	在view.py中加入代码

		def home(request):
			return render(request, 'home.html')

* 在learn目录下加入文件夹templates，并在其中新建home.html文件

	*默认配置下，Django 的模板系统会自动找到app下面的templates文件夹中的模板文件。*
	
* 编写home.html文件
* 将视图函数对应到网址，修改urls.py，在urlpatterns添加：

		url(r'^s', 'learn.views.home', name='home'),
		
* 同步数据库

		python manage.py syncdb
	
* 运行开发服务器

		python manage.py runserver
		
###补充：

网站模板的设计，一般的，我们做网站有一些通用的部分，比如 导航，底部，访问统计代码等等**nav.html, bottom.html, tongji.html**

**可以写一个 base.html 来包含这些通用文件（include)**

	<!DOCTYPE html>
	<html>
	<head>
	    <title>{% block title %}默认标题{% endblock %} - zhuwei05的小站</title>
	</head>
	<body>
	 
	{% include 'nav.html' %}
	 
	{% block content %}
	<div>这里是默认内容，所有继承自这个模板的，如果不覆盖就显示这里的默认内容。</div>
	{% endblock %}
	 
	{% include 'bottom.html' %}
	 
	{% include 'tongji.html' %}
	 
	</body>
	</html>			

如果需要，写足够多的**block**以便继承的模板可以重写该部分，**include**是包含其它文件的内容，就是把一些网页共用的部分拿出来，重复利用，改动的时候也方便一些，还可以把广告代码放在一个单独的html中，改动也方便一些，在用到的地方include进去。其它的页面继承自 **base.html**就好了，继承后的模板也可以在 block 块中 include 其它的模板文件。

比如我们的首页 home.html，**继承或者说扩展(extends)原来的 base.html**，可以简单这样写，重写部分代码（默认值的那一部分不用改）

	{% extends 'base.html' %}
	 
	{% block title %}欢迎光临首页{% endblock %}
	 
	{% block content %}
	{% include 'ad.html' %}
	这里是首页，欢迎光临
	{% endblock %}
			
> 注意：模板一般放在app下的templates中，Django会自动找到。假如我们每个app都有一个 index.html，当我们在views.py中使用的时候，如何判断是当前 app 的 home.html 呢?

> 这就需要把每个app中的 templates 文件夹中再建一个 app 的名称，仅和该app相关的模板放在 app/templates/app/ 目录下面，

> 比如，projectA，下面startapp有两个app为A，B，那么分别在A，B文件夹中新建templates，然后再在分别其下新建文件夹A和B，把html文件分别放在这里就可以了，即A/templates/A/ 和B/templates/B/

###Django模板中的循环，条件判断，常用的标签，过滤器的使用

####list和字典使用举例

* 列表

	views.py

		def home(request):
		    TutorialList = ["HTML", "CSS", "jQuery", "Python", "Django"]
		    return render(request, 'home.html', {'TutorialList': TutorialList})
	    
	在视图中我们传递了一个List到模板 home.html，在模板中这样使用它：

	home.html

		教程列表：
		{% for i in TutorialList %}
		{{ i }}
		{% endfor %}	
		
* 字典

	views.py

		def home(request):
    		info_dict = {'site': u'自强学堂', 'content': u'各种IT技术教程'}
    
    		return render(request, 'home.html', {'info_dict': info_dict})

	home.html

		站点：{{ info_dict.site }} 内容：{{ info_dict.content }}


**小结**：一般的变量之类的用： 双花括号（变量），功能类的，比如循环，条件判断是用： 单括号（标签）

###for

在for循环中还有很多有用的东西，如下：

	变量	描述
	forloop.counter	索引从 1 开始算
	forloop.counter0	索引从 0 开始算
	forloop.revcounter	索引从最大长度到 1
	forloop.revcounter0	索引从最大长度到 0
	forloop.first	当遍历的元素为第一项时为真
	forloop.last	当遍历的元素为最后一项时为真
	forloop.parentloop	 用在嵌套的 for 循环中，获取上一层 for 循环的 forloop

当列表中可能为空值时用语法：`for empty`

	<ul>
	{% for athlete in athlete_list %}
	    <li>{{ athlete.name }}</li>
	{% empty %}
	    <li>抱歉，列表为空</li>
	{% endfor %}
	</ul>


###模板上得到视图对应的网址：`{% url "view-name" arg1 arg2 %}`

	# urls.py
	urlpatterns = patterns('',
	    url(r'^add/(\d+)/(\d+)/$', 'calc.views.add', name='add'),
	)
	 
	# template html
	{% url 'add' 4 5 %}

###模板中的逻辑操作：

* ==, !=, >=, <=, >, < 这些比较都可以在模板中使用

* and, or, not, in, not in 也可以在模板中使用

###Django渲染json到模板

直接在视图函数（views.py中的函数）中渲染一个 list 或 dict 和其它的网页部分一起显示到网页上

需要注意的是，我们如果直接这么做，传递到 js 的时候，网页的内容会被转义，得到的格式会报错。

**需要注意两点：1. views.py中返回的函数中的值要用 json.dumps()处理，2. 在网页上要加一个 safe 过滤器。**

**举例**

views.py

	# -*- coding: utf-8 -*-
	 
	from __future__ import unicode_literals
	 
	import json
	from django.shortcuts import render
	 
	def home(request):
	    List = ['django', 'json渲染']
	    Dict = {'site': 'zhuwei05.com', 'author': 'zhuwei05'}
	    return render(request, 'home.html', {
	            'List': json.dumps(List),
	            'Dict': json.dumps(Dict)
	        })

home.html 只给出了 js 核心部分：

	//列表
	var List = {{ List|safe }};
	//字典
	var Dict = {{ Dict|safe }};

##Django模型（数据库）

Django 模型是与数据库相关的，与数据库相关的代码一般写在 `models.py` 中，Django 支持 sqlite3, MySQL, PostgreSQL等数据库，只需要在settings.py中配置即可，不用更改models.py中的代码，丰富的API极大的方便了使用。

* 新建project和app

		django-admin.py startproject learn_models # 新建一个项目
		cd learn_models # 进入到该项目的文件夹
		django-admin.py startapp people # 新建一个 people 应用（app)
		
	补充：新建app也可以用 python manage.py startapp people, 需要指出的是，django-admin.py 是安装Django后多出的一个命令，并不是指一个 django-admin.py 脚本在当前目录下。

	那么project和app什么关系呢，一个项目一般包含多个应用，一个应用也可以用在多个项目中。


* 新建的应用（people）添加到 settings.py 中的 INSTALLED_APPS中，也就是告诉Django有这么一个应用。

* people/models.py 文件，修改其中的代码

		from django.db import models
	 
		class Person(models.Model):
		    name = models.CharField(max_length=30)
		    age = models.IntegerField()

	新建了一个Person类，继承自models.Model, 一个人有姓名和年龄。这里用到了两种Field，更多Field类型可以参考教程最后的链接。
	
	> name 和 age 等字段中不能有 __（双下划线，因为在Django QuerySet API中有特殊含义（用于关系，包含，不区分大小写，以什么开头或结尾，日期的大于小于，正则等）

	> 也不能有Python中的关键字，name 是合法的，student_name 也合法，但是student__name不合法，try, class, continue 也不合法，因为它是Python的关键字( import keyword; print(keyword.kwlist) 可以打出所有的关键字)

* 同步一下数据库

		python manage.py syncdb # 进入 manage.py 所在的那个文件夹下输入这个命令
 
		注意：Django 1.7 及以上的版本需要用以下命令
		python manage.py makemigrations
		python manage.py migrate

* 使用


	新建一个对象的方法有以下几种：

		Person.objects.create(name=name,age=age)
		
		p = Person(name="WZ", age=23)
		
		p.save()
		
		p = Person(name="TWZ")
		
		p.age = 23
		
		p.save()
		
		Person.objects.get_or_create(name="WZT", age=23)

	这种方法是防止重复很好的方法，但是速度要相对慢些，返回一个元组，第一个为Person对象，第二个为True或False, 新建时返回的是True, 已经存在时返回False.



	获取对象有以下方法：

		Person.objects.all()
		
		Person.objects.all()[:10] 切片操作，获取10个人，不支持负索引，切片可以节约内存
		
		Person.objects.get(name=name)



	get是用来获取一个对象的，如果需要获取满足条件的一些人，就要用到filter

		Person.objects.filter(name="abc") # 等于Person.objects.filter(name__exact="abc") 名称严格等于 "abc" 的人
		
		Person.objects.filter(name__iexact="abc") # 名称为 abc 但是不区分大小写，可以找到 ABC, Abc, aBC，这些都符合条件
		
		
		
		Person.objects.filter(name__contains="abc") # 名称中包含 "abc"的人
		
		Person.objects.filter(name__icontains="abc") #名称中包含 "abc"，且abc不区分大小写
		
		
		
		Person.objects.filter(name__regex="^abc") # 正则表达式查询
		
		Person.objects.filter(name__iregex="^abc")# 正则表达式不区分大小写


	filter是找出满足条件的，当然也有排除符合某条件的

		Person.objects.exclude(name__contains="WZ") # 排除包含 WZ 的Person对象
		
		Person.objects.filter(name__contains="abc").exclude(age=23) # 找出名称含有abc, 但是排除年龄是23岁的


###Django 的官方提供了很多的 Field，但是有时候还是不能满足我们的需求，不过Django提供了自定义 Field 的方法

###QuerySet API

从数据库中查询出来的结果一般是一个集合，这个集合叫做 QuerySet。基本SQL语句的各种查询方法都有对应的API。

##Django 后台

与后台相关文件：每个app中的 admin.py 文件与后台相关。

django的后台我们只要加少些代码，就可以实现强大的功能。

##Django表单

request.GET 可以看成一个字典，用GET方法传递的值都会保存到其中，可以用 request.GET.get('key', None)来取值，没有时不报错。

* 新建project和app

		新建一个 form2 项目
		django-admin.py startproject form2
		# 进入到 form2 文件夹，新建一个 tools APP
		python manage.py startapp tools

* 在tools文件夹中新建一个 forms.py 文件

		from django import forms
		 
		class AddForm(forms.Form):
		    a = forms.IntegerField()
		    b = forms.IntegerField()

* 视图函数 views.py 中

		# coding:utf-8
		from django.shortcuts import render
		from django.http import HttpResponse
		 
		# 引入我们创建的表单类
		from .forms import AddForm
		 
		def index(request):
		    if request.method == 'POST':# 当提交表单时
		     
		        form = AddForm(request.POST) # form 包含提交的数据
		         
		        if form.is_valid():# 如果提交的数据合法
		            a = form.cleaned_data['a']
		            b = form.cleaned_data['b']
		            return HttpResponse(str(int(a) + int(b)))
		     
		    else:# 当正常访问时
		        form = AddForm()
		    return render(request, 'index.html', {'form': form})


* 对应的模板文件 index.html
	
		<form method='post'>

		<input type="submit" value="提交">
		</form>	

* 再在 urls.py 中对应写上这个函数

		urlpatterns = patterns('',
		    # 注意下面这一行
		    url(r'^$', 'tools.views.index', name='home'),
		    url(r'^admin/', include(admin.site.urls)),
		)


##Django配置

settings.py

* BASE_DIR： 项目 所在目录
* DEBUG＝True 时，如果出现 bug 便于我们看见问题所在，但是部署时最好不要让用户看见bug的详情
* ALLOWED_HOSTS 允许你设置哪些域名可以访问，即使在Apache中绑定了，这里不允许的话，也是不能访问的。
* static 是静态文件所有目录，比如 jquery.js, bootstrap.min.css 等文件。

	一般来说我们只要把静态文件放在 APP 中的 static 目录下，部署时用 python manage.py collectstatic 就可以把静态文件收集到 STATIC_ROOT 目录，但是有时我们有一些共用的静态文件，这时候可以设置 STATICFILES_DIRS 另外弄一个文件夹，如下：

* media文件夹用来存放用户上传的文件，与权限有关

	MEDIA_URL = '/media/'
	
	MEDIA_ROOT = os.path.join(BASE_DIR,'media')

##Django 静态文件

静态文件是指 网站中的 js, css, 图片，视频等文件


	






























	