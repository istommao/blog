

## 投票小项目

### 环境配置

	mkdir react-qa
	cd react-qa
	npm init
	
	npm install react --save
	npm install -g gulp

开发工具：

	npm install --save-dev gulp gulp-browserify gulp-concat gulp-react gulp-connect lodash reactify
	
前端：

	bower init
	bower install bootstrap --save
	
创建app和dist目录

	react-qa/app, react-qa/dist
	
创建gulpfile.js



### 创建react的components

#### QuestionApp组件
创建组件QuestionApp,

* 在app/js/main.js：

		var React = require('react');
		var QuestionApp = require('./components/QuestionApp.js');
		
		var mainCom = React.render(
		    <QuestionApp />,
		    document.getElementById('app')
		)

* app/js/components/QuestionApp.js

	将index.html中所有的静态设置拷贝到QuestionApp.js中，创建组件：

		var React = require('react');
	
		module.exports = React.createClass({
		    render: function() {
		        return (
		          // html代码
		        )
		    }
		})

#### 分解html

不考虑交互性，将各个组件的js文件创建出来

* “添加问题”按钮：ShowAddButton.js
* "问题表单"： QuestionForm.js
* "问题列表"： QuestionList.js

#### 细分子组件--QuestionList

* 每个Question都是一样的，可以通过生成一个组件QuestionItem.js实现
* 通过getInitialState模拟QuestionList的初始列表，通过this.state传入QuestionList.js

#### 添加交互性

* 表单显示：通过按钮"添加问题"让表单显示或不显示
* 表单取消：与表单显示功能一样
* 表单提交：在点击提交按钮时，读取表单内容，创建出新的问题，并通过回调将新的问题追加到问题列表，同时需要进行新的排序
* voteCount: 在点击投票后，通过回调完成新的投票值得改变，并传递从app逐步往下传，同时完成新的值render



## 源码
[react-qa](https://github.com/zhuwei05/react-demo/tree/master/react-qa)

## 参考

* [react视频教程](http://eisneim.github.io/articles/2015-4-9-react-js-video-tutorial-in-chinese.html)
