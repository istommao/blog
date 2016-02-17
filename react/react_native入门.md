title: react native入门
date: 2016-01-31 18:29:02
tags:
- react native

---

# react native入门

## 安装配置（ios）

* nodejs4.0及以上

		brew install node

* 使用homebrew（maxos）
* 安装watchman和flow

		brew install watchman
		brew install flow
		
	flow是Facebook的类型检测库
	
	如果遇到问题，可能需要升级brew
	
		brew update
		brew upgrade
		
* xcode7.0及以上
* 安装react-native-cli

		npm install -g react-native-cli
		
* 创建xcode工程和gradle工程

		react-native init FirstProject
		
		├── android
		├── index.android.js
		├── index.ios.js
		├── ios
		├── node_modules
		└── package.json			
		
	![react-native-project-file-struct](http://image17-c.poco.cn/mypoco/myphoto/20160217/17/17349718220160217175006060_640.jpg?848x1182_130)	
	
	如果提示
	
		ERROR EACCES, permission denied '/Users/zhuwei/.babel.json'
	
	执行
	
		sudo chmod 777 /Users/zhuwei/.babel.json
		
	将`zhuwei`替换为你的用户名
		
* 执行

		react-native run-ios
		react-native run-android	

## 使用xcode运行程序

打开生成的*FirstProject.xcodeproj*，点击运行按钮（Run）。

 	
		
		
	


## 参考

* [react native官网](http://facebook.github.io/react-native/docs/getting-started.html)

