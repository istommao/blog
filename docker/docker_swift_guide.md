#Docker swift guide

基础：基于linux的namespace和cgroup

* CGroup限制容器的资源使用
* namespace机制，实现荣期间的隔离
* chroot，文件系统的隔离

##镜像、容器、仓库

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

				
		
	
		







				
	