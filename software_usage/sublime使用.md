title: sublime使用
date: 2016-06-23 15:12:00
tags:
- sublime

# sublime使用

* 配置快捷键

	Preference -> Key Bindings - User
	
	输入：
	
		[
		    { "keys": ["command+shift+c"], "command": "copy_path" },
		    { "keys": ["command+b"], "command": "navigate_to_definition" }
		]
	
* 配置快捷键

```
[
    { "keys": ["super+shift+c"], "command": "copy_path" },
    { "keys": ["ctrl+t"], "command": "open_terminal" },
    { "keys": ["super+shift+j"], "command": "goto_definition" },
    { "keys": ["super+shift+k"], "command": "run_macro_file", "args": {"file": "res://Packages/Default/Delete Line.sublime-macro"} },
]


```

## vim 模式

* [Vim 模式设置](http://www.cnblogs.com/zuike/p/4402022.html)

## 插件

* package control: 包管理器
* autopep8: python pep8
* ctags: 跳转
* gitgutter: git 显示
* side bar: 左侧栏
* jedi: python，自动补全
* [termimal](https://github.com/wbond/sublime_terminal): 在终端中打开文件所在目录
* 主题：[spacegray](https://github.com/kkga/spacegray)


其他：

* 完整常见插件
![其他](http://ww1.sinaimg.cn/large/616fb088gw1fa0o9t1ei3j20ou0u0grk.jpg)

* python 开发
![python](http://ww1.sinaimg.cn/large/616fb088gy1fh6sahi6lqj21180mq7bq.jpg)




## project 搜索配置

```
<project>,-*.tags,-*.tags_sorted_by_file,-test*.py, -*coverage, -*tox/*,-*/site-packages/*,-*.log,-*.Python,-*/venv/*,-*/env/*,-*/.idea/*,-*.html,-*.js,-*.css,
```

