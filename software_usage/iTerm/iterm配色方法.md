#iTerm配色方法

====

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


	