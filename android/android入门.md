title: android入门
date: 2016-02-02 07:55:55
tags:
- android

----

# android入门

## 安装和配置


## 什么是Activity

* 当程序第一次运行时用户就会看这个Activity
* 当启动其他Activity，当前Activity

### Activity生命周期

7个方法，3个阶段

* onCreate
* onStart
* onRestart
* onResume
* onPause
* onStop
* onDestroy

* 开始Activity： onCreate, onStart, onResume
* 重新开始： onStart,  onRestart, onResume
* 关闭： onPause, onStop, onDestroy


Activity具体生命周期：

* 整体生命周期： onCreate --> onDestroy
* 可视生命周期： onStart --> onStop
* 焦点生命周期： onResume --> onPause




