title: bumpversion的使用
date: 2016-11-25 20:07:00
tags:
- bumpversion
- python

# bumpversion的使用

* Bumping version according to [semantic versioning](http://semver.org/)
* 快速入门，参看 [bumpversion](https://github.com/peritus/bumpversion) 的视频


## 安装

    pip install bumpversion


## 在项目中使用

在项目中加入 `.bumpversion.cfg` :

    [bumpversion]
    current_version = 0.0.1
    commit = True
    tag = True

* current_version: 必须字段。指定了当前的版本。当你执行 `bumpversion [options] part [file]` 的时候，它会读取该文件的 `current_version` 并根据指定的 `part` 去更改版本号，并且更改文件中的版本号
* commit: 可选。当使用版本控制，如 `git`，会自动生成一次提交。`bumpversion patch --commit`
* tag: 可选。和 commit 类似。`bumpversion minor --commit --tag`

所以，在上面的配置做的工作就是当你执行 `bummversion part` 的时候，它会根据你指定的 `part` (*major*, *minor*, *patch*)自动修改 `.bumpversoin.cfg` 中的版本号，并在版本控制中生成一个 `commit` 和 一个 `tag`





## 参考

* [bumpversion](https://github.com/peritus/bumpversion)

