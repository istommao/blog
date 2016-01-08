#flask+nginx+uwsgi+supervisor

## 编写flask代码

### virtualenv

先安装virtualenv

	pip install virtualenv
	
创建flask工作目录和virtualenv

	mkdir ~/flask-hello
	cd ~/flask-hello
	virtualenv env
	source env/bin/active
	
### 安装flask和uwsgi

	pip install uwsgi flask

### 编写简单的flask代码

在工程目录~/flask-hello新建app.py

	#!flask/bin/python
	__author__ = 'zhuwei'
	
	from flask import Flask
	
	app = Flask(__name__)
	
	@app.route('/')
	def index():
	    return "Hello world!"
	
	if __name__ == '__main__':
	    app.run(debug=True)
	
### 运行

	python app.py	
	
访问`localhost:5000`是可以看到页面显示`Hello world!`


## uwsgi

### 创建uwsgi入口点

在工程目录~/flask-hello新建wsgi.py

	from app import app

	if __name__ == "__main__":
		app.run()

### 测试

	uwsgi --socket 0.0.0.0:8000 --protocol=http --wsgi-file wsgi.py --callable app
	
这时去访问: localhost:8000，如果成功说明ok。
	
`注意：这里不知道为什么一定指定--wsgi-file和--callable`

	--wsgi-file wsgi.py， 而不能使用-w
	而且一定能够要加上 --callable app
	
如果不添加，会报错：

	ImportError: No module named py
	unable to load app 0 (mountpoint='') (callable not found or import error)		
	
参考回答： <http://serverfault.com/questions/412849/uwsgi-cannot-find-application-using-flask-and-virtualenv>

猜测可能是flask版本和uwsgi版本兼容的问题。

现在python的代码和测试均设置好了，可以退出virtualenv

	deactive

### 配置uwsgi
进入uwsgi.ini文件：

	[uwsgi]
	socket = /tmp/hello.sock
	master = true
	processes = 2
	module = wsgi:app
	gid = nginx
	uid = nginx
	chmod-socket = 664
	max-requests = 5000
	enable-threads = true
	vacuum = true	
	die-on-term = true
	

## nginx

### 安装-mac	

	brew install nginx
	
安装好后，启动nginx

	sudo nginx
	
此时访问`localhost`可以看到nginx的页面

> p.s nginx命令： https://github.com/zhuwei05/blog/blob/master/nginx/mac%E5%AE%89%E8%A3%85nginx.md

> nginx重启报错：http://www.cnblogs.com/yuqianwen/p/4285686.html


### 配置代理

	cd /usr/local/etc/nginx
	vim sites-available/hello
	
	写入如下内容：
		server {
	       listen 80;
	       server_name zhuwei05.flask-app.com;
	
		    location / {
		        include uwsgi_params;
		        uwsgi_pass unix:/tmp/hello.sock;
		    }
		}

	sudo ln -s sites-available/hello sites-enabled/	


### 修改/etc/hosts:

	vim /etc/hosts 
	在文件最后添加：
		127.0.0.1 zhuwei05.flask-app.com

## supervisor

	sudo pip install supervisor
	
	
	
参考：<http://dhq.me/mac-supervisor-install>	

## 参考

<https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uwsgi-and-nginx-on-ubuntu-14-04>	

	
	

	
	
	
	
		