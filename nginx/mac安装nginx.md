#mac安装nginx

建议如果没有版本要求还是用brew安装，方便。

1. http://nginx.org/en/download.html下载源码
2. 解压源码
3. 进入解压目录执行

		./configure --without-http_rewrite_module
	
		为了方便最好还是：
		./configure --prefix=/usr/local --sbin-path=/usr/local/sbin --conf-path=/etc/nginx --pid-path=/var/run --error-log-path=/var/log/nginx --http-log-path=/var/log/nginx	
		
4. make 
5. sudo make install
6. 运行nginx
		
		sudo /usr/local/nginx/sbin/nginx
		
7. 浏览器访问:localhost

8. 关闭nginx
	
		sudo /usr/local/nginx/sbin/nginx -s stop

9. 可设置软连接，让终端可以执行

		sudo ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx

nginx启动关闭命令

	#测试配置是否有语法错误
	nginx -t
	
	#打开 nginx
	sudo nginx
	
	#重新加载配置|重启|停止|退出 nginx
	nginx -s reload|reopen|stop|quit
	
10. Nginx监听80端口需要root权限执行，因此：

## 参考

<http://my.oschina.net/indestiny/blog/220017>

	
	