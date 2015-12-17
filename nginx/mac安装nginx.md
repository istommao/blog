#mac安装nginx

1. http://nginx.org/en/download.html下载源码
2. 解压源码
3. 进入解压目录执行

		./configure --without-http_rewrite_module
4. make 
5. sudo make install
6. 运行nginx
		
		sudo /usr/local/nginx/sbin/nginx
		
7. 浏览器访问:localhost

8. 关闭nginx
	
		sudo /usr/local/nginx/sbin/nginx -s stop

9. 可设置软连接，让终端可以执行

		sudo ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
