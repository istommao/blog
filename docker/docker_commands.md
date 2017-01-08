title: docker_commands
date: 2017-01-08 18:14:00
tags:
- docker

# docker_commands

`docker` 基本命令

## docker 组件

* 镜像: 只读的静态模板，保存着容器需要的环境和应用的执行代码
* 容器: 一个镜像的运行状态
* 库: 某个特定用户存储镜像的目录。用户的一系列镜像


## 容器

### 容器基本操作: 创建、删除、启动、停止、查看

* docker create
* docker run
* docker start
* docker stop
* docker inspect

创建处于停止状态的容器：`docker create <IMAGE>`

	docker create ubuntu:14.04
	
	* [仓库REPO:标签TAG]: ubuntu:14.04

创建交互型、后台型容器: `docker run <IMAGE>`

	交互型：
	docker run -it --name inter_demo_name ubuntu /bin/bash
	
	* -i: 开启标准输入
	* -t: 创建命令行终端
	* --name: 指定容器名字，可选
	* IMAGE: 指定用于创建容器的镜像
	* /bin/bash: 在容器里执行命令
	* --restart=always/on-failure:5 : 指定重启

	后台型: -d
	docker run --name daemon_demo_name -d ubuntu 

查看容器：`docker ps`:

	docker ps [-a|l|n]
	输出项：
	
	* CONTAINER ID: 容器ID, 对某个容器的操作可以通过它来标识操作目标
	* IMAGE: 镜像，创建容器时使用的镜像
	* COMMAND: 容器最后运行的命令
	* CREATED: 容器创建的时间
	* STATUS: 容器的窗台
	* PORTS: 对外开放的端口
	* NAMES: 容器名。和容器ID一样都可以唯一标识一个容器

	选项:
	* -l 列出最后创建的容器
	* -a 所有
	* -n=x 列出最后创建的 x 个容器

	
启动容器(docker run创建的容器会直接进入运行状态): `docker start CONTAINERID/CONTAINERNAME`

	docker start inter_demo_name
	docker start 4a2ae1d0c01a
	
停止容器: `docker stop CONTAINERID/CONTAINERNAME`

删除容器: `docker rm CONTAINERID/CONTAINERNAME`:

	docker rm inter_demo_name
	docker rm 4a2ae1d0c01a
	docker rm -f 	inter_demo_name # 强制
	docker rm `docker ps -a -q` # 删除所有容器
	
### 容器内信息获取和命令执行

依附容器, 只能用于交互型容器: `docker attach CONTAINERID/CONTAINERNAME`

	创建交互型容器
	docker run -it --name ub ubuntu:14.04 /bin/sh
	依附到容器
	docker attach ub

查看容器日志: `docker logs [-f] [--tail=5] CONTAINERID/CONTAINERNAME`

	docker logs -f ub
	docker logs -f --tail=20 CONTAINERID/CONTAINERNAME
	
查看容器进程: `docker top CONTAINERID/CONTAINERNAME`

	docker top ub
	
	
查看容器信息: `docker inspect [-f] CONTAINERID/CONTAINERNAME`

	docker inspect ub
	docker inspect --format='{{.State.Running}}' ub
	docker inspect --format='{{.Name}} {{.NetworkSettings.IPAddress}}' ub
	
容器内执行命令: `docker exec [-d] CONTAINERID/CONTAINERNAME COMMAND [ARG...]`

	有时候需要在容器运行之后，另外启动一个程序，可以使用该命令
	
	docker exec -d ub touch /tmp/test.txt
	docker exec -it ub /bin/bash
	
容器导入导出: `docker export/import CONTAINERID/CONTAINERNAME`

	docker export ub > a_ub.tar
	cat a_ub.tar | docker import - imported:a_tag
	docker import url repo:tag
	
## 镜像

### 镜像基本操作

* docker images
* docker search
* docker rmi
* docker commit 或 Dockerfile 和 docker build
* docker tag
* docker pull
* docker push

查看: `docker images`

	docker images
	
	输出:
	* REPOSITORY: 仓库名。一般用来存放同意类型的镜像
	* TAG: 区分同意仓库中不同镜像，默认为 latest
	* IMAGE ID: 镜像 ID
	* CREATED: 镜像创建时间
	* SIZE: 奖项所占用虚拟的大小，该大小包含了所有共享文件的大小

仓库名形式:

* [namespace/ubuntu]: 命名空间和仓库名组成
* [ubuntu]: 只有仓库名。对于这种高明明空间的仓库名，一般可以认为它属于顶级命名空间，该空间的仓库只用于官方的镜像，由 Docker 官方进行管理
* [dl.dockerpool.com:5000/ubuntu:14.04]: 指定URL路径的方式，一般防止在自己搭建的 Hub 或第三方 Hub 上. `dl.dockerpoolcom:5000` 是 Hub 的主机名和端口

下载镜像: 在创建容器的时候，Docker 首先会在本机寻找镜像，如果本机没有就去 Docker Hub 搜索

搜索镜像: `docker search wordpress`

删除镜像: `docker rmi 一个或多个IMAGEID/TAG`

	相对于删除容器，多了一个 `i`, 即 image 的意思
	docker rmi c148be8e2e1e

删除无用的容器:

	docker rm $(docker ps -a -q)
	
创建镜像: `docker commit CONTAINER [REPOSITORY[:TAG]]` 或 使用 `Dockerfile`。使用 `Dockerfile` 和 `docker build` 指令 来构建镜像更加独立方便

	docker commit -m="Message" --author="Author" 1d3cf9046a76 develop:base
	
	执行 docker images 会发现多了一个镜像
	
Dockerfile 示例：

* FROM: 指定带扩展的父级镜像
* MAINTAINER: 声明创建镜像的作者信息
* RUN: 用来修改镜像的命令，常用来安装库、程序和配置程序

	有两种形式：
	
		RUN apt-get update
		RUN ["agt-get", "update"]
		
	* 第一种形式在 `/bin/sh` 环境中执行指定的命令
	* 第二种形式直接使用系统调用 `exec` 来执行

* EXPOSE: 指定容器对外开发的端口，多个端口之间使用空格隔开。运行容器时，也可以通过 `-P 或 -p` 进行端口映射
* ADD: 向镜像添加文件
* VOLUME: 在镜像中创建一个指定路径(文件或文件夹)的挂载点
* WORKDIR: 为接下来执行的指令指定一个新的工作目录，这个目录可以是绝对目录，也可以是相对目录
* ENV: 设置容器运行时的环境变量
* CMD: 用来设置启动容器时默认运行的命令

	与RUN类似，也有两种形式:
	
		CMD ls -l -a
		CMD ["ls", "-l", "-a"]
		
* ENTRYPOINT: 与 CMD 类似，也是用来指定容器启动时默认运行的命令

	**ENTRYPOINT 和 CMD 的区别在于运行容器时添加在镜像名之后的参数, 对于ENTRYPOIT是拼接，对于CMD命令则是覆盖**
	
	比如设置 ENTRYPOINT ["ls", "-l"]，那么:
	
		docker run ubuntu => docker run ubuntu ls -l
		docker run ubuntu -a => docker run ubuntu ls -l -a
		
	通常会将 CMD 和 ENTRYPOINT 搭配使用。ENTRYPOINT 指定需要运行的命令，CMD指定运行命令所需的参数
	
		ENTRYPOINT ["ls"]
		CMD ["-a", "-l"]
	
	这样就可以覆盖CMD命令，使得灵活变动命令的参数。当然，启动容器的时候可以指定`--entrypoint` 来覆盖 Dockerfile 中的参数
	
* USER: 为容器的运行和接下来的RUN, CMD, ENTRYPOINT等指令的运行指定用户或UID
* ONBUILD: 触发器指定。构建镜像的时候，Docker 镜像的构建器会将所有的ONBUILD指令指定的命令保存到镜像的元数据中，这些命令在当前镜像的构建过程中并不会执行，只有新的镜像使用FROM指令指定父镜像为这个镜像时，便会触发执行	

```

    # 1. 环境配置
    FROM ubuntu:14.04
    MAINTAINER example <example@goodrain.com>
    
    # 2. 运行命令，配置和安装相关文件
    RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata

    RUN apt-get update && apt-get install -y curl vim net-tools && rm -rf /var/lib/apt/lists/* \
        && mkdir -p /app
    ## Install JDK 7
    
    # 添加文件、文件夹、网络文件
    ADD abc.txt /tmp/
    ADD ./data /opt/data
    ADD https://www.example.com/image.jpg /opt/
    
    # 设置环境变量
    ENV WEBAPP_PORT=9090
    
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
    
    # 设置卷
    VOLUMN ["/data", "/var/www"]
      
    # Define default command. 指定脚本的运行
    # ENTRYPOINT 用于标明一个镜像作为容器运行时，最后要执行的程序或命令。 
    ENTRYPOINT ["/app/tomcat7.sh"]

```

构建镜像: `docker build [-t 命名空间仓库名和TAG] PAHT|URL`, 从 Dockerfile 构建镜像

	docker build -t develop:v1.1 .
	
	* -t: 指定镜像的命名空间、仓库名和TAG
	* .: 表示Dockerfile文件所在的相对目录
	
TAG: `docker tag IMAGE[:TAG] IMAGE[:TAG]`

	docker tag develop:v1.1 develop:v1.2

* 拉取镜像: `docker pull NAME[:TAG|@DIGEST]`

		docker pull registry:latest

* 发布镜像: `docker push  NAME[:TAG]`

		docker push registry.aliyuncs.com/example/develop:v1.1.0
		docker push registry.aliyuncs.com/example/develop:latest

	