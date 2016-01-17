# hive安装

	1：MySQL server + hive metastore service （hadoop3）
	安装MySQL
	[root@hadoop9 hadoop]# mysql -uroot -p 
	mysql> grant all on *.* to mysql@'%' identified by 'mysql' with grant option; 
	mysql> create user 'hadoop' identified by 'hadoop'; 
	mysql> grant all on *.* to hadoop@'%' with grant option; 
	mysql> quit;
	[root@hadoop9 hadoop]# mysql -uhadoop -p 
	mysql> create database hive; 
	mysql> quit;
	
	安装hive
	上传hive安装文件
	hadoop@wyy:/app/hadoop$ scp /home/mmicky/soft/hadoop/apache/hive/apache-hive-0.13.1-bin.tar.gz hadoop@hadoop3:/app/hadoop/
	解压
	[hadoop@hadoop3 hadoop]$ tar zxf  apache-hive-0.13.1-bin.tar.gz
	[hadoop@hadoop3 hadoop]$ mv apache-hive-0.13.1-bin hive013
	[hadoop@hadoop3 hadoop]$ cd hive013/conf
	[hadoop@hadoop3 conf]$ cp hive-default.xml.template hive-site.xml
	[hadoop@hadoop3 conf]$ cp hive-env.sh.template hive-env.sh
	[hadoop@hadoop3 conf]$ vi hive-env.sh
	HADOOP_HOME=/app/hadoop/hadoop220
	
	
	[hadoop@hadoop3 conf]$ vi hive-site.xml 
	<property> 
	  <name>javax.jdo.option.ConnectionURL</name> 
	  <value>jdbc:mysql://hadoop3:3306/hive?=createDatabaseIfNotExist=true</value> 
	  <description>JDBC connect string for a JDBC metastore</description> 
	</property> 
	<property> 
	  <name>javax.jdo.option.ConnectionDriverName</name> 
	  <value>com.mysql.jdbc.Driver</value> 
	  <description>Driver class name for a JDBC metastore</description> 
	</property> 
	<property> 
	  <name>javax.jdo.option.ConnectionUserName</name> 
	  <value>hadoop</value> 
	  <description>username to use against metastore database</description> 
	</property> 
	<property> 
	  <name>javax.jdo.option.ConnectionPassword</name> 
	  <value>hadoop</value> 
	  <description>password to use against metastore database</description> 
	</property>
	
	增加驱动程序
	hadoop@wyy:/app/hadoop$ scp /home/mmicky/soft/Program/mysql-connector-java-5.1.26-bin.jar hadoop@hadoop3:/app/hadoop/hive013/lib/.
	
	配置HIVE_HOME环境变量
	
	2：hive client安装
	复制将hive安装
	修改配置文件
	[hadoop@hadoop2 conf]$ vi hive-site.xml
	<property>
	  <name>hive.metastore.uris</name>
	  <value>thrift://hadoop3:9083</value>
	  <description>Thrift uri for the remote metastore. Used by metastore client to connect to remote metastore.</description>
	</property>
	
	配置HIVE_HOME环境变量
	
	
	3：metasotre演示
	启动hadoop
	[hadoop@hadoop1 hadoop220]$ sbin/start-dfs.sh
	[hadoop@hadoop1 hadoop220]$ sbin/start-yarn.sh
	
	单用户使用hive
	[hadoop@hadoop3 hive013]$ bin/hive
	
	多用户使用hive
	[hadoop@hadoop3 hive013]$ bin/hive --service metastore
	[hadoop@hadoop2 hive013]$ bin/hive
	
	再增加一个用户
	hadoop@wyy:/app/hadoop/hive013$ scp -r hadoop@hadoop2:/app/hadoop/hive013 .
	hadoop@wyy:/app/hadoop/hive013$ bin/hive
	
	后台运行
	前台退出ctrl+c 
	nohup bin/hive --service metastore > metastore.log 2>&1 &
	后台退出
	[hadoop@hadoop3 hive013]$ jobs
	[hadoop@hadoop3 hive013]$ kill %num