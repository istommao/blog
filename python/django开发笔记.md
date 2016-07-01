title: django开发笔记
date: 2016-06-21 10:48:00
tags:
- django

# django开发笔记

### 创建超级用户

	python manage.py createsuperuser
	
### migration

	python manage.py makemigrations <app-name>
	python manage.py migrate

### 权限获取

	python manage.py shell
	  
	>>> from django.contrib.auth import models
	>>> for x in models.Group.objects.filter(name="my_group_name")[0].permissions.all():
	...     print x
	...
	

### 定制权限

[自定义身份认证](http://python.usyiyi.cn/django/topics/auth/customizing.html)	



### 静态文件

参考：

* [静态文件](http://python.usyiyi.cn/django/ref/settings.html#static-files)
* [django管理静态文件](http://python.usyiyi.cn/django/howto/static-files/index.html)

相关点（举例）：

* INSTALL_APPS: 

		'django.contrib.staticfiles',
		
* static url 和 static root

		STATIC_URL = '/static/'
		STATIC_ROOT = cfg_dicts['global']['static_root']

* nginx配置：
	
		location /static {
			root /var/www/html/ops-portal/;
		}

* 拷贝静态文件

		python manage.py collectstatic	
### 模板变量

* [template](http://python.usyiyi.cn/django/topics/templates.html)

可以自定义模板OPTIONS: `context_processors`，这样在模板文件中就可以使用这些变量。

举例：

* context_processor:

		....
		'OPTIONS': {
		            'context_processors': [
		                 "users.contrib.context_processor.profile",
		                "users.contrib.context_processor.message",
		            ],
		        },
		...
		
* apps：`users/contrib/profile.py`
* 模板中使用：`{{profile.address}}`		



## 参考

* [django官网](https://www.djangoproject.com/)
* [django1.8中文文档](http://python.usyiyi.cn/django/index.html)