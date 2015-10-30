#git常用操作和问题
====

##git常用操作
	
###必懂和常使用的指令	
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
	git merge

###部分指令介绍

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
	git check <branch>
	切换分支。
	git check <filename>
	把文件恢复到最后一次提交。
	git merge <branch>
	把指定分支合并到当前分支。
	git stash
	把修改提交到暂存区里。
	git stash pop
	把暂存区里的取出并与当前合并。

*git工作流程图：*

![git工作流程图](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/git-%E5%B7%A5%E4%BD%9C%E6%B5%81%E7%A8%8B.png)

git的学习和命令链接：
	
[快速入门：git简易指南](http://www.bootcss.com/p/git-guide/)

[git使用简单汇总](http://blog.csdn.net/richardysteven/article/details/5956854)

[Pro git en](http://git-scm.com/book/en/v2)

[Pro git cn](http://git-scm.com/book/zh/v1)



##git commit合并

<http://sumsung753.blog.163.com/blog/static/146364501201312514427364/>

有时commit太多，而且可能一个commit只是提交一个小bug，那么合并commit势在必行。

有两种方法：

* 一是在提交最后一个修改的commit使用参数，这时之前的一个commit将会合并到这个即将提交的commit中来：
	
		git commit -a --amend -m "my message here"
	
	如果之前有一个提交，并且信息为:

		git commit -a -m "my last commit message"
	
	则这个commit message将不存在。但该commit的信息已经合并到"my message here"中了。
	
* 第二个是，如果你提交了最后的修改，这时可用

		$ git reset --soft HEAD^ #或HEAD^意为取消最后commit
		$ git commit --amend	
		
	这将会把最后一个commit合并到前一个提交中去，例如（由上往下读）：
	
		git add b.text
		git commit -a -m "my message here"
		git add a.text
		git commit -a -m "my last commit message"	
	那么最后存在的将是"my last commit message"。也可后退n个，合并到前面第n+1个commit中去：
	
		$ git reset --soft HEAD~n 
		$ git commit --amend [-m "new message"]
		
				
> 需要注意的是：合并commit只能对还未提交的几个commit之间进行，因为如果对远程仓库已经有的commit合并将会遇到head冲突。在push到远程仓库时（比如github），会收到commit冲突提示。

=====

##git revert和git reset

git revert和git reset的区别：

> git revert 是撤销某次操作，此次操作之前的commit都会被保留

> git reset 是撤销某次提交，但是此次之后的修改都会被退回到暂存区


执行:
	
	git revert HEAD~1
	
则倒数第二次的commit被取消，但是不影响提交的代码，此时git status没有任何变化。

执行git reset需要区分三种不同的情形：

	git reset --mixed id ，是将git的HEAD变了（也就是提交记录变了），但文件并没有改变，（也就是working tree并没有改变）。
	
	git reset --soft id. 实际上，是git reset –mixed id 后，又做了一次git add
	
	git reset --hard id.是将git的HEAD变了，文件也变了。

> git revert与git reset最大的不同是，git revert 仅仅是撤销某次提交。
比如git revert HEAD~1  ,那么会撤销倒数第二次的提交结果。而倒数第一次的提交记录，仍然在。

> 如果git reset –hard HEAD~1,那么，commit退回到倒数第三次的状态中。	
> 通过git reset –soft id的方法，可以将原来多次的git提交记录合并为一个。就是前面提到的git commit合并的一种方法。

更多参考: 

<http://my.oschina.net/MinGKai/blog/144932>

<http://samael65535.github.io/git/2013/01/18/git/>

====

##git忽略提交的文件

	首先， git rm --cached logs/xx.log
	然后更新 .gitignore 忽略掉目标文件
	最后 git commit -m "We really don't want Git to track this anymore!"
	
[参考](http://segmentfault.com/q/1010000000430426)

====

##fatal: Pathspec 'xxx' is in submodule 'module/CC'

	git rm -rf --cached CC/
	git add CC/


参考：<http://stackoverflow.com/questions/23612012/fatal-pathspec-autoload-classmap-php-is-in-submodule-module-cocktailmakermod>	

====	

##git密码

====

##git配置

	git config --global user.name "your name"
	git config --global user.email  mail@box.com
	git config --global color.ui true
	git config --global core.editor vi
	git config --global alias.lol "log --graph --all"    设置alias，这样lol就是自己新的命令了。
	
	git config --list
	git config --local user.name "your name"
	git config --local user.email mail@box.com
	
设置别名
	
	$ git config --global alias.co checkout
	$ git config --global alias.ci commit
	$ git config --global alias.br branch
	
		
====

##git列出跟踪的文件

	git ls-files		
	
===

##git status中文显示unicode

	git config --global core.quotepath false





		