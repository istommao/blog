title: flask学习2-博客小项目Flasky
date: 2016-02-25 00:26:00
tags:
- flask

----

# 博客小项目Flasky
---

## 认证

使用的扩展：

* Flask-Login：管理登录用户的sessions

	用到接口或功能：
	
	* 提供UserMixin类，User类可以继承该类，默认提供`is_authenticated(), is_active(), is_anonymous(), get_id()`函数，也可在自己的User类中重写
	* LoginManager: 管理用户登录的Login实例
	* @login_manager.user_loader
	* @login_required：装饰器，保证路由只可以有认证的用户访问
	* current_user变量: 指定登录后的用户
	* login_user(): 记录登录的用户的session
	* logout_user(): login_user的反操作
	
	完成的事情：
	
* Werkzeug：密码哈希和认证

	用到接口或功能：
	
	* generate_password_hash(password, method, salt_lenght)： 生成加密后的密码
	* check_password_hash(hash, password)
	* @property, @password.setter
	
	完成的事情：用户密码的加密
	
* 	itsdangerous: 生成token

	用到接口或功能：
	
	* TimedJSONWebSignatureSerializer：序列化
	* loads(), dumps(): 载入和解析序列化或反序列化
	* 
	
	
	完成的事情：用于生成认证邮件的链接
	
* Flask-Email: 邮件发送
* Flask-Bootstrap: HTML模板
* Flask-WTF: Form表单	
* Flask的blueprint的@before_app_request或@before_request

## 用户角色

* 用户角色表：用户权限，角色名，关联的user

* 超级管理员：

* 角色认证

	使用Flask-login的UserMixin和AnonymousMixin
	
* permission_required装饰器的实现
* admin_required装饰器的实现
* blueprint的app_context_processor装饰器：让变量在所有模板都可用	






