# git基础和常用指令

## git常用操作
	
### 必懂和常使用的指令	
	git clone
	git init
	git log
	git status
	git add: 
		git add .
	git commit: 
		git commit -m"xxx" filename
		git commit -am"xxx"
	git push:
		git push
		git push origin master
	git pull:
		git pull
		git pull origin master
	git tag
	git branch
	git checkout
		git checkout -b <new_branch>
		git checkout -b <new_branch> [start_point] 
		
	指令详解[git-checkout](https://git-scm.com/docs/git-checkout)：

		git checkout [-q] [<commit>] [--] <paths> ...
		git checkout [<branch>]
		git checkout [-m] [ [-b | -- orphan ] <new_branch>]  [start_point] 
		
	git merge
	
[直观的命令总结](https://github.com/zhuwei05/blog/blob/master/git/%E7%9B%B4%E8%A7%82%E7%9A%84git%E5%91%BD%E4%BB%A4%E8%A1%A8.png)	
### 程库的常见操作

[远程库常见操作](https://github.com/zhuwei05/blog/blob/master/git/git%E8%BF%9C%E7%A8%8B%E5%BA%93.md)	

### 部分指令介绍

	git init
	初始化当前目录为git可管理的目录。
	git clone
	从远程库中复制一份。
	git remote add NAME URL
	添加远程仓库。
	git pull
	拉取远程库并且合并
	git push
	推送到远程库
	git add <pathspec>
	<pathspec>可以是文件，也可以是目录。把文件提交到暂存区中。
	git commit
	把暂存区的提交到本地库中。只有已经提交的，才能回退到任意版本。
	git reset
	版本回退。
	回退有三种模式：--hard，回退版本，并且工作区会恢复成版本库里的状态
	                             --soft，回退版本，工作区不修改，版本差异内容会放在暂存区里
	                             --mixed，默认模式，回退版本，工作区不修改版本差异内容不会放在暂存区里
	git diff
	查看与不同版本间的差异，默认是最当前分支的最新版本，也可以与不同分支，不同版本比较。
	git status
	查看当前状态，哪些被修改，哪些添加到缓存区。
	git show
	查看当前版本的修改。
	git log
	打印commit日志。加上-p还能看版本间的修改。
	git tag
	给版本打上tag，相当于别名，从而不用去记住版本号。
	git branch
	列出所有分支。
	git branch [<branch>]
	从branch产生一个新的分支，默认是master分支。
	git branch -d <branch>
	删除分支。
	git checkout <branch>
	切换分支。
	git checkout <filename>
	把文件恢复到最后一次提交。
	git merge <branch>
	把指定分支合并到当前分支。
	git stash
	把修改提交到暂存区里。
	git stash pop
	把暂存区里的取出并与当前合并。

## git工作流程图

![git工作流程图](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/git-%E5%B7%A5%E4%BD%9C%E6%B5%81%E7%A8%8B.png)

## git的学习和命令链接：
	
* [快速入门：git简易指南](http://www.bootcss.com/p/git-guide/)
* [git使用简单汇总](http://blog.csdn.net/richardysteven/article/details/5956854)
* [Pro git en](http://git-scm.com/book/en/v2)
* [Pro git cn](http://git-scm.com/book/zh/v1)
* [git命令](https://git-scm.com/docs)