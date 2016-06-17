title: python应用部署
date: 2016-06-16 10:59:00
tags:
- gunicorn
- wsgi
- python
- gevent
- supervisord


# python应用部署

## 简介

python应用的部署有非常多的方式。

对于一些脚本任务，可以直接通过`后台脚本运行`：

比如直接通过shell执行: 
		
	nohup python app.py > /dev/null 2>&1  &
		
crontab添加定时任务：
	
	30 7-22/1 * * * python app.py >> /temp/log/app.log 2>&1
		
对于python的web应用的部署，一般都是: `HTTP服务器 + WSGI服务器 + supervisord + web应用:app`

* `WSGI服务器`就是实现了：WSGI(Web Server Gateway Interface)接口的服务。主要功能就是：接受HTTP请求、解析HTTP请求、发送HTTP响应等苦力活。我们的app应用就需要依赖它运行。
* `HTTP服务器`：`Apache`、`Nginx`、`Lighttpd`功能类似于`WSGI服务器`。主要功能进行网站代理。
* `supervisord`：用于监控程序的状态，程序崩溃了会进行重启策略。一般用来处理：通过`WSGI`启动的`app`意外崩溃后，进行重启
* `web应用`：python web应用app

脚本的部署很简单。下面主要介绍python web项目的部署。

## python web部署

上面提到的4个部分，其实必要的就是：`WSGI服务器` 和 `web应用`。因此部署方式非常多，比如：

* uwsgi + app
* uwsgi + app + supervisor
* uwsgin + app + supervisor + nginx
* gunicorn + app
* gunicorn + app + nginx
* gunicorn + app + nginx + supervisor
* aiohttp + app + nginx + supervisor
* ...


本文介绍这种部署方式：

![python-deploy-arch](https://raw.githubusercontent.com/zhuwei05/blog-resources/master/python-deploy-arch.png)

* Nginx：高性能Web服务器+负责反向代理
* gunicorn: 运行app应用
* Supervisor: 监控gunicorn的运行情况
* app：python web应用，如flask，django等

总结步骤：

1. 安装nginx，Gunicorn， supervisord
2. 给你的应用配置nginx
3. 使用编写app入口（文章以code.py文件为例），用Gunicorn启动code.py
4. 配置supervisord

## 示例

`talk is cheap, show me the code!`

[python部署flask实例](https://github.com/zhuwei05/python-web-deployment-demo/blob/master/gunicorn%E9%83%A8%E7%BD%B2python%E5%BA%94%E7%94%A8.md)



