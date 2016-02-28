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





	