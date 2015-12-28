#hadoop分布式部署

## 基本设置

### 创建hadoop用户

	su    # 切换root用户
	groupadd hadoop     #添加一个叫hadoop的用户组
	useradd hadoop -g hadoop  #添加一个hadoop用户并加入hadoop组
	vim /etc/sudoers    #编辑sudoers文件，给hadoop用户sudo权限
	hadoop ALL=(ALL) ALL    #在sudoers尾部加上这一行
	
	修改密码
	passwd hadoop	

### 配置ssh无密码登录

切换到hadoop用户

	cd ~/.ssh/                     # 若没有该目录，请先执行一次ssh localhost
	ssh-keygen -t rsa              # 会有提示，都按回车就可以
	cat id_rsa.pub >> authorized_keys  # 加入授权
	
	sudo chmod 644 ~/.ssh/authorized_keys
	sudo chmod 700 ~/.ssh

### 安装java环境

安装java

	去java官方下载并安装使用：http://www.java.com/zh_CN/download/manual.jsp
	
配置JAVA_HOME

	vim ~/.bashrc

	在文件最后面添加如下单独一行（指向 JDK 的安装位置），并保存：
		export JAVA_HOME={你的java安装路径}
	
	比如：
		export JAVA_HOME=/usr/lib/java
	
	使变量设置生效
		source ~/.bashrc    			
	
		

## 伪分布式安装

### 安装hadoop

下载hadoop的编译版本: ***hadoop-2.x.y.tar.gz***

解压到目录：

	cd /home/hadoop
	tar -zxvf hadoop-2.7.1.tar.gz
	mv hadoop-2.7.1 hadoop
	
### 伪分布式	配置

伪分布式需要修改的配置文件：***core-site.xml*** 和 ***hdfs-site.xml***

修改$HADOOP_HOME/etc/hadoop/core-site.xml，在configuration中增加：

	<configuration>
	    <property>
	        <name>hadoop.tmp.dir</name>
	        <value>file:/usr/local/hadoop/tmp</value>
	        <description>Abase for other temporary directories.</description>
	    </property>
	    <property>
	        <name>fs.defaultFS</name>
	        <value>hdfs://localhost:9000</value>
	    </property>
	</configuration>
	
修改$HADOOP_HOME/etc/hadoop/hdfs-site.xml，在configuration中增加：	

	<configuration>
	    <property>
	        <name>dfs.replication</name>
	        <value>1</value>
	    </property>
	    <property>
	        <name>dfs.namenode.name.dir</name>
	        <value>file:/usr/local/hadoop/tmp/dfs/name</value>
	    </property>
	    <property>
	        <name>dfs.datanode.data.dir</name>
	        <value>file:/usr/local/hadoop/tmp/dfs/data</value>
	    </property>
	</configuration>
	
### 格式化

	./bin/hdfs namenode -format
	
注意不能多次格式化，要重新格式化，先把dfs的目录删除：`rm -rf ~/hadoop/tmp`	
	
### 启动NameNode和DataNode守护进程

	./sbin/start-dfs.sh
	
启动时可能会有 WARN 提示 :

> WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable

> 这个问题搜索一下能找到解决办法，主要就是因为下载的bin是32位机器上编译的，所以本地库不好用，需要拿源码在本机重新编译一下。不过据说不影响使用，暂时就不管它了。


启动完成后，可以通过命令 **jps** 来判断是否成功启动，若成功启动则会列出如下进程: **NameNode、DataNode和SecondaryNameNode**（如果 SecondaryNameNode 没有启动，请运行 sbin/stop-dfs.sh 关闭进程，然后再次尝试启动尝试）。如果没有 NameNode 或 DataNode ，那就是配置不成功，请仔细检查之前步骤，或通过查看启动日志排查原因。


## 分布式部署

###基本设置

1. 同前面的**基本设置**中所讲一样，安装java并配置JAVA_HOME

2. 给集群所有节点配置hostname，修改/etc/hosts文件。例如：

		#增加了下面3行
		192.168.11.10   DataWorks.Master
		192.168.11.11   DataWorks.Node1
		192.168.11.12   DataWorks.Node2

3. 将集群各个节点的~/.ssh/id_rsa.pub中的内容都添加到~/.ssh/authorized_keys，确保所有节点互相之间ssh做到无密码

### 修改配置文件（只需在主节点进行）

这里要涉及到的配置文件有7个：
 
* ~/hadoop/etc/hadoop/hadoop-env.sh 
* ~/hadoop/etc/hadoop/yarn-env.sh 
* ~/hadoop/etc/hadoop/slaves 
* ~/hadoop/etc/hadoop/core-site.xml 
* ~/hadoop/etc/hadoop/hdfs-site.xml 
* ~/hadoop/etc/hadoop/mapred-site.xml 
* ~/hadoop/etc/hadoop/yarn-site.xml


hadoop-env.sh	
	
	$ vim ~/hadoop/etc/hadoop/hadoop-env.sh
	# 这个文件要修改的地方就是JAVA_HOME环境变量，刚才我们设置过JAVA_HOME的，在我的案例里改成如下——
	# The java implementation to use.
	export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.91.x86_64	
	
yarn-env.sh
	
	$ vim ~/hadoop/etc/hadoop/yarn-env.sh
	# yarn的环境配置，同样只需要修改JAVA_HOME就行，找到下面这行——
	# some Java parameters
	export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.91.x86_64
	
slaves
	
	$ vim ~/hadoop/etc/hadoop/slaves
	# 这是设置从节点hostname的地方，一行一个，我们的例子里只要在文件里写上如下两行就行了
	DataWorks.Node1
	DataWorks.Node2
	
core-site.xml
	
	$ vim mkdir ~/hadoop/tmp	#新建一个tmp文件夹
	$ vim ~/hadoop/etc/hadoop/core-site.xml
	#fs.default.name配置了hadoop的HDFS系统的命名，位置为主机的9000端口；hadoop.tmp.dir配置了hadoop的tmp目录的根位置。这里使用了一个文件系统中没有的位置，所以要先用mkdir命令新建一下。
	<configuration>
	<property>
	<name>hadoop.tmp.dir</name>
	<value>/home/hadoop/hadoop/tmp</value>
	</property>
	<property>
	<name>fs.default.name</name>
	<value>hdfs://DataWorks.Master:9000</value>
	</property>
	</configuration>
	
	
hdfs-site.xml
	
	$ vim ~/hadoop/etc/hadoop/hdfs-site.xml
	#这个是hdfs的配置文件，dfs.http.address配置了hdfs的http的访问位置；dfs.replication配置了文件块的副本数，一般不大于从机的个数。
	<configuration>
	<property>
	<name>dfs.http.address</name>
	<value>DataWorks.Master:50070</value>
	</property>
	<property>
	<name>dfs.namenode.secondary.http-address</name>
	<value>DataWorks.Master:50090</value>
	</property>
	<property>
	<name>dfs.replication</name>
	<value>1</value>
	</property>
	</configuration>


接下去是mapreduce的配置文件mapred-site.xml
	
	$ cd ~/hadoop/etc/hadoop/
	$ cp mapred-site.xml.template mapred-site.xml
	$ vim mapred-site.xml			

在\<configuration\>\</configuration\>中添加设置。在mapreduce.framework.name属性下配置为yarn。mapred.map.tasks和mapred.reduce.tasks分别为map和reduce的任务数

	<!-- Put site-specific property overrides in this file. -->
	<configuration>
	<property>
	<name>mapred.job.tracker</name>
	<value>DataWorks.Master:9001</value>
	</property>
	<property>
	<name>mapred.map.tasks</name>
	<value>20</value>
	</property>
	<property>
	<name>mapred.reduce.tasks</name>
	<value>4</value>
	</property>
	<property>
	<name>mapreduce.framework.name</name>
	<value>yarn</value>
	</property>
	<property>
	<name>mapreduce.jobhistory.address</name>
	<value>DataWorks.Master:10020</value>
	</property>
	<property>
	<name>mapreduce.jobhistory.webapp.address</name>
	<value>DataWorks.Master:19888</value>
	</property>
	</configuration>
	
yarn-site.xml
		
	$ vim ~/hadoop/etc/hadoop/yarn-site.xml
	#该文件为yarn框架的配置,主要是一些任务的启动位置
	<configuration>
	<!-- Site specific YARN configuration properties -->
	<property>
	 <name>yarn.resourcemanager.address</name>
	<value>DataWorks.Master:8032</value>
	</property>
	<property>
	<name>yarn.resourcemanager.scheduler.address</name>
	 <value>DataWorks.Master:8030</value>
	</property>
	<property>
	 <name>yarn.resourcemanager.webapp.address</name>
	 <value>DataWorks.Master:8088</value>
	</property>
	<property>
	<name>yarn.resourcemanager.resource-tracker.address</name>
	<value>DataWorks.Master:8031</value>
	</property>
	<property>
	<name>yarn.resourcemanager.admin.address</name>
	<value>DataWorks.Master:8033</value>
	</property>
	<property>
	<name>yarn.nodemanager.aux-services</name>
	<value>mapreduce_shuffle</value>
	</property>
	<property>
	<name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
	<value>org.apache.hadoop.mapred.ShuffleHandler</value>
	</property>
	</configuration>	
	

配置完成了

	将配置好的hadoop复制到其他节点
	scp –r ~/hadoop hadoop@DataWorks.Node1:~/
	scp –r ~/hadoop hadoop@DataWorks.Node2:~/

这样就安装完了。是不是心里有点小激动？别着急，我们接下去就启动它来验证一下是否正常工作。由于Master机是namenode，所以我们要先对它的hdfs格式化一下。在DataWorks.Master下：

	$ cd ~/hadoop
	$ ./bin/hdfs namenode -format   #格式化namenode
	$ ./sbin/start-all.sh      #启动hadoop。2.6.2版本的start-all.sh是在./sbin目录下的，看到网上其他一些教程写的是./bin，估计就是版本差异


	jps
	43551 ResourceManager
	43206 NameNode
	43398 SecondaryNameNode
	43950 Jps

DataWorks.Master上执行jps查看发现有四个进程 

DataWorks.Node1上大致有:

	Jps 
	DataNode 
	NodeManager 
	
这三个进程。

打开浏览器访问一下http://DataWorks.Master:50070


##参考

完全分布式直接安装该文章：

<https://www.zybuluo.com/Emptyset/note/220230>

伪分布安装也可以按照完全分布式的步骤，只不过不进行**~/hadoop/etc/hadoop/slaves**的修改即可。

伪分布式也可以按照该文章：

<http://dblab.xmu.edu.cn/blog/install-hadoop-in-centos/>

 




