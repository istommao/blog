#git常用操作和问题
====

##摘取某个或某几个提交

使用git cherry-pick或者通过git rebase

	git cherry-pick <commit-id>
	
	或者
	1. 假设要摘取在feature分支的提交到master分支
	git checkout feature
	2. 基于feature创建一个新的分支，指明新分支的最后一个commit
	git checkout -b new-br <最新的要摘取的提交id>
	3. rebase这个新分支的commit到master
	git rebase --onto master
	

可参考:

[多个commit 合并为一个patch](http://blog.csdn.net/xsckernel/article/details/17718127)

[Git合并特定commits 到另一个分支](http://blog.csdn.net/ybdesire/article/details/42145597)


##git commit合并

<http://sumsung753.blog.163.com/blog/static/146364501201312514427364/>

有时commit太多，而且可能一个commit只是提交一个小bug，那么合并commit势在必行。

操作方法：

* 一：该方法仅仅适用合并最后的两个提交。步骤是在提交最后一个修改的commit使用参数，这时之前的一个commit将会合并到这个即将提交的commit中来：
	
		git commit -a --amend -m "my message here"
	
	效果为：如果之前有一个提交，并且信息为:

		git commit -a -m "my last commit message"
	
	则这个commit message将不存在。但该commit的信息已经合并到"my message here"中了。
	
* 二：你提交了最后的修改，这时可用

		$ git reset --soft id 或者 git reset --mix id, git add .
		$ git commit -am"message"
						
> 需要注意的是：合并commit只能对还未提交的几个commit之间进行，因为如果对远程仓库已经有的commit合并将会遇到head冲突。在push到远程仓库时（比如github），会收到commit冲突提示。

* 三：使用git rebase -i <不变动的SHA-1>
* 四：通过分支合并的参数--sqush的方式。
	
	> --squash选项的含义是：本地文件内容与不使用该选项的合并结果相同，但是不保留待合并分支上的历史信息，也不提交、不移动HEAD，因此需要一条额外的commit命令。其效果相当于将another分支上的多个commit合并成一个，放在当前分支上，原来的commit历史则没有拿过来。
	
   > 判断是否使用--squash选项最根本的标准是，待合并分支上的历史是否有意义。

	比如要开发分支为feature，先建一个额外分支feature-test，在里面做了各种修改和提交，测试通过后，通过merge --squash进行合并，合并后进行一次commit。那么在feature-test里的各种提交都不见了，只剩下一个commit了。
	
		git checkout feature-test
		...做个各种commit1, commit2, ..., commitN
		git checkout feature
		git merge --squash feature-test
		git commit -am"New Commit"
		这时feature分支里没有commit1, commit2, ..., commitN，只有New Commit。

###参考：
[如何在 Git 里撤销(几乎)任何操作](http://blog.jobbole.com/87700/)




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

[多个commit 合并为一个patch](http://blog.csdn.net/xsckernel/article/details/17718127)

[git revert 和reset的区别](http://my.oschina.net/MinGKai/blog/144932)

[git中reset与revert的使用](http://samael65535.github.io/git/2013/01/18/git/)

====

##git忽略提交(add or commit)的文件

	首先， git rm --cached logs/xx.log
	然后更新 .gitignore 忽略掉目标文件
	最后 git commit -m "We really don't want Git to track this anymore!"
	
	p.s. 忽略已经add，但没有commit的文件夹
	git rm --cached -r logs

git rm --cached 删除的是追踪状态，而不是物理文件；如果你真的是彻底不想要了，你也可以直接 rm＋忽略＋提交。

	
[git忽略已经被提交的文件](http://segmentfault.com/q/1010000000430426)

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


##使用bc解决冲突

###在git中使用Beyond Compare

直接修改.gitconfig, 在文件后增加：

	[diff]
	tool = bcomp
	[difftool]
	prompt = false
	[difftool "bcomp"]
	trustExitCode = true
	cmd = "/usr/local/bin/bcomp" "$LOCAL" "$REMOTE"
	[merge]
	tool = bcomp
	[mergetool]
	prompt = false
	[mergetool "bcomp"]
	trustExitCode = true
	cmd = "/usr/local/bin/bcomp" "$LOCAL" "$REMOTE" "$BASE" "$MERGED"
	
冲突发生后，执行

	git mergetool

	

[在Mac下使用Beyond Compare](http://linyehui.wikidot.com/using-beyond-compare-in-mac)


## 如何PR

> Pull Request流程

> 开始我对Pull Request流程不熟悉，后来参考了[@numbbbbb](https://github.com/numbbbbb)的《The Swift Programming Language》协作流程，在此感谢。

1. 首先fork我的项目
2. 把fork过去的项目也就是你的项目clone到你的本地
3. 运行 git remote add looly git@github.com:looly/elasticsearch-definitive-guide-cn.git 把我的库添加为远端库
4. 运行 git pull looly master 拉取并合并到本地
5. 翻译内容
6. commit后push到自己的库（git push origin master）
7. 登录Github在你首页可以看到一个 pull request 按钮，点击它，填写一些说明信息，然后提交即可。

1~3是初始化操作，执行一次即可。在翻译前必须执行第4步同步我的库（这样避免冲突），然后执行5~7既可。

### 参考

* [Elasticsearch权威指南（中文版）](https://www.gitbook.com/book/looly/elasticsearch-the-definitive-guide-cn/details)

		