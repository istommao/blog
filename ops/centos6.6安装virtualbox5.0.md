title: centos6.6安装virtualbox5.0
date: 2016-06-13 13:10:00
tags:
- centos
- virtualbox

# centos6.6安装virtualbox5.0

找到的一篇简单有效的在centos安装virtualbox5.0的文章。记录步骤。

* 如果已安装vb4.0，先卸载

		# yum remove VirtualBox-4*
	
* 添加源

		# cd /etc/yum.repos.d/
		# wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo	
* 安装依赖

		# yum update
		# yum install binutils qt gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms	
		

* Install VirtualBox 5.0

		# yum install VirtualBox-5.0
		
* Rebuild Kernel Modules for VirtualBox 5.0

		# /etc/init.d/vboxdrv setup
		OR 
		# service vboxdrv setup		
		


## 参考

* [VirtualBox 5.0 Released ](http://www.tecmint.com/install-virtualbox-on-redhat-centos-fedora/)