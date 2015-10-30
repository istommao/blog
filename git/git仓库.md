#git仓库和远程库操作

## 复制 2600hz/kazoo 镜像库
	git clone --mirror https://github.com/2600hz/kazoo.git
 
## 添加上游源和本地源
	cd kazoo.git
	git remote rename origin upstream
	git remote add origin ssh://root@192.168.1.11/kazoo.git
 
## 将镜像仓库推送到 git stash
	git push --all origin
	git push --tags origin
 
## 上游代码同步: 在本地kazoo.git镜像库定期执行以下操作进行同步并推送到git stash
	git fetch --prune upstream
	git push --all origin
	git push --tags origin


##其他操作
从原有repo生成裸repo

	git clone --bare project_test projetest.git

切换远程分支
	
	git checkout -b 本地分支名 远端分支
	git checkout -b br_name remotes/br_name
	
远程库命令

	查看当前的远程库
	git remote [-v]
	git remote show [remote-name]
	
	添加远程仓库
	git remote add [shortname] [url]
	
	从远程仓库抓取数据
	git fetch [remote-name]
	git pull
	
	推送数据到远程仓库
	git push [remote-name] [branch-name]
	e.g git push origin master

	远程仓库的删除和重命名
	git remote rename old-name new-name
	git remote rm name
	
	添加多个远程库
		首先，先增加第一个地址 git remote add all <url1> 
		然后增加第二个地址 git remote set-url --add all <url2> 
		增加第三个地址 git remote set-url --add all <url3> 	
		
		只要使用git push all master 就可以一次性push到3各库里面了(使用git push也可)
		
	解释：git remote set-url --add origin 就是往当前git项目的config文件里增加一行记录，因此可以直接通过vim或git config -e对.git/config文件中增加也是可以的,例如增加
	
		[remote "all"] 
		 url = ssh://server.example.org/opt/ex1.git 
      url = ssh://other.example.org/opt/ex2.git
	
	
	
	