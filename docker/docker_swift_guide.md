# Docker swift guide

## 基础

### dockerfile

* 参考：[Docker修炼第一式： 从Dockerfile开始](http://t.goodrain.com/t/docker-dockerfile/233/1)

示例：

    # 1. 环境配置
    FROM ubuntu:14.04
    MAINTAINER example <example@goodrain.com>
    
    # 2. 运行命令，配置和安装相关文件
    RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata
    
    RUN apt-get update && apt-get install -y curl vim net-tools && rm -rf /var/lib/apt/lists/* \
        && mkdir -p /app
    ## Install JDK 7
    
    # 指定工作目录
    WORKDIR /app
    RUN  curl -L 'http://download.oracle.com/otn-pub/java/jdk/7u65-b17/jdk-7u65-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie; gpw_e24=Dockerfile' | tar -xz \
        && curl -L 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.8/bin/apache-tomcat-7.0.8.tar.gz' | tar -xz
    
    # 指定运行脚本
    # copy scripts to docker container
    COPY run.sh /app/run.sh
    COPY tomcat7.sh /app/tomcat7.sh
    RUN chmod +x /app/run.sh
    RUN chmod +x /app/tomcat7.sh
    
    COPY java-war.war /app/java-war.war
    
    # Expose ports. 指定端口
    # EXPOSE指令用于标明，这个镜像中的应用将会侦听某个端口，并且希望能将这个端口映射到主机的网络界面上
    EXPOSE 8080
      
    # Define default command. 指定脚本的运行
    # ENTRYPOINT 用于标明一个镜像作为容器运行时，最后要执行的程序或命令。 
    ENTRYPOINT ["/app/tomcat7.sh"]
    #ENTRYPOINT ["/app/run.sh"]



## 基础介绍

基于linux的namespace和cgroup

* CGroup限制容器的资源使用
* namespace机制，实现荣期间的隔离
* chroot，文件系统的隔离

### 镜像、容器、仓库

docker hub

	docker search 
	docker pull {image name}
	
	docker login, docker commit 

运行一个container必须指定一个image作为初始化文件系统

	sudo docker run [options] IMAGE[:TAG] [COMMAND] [ARG...]

fig

	对Docker封装

service

	一个独立的组件。如web server，mysql、redis等
	一个service对应一个或多个container

kubernates

	集群的扩展和可靠。使用go语言编写

	kubercfg --> Master API --> minion--host

	Hubercfg -> Kuber Client -> API Server ->
	REST Storage API -> xxx Storage --> Etcd REgistry Storage(KV存储)

几大热点技术

	部署	
	kubernetes + Docker
	
	大数据
	Hadoop + Spark 
	
	移动
	Android + H5 + ARM

Spark和Docker

	hadoop和docker

	spark和docker

docker和测试


docker分布式

	marathon
	mesos

hadoop、spark集群和docker

​		
​	

## 维护



清除不用的 container

```
# delete ALL unused data 
docker system prune

# Delete all docker containers
docker rm $(docker ps -a -q)
```



清除 images

```
# Delete all docker images
docker rmi $(docker images -q)

# Use grep to remove all except my-image and ubuntu
docker rmi $(docker images | grep -v 'ubuntu\|my-image' | awk {'print $3'})
```












​	