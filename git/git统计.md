#git统计

命令：

	git log --author="$(git config --get user.name)" --no-merges --since=1am --stat
	
	git diff --since=yesterday --stat