#ssh

##iTerm配色方法

1. 编写~/.bash_profile。看网上那个作者的配置是错的，坑死了。

		#enables colorin the terminal bash shell export
		export CLICOLOR=1
		
		#sets up thecolor scheme for list export
		export LSCOLORS=gxfxcxdxbxegedabagacad
		
		#sets up theprompt color (currently a green similar to linux terminal)
		export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
		
		#enables colorfor iTerm
		export TERM=xterm-256color
	
2. 打开iTerm2的使用偏好设置，选择profiles，然后选择Colors标签，然后进行颜色配置。用户也可以点击“Load Presets…”按钮加载一些经典的配色方案。

	托管在github上的关于iterm2配色方案的项目。地址是[github托管的iTerm配色地址](https://github.com/baskerville/iTerm-2-Color-Themes。)

##oh my zsh

1. 查看系统的shell

		cat /etc/shells
		
			/bin/bash
			/bin/csh
			/bin/ksh
			/bin/sh
			/bin/tcsh
			/bin/zsh
			
2. 如果没有zsh，安装zsh

		Debian
			sudo yum install zsh
		Ubuntu
			sudo apt-get install zsh
			
	安装完成后设置当前用户使用 zsh：chsh -s /bin/zsh，根据提示输入当前用户的密码就可以了。	
	
3. 安装zsh

	如果没有安装git，需要先安装git
		
		sudo yum install git
	
	自动安装zsh
	
		wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
		
		
4. 参考

	[终极 Shell](http://macshuo.com/?p=676)	

##免密码登录
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