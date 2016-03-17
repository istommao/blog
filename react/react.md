title: react
date: 2016-01-25 00:20:38
tags: 
- react

----

# React.js

## 简介

提供MVC中的“V”，

* 单向数据流

	数据一旦更新，就直接重新渲染整个app。
	
	一个react组件可以理解成一个独立的函数：接收参数（props），可复用，可传递，返回结果（渲染组件）	
* 虚拟DOM树

	* 重建DOM树
	* 找到上个版本中DOM的差异
	* 计算出最新的DOM更新操作
	* 从操作队列中批量执行DOM更新操作
	
	可以在Node中运行
	
react只关注两件事：

* 更新DOM
* 响应事件框架	

React本质上是一个“状态机”，可以帮助开发者管理复杂的随着时间而变化的状态。它以一个精简的模型实现了这一点。

## JSX

JSX（JavaScrip XML）：一种在react组件内部构建标签的类XML语法。React在不适用JSX的情况下一样可以工作，然而使用JSX可以提高组件的可读性。

使用 JSX，但它有以下优点：

* JSX 执行更快，因为它在编译为 JavaScript 代码后进行了优化。
* 它是类型安全的，在编译过程中就能发现错误。
* 使用 JSX 编写模板更加简单快速。

**demo:**

	ReactDOM.render(
		<h1>Hello, world!</h1>,
		document.getElementById('example')
	);
	
### 语法规则

* 嵌套多个 HTML 标签，需要使用一个 `div `元素包裹它

* React JSX 代码可以放在一个独立文件上

* 在 JSX 中使用 JavaScript 表达式。表达式写在花括号 `{} `中

		ReactDOM.render(
			<div>
			  <h1>{1+1}</h1>
			</div>
			,
			document.getElementById('example')
		);

* 在 JSX 中不能使用 if else 语句，但可以使用 conditional (三元运算) 表达式来替代

* 样式：React 推荐使用`内联样式`。我们可以使用 `camelCase` 语法来设置内联样式. React 会在指定元素数字后自动添加 `px`

		var myStyle = {
			fontSize: 100,
			color: '#FF0000'
		};
		ReactDOM.render(
			<h1 style = {myStyle}>菜鸟教程</h1>,
			document.getElementById('example')
		);
		
* 注释需要写在花括号中

		ReactDOM.render(
			<div>
		    <h1>菜鸟教程</h1>
		    {/*注释...*/}
		 	</div>,
			document.getElementById('example')
		);		

* JSX 允许在模板中插入数组，数组会自动展开所有成员

		var arr = [
		  <h1>菜鸟教程</h1>,
		  <h2>学的不仅是技术，更是梦想！</h2>,
		];
		ReactDOM.render(
		  <div>{arr}</div>,
		  document.getElementById('example')
		);	

* HTML 标签 vs. React 组件

	React 的 JSX 使用大、小写的约定来区分本地组件的类和 HTML 标签。
	
	React 可以渲染 HTML 标签 (strings) 或 React 组件 (classes)。

	要`渲染 HTML 标签`，只需在 JSX 里使用小写字母的标签名。
	
		var myDivElement = <div className="foo" />;
		ReactDOM.render(myDivElement, document.getElementById('example'));		
	要`渲染 React 组件`，只需创建一个大写字母开头的本地变量。

		var MyComponent = React.createClass({/*...*/});
		var myElement = <MyComponent someProperty={true} />;
		ReactDOM.render(myElement, document.getElementById('example'));	


**注意:
由于 JSX 就是 JavaScript，一些标识符像 class 和 for 不建议作为 XML 属性名。作为替代，React DOM 使用 className 和 htmlFor 来做对应的属性。**

	
## helloworld

## 组件
### 组件嵌套			

### 组件的状态	

### 组件参数props

## 事件events

React通过将`事件处理器`绑定到组件上来处理事件。在事件被触发的同时，`更新组件的内部状态`，由此触发组件的`重绘`。因此，**想要渲染出事件触发后的结果，所要做的就是在渲染函数render中读取组件的内部状态。**

React处理的事件本质上和原生js事件一样：MouseEvents事件用于点击处理器，Change事件用于表单元素变化。所有的事件在命名上与原生js规范一致，并且会在相同情景下被触发。

事件涉及知识：

* 事件和状态
* 根据状态进行渲染
* 更新状态
* 事件对象

**小结：**

从用户输入到更新用户界面，处理步骤非常简单：

1. 在react组件上绑定事件处理器
2. 在事件处理器当中更新组件的内部状态。组件状态的更新会触发重绘
3. 实现组件的render函数用来渲染this.state数据


## 指向ref

## 双向数据流


## 组件生命周期

* componentWillMount
* componentWillUpdate
* 

## mixins


					
## 参考

* [菜鸟](http://www.runoob.com/react/react-tutorial.html)
* [react-webpack](https://github.com/zhuwei05/react-demo)
* [react]()
 


