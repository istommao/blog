#Mac的使用

##关闭Dashboard和Spotlight

[参考出处](http://blog.csdn.net/ituff/article/details/40209755)
###关闭Dashboard

	defaults write com.apple.dashboard mcx-disabled -boolean YES
	killall Dock

###关闭Spotlight

####1、关闭Spotlight服务

	sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

####2、删除Spotlight图标

	cd /System/Library/CoreServices/
	sudo mv Search.bundle/ Search2.bundle/
	killall SystemUIServer

####如果你后悔了

###恢复Dashboard

	defaults write com.apple.dashboard mcx-disabled -boolean NO
	killall Dock

###开启Spotlight服务

	sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
###恢复Spotlight图标

	cd /System/Library/CoreServices/
	sudo mv Search2.bundle/ Search.bundle/
	
##在Mac下显示Finder中的所有文件

[参考出处](http://www.cnblogs.com/elfsundae/archive/2010/11/30/1892544.html)

	显示：defaults write com.apple.Finder AppleShowAllFiles YES
	隐藏：defaults write com.apple.Finder AppleShowAllFiles NO
	
	或者：
	
	显示：defaults write com.apple.finder AppleShowAllFiles -bool true
	隐藏：defaults write com.apple.finder AppleShowAllFiles -bool false
	
	