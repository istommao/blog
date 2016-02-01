title: react native入门
date: 2016-01-31 18:29:02
tags:
- react native

---

# react native入门

## 安装配置（ios）

* nodejs4.0及以上
* 使用homebrew（maxos）
* 安装watchman和flow

		brew install watchman
		brew install flow
		
* xcode7.0及以上
* 安装react-native-cli

		npm install -g react-native-cli
		
* 创建xcode工程和gradle工程

		react-native init AwesomeProject
		
		├── android
		├── index.android.js
		├── index.ios.js
		├── ios
		├── node_modules
		└── package.json			
		
* 执行

		react-native run-ios
		react-native run-android	
	
		
	


## 参考

* [react native官网](http://facebook.github.io/react-native/docs/getting-started.html)

