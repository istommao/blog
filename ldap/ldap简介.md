title: ldap简介
date: 2016-06-01 15:59:00
tags:
- ldap

# ldap简介

## 简介

LDAP是Lightweight Directory Access Protocol的简写，中文是轻型目录服务。它是基于X.500标准的，但支持TCP/IP，而且简单很多，并可根据需要定制。优点包括：

* 可以在任何计算机平台上运行；
* 通过简单的“推”或“拉”的方式即可复制部分或全部数据，比常见的关系数据库简单很多；
* 主要是面向数据的查询服务，速度比关系数据库快很多；
* 可以使用ACI（类似ACL，访问控制列表）控制对数据的读、写管理，并且是在LDAP服务器内部实现的，不用担心应用程序Bug问题（相对Web架构来说）；
* 使用类似DNS树的目录树结构，方便多级服务器的连接和管理；

## 什么情况下使用
   
LDAP中的数据（`成为entry，条目`），一般是按照地理位置和组织关系进行组织的，常用于存放需要从不同地点读取，但是不需要经常更新的数据。大多数的LDAP服务器都为读进行了优化，在读的性能对比上，LDAP服务器会比关系数据库快一个数量级，但LDAP不适合存储需要经常改变的数据。所以，LDAP和关系数据库是有区别的。但也有后台使用关系数据库，中间架设LDAP服务器作为应用接口的情况，以加快用户获取信息的速度。好像常见的企业级邮件服务器就是这种。

## LDAP的结构

LDAP中目录是按照`树型结构`组织的，目录由`条目（entry）组成`，

* 条目相当于关系数据库中的`表`；条目 = `DN` + `Attribute集合` 。是区别名（DN，Distiguished Name）的属性（Attribute）集合

* DN相当于关系数据库中的`主键`（Primary Key），是区别的标识；

* 属性就由类型（Type）和多个值（Values）组成，相当于关系数据库中的域是由域名和数据类型组成，只是不同在于其中的值不像关系数据库中为了降低数据冗余性必须不相关。

* 基准DN的常用格式是用DNS域名的不同部分组成
* 使用容器（OU，Oraganization Unit）从逻辑上把数据区分开

* 在容器下面，就是由类型和属性组成对象类（objectclass ），而属性是可以自己定制的。

	OpenLDAP为例，一个条目的属性必须要遵循 /etc/openldap/schema/ 模式文件中定义的规则。规则包含在条目的 objectclass 属性中

举例：

一条dn: 

	cn=zhuwei05, ou=people,ou=groups,dc=github,dc=io
	
	
objectclass: 用类型定义属性，cn、uid、uidNumber等就是属性，用属性加入对象类

	objectclass ( 1.3.6.1.1.1.2.0 NAME 'posixAccount' SUP top AUXILIARY
	  DESC 'Abstraction of an account with POSIX attributes'
	  MUST ( cn $ uid $ uidNumber $ gidNumber $ homeDirectory )
	  MAY ( userPassword $ loginShell $ gecos $ description ) )	
	

## DN, CN, DC

* LDAP连接服务器的连接字串格式为：`ldap://servername/DN`
* 其中DN有三个属性，分别是CN,OU,DC， 所以CN, OU, DC 都是LDAP连接服务器的端字符串中的区别名称（DN, distinguished name）
* DC (Domain Component)
* CN (Common Name)
* OU (Organizational Unit)

LDAP 目录类似于文件系统目录。

举例：

一条DN：

	CN=test,OU=developer,DC=domainname,DC=com 

cn=test 可能代表一个用户名，ou=developer 代表一个 active directory 中的组织单位。这句话的含义可能就是说明 test 这个对象处在domainname.com 域的 developer 组织单元中


	




## 参考

* [LDAP服务介绍](http://www.linuxfly.org/post/104/)
* [操作ldap 数据库](http://www.linuxfly.org/post/569/)
* [python-ldap文档](https://www.python-ldap.org/docs.html)