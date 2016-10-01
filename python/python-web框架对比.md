title: python-web框架对比
date: 2016-08-18 19:47:00
tags:
- flask
- django
- tornado
- gevent

# python-web框架对比

## 框架简介

* tornado: a Python web framework and asynchronous networking library
* falcon: a minimalist WSGI library for building speedy web APIs and app backends
* 两者更像：application servers 而不是web framework


### 其他

* Django, http://www.djangoproject.com/
* Flask, http://flask.pocoo.org/
* Pyjamas, http://pyjs.org/
* Pylons, http://pylonshq.com/ to become Pyramid, http://docs.pylonshq.com/
* Web2py, http://web2py.com/
* Web.py, http://webpy.org/
* Zope, http://www.zope.org/

摘自[quora 回答：the-best-Python-web-app-framework](https://www.quora.com/What-is-the-best-Python-web-app-framework-And-why)

* Django is very good whenever you have a relational database to work with. Its ORM is very simple and powerful.
* Flask and Bottle are fast and lightweight., very good to start writing web stuff with Python.
* Pyramid is somehow similar to Django.
* CherryPy, Falcon and Tornado are agnostic, low-level frameworks, more application servers than web frameworks.

> "Django is a high-level Python Web framework that encourages rapid development and clean, pragmatic design". If you are building something that is similar to a e-commerce site, then you should probably go with Django. It will get your work done quick. You don't have to worry about too many technology choices. It provides everything thing you need from template engine to ORM. It will be slightly opinionated about the way you structure your app, which is good If you ask me. And it has the strongest community of all the other libraries, which means easy help is available.

> "Flask is a microframework for Python based on Werkzeug, Jinja 2 and good intentions". Beware - "microframework" may be misleading. This does not mean that Flask is a half-baked library. This mean the core of Flask is very, very simple. Unlike Django, It will not make any Technology decisions for you. You are free to choose any template engine or ORM that pleases you. Even though it comes with Jinja template engine by default, you are always free to choose our own. As far as I know Flask comes in handy for writing APIs endpoints(RESTful rervices).

> "Twisted is an event-driven networking engine written in python". This is a high-performance engine. The main reason for its speed is something called as deferred. Twisted is built on top of deferred. For those of you who don't know about deferred, it is the mechanism through with asynchronous architecture is achieved. Twisted is very fast. But is not suitable for writing conventional WebApps. If you want to do something low-level networking stuff, Twisted is your friend.

> "Tornado is a Python web framework and asynchronous networking library, originally developed at FriendFeed. By using non-blocking network I/O, Tornado can scale to tens of thousands of open connections, making it ideal for long polling, WebSockets, and other applications that require a long-lived connection to each user". Tornado stands some where between Django and Flask. If you want to write something with Django or Flask, but if you need a better performance, you can opt for Tornado. It can handle C10k problem very well if it is architected right.

> "Cyclone is a web server framework for Python that implements the Tornado API as a Twisted protocol". Now, what if you want something with Twisted's performance and easy to write conventional webapps? Say hello to Cyclone. I would prefer Cyclone over Tornado. It has an API that is very similar to Tornado. As a matter of fact, this is a fork of Tornado. But the problem is it has relatively small community. Alexandre Fiori is the only main commiter to the repo.

> "Pyramid is a general, open source, Python web application development framework. Its primary goal is to make it easier for a Python developer to create web applications". I haven't really used Pyramid, but I went through the documentation. From what I understand, Pyramid is very similar to Flask and I think you can use Pyramid wherever Flask seems appropriate and vice-versa.
> 

知乎上的问答

* [如何理解 Tornado](https://www.zhihu.com/question/20136991)
* [知乎为什么选择 Tornado 作为 Web 开发框架](https://www.zhihu.com/question/19574244)


### 使用程度

#### Github

* tornado: 11942 star, 3660 fork, 237 contributors, 780+56 pr, 857+107 issues
* falcon: 3148 star, 353 fork, 65 contributors, 388+9 pr, 323+150 issues

#### 文档

* [tornado](http://www.tornadoweb.org/en/stable/)：官方文档不算丰富，基本知识
* [falcon](http://falcon.readthedocs.io/en/latest/)：同上

## 设计理念

* tornado：异步网络库
* falcon：轻量，高性能，适配REST快速构建API

### 特点

tornado

* 异步，扩展性强
* [其他资源](https://github.com/tornadoweb/tornado/wiki/Links)

falcon

* 轻量，可结合gevent等实现高性能，扩展性强


### 不足

tornado

* 扩展性强，很多东西需要引入第三方库或自己写
* 编写异步代码

falcon

* 扩展性强，很多东西需要引入第三方库或自己写

## 使用project

* tornado： 知乎、quora(as Comet server)、
* [projects-built-on-tornado](https://github.com/tornadoweb/tornado/wiki/Links#projects-built-on-tornado)
* [who's using falcon](https://github.com/falconry/falcon/wiki/Who's-using-Falcon%3F)


## 性能

* [Python's Web Framework Benchmarks](http://klen.github.io/py-frameworks-bench/)
* [Performance of Flask, Tornado, GEvent, and their combinations](https://gist.github.com/andreif/6088558)




## 参考

* [Python's Web Framework Benchmarks](http://klen.github.io/py-frameworks-bench/)
* [Performance of Flask, Tornado, GEvent, and their combinations](https://gist.github.com/andreif/6088558)