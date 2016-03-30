title: nodejs http
date: 2016-03-30 10:27:30
tags:
- nodejs
- http
- request

# nodejs http request

## 原生node的http模块

Node.js 提供了 `http` 模块，`http` 模块主要用于搭建 HTTP 服务端和客户端，使用 HTTP 服务器或客户端功能必须调用 http 模块。

客户端：

	var http = require('http');
	
	// 用于请求的选项
	var options = {
	   host: 'localhost',
	   port: '8081',
	   path: '/index.htm'  
	};
	
	// 处理响应的回调函数
	var callback = function(response){
	   // 不断更新数据
	   var body = '';
	   response.on('data', function(data) {
	      body += data;
	   });
	   
	   response.on('end', function() {
	      // 数据接收完成
	      console.log(body);
	   });
	}
	// 向服务端发送请求
	var req = http.request(options, callback);
	req.end();



## request模块

	npm install request
	
example：from [request/request](https://github.com/request/request)：

	var request = require('request');
	request('http://www.google.com', function (error, response, body) {
	  if (!error && response.statusCode == 200) {
	    console.log(body) // Show the HTML for the Google homepage.
	  }
	})	
	
	



## 参考

* [request/request](https://github.com/request/request)