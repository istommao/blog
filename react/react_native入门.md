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

 	
## 代码初探

### 在View中增加Component

AppDelegate.m

* jsCodeLocation: 指定部署的物理设备

		jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
		
	如果需要部署到你的iPhone设备，将*localhost*改为本地Mac的IP地址
		
* 	RootView

		
		  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
		                                                      moduleName:@"FirstProject"
		                                               initialProperties:nil
		                                                   launchOptions:launchOptions];
		
		  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
		  UIViewController *rootViewController = [UIViewController new];
		  rootViewController.view = rootView;
		  self.window.rootViewController = rootViewController;
		  [self.window makeKeyAndVisible];
		

	上述代码实现了：
	1. 定义RCTRootView，是一个React Native的类。
	2. 将RCTRootView与UIViewController关联起来
	3. 渲染RCTRootView到窗口中（类似于react中挂载和渲染组件）
	
### Component的注册	

*为了使用组件，还需要进行注册*

index.ios.js

	AppRegistry.registerComponent('FirstProject', () => FirstProject);	
		
上述代码实现了组件`FirstProject`的注册，这样在`AppDelegate.m`中就可以使用该组件。
	
### 分析index.ios.js

#### 第一部分：导入React Native

	import React, {
	  AppRegistry,
	  Component,
	  StyleSheet,
	  Text,
	  View
	} from 'react-native';
	
> 上述代码使用`ES6`中的语法

#### 第二部分：组件*FirstProject*

	class FirstProject extends Component {
	  render() {
	    return (
	      <View style={styles.container}>
	        <Text style={styles.welcome}>
	          Welcome to React Native!
	        </Text>
	        <Text style={styles.instructions}>
	          To get started, edit index.ios.js
	        </Text>
	        <Text style={styles.instructions}>
	          Press Cmd+R to reload,{'\n'}
	          Cmd+D or shake for dev menu
	        </Text>
	      </View>
	    );
	  }
	}
	
> 与React语法非常类似, 同时使用了`StyleSheet`设置的样式。
	
#### 第三部分：设置样式

	const styles = StyleSheet.create({
	  container: {
	    flex: 1,
	    justifyContent: 'center',
	    alignItems: 'center',
	    backgroundColor: '#F5FCFF',
	  },
	  welcome: {
	    fontSize: 20,
	    textAlign: 'center',
	    margin: 10,
	  },
	  instructions: {
	    textAlign: 'center',
	    color: '#333333',
	    marginBottom: 5,
	  },
	});

> 通过`StyleSheet`设置样式

#### 第四部分：注册组件

	AppRegistry.registerComponent('FirstProject', () => FirstProject);	
	
> 注册组件*FirstProject*	

## Mobile组件

* \<View\>
* \<Image\>
* \<Text\>
* \<ListView\>
* \<TabView\>
* \<NavigatorView\>
* ...

### HTML元素和Native Components区别

|HTML|React Native|
|-:-|-:-|
|div|View|
|img|Image|
|span,p|Text|
|ul/ol,li|ListView, child items|

#### Text组件

	<View>
	  <Text>This is OK!</Text>
	</View>

不支持\<em\>等标签，通过内嵌样式：

	<Text>
	  The quick <Text style={{fontStyle: "italic"}}>brown</Text> fox
	  jumped over the lazy <Text style={{fontWeight: "bold"}}>dog</Text>.
	</Text>
	
进一步，可以创建样式组件\<Em\>，就可以写出如下类似HTML的代码：

	<Text>
	  The quick <Em>brown</Em> fox jumped
	  over the lazy <Strong>dog</Strong>.
	</Text>	





## 参考

* [react native官网](http://facebook.github.io/react-native/docs/getting-started.html)

