title: 如何使用gitbook
date: 2016-04-08 23:10:10
tags:
- gitbook

# 如何使用gitbook
----

[GitBook](https://www.gitbook.com/) 是一个提供 Markdown 书籍托管的网络平台， 支持通过 git 以及 GitHub 进行文档管理，使用它可以很简单地生成、发布电子图书。 同时，[GitBook](https://www.gitbook.com/) 也是一个 Node.js 命令行工具，可以使用它搭建自己的 GitBook 站点。

除了命令行程序和 web 服务外，GitBook 官方还提供了 跨平台的编辑器，提供直接编辑、发布电子书的功能， 不过实际上仅相当于自启动的 GitBook 控制台程序，并不推荐安装，尤其对于 *nix 系统而言。

GitBook 网站使用简单，这里就不再赘述了，GitBook 控制台提供强大的本地服务， 自启动的站点能够提供和网站完全一样的编辑服务， 对于不方便登录其网站的用户来说非常方便。 GitBook 甚至提供 GitHub hook，在每一次 push 时自动更新书籍内容。

## 格式

* README: Introduction of the book
* SUMMARY: Chapters Structure
* LANGS: Multi-Languages book
* GLOSSARY: List of terms with descriptions

一本书至少需要有`README`和`SUMMARY`

### 输出格式

* 静态web（默认格式）
* PDF
* ePub
* Mobi

### README

书的第一页从`README.md`提取

用于`README.md`在github仓库常常用于工程介绍，因此可以使用其他文件替换（要求Gitbook > 2.0.0）：

`book.json`(myIntro.md需要位于书的根目录)

	{
	    "structure": {
	        "readme": "myIntro.md"
	    }
	}
	
### 章节

使用`SUMMARY.md`文件定义章节。`SUMMARY.md`中就是一些列指向对应章节文件的链接。

例子：

	# Summary
	
	* [Part I](part1/README.md)
	    * [Writing is nice](part1/writing.md)
	    * [GitBook is nice](part1/gitbook.md)
	* [Part II](part2/README.md)
	    * [We love feedback](part2/feedback_please.md)
	    * [Better tools for authors](part2/better_tools.md)

### 封面

默认使用`cover.jpg`或`cover_small.jpg`

### 多语言书籍

每种语言的文件都放置在不同的目录，然后在书的根目录中创建`LANGS.md`：

	* [English](en/)
	* [French](fr/)
	* [Español](es/)

示例[Learn Git](https://github.com/GitbookIO/git)

### Glossary

根目录下的`GLOSSARY.md`指定文中的术语，gitbook在遇到书中出现的术语时会自动建立术语的索引和高亮。

e.g.:

	# term
	Definition for this term
	
	# Another term
	With it's definition, this can contain bold text and all other kinds of inline markup ...
	
### 模板

Gitbook使用[Nunjucks](https://mozilla.github.io/nunjucks/)	和[Jinja2](http://jinja.pocoo.org/)

### 内容引用

* 从本地文件

		{% include "./test.md" %}

* 从其他书中引用

		{% include "git+https://github.com/GitbookIO/documentation.git/README.md#0.0.1" %}
		
	url的格式：
	
		git+https://user@hostname/project/blah.git/file#commit-ish
		

* 使用模板继承

### 忽略文件和文件夹

Gitbook会读取`.gitignore`, `.bookignore` 和 `.ignore`获取需要忽略的文件。这些文件的格式都与`.gitignore`一样：

	# This is a comment
	
	# Ignore the file test.md
	test.md
	
	# Ignore everything in the directory "bin"
	bin/*

### 配置

配置存储在json文件`book.json`中，所有的字段都是可选或者有默认值。

字段：

* gitbook：gitbook版本
* title：书的标题，默认从README.md读取
* description：书的描述
* isbn
* language：书的语言
* direction：文本方向
* styles：给书籍自定义css
* plugins：使用的一些列插件
* pluginsConfig：插件的配置
* structure：覆盖Gitbook的默认文件路径
* variables：定义模板中使用的变量
* pdf：可以设置pdf的页眉和页脚

### 插件

可以通过插件扩展Gitbook的功能。

#### 插件的使用

* 查找合适插件：[plugins.gitbook.com](plugins.gitbook.com)
* 在`book.json`指定或者如果在本地构建书籍的话，通过`gitbook install`安装

### 样式

`styles`目录可以指定书籍对应形式的`css`文件，可以使用`css`预处理器`less`和`sass`

### Math和Tex

## 构建书籍

1. 到gitbook.com创建书籍，生成的url为：`https://git.gitbook.com/{{UserName}}/{{Book}}.git` 

	p.s.: 该url可以在该book的`settings`中找到。	
2. 直接clone仓库：`git clone https://git.gitbook.com/{{UserName}}/{{Book}}.git`。根据提示输入用户名和密码（或gitbook的API Token）
3. 在clone下来的仓库进行文章的编写

### 免密

在`~/.netrc`新增或追加：

	machine git.gitbook.com
	  login USERNAME-or-EMAIL
	  password API-TOKEN-or-PASSWORD
	  
## GitHub集成

1. 在gitbook的account settings授权访问github，可以选择：默认权限、访问webhook权限、访问公有库、访问私有库






## 参考

* [GitBook Documentation](https://help.gitbook.com/)	
* [使用GitBook](http://blog.windrunner.info/tool/gitbook-tutorial.html)
	
	


