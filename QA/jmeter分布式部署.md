#jmeter分布式部署

##简介
Jmeter 是java 应用，对于CPU和内存的消耗比较大，因此，当需要模拟数以千计的并发用户时，使用单台机器模拟所有的并发用户就有些力不从心，甚至会引起JAVA内存溢出错误。为了让jmeter工具提供更大的负载能力，jmeter短小精悍一有了使用多台机器同时产生负载的机制。
Jmeter的分布式部署分为jmeter客户端和jmeter服务器，一个jmeter客户端实例，理论上可以控制任意多的远程jmeter实例，并通过他们收集测试数据。测试时，先启动远程的jmeter服务器实例，然后再jmeter客户端远程运行服务端的jmeter进行测试。如此，便可以跨越多台低端计算机复制测试，模拟一个比较大的服务器压力。
结构如下：

<http://blog.csdn.net/jlminghui/article/details/42063231>

##部署步骤
###部署机器情况

	jmeter客户端：自己的Mac
	jmeter服务器：开发机192.168.1.10和192.168.1.11

###操作步骤
Step1：在每台需要部署jmeter的服务器上安装jdk，注意版本的选择（64or32bit）。如果安装不成功，可能需要先卸载原来的jdk版本。rpm -qa | grep jdk查看jdk的版本，然后卸载之，再重新安装jdk即可。

Step2：将jmeter包复制到每台部署机上。

Step3：分别到两台服务器将jmeter以服务器的方式启动：
	
	./jmeter-server -Djava.rmi.server.hostname=192.168.1.10 
	./jmeter-server -Djava.rmi.server.hostname=192.168.1.11

Step4：在本地Mac的jmeter安装路径中的bin目录修改jmeter.properties中的remote_hosts设置为

	remote_hosts=127.0.0.1,192.168.1.10,192.168.1.11

Step4：在本地Mac将jmeter以客户机的方式启动：./jmeter &

Step5：本地Mac弹出的图像界面可以通过：菜单-->运行–>远程启动（远程全部启动）将在对应（所有）的jmeter服务端启动测试计划。


###远端执行
将csv文件和测试脚本拷贝到对应目录，

如果不通过代理，那么直接登陆需要执行jmeter脚本的服务器，然后执行命令：

	jmeter -n -t <testplan filename> -l <listener filename>

比如：

	./jmeter -n -t test-plan.jmx -l listen_50_loop.jtl
	
如果需要通过分布式代理执行脚本：
	
	./jmeter -n -t <testplan filename> -R  ip1,ip2 -l <listener filename>
	
比如：

	./jmeter -n -t test-plan.jmx -R 192.168.181.10,192.168.181.11 -l listen_50_loop.jtl	

<http://blog.csdn.net/defonds/article/details/40858005>
<http://www.51testing.com/html/55/383255-847895.html>
<http://blog.csdn.net/ceo158/article/details/9331813>