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
	


	

	


	



	