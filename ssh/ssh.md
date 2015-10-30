#ssh

生成公匙

	ssh-keygen
	ssh-keygen -t rsa 

在~/.ssh/有公匙id_rsa.pub和密匙id_rsa
	
拷贝到服务器，然后执行

	cat id_rsa.pub >> ~/.ssh/authorized_keys
	
如果用到github上，可以在github账号添加公匙id_rsa.pub的内容。


设置文件和目录权限

	chmod 600 authorized_keys
	chmod 700 -R .ssh  
	
总结

>某个机器生成自己的RSA或者DSA的数字签名，将公钥给目标机器，然后目标机器接收后设定相关权限（公钥和authorized_keys权限），这个目标机就能被生成数字签名的机器无密码访问了	