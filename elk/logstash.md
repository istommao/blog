title: logstash
date: 2016-01-27 18:01:41
tags:
- logstash
- log
- elk

----


# logstash入门

## 简介

LogStash架构专为收集、分析和存储日志所设计。三个主要功能：事件输入、事件数据过滤以及事件输出。

Logstash的理念很简单，它只做3件事情：

* Collect：数据输入
* Enrich：数据加工，如过滤，改写等
* Transport：数据输出

LogStash的这三个功能是根据配置信息执行的，这些信息存储在简单易懂的“.conf”文件中。 “.conf”文件中有不同的配置节对应LogStash所使用的三种不同类型的插件 输入（input）、过滤器（filter）以及输出（output）。

## 安装

下载[logstash](https://www.elastic.co/downloads/logstash)


可下载源码，然后解压后得到源码，设置软连接，比如：

	ln -s /root/logstash/logstash-2.1.0 /usr/local/logstash
	
### 测试

	/usr/local/logstash/bin/logstash -e 'input { stdin { } } output { stdout {} }'
	
等待logstash启动成功后, 出现类似：

	Settings: Default filter workers: 2
	Logstash startup completed
	
在终端（注意没提示）输入内容：会生成对应输出.

## 使用logstash收集日志

### 编写conf文件

### 测试conf文件

	bin/logstash -f first-pipeline.conf --configtest
	
### 运行

	bin/logstash -f first-pipeline.conf
	