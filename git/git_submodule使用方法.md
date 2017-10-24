title: git submodule使用方法
date: 2016-07-28 09:28:00
tags:
- git
- submodule

# git submodule使用方法

## 简介

### 添加

为当前工程添加submodule，命令如下：

	git submodule add 仓库地址 路径

* 其中，仓库地址是指子模块仓库地址，路径指将子模块放置在当前工程下的路径。 
* 注意：路径不能以 / 结尾（会造成修改不生效）、不能是现有工程已有的目录（不能順利 Clone）. 比如： `git submodule add git@xxx/abc.git sub/abc`
* 命令执行完成，会在当前工程根路径下生成一个名为“`.gitmodules`”的文件，其中记录了子模块的信息。添加完成以后，再将子模块所在的文件夹添加到工程中即可。

### 删除

submodule的删除稍微麻烦点：

* 首先，要在“`.gitmodules`”文件中删除相应配置信息。
* 然后，执行“`git rm --cached `”命令将子模块所在的文件从git中删除。

#### 常见问题

删除然后在添加报错：`is found locally with remote`:

* git rm –-cached path_to_submodule
* Delete the relevant lines from the `.gitmodules`
* Delete the relevant section from .git/config
* rm -rf .git/modules/path_to_submodule
* Then, you can finally: `git submodule add https://github.com/path_to_submodule`

### 下载的工程带有submodule

当使用`git clone`下来的工程中带有`submodule`时，初始的时候，submodule的内容并不会自动下载下来的，此时，只需执行如下命令：

	git submodule update --init --recursive

即可将子模块内容下载下来后工程才不会缺少相应的文件。






## 参考

* [Git Submodule使用完整教程](http://www.kafeitu.me/git/2012/03/27/git-submodule.html)
* [git submodule的使用](http://blog.csdn.net/wangjia55/article/details/24400501)
* [Git-工具-子模块](https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E5%AD%90%E6%A8%A1%E5%9D%97)