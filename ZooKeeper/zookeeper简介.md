title: ZooKeeper简介
date: 2016-02-19 10:36:25
tags:
- ZooKeeper

----

# ZooKeeper简介

[分布式协调服务ZooKeeper工作原理](http://mp.weixin.qq.com/s?__biz=MzA4Nzc4MjI4MQ==&mid=402839281&idx=1&sn=e46ab7a4865f94f7a2ade584621c62c3&scene=0#wechat_redirect)

> **ZooKeeper是什么**
> 
> ZooKeeper(ZK)是一个分布式开源协调服务框架，是Google的Chubby一个开源的实现，是hadoop的一个子项目
> 
> 主要用来解决分布式系统的一致性问题，封装好了复杂易出错的关键服务，通过简单的接口为外部提供高性能、稳定的服务
> 
> 实际应用场景包括：统一命名服务、分布式配置管理、集群管理、分布式锁、分布式队列 ……

> **整体结构**
> 
> 对于外部，ZK是个整体，通过API与外部交流
> 
> ZK的内部，是个服务器集群，各服务器内数据完全相同，其中有一个server为leader，用来为其他server校准数据
> 
> client连接到ZK后，ZK会根据各个server的压力情况，把这个连接分配给合适的server，对client透明，client只知道自己已经和ZK连接了，不知道具体是哪个server

> **工作流程**
> 
> *读*
> 
> 读操作非常简单，因为各个server的数据完全一致，client发送读请求时，与此client相连的server直接从自己内存获取数据返回给client，非常快
> 
> *写*
> 
> 写操作会影响目录树结构和节点的数据内容，涉及到各个server间的数据一致性，所以不像读操作那么简单
> 
> 步骤
> 
> （1）client发送写请求给与其相连的server
> 
> （2）server把写请求转给leader
> 
> （3）leader执行写操作，然后通知其他server：数据有变化，你们马上更新
> 
> （4）各server更新数据后，通知client写操作完成




