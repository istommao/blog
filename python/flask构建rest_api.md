#Flask构建Rest API

##规划根URL

	http://[hostname]/todo/api/v1.0/
	
##规划资源的URL

	GET	http://[hostname]/todo/api/v1.0/tasks	检索任务清单
	GET	http://[hostname]/todo/api/v1.0/tasks/[task_id]	检索一个任务
	POST	http://[hostname]/todo/api/v1.0/tasks	创建一个新任务
	PUT	http://[hostname]/todo/api/v1.0/tasks/[task_id]	更新一个已存在的任务
	DELETE	http://[hostname]/todo/api/v1.0/tasks/[task_id]	删除一个任务	
	

定义任务清单有以下字段：

	id:唯一标识。整型。
	title:简短的任务描述。字符串型。
	description:完整的任务描述。文本型。
	done:任务完成状态。布尔值型。
	
##使用Python 和 Flask实现RESTful services

	#!flask/bin/python
	#! -*- coding: utf-8 -*-
	__author__ = 'zhuwei'
	
	from flask import Flask, jsonify
	from flask import abort
	from flask import make_response
	from flask import request
	from flask import url_for
	
	app = Flask(__name__)
	
	tasks = [
	    {
	        'id': 1,
	        'title': u'Buy groceries',
	        'description': u'Meat, Milk, Fruit',
	        'done': False
	    },
	    {
	        'id': 2,
	        'title': u'Learn Python',
	        'description': u'Learn Flask',
	        'done': False
	    }
	
	]
	
	# jsonify模块将字典打包成JSON格式
	@app.route('/todo/api/v1.0/tasks', methods=['GET'])
	def get_tasks():
	    # return jsonify({'tasks': tasks})
	    return jsonify({'tasks': map(make_public_task, tasks)})
	
	@app.route('/todo/api/v1.0/task/<int:task_id>', methods=['GET'])
	def get_task(task_id):
	    task = filter(lambda t: t['id'] == task_id, tasks)
	    if len(task) == 0:
	        abort(404)
	    return jsonify({'task': task[0]})
	
	# 改进404错误处理
	@app.errorhandler(404)
	def not_found(error):
	    return make_response(jsonify({'error':'Not found'}), 404)
	
	# request.json里面包含请求数据，如果不是JSON或者里面没有包括title字段，将会返回400的错误代码。
	@app.route('/todo/api/v1.0/tasks', methods=['POST'])
	def creat_task():
	    if not request.json or not 'title' in request.json:
	        abort(400)
	    task = {
	        'id': tasks[-1]['id'] + 1,
	        'title': request.json['title'],
	        'description': request.json.get('description', ""),
	        'done': False
	    }
	    tasks.append(task)
	    return jsonify({'task':task}), 201
	
	@app.route('/todo/api/v1.0/tasks/<int:task_id>', methods=['PUT'])
	def update_task(task_id):
	    task = filter(lambda t: t['id'] == task_id, tasks)
	    if len(task) == 0:
	        abort(404)
	    if not request.json:
	        abort(400)
	    if 'title' in request.json and type(request.json['title']) != unicode:
	        abort(400)
	    if 'description' in request.json and type(request.json['description']) is not unicode:
	        abort(400)
	    if 'done' in request.json and type(request.json['done']) is not bool:
	        abort(400)
	    task[0]['title'] = request.json.get('title', task[0]['title'])
	    task[0]['description'] = request.json.get('description', task[0]['description'])
	    task[0]['done'] = request.json.get('done', task[0]['done'])
	    return jsonify({'task': task[0]})
	
	@app.route('/todo/api/v1.0/tasks/<int:task_id>', methods=['DELETE'])
	def delete_task(task_id):
	    task = filter(lambda t: t['id'] == task_id, tasks)
	    if len(task) == 0:
	        abort(404)
	    tasks.remove(task[0])
	    return jsonify({'result': True})
	
	# 通过Flask的url_for模块，获取任务时，将任务中的id字段替换成uri字段，并且把值改为uri值。
	def make_public_task(task):
	    new_task = {}
	    for field in task:
	        if field == 'id':
	            new_task['uri'] = url_for('get_task', task_id = task['id'], _external = True)
	        else:
	            new_task[field] = task[field]
	
	    return new_task
	
	
	if __name__ == '__main__':
	    app.run(debug=True)
	
	
##RESTful web service的安全认证

当前service是所有客户端都可以连接的，如果有别人知道了这个API就可以写个客户端随意修改数据了。 大多数教程没有与安全相关的内容，这是个十分严重的问题。

最简单的办法是在web service中，只允许用户名和密码验证通过的客户端连接。在一个常规的web应用中，应该有登录表单提交去认证，同时服务器会创建一个会话过程去进行通讯。这个会话过程id会被存储在客户端的cookie里面。不过这样就违返了我们REST中无状态的规则，因此，我们需求客户端每次都将他们的认证信息发送到服务器。

 为此我们有两种方法表单认证方法去做，分别是 Basic 和 Digest。

有个小Flask extension可以轻松做到。首先需要安装 Flask-HTTPAuth 

	$ flask/bin/pip install flask-httpauth
	
假设web service只有用户 ok 和密码为 python 的用户接入
	
	from flask.ext.httpauth import HTTPBasicAuth
	auth = HTTPBasicAuth()
	
	@auth.get_password
	def get_password(username):
	    if username == 'ok':
	        return 'python'
	    return None
	
	@auth.error_handler
	def unauthorized():
	    return make_response(jsonify({'error': 'Unauthorized access'}), 401)	
	    
get_password函数是一个回调函数，获取一个已知用户的密码。在复杂的系统中，函数是需要到数据库中检查的，但是这里只是一个小示例。

当发生认证错误之后，error_handler回调函数会发送错误的代码给客户端。这里我们自定义一个错误代码401，返回JSON数据，而不是HTML。

将@auth.login_required装饰器添加到需要验证的函数上面

	@app.route('/todo/api/v1.0/tasks', methods=['GET'])
	@auth.login_required
	def get_tasks():
    	return jsonify({'tasks': tasks})


此时需要认证：

	curl -u ok:python -i http://localhost:5000/todo/api/v1.0/tasks	
	
这个认证extension十分灵活，可以随指定需要验证的APIs。

为了确保登录信息的安全，最好的办法还是使用https加密的通讯方式，客户端与服务器端传输认证信息都是加密过的，防止第三方的人去看到。

当使用浏览器去访问这个接口，会弹出一个丑丑的登录对话框，如果密码错误就回返回401的错误代码。为了防止浏览器弹出验证对话框，客户端应该处理好这个登录请求。

有一个小技巧可以避免这个问题，就是修改返回的错误代码401。例如修改成403（”Forbidden“）就不会弹出验证对话框了。

	@auth.error_handler
	def unauthorized():
    	return make_response(jsonify({'error': 'Unauthorized access'}), 403)	
	
##小结

还有很多办法去改进这个web service。

事实上，一个真正的web service应该使用真正的数据库。使用内存数据结构有非常多的限制，不要用在实际应用上面。

另外一方面，处理多用户。如果系统支持多用户认证，则任务清单也是对应多用户的。同时我们需要有第二种资源，用户资源。当用户注册时使用POST请求。使用GET返回用户信息到客户端。使用PUT请求更新用户资料，或者邮件地址。使用DELETE删除用户账号等。

通过GET请求检索任务清单时，有很多办法可以进扩展。第一，可以添加分页参数，使客户端只请求一部份数据。第二，可以添加筛选关键字等。所有这些元素可以添加到URL上面的参数。

##源码

<https://github.com/zhuwei05/flask-rest-demo-todo-api>

##参考

[使用python的Flask实现一个RESTful API服务器端[翻译]](http://www.cnblogs.com/vovlie/p/4178077.html)	
	