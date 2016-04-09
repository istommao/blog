title: hexo搭建github博客
date: 2016-01-20 20:04:44
tags: git hexo
---

## 前提

* 安装git工具
* 申请github账号
* 新建一个仓库并配置好，xxx.github.io

具体可以参考[创建GitHub技术博客全攻略](http://blog.csdn.net/renfufei/article/details/37725057/)

## 安装hexo

	npm install -g hexo
	
## 搭建hexo

### 设置hexo目录
以下以我的mac电脑为例，在/Users/zhuwei/目录下新建一个文件夹，名字为hexo:

	cd ~
	mkdir hexo

进入新建的目录，执行：

	hexo init
	
### 启动hexo服务，测试是否成功

执行命令：

	hexo server

打开浏览器访问： `localhost:4000`

### 创建一个新文章

先CTRL+C停止：hexo server

执行命令：

	hexo new "My New Post"
	
该命令会在**source/_posts/目录创建一个My-New-Post.md的文件**

这样就可以在md中编写你的文章。


### 生成静态文件

	hexo generate

该命令将markdown文件生成静态网页

### 部署到Github

首先安装：

	npm install hexo-deployer-git --save
	
	
然后需要配置_config.yml文件，首先找到下面的内容

	# Deployment
	## Docs: http://hexo.io/docs/deployment.html
	deploy:
  		type:
  		
修改为：

	deploy:
  		type: git
  		repository: git@github.com:zhuwei05/zhuwei05.github.io.git
  		branch: master  	
  		
最后执行部署命令：

	 hexo deploy
	 
如果正确执行，那么就可以通过github域名就可以访问了：

	http://zhuwei05.github.io/
	
P.S.

1. 
> Repository：必须是SSH形式的url（git@github.com:zhuwei05/zhuwei05.github.io.git），而不能是HTTPS形式的url（https://github.com:zhuwei05/zhuwei05.github.io.git），否则会出现错误

2. 
> 如果你是为一个项目制作网站，那么需要把branch设置为gh-pages	


## 写文章

经过前面的步骤搭建好hexo后，之后就可以新建自己的文章，然后放到**source/_posts/目录**，然后在执行：

	hexo generate
	hexo deploy
	
就可以成功将文章发布了。	

## 命令
复合命令

	hexo deploy -g  #生成加部署
	hexo server -g  #生成加预览
命令的简写为：

	hexo n == hexo new
	hexo g == hexo generate
	hexo s == hexo server
	hexo d == hexo deploy


## 参考

* [Hexo搭建Github静态博客](http://www.cnblogs.com/zhcncn/p/4097881.html)
* [创建GitHub技术博客全攻略](http://blog.csdn.net/renfufei/article/details/37725057/)




