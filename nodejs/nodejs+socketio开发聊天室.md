#nodejs+socketio开发聊天室

##npm

		npm init 命令为你的应用创建一个 package.json 文件。 

##socketio

	$ npm install --save socket.io
	
##chat应用

###配置

####指定目录为：chat, 新建package.json

	{
	  "name": "realtime-server",
	  "version": "0.0.1",
	  "description": "my first realtime server",
	  "dependencies": {}
	}	
	
####安装express 和 socket.io

	npm install --save express
	npm install --save socket.io
	
安装成功后，应该可以看到工作目录下生成了一个名为node_modules的文件夹，里面分别是express和socket.io

###编写服务端代码

	var app = require('express')();
	var http = require('http').Server(app);
	var io = require('socket.io')(http);
	app.get('/', function(req, res){
		res.send('<h1>Welcome Realtime Server</h1>');
	});
	http.listen(3000, function(){
		console.log('listening on *:3000');
	});
	
运行node index.js，如果一切顺利，你应该会看到返回的listening on *:3000字样，这说明服务已经成功搭建了。此时浏览器中打开http://localhost:3000应该可以看到正常的欢迎页面。	
###nginx配置

如果你想要让服务运行在线上服务器，并且可以通过域名访问的话，可以使用Nginx做代理，在nginx.conf中添加如下配置，然后将域名（比如：realtime.plhwin.com）解析到服务器IP即可：

	server
	{
	  listen       80;
	  server_name  realtime.plhwin.com;
	  location / {
	    proxy_pass http://127.0.0.1:3000;
	  }
	}			

完成以上步骤，http://realtime.plhwin.com:3000的后端服务就正常搭建了。


	

##参考

[使用Node.js+Socket.IO搭建WebSocket实时应用](http://www.plhwin.com/2014/05/28/nodejs-socketio/)

