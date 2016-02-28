title: flask学习3-博客小项目Flasky的部署(发布前准备)
date: 2016-02-28 00:13:00
tags:
- flask
- deploy

----

# flask学习3-博客小项目Flasky的部署(发布前准备)
---

## 测试

### coverage
	
	(venv) $ pip install coverage
	
### flask test client	

test client保存有当前的运行环境（request，session等）

### selenium

模拟浏览器

	(venv) $ pip install selenium
	
## 性能

### 数据库查询优化

可以通过Flask-SQLAlchemy提供的`get_debug_queries`统计。

* statement
* parameters
* start_time
* end_time
* duration
* context

### 代码分析

Werkzeug提供：Python profiler的`ProfilerMiddleware`

## 部署

### 部署工作流

### 记录生产中的错误

app.logger

### 云部署

#### Heroku

### 传统主机

#### 服务端设置

* 数据库安装
* Mail Transport Agent（MTA）安装：发送邮件
* 生产级别的web server：uWSGI 或者 Gunicorn
* 配置SSL认证
* 配置反向代理nginx或apache（可选，但建议添加）
* 增加服务器的稳定：如增加防火墙，移除不必要软件

#### 导入环境变量

#### 设置日志





	