#git分支模型
====

<http://www.oschina.net/translate/a-successful-git-branching-model>

![模型图](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/git-branch-model.png)

简单说来：

* master分支用于发布到线上和生产环境，记得在其上打上tag
* develop是开发者使用的分支
* 功能分支（feature branches）就是开发人员在develop分支上根据需要基于develop在本地新建的各个分支，并在开发完成或取消就讲其合并到develop分支。因此该分支存在于某个该功能开发过程中，开发完成就删除。
* 发布分支(release branches)一般基于develop分支，但develop分支达到一个稳定的待发布状态，这是就可以创建release分支，进行新版本发布前的准备（小bug的修改和版本号，开发时间等）。准备好后就可以合并到master分支。如果发布到达预期目标，就可以将该release分支合并到develop，并删除该分支。
* 热修复分支(hotfixes)一般基于master分支，一般在线上环境出现的bug进行快速修复，就可以在master分支上创建该类型分支，并带上小版本号，修复后就可以合并到master，如果达到预期目标，就可以将该热修复合并到release分支（如果存在）或develop分支，最后就可以删除该分支了。



##主分支

* master分支
* develop分支

每个Git用户都要熟悉原始的master分支。与master分支并行的另一个分支，我们称之为develop分支。

当develop分支的源码到达了一个稳定的待发布状态，所有的代码变更需要以某种方式合并到master分支，然后标记一个版本号。

所以，每次变更都合并到了master，这就是新产品的定义。在这一点，我们倾向于严格执行这一点，从而，理论上，每当对master有一个提交操作，我们就可以使用Git钩子脚本来自动构建并且发布软件到生产服务器。


##辅助性分支

* 功能分支(feature branches)
* 发布分支(release branches)
* 热修复分支(hotfixes)

###功能分支

* 功能分支（有时被称为topic分支）通常为即将发布或者未来发布版开发新的功能。

* 功能版本的实质是只要这个功能处于开发状态它就会存在，但是最终会或合并到develop分支（确定将新功能添加到不久的发布版中）或取消（譬如一次令人失望的测试）。

* 功能分支通常存在于开发者的软件库，而不是在源代码库中。

* develop分支的分支版本，最终必须合并到develop分支中。

* 分支命名规则：除了master、develop、release-\*、hotfix-\*之外，其他命名均可。

####命令

1. 创建一个功能分支

		git checkout -b myfeature develop
	
2. 合并一个功能到develop分支

	完成的功能可以合并进develop分支，以明确加入到未来的发布：
	
		git checkout develop
		git merge --no-ff myfeature
		git branch -d myfeature
		git push origin develop
		
	--no-ff标志导致合并操作创建一个新commit对象，即使该合并操作可以fast-forward。这避免了丢失这个功能分支存在的历史信息。
	
###发布分支Release

* Release分支可能从develop分支分离而来，但是一定要合并到develop和master分支上，它的习惯命名方式为：release-*。
* Release分支是为新产品的发布做准备的。它允许我们在最后时刻做一些细小的修改。他们允许小bugs的修改和准备发布元数据（版本号，开发时间等等）。

####命令

1. 创建一个release分支
	
	Release分支是从develop分支创建的。develop 分支已经为下次发行做好了准备。
	
		git checkout -b release-1.2 develop
		...这里可能有些小的修改，并提交...
	
	这个新分支可能会存在一段时间，直到该发行版到达它的预定目标。在此期间，bug的修复可能被提交到该分支上（而不是提交到develop分支上）。**在这里严格禁止增加大的新features**。他们必须合并到develop分支上，然后等待下一次大的发行版。
	
2. 完成一个release分支

	当一个release分支准备好成为一个真正的发行版的时候，有一些工作必须完成。
	* release分支要合并到master上（因为每一次提交到master上的都是一个新定义的发行版，记住），并打上标签，以便以后更加方便的引用这个历史版本
			
			git checkout master
			git merge --no-ff release-1.2
			git tag -a 1.2
	
	* 在release分支上的修改必须合并到develop分支上，并删除该分支
	
			git checkout develop
			git merge --no-ff release-1.2 #可能有冲突，修复并提交
			git branch -d release-1.2
			
###热修复分支

* 一般基于master分支，必须合并回develop和master分支。
* 分支名约定：hotfix-*			
* 当生成环境验证缺陷必须马上修复是，热修复分支可以基于master分支上对应与线上版本的tag创建。
* 其本质是团队成员（在develop分支上）的工作可以继续，而另一个人准备生产环境的快速修复。

####命令

1. 创建修补bug分支
	
	hotfix branch(修补bug分支)是从Master分支上面分出来的。例如，1.2版本是当前生产环境的版本并且有bug。但是开发分支（develop）变化还不稳定。我们需要分出来一个修补bug分支（hotfix branch）来解决这种情况。*（这里记得更新版本号冲1.2==》1.2.1）*
	
		git checkout -b hotfix-1.2.1 master
		...进行bug修复，并提交
			
2. 完成一个hotfix分支

	类似完成一个release分支，也需要进行几部基本操作。
	
	* 更新master并对release打上tag
	
			git checkout master
			git merge --no-ff hotfix-1.2.1
			git tag -a 1.2.1
		
	* 一般将bugfix添加到develop分支中，*除非这是存在一个release分支，那么应该把hotfix合并到这个release分支，而不是合并到develop分支。*，并删除该分支
	
			git checkout develop
			git merge --no-ff hotfix-1.2.1
			git branch -d hotfix-1.2.1		
			
	
			
			
	







