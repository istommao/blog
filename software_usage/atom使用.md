title: atom使用
date: 2016-07-11 00:42:00
tags:
- atom

# atom使用

准备专用atom作为前端、markdown等编辑器。记录atom使用的技巧。

## 快捷键

： `cmd + shift + p`

## 插件

插件安装：

	apm install
	or
	Preferences -> Install	
	
	
* atom-beautify：这是个美化代码的插件，几乎支持所有主流的语言，完全可以满足前端同学的使用
* autocomplete-paths：常用IDE的同学会常常在引入图片的时候发现只要输入 . 或者/ 或者文件夹名称的时候就会自动显示出文件夹中的内容，非常的实用，强烈推荐。
* autoprefixer：很多前端的同学在写css样式的时候常常忘记了添加兼容性前缀，例如-webkit-等内容，所以在写完css之后只需要这个插件就可以自动的帮你添加好所有需要的兼容性前缀
* color-picker: 作为一个有审美的设计向前端，常常需要确认自己的颜色属性是否是完美的，那么就需要这个插件，你就可以在任何一种颜色属性上看到一个完整的取色器
* docblockr： 我们不仅仅要写代码，还要养成写好注释的习惯，而经常看开源框架的同学会发现那些大神的代码前都会有一段完美的注释，写清了所有的参数和使用方式，你会觉得大神不仅仅代码专业，态度也是非常的认真，其实，有了这个插件，你仅仅需要一个tab键就可以写出一样专业的注释！强烈推荐！！！
* emmet：用sublime text的同学都知道这个插件，我这里就不多说了
* file-icons：你不觉得每一个文件前面都要有个漂亮的图标嘛~没错，你就需要它
* grunt-runner：作为一个前端，grunt相信大家都听说过，因为这个插件你就可以直接在编辑器里面操作你的grunt任务了
* git-plus：虽然原生的Atom就支持了git命令，但是这个插件会让你更加喜欢在Atom中使用git，这非常方便在Windows上使用git的同学
* linter：你觉得你的代码写的很不专业吗？这个插件会自动提示你代码中不规范的地方，如果你希望得到更完整的提示的话可以尝试更加详细的系列，例如linter-jshint
* markdown-format，markdown-writer：如果你不是Mac用户，并且十分喜欢使用markdown来写东西的话，那么你一定会爱上在Atom上写markdown的感觉
* minimap：用过sublime text的同学一定知道右边那方便的缩略图，难道这么好用的工具Atom上会没有吗？不会！这个插件就会让你见到熟悉的缩略图，那么为什么要用插件呢？因为这个插件可以继续安装插件！你会发现一个真正强大的缩！略！图！

	* minimap-codeglance: 用过Webstrom的同学都会记得有个代码放大镜的功能，这个插件就会让你的鼠标移动到缩略图上的时候放大显示那边部分的代码
minimap-find-and-replace
	* 当你想替换单词的时候你会想起ctrl+D，可以你知道全篇有多少你要替换的字符串吗？通过这个插件你就可以在缩略图上看到所有你选中的字符串
	* minimap-git-diff: 通过这个插件，每当你修改你的代码的时候你就会在缩略图上看到和之前git中的区别
	* minimap-highlight-selected: 当你选中部分代码的时候，它就会高亮的出现在缩略图中
	* minimap-linter: 这个插件让你的缩略图显示的更加漂亮和完整

* project-manager：做完一个前端狗，我相信你开发的不仅仅只有一个项目吧~那么你就需要这个插件来在一个Atom中管理你所有的项目
* javascript-snippets：这个插件也是我强烈推荐的！！！你以为只有html才有Emmet吗？太年轻了你！这个插件会告诉你javascrpt也有Emmet一样的插件！只需要输入几个字母，一个tab就让你完成了一长串的代码！！ 
* expose：当你一次性打开多个文件的时候也许你会使用分屏来查看，但是我相信你的屏幕不会大到让你无限的分屏，那么就需要在多个文件中切换，或者是查看多个文件，那么你可以点击最上边的标签，那有没有更方便的呢？有的！！那就是这个插件，shift+atl+e
* vim-mode：如果你是个忠诚的vim党，我相信这个插件你一定会喜欢的！


## 参考

(排名不分先后:))

* [优美的编辑器GitHub Atom](http://www.mamicode.com/info-detail-1060353.html)
* [极客学院atom教程](http://wiki.jikexueyuan.com/project/atom/)
* [emmet cheat-sheet](http://docs.emmet.io/cheat-sheet/)
* [atom折腾记](http://blog.csdn.net/bomess/article/category/3202419)
