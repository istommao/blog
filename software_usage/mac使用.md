title: mac使用
date: 2016-11-17 09:35:00
tags:
- mac

# mac使用

装机软件: 

* appcleaner: 卸载软件
* apptivate: 设置打开软件快捷键
* alfred: 快速启动软件及高级功能
* 输入法
* sublime: 编辑器
* 有道云笔记/evernote, 有道词典
* mou: markdown 写作
* chrome: 浏览器，安装装相关插件
* dash: 开发者， api 手册
* tuxera: ntfs 
* beyond compare: 比较软件
* thunder, utorrent
* the unarchiver: 解压软件
* qq
* 爱奇艺, mpv 等
* 百度同步盘
* cheetsheet: 快捷键

## 命令

* 允许重复按键

  在 os x 里, 持续按住一个键, 是不会重复起作用的. 例如在 ST 里使用 Vim 模式, 我习惯按住 j 来持续移动. 但是发现移不动, 只移了一行. 可以执行如下命令禁止 os x 的这个行为:
  
    ```
    defaults write -g ApplePressAndHoldEnabled -bool false
    or 
    defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
    or 
    defaults write com.sublimetext.2 ApplePressAndHoldEnabled -bool false
    ```
    
  restart sublime!
  
 
