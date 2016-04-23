title: Linux下的iptables
date: 2016-04-23 20:02:02
tags:
- linux
- iptables

# Linux下的iptables

一直没明白`iptables`命令的使用，看到这篇文章，就做个简单的笔记。只记录关键的总结，具体的可以参考[Linux下使用iptables](Linux下的iptables)

### iptables规则组成

组成部分：四张表+五条链（Hook point） + 规则

四张表：filter表、nat表、mangle表、raw表 

* filter表：访问控制、规则匹配 
* nat表：地址转发 
* mangle表：修改数据包，改变包头中内容（TTL、TOS、MARK），需要交换机支持 
* raw表：数据包状态跟踪和分析

五条链：`INPUT` `OUTPUT` `FORWARD` `PREROUTING` `POSTROUTING`

![数据包在规则表、链匹配流程](http://img.blog.csdn.net/20160423141218622)

### iptables规则组成

* 数据包访问控制：ACCEPT、DROP（无返回信息）、REJECT（有返回信息） 
* 数据包改写：SNAT、DNAT 
* 信息记录：LOG 

![iptables规则组成](http://img.blog.csdn.net/20160423152014560)

### iptables配置：实例

#### 场景一

* 规则1、对所有的地址开放本机的tcp（80、22、10-21）端口的访问 
* 规则2、允许对所有的地址开放本机的基于ICMP协议的数据包访问 
* 规则3、其他未被允许的端口禁止访问

例如：

	// 查看iptables版本
	#iptables -v
	// 查看iptables中已经设置的规则
	#iptables -L
	// 让主机名等不显示出来
	#iptables -nL
	// 清除iptables之前设置的规则
	#iptables -F
	
	// iptables设置规则1
	#iptables -I INPUT -p tcp --dport 80 -j ACCEPT
	#iptables -I INPUT -p tcp --dport 22-j ACCEPT
	#iptables -I INPUT -p tcp --dport 10:21 -j ACCEPT
	
	// iptables设置规则2
	#iptables -I INPUT -p icmp -J ACCEPT
	
	// iptables设置规则3
	#iptables -A INPUT -j REJECT
	
	// 删除访问80端口的规则，并设置80端口不可访问
	#iptables -D INPUT -p tcp --dport 80 -j ACCEPT
	#iptables -I INPUT -p tcp --dport 80 -j REJECT


iptables配置存在的问题 

1. 本机无法访问本机 
2. 本机无妨访问其他主机

修改上面规则设置

	#iptables -I INPUT -i lo -j ACCEPT
	#ipatables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

在场景一基础上，只允许10.103.188.233访问本机的http服务

	#iptables -D INPUT -p tcp --dport 80 -j ACCEPT
	#iptables -nL
	#iptables -I INPUT -p tcp -s 10.10.188.233 --dport 80 -j ACCEPT

#### 场景二

1. ftp主动模式下iptables的规则设置 
2. ftp被动模式下iptables的规则设置

ftp主动模式下iptables的规则设置

#### 场景三

1. 员工在公司内部（10.10.155.0/24,10.10.188.0/24）能访问服务器上的任何服务 
2. 当员工出差例如在上海，通过VPN连接到公司 

	外网（员工）—拨号到—->VPN服务器—–>内容FTP、SAMBA、NFS、SSH 
3. 公司有一个门户网站需要允许公网访问

### 配置规则基本思路 

ACCEPT规则： 

* 允许本地访问 
* 允许已监听状态数据包通过 
* 允许规则中允许的数据包通过（注意开放ssh远程管理端口） 

DENY规则： 

* 拒绝未被允许的数据包 
* iptables规则保存成配置文件，防止宕机或误删除。

### iptables防火墙nat表规则配置




## 参考

* [Linux下使用iptables](Linux下的iptables)