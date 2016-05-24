title: vagrant学习
date: 2016-05-24 21:27:00
tags:
- vargrant
- virtual
- ops

# vagrant学习

## 简介

vagrant是一个用来构建虚拟环境的工具，通过添加box（一个包含操作系统和开发环境的镜像），就可以保证所有人的开发环境一致。

### 虚拟开发环境

平常我们经常会遇到这样的问题：在开发机上面开发完毕程序，放到正式环境之后会出现各种奇怪的问题：描述符少了、nginx配置不正确、MySQL编码不对、php缺少模块、glibc版本太低等。

所以我们就需要虚拟开发环境，我们虚拟和正式环境一样的虚拟开发环境，而随着个人开发机硬件的升级，我们可以很容易的在本机跑虚拟机，例如VMware、VirtualBox等。因此使用虚拟化开发环境，在本机可以运行自己喜欢的OS（Windows、Ubuntu、Mac等），开发的程序运行在虚拟机中，这样迁移到生产环境可以避免环境不一致导致的莫名错误。

虚拟开发环境特别适合团队中开发环境、测试环境、正式环境不同的场合，这样就可以使得整个团队保持一致的环境，我写这一章的初衷就是为了让大家和我的开发环境保持一致，让读者和我们整个大团队保持一致的开发环境。

### vagrant

Vagrant就是为了方便的实现虚拟化环境而设计的，使用Ruby开发，基于VirtualBox等虚拟机管理软件的接口，提供了一个可配置、轻量级的便携式虚拟开发环境。使用Vagrant可以很方便的就建立起来一个虚拟环境，而且可以模拟多台虚拟机，这样我们平时还可以在开发机模拟分布式系统。

Vagrant还会创建一些共享文件夹，用来给你在主机和虚拟机之间共享代码用。这样就使得我们可以在主机上写程序，然后在虚拟机中运行。如此一来团队之间就可以共享相同的开发环境，就不会再出现类似“只有你的环境才会出现的bug”这样的事情。

团队新员工加入，常常会遇到花一天甚至更多时间来从头搭建完整的开发环境，而有了Vagrant，只需要直接将已经打包好的package（里面包括开发工具，代码库，配置好的服务器等）拿过来就可以工作了，这对于提升工作效率非常有帮助。

Vagrant不仅可以用来作为个人的虚拟开发环境工具，而且特别适合团队使用，它使得我们虚拟化环境变得如此的简单，只要一个简单的命令就可以开启虚拟之路。

## vagrant安装

### 安装virtualbox

到 [virtualbox官网](https://www.virtualbox.org/wiki/Downloads/) 下载对应平台的VirtualBox最新版本并安装。

### 安装vagrant

到 [vagrant官网](https://www.vagrantup.com/downloads.html) 下载对应平台的vagrant最新版本并安装。

### vagrant配置

当我们安装好VirtualBox和Vagrant后，我们要开始考虑在VM上使用什么操作系统了，一个打包好的操作系统在Vagrant中称为Box，即Box是一个打包好的操作系统环境，目前网络上什么都有，所以你不用自己去制作操作系统或者制作Box：[vagrantbox.es](http://www.vagrantbox.es/)上面有大家熟知的大多数操作系统，你只需要下载就可以了，下载主要是为了安装的时候快速，当然Vagrant也支持在线安装。

	
#### 下载box

box是一个操作系统环境，实际上它是一个zip包，包含了Vagrant的配置信息和VirtualBox的虚拟机镜像文件.

#### 添加box

命令解析：

	vagrant box add <box-name> <远端的box地址或者本地的box文件名>
	
	例如：
		vagrant box add base http://files.vagrantup.com/lucid64.box
		vagrant box add base https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box
		vagrant box add base CentOS-6.3-x86_64-minimal.box
		vagrant box add "CentOS 6.3 x86_64 minimal" CentOS-6.3-x86_64-minimal.box	
加入我们下载了lucid64，那么执行：

	vagrant box add base lucid64.box
	
box中的镜像文件被放到了：**/Users/\`{whoami}\`/.vagrant.d/boxes/**，如果在window系统中应该是放到了： `C:\Users\当前用户名\.vagrant.d\boxes\`目录下。	
	
#### 初始化 

首先建立开发环境目录(已Mac为例)，读者可以根据自己的系统不同建立一个目录就可以：

	cd ~
	mkdir vagrant-dev
	
	cd ~/vagrant-dev
	vagrant init [box-name]
	
如果你添加的box名称不是base，那么需要在初始化的时候指定名称

会在当前目录生成一个`Vagrantfile`的文件，里面有很多配置信息，可以修改配置文件进行个性化的定制。

#### 启动虚拟机

	vagrant up
	
#### 连接到虚拟机

启动虚拟机后，就可以通过ssh来连接到虚拟机，这样我们就可以像连接到一台服务器一样进行操作了。

	vagrant ssh
	cd /vagrant  # 切换到开发目录，也就是宿主机上的 ~/vagrant-dev
	
`/vagrant`	这个目录自动映射到宿主机的开发环境目录，本文是`~/vagrant-dev`，这样就方便我们以后在开发机中进行开发，在虚拟机中进行运行效果测试了。
	
剩下的步骤就是在虚拟机里配置你要运行的各种环境和参数了。

#### 打包分发

当你配置好开发环境后，退出并关闭虚拟机。在终端里对开发环境进行打包：

	$ vagrant package

打包完成后会在当前目录生成一个 `package.box` 的文件，将这个文件传给其他用户，其他用户只要添加这个 `box` 并用其初始化自己的开发目录就能得到一个一模一样的开发环境了。

	
## Vagrantfile配置文件详解

在我们的开发目录下有一个文件Vagrantfile，里面包含有大量的配置信息，主要包括三个方面的配置：`虚拟机的配置`、`SSH配置`、`Vagrant的一些基础配置`。Vagrant是使用Ruby开发的，所以它的配置语法也是Ruby的，但是我们没有学过Ruby的人还是可以跟着它的注释知道怎么配置一些基本项的配置。

* box设置

		config.vm.box = "base"

	上面这配置展示了Vagrant要去启用那个box作为系统，也就是上面我们输入`vagrant init Box名称`时所指定的box，如果沒有输入box名称的話，那么默认就是base，VirtualBox提供了VBoxManage这个命令行工具，可以让我们设定VM，用`modifyvm`这个命令让我们可以设定VM的名称和内存大小等等，这里说的名称指的是在VirtualBox中显示的名称，我们也可以在`Vagrantfile`中进行设定，在`Vagrantfile`中加入如下这行就可以设定了：

		config.vm.provider "virtualbox" do |v|
		  v.customize ["modifyvm", :id, "--name", "astaxie", "--memory", "512"]
		end
		
这行设置的意思是调用VBoxManage的`modifyvm`的命令，设置VM的名称为astaxie，内存为512MB。你可以类似的通过定制其它VM属性来定制你自己的VM。

* 网络设置

	Vagrant有两种方式来进行网络连接，一种是`host-only(主机模式)`，意思是主机和虚拟机之间的网络互访，而不是虚拟机访问internet的技术，也就是只有你一個人自High，其他人访问不到你的虚拟机。另一种是`Bridge(桥接模式)`，该模式下的VM就像是局域网中的一台独立的主机，也就是说需要VM到你的路由器要分配IP，这样局域网里面其他机器就可以访问它了，一般我们设置虚拟机都是自high为主，所以我们的设置一般如下：

		config.vm.network :private_network, ip: "11.11.11.11"
		
	这里我们虚拟机设置为`hostonly`，并且指定了一个`IP`，IP的话建议最好不要用`192.168..`这个网段，因为很有可能和你局域网里面的其它机器`IP`冲突，所以最好使用类似`11.11..`这样的IP地址。
	
	重启虚拟机，这样我们就能用 `11.11.11.11` 访问这台机器了。
	
* hostname设置

	`hostname`的设置非常简单，`Vagrantfile`中加入下面这行就可以了：

		config.vm.hostname = "go-app"

	设置`hostname`非常重要，因为当我们有很多台虚拟服务器的时候，都是依靠`hostname`來做识别的，例如`Puppet`或是`Chef`，都是通过`hostname`來做识别的，既然设置那么简单，所以我们就別偷懒，设置一个。
	
* 同步目录

	我们上面介绍过`/vagrant`目录默认就是当前的开发目录，这是在虚拟机开启的时候默认挂载同步的。我们还可以通过配置来设置额外的同步目录：

		config.vm.synced_folder  "/Users/{你的用户名}/data", "/vagrant_data"

	上面这个设定，第一个参数是主机的目录，第二个参数是虚拟机挂载的目录			
		
	
* 端口转发

		config.vm.network :forwarded_port, guest: 80, host: 8080

	这一行的意思是把对`host机器`上`8080`端口的访问请求`forward`到`虚拟机的80端口`的服务上，例如你在你的虚拟机上使用nginx跑了一个Go应用，那么你在host机器上的浏览器中打开`http://localhost:8080`时，`Vagrant`就会把这个请求转发到`VM`里面跑在`80端口的nginx`服务上，因此我们可以通过这个设置来帮助我们去设定`host`和`VM`之间，或是`VM`和`VM`之间的信息交互。

> 修改完`Vagrantfile`的配置后，记得要用`vagrant reload`命令来重启VM之后才能使用VM更新后的配置.

## vagrant使用入门

### Vagrant常用命令

* $ vagrant init  # 初始化
* $ vagrant up  # 启动虚拟机
* $ vagrant halt  # 关闭虚拟机
* $ vagrant reload  # 重启虚拟机，主要用于重新载入配置文件
* $ vagrant ssh  # SSH 至虚拟机
* $ vagrant status  # 查看虚拟机运行状态
* $ vagrant destroy  # 停止当前正在运行的虚拟机并销毁所有创建的资源
* $ vagrant box list # 显示当前已经添加的box列表
* $ vagrant box remove # 删除相应的box
* $ vagrant package # 打包命令，可以把当前的运行的虚拟机环境进行打包
* $ vagrant suspend # 挂起当前的虚拟机
* $ vagrant resume # 恢复前面被挂起的状态
* $ vagrant ssh-config # 输出用于ssh连接的一些信息
* $ vagrant plugin # 用于安装卸载插件
* $ vagrant provision

	通常情况下Box只做最基本的设置，而不是设置好所有的环境，因此Vagrant通常使用Chef或者Puppet来做进一步的环境搭建。那么Chef或者Puppet称为provisioning，而该命令就是指定开启相应的provisioning。按照Vagrant作者的说法，所谓的provisioning就是"The problem of installing software on a booted system"的意思。除了Chef和Puppet这些主流的配置管理工具之外，我们还可以使用Shell来编写安装脚本。
	
	
	
## 模拟打造多机器的分布式系统

前面这些单主机单虚拟机主要是用来自己做开发机，从这部分开始的内容主要将向大家介绍如何在单机上通过虚拟机来打造分布式造集群系统。这种多机器模式特别适合以下几种人：

* 快速建立产品网络的多机器环境，例如web服务器、db服务器
* 建立一个分布式系统，学习他们是如何交互的
* 测试API和其他组件的通信
* 容灾模拟，网络断网、机器死机、连接超时等情况
* Vagrant支持单机模拟多台机器，而且支持一个配置文件Vagrntfile就可以跑分布式系统。

未完待续......	，参看[模拟打造多机器的分布式系统](https://github.com/astaxie/Go-in-Action/blob/master/ebook/zh/01.3.md#模拟打造多机器的分布式系统)

	


## 参考

* [Vgrant安装配置](https://github.com/astaxie/Go-in-Action/blob/master/ebook/zh/01.2.md)
* [使用 Vagrant 打造跨平台开发环境](https://segmentfault.com/a/1190000000264347)



