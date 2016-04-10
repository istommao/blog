title: shadowsocks(centos)
date: 2016-02-17 10:32:35
tags:
- shadowsocks
- finalspeed
- vpn

# shadowsocks(centos)

## 安装shadowsocks

	yum install epel-release
	yum update
	yum install python-setuptools
	easy_install pip
	pip install shadowsocks

## 配置SS服务

	vi /etc/shadowsocks.json

输入：

	{
    "server":"0.0.0.0",
    "server_port":443,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"password",
    "timeout":500,
    "method":"aes-256-cfb",
    "fast_open": true
	}

* server 服务端监听的地址，服务端可填写 0.0.0.0
* server_port 服务端的端口
* local_address 本地端监听的地址
* local_port 本地端的端口
* password 用于加密的密码
* timeout 超时时间，单位秒
* method 默认 “aes-256-cfb”
* fast_open 是否使用 TCP_FASTOPEN, true / false（后面优化部分会打开系统的TCP_FASTOPEN，所以这里填true,否则填false)

	password和server_port也是可以修改的，例如 443 是 Shadowsocks 客户端默认的端口号
	
## 设置supervisor

	yum install python-setuptools supervisor
	
编辑/etc/supervisord.conf文件

	vi /etc/supervisord.conf	
	
在文件最后输入：

	[program:shadowsocks]
	command=ssserver -c /etc/shadowsocks.json
	autostart=true
	autorestart=true
	user=root

运行以下命令（如询问（Y/N)，请Y回车）：

	sudo chkconfig --add supervisord
	sudo chkconfig supervisord on
	service supervisord start
	supervisorctl reload
		

到此Shadowsocks已经在CentOS 7 x64下安装配置成功，再运行命令

	reboot

重启服务器使服务生效。

已经可以使用正常Shadowsocks服务。

## 客户端



## 参考

* [如何在 VPS 上搭建 VPN 来翻墙](http://letchinese.com/2015/04/12/build-your-own-vps/)
* [DigitalOcean搭建Shadowsocks服务和优化方案](http://www.linexy.net/archives/digitalocean-build-shadowsocks-services-and-optimization-program/)
* [科学上网利器 Shadowsocks 使用方法](https://ttt.tt/150/)
* [客户端下载](https://shadowsocks.org/en/download/clients.html)
* [Shadowsocks for OSX Help](https://github.com/shadowsocks/shadowsocks-iOS/wiki/Shadowsocks-for-OSX-Help)
* [ShadowSocks—科学上网之瑞士军刀](http://www.jianshu.com/p/08ba65d1f91a)








 