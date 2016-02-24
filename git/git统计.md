title: git统计
date: 2016-02-24 10:26
tags:
- git
- statistics

----


# git统计

## 简单命令：

	git log --author="$(git config --get user.name)" --no-merges --since=1am --stat
	
	git diff --since=yesterday --stat
	
显示所有贡献者及其commit数

	git shortlog -–numbered -–summary
	
只看某作者提交的commit

	git log -–author="xxx" –-oneline -–shortstat		
	
## 使用gitstats

	git clone git://github.com/hoxu/gitstats.git
	cd gitstats
	./gitstats 你的项目的位置 生成统计的文件夹位置
	
根据提示打开生成的idex.html文件即可查看		
	
## 参考

* [gitstats](https://github.com/hoxu/gitstats)
* [统计本地Git仓库...](http://www.94joy.com/archives/115)	