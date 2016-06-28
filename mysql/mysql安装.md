title: mysql安装
date: 2016-06-28 14:37:00
tags:
- mysql
- centos

# mysql安装

## centos安装

### 卸载原有mysql

	# 查找
	rpm -qa | grep mysql
	# 卸载查找的mysql相关包
	rpm -e xxx
	
### 安装：（centos6）

	wget http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
	yum localinstall mysql57-community-release-el6-7.noarch.rpm
	yum install mysql-community-server
	
### 启动
	
	service mysqld start
	
如果启动失败：

* `/var/log/mysqld.log`报错：`Table 'mysql.plugin' doesn't exist`：

	* mkdir -p /data/mysql/3306
	* 修改`datadir`，执行`vi /etc/my.cnf`: `datadir=/data/mysql/3306`
	* 该权限：`chown mysql:mysql -R /data/mysql`	* 启动：`service mysqld start`	
	
参考：[Mysql 5.6 安装常见问题 – 路径设置不一致](http://blog.hexu.org/archives/848.shtml)	
### 修改密码	

获取临时密码：

	grep 'temporary password' /var/log/mysqld.log
	
更改密码：

	mysql_secure_installation		
		
	

## 参考

* [How to Install Latest MySQL on RHEL/CentOS and Fedora](http://www.tecmint.com/install-latest-mysql-on-rhel-centos-and-fedora/)