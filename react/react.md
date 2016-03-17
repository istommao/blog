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
> **注意:
由于 JSX 就是 JavaScript，一些标识符像 class 和 for 不建议作为 XML 属性名。作为替代，React DOM 使用 className 和 htmlFor 来做对应的属性。**

	
## helloworld

## 组件

**demo**

输出"hello world"

	var HelloMessage = React.createClass({
	  render: function() {
	    return <h1>Hello World！</h1>;
	  }
	});
	
	ReactDOM.render(
	  <HelloMessage />,
	  document.getElementById('example')
	);
	
解析：

* React.createClass 方法用于生成一个组件类 HelloMessage。
* `<HelloMessage />` 实例组件类并输出信息。

> 注意，原生 HTML 元素名以小写字母开头，而自定义的 React 类名以大写字母开头，比如 HelloMessage 不能写成 helloMessage。除此之外还需要注意组件类只能包含一个顶层标签，否则也会报错。	


### 组件参数`props`

需要向组件传递参数，可以使用 `this.props` 对象，传递给组件的参数（变量或函数）都会保存到`this.props`对象中。

	var HelloMessage = React.createClass({
	  render: function() {
	    return <h1>Hello {this.props.name}</h1>;
	  }
	});
	
	ReactDOM.render(
	  <HelloMessage name="world" />,
	  document.getElementById('example')
	);
	
解析：上述例子将参数`name`传递给了组件`HelloMessage`，所以在组件`HelloMessage`中，通过`this.props.name`可以得到参数值`world`
	

### 组件嵌套

通过创建多个组件来合成一个组件，即把组件的不同功能点进行分离.		

## 组件的状态`state`

React 把组件看成是一个状态机（State Machines）。通过与用户的交互，实现不同状态，然后渲染UI，让用户界面和数据保持一致。React里，只需`更新组件的state`(通过js与用户交互，更改state)，然后根据新的state重新渲染用户界面（不要操作 DOM）。

* getInitialState 方法用于定义初始状态，也就是一个`对象`，这个对象可以通过 `this.state` 属性读取
* 当用户点击组件，导致状态变化，`this.setState` 方法就修改状态值，每次修改以后，自动调用 `this.render` 方法，再次渲染组件


## 再议props

> state 和 props 主要的区别在于** props 是不可变的**，而 **state 可以根据与用户交互来改变**。这就是为什么有些容器组件需要定义 state 来更新和修改数据。 而子组件只能通过 state 来传递数据。

> 在应用中组合使用 state 和 props 。我们可以**在父组件中设置 state**， 并通过**在子组件上使用 props **将其传递到子组件上。

### Props 验证
Props 验证使用 propTypes，它可以保证我们的应用组件被正确使用，React.PropTypes 提供很多[验证器 (validator)](http://facebook.github.io/react/docs/reusable-components.html) 来验证传入数据是否有效。当向 props 传入无效数据时，JavaScript 控制台会抛出警告。

## 组件API

### 设置状态：setState

	setState(object nextState[, function callback])

* nextState，将要设置的新状态，该状态会和当前的state合并
* callback，可选参数，回调函数。该函数会在setState设置成功，且组件重新渲染后调用。

> 合并nextState和当前state，并重新渲染组件。

> setState是React事件处理函数中和请求回调函数中**触发UI更新的主要方法**。

#### setState注意点

* 不能在组件内部通过this.state修改状态，因为该状态会在调用setState()后被替换。
* setState()并不会立即改变this.state，而是创建一个即将处理的state。setState()并不一定是同步的，为了提升性能React会批量执行state和DOM渲染。
* setState()总是会触发一次组件重绘，除非在shouldComponentUpdate()中实现了一些条件渲染逻辑。

### 替换状态：replaceState

	replaceState(object nextState[, function callback])

* nextState，将要设置的新状态，该状态会替换当前的state。
* callback，可选参数，回调函数。该函数会在replaceState设置成功，且组件重新渲染后调用。

> replaceState()方法与setState()类似，但是方法只会保留nextState中状态，原state不在nextState中的状态都会被删除。

### 设置属性：setProps

	setProps(object nextProps[, function callback])

* nextProps，将要设置的新属性，该状态会和当前的props合并
* callback，可选参数，回调函数。该函数会在setProps设置成功，且组件重新渲染后调用。

> 设置组件属性，并重新渲染组件。

> props相当于组件的数据流，它总是会从父组件向下传递至所有的子组件中。当和一个外部的JavaScript应用集成时，我们可能会需要**向组件传递数据或通知React.render()组件**需要重新渲染，可以使用setProps()。

> 更新组件，我可以在节点上再次调用React.render()，也可以通过setProps()方法改变组件属性，触发组件重新渲染。

### 替换属性：replaceProps
	replaceProps(object nextProps[, function callback])

* nextProps，将要设置的新属性，该属性会替换当前的props。
* callback，可选参数，回调函数。该函数会在replaceProps设置成功，且组件重新渲染后调用。

> replaceProps()方法与setProps类似，但它会删除原有props

### 强制更新：forceUpdate

	forceUpdate([function callback])

* callback，可选参数，回调函数。该函数会在组件render()方法调用后调用。

> forceUpdate()方法会使组件调用自身的render()方法重新渲染组件，组件的子组件也会调用自己的render()。但是，组件重新渲染时，依然会读取this.props和this.state，如果状态没有改变，那么React只会更新DOM。
> 
> forceUpdate()方法**适用于this.props和this.state之外的组件重绘**（如：修改了this.state后），通过该方法通知React需要调用render()
> 
> 一般来说，应该尽量避免使用forceUpdate()，而仅从this.props和this.state中读取状态并由React触发render()调用。

### 获取DOM节点：getDOMNode

	DOMElement getDOMNode()

* 返回值：DOM元素DOMElement

> 如果组件已经挂载到DOM中，该方法返回对应的本地浏览器 DOM 元素。当render返回null 或 false时，this.getDOMNode()也会返回null。**从DOM 中读取值的时候，该方法很有用**，如：获取表单字段的值和做一些 DOM 操作。

### 判断组件挂载状态：isMounted

	bool isMounted()
	
* 返回值：true或false，表示组件是否已挂载到DOM中

> isMounted()方法用于判断组件是否已挂载到DOM中。可以使用该方法**保证了setState()和forceUpdate()在异步场景**下的调用不会出错。

## 组件生命周期

组件的生命周期可分成三个状态：

* Mounting：已插入真实 DOM
* Updating：正在被重新渲染
* Unmounting：已移出真实 DOM

生命周期的方法[官方文档](http://facebook.github.io/react/docs/component-specs.html#lifecycle-methods)有：

* componentWillMount 在渲染前调用,在客户端也在服务端。

* componentDidMount : 在第一次渲染后调用，只在客户端。之后组件已经生成了对应的DOM结构，可以通过this.getDOMNode()来进行访问。 如果你想和其他JavaScript框架一起使用，可以在这个方法中调用setTimeout, setInterval或者发送AJAX请求等操作(防止异部操作阻塞UI)。


* componentWillReceiveProps 在组件接收到一个新的prop时被调用。这个方法在初始化render时不会被调用。

* shouldComponentUpdate 返回一个布尔值。在组件接收到新的props或者state时被调用。在初始化时或者使用forceUpdate时不被调用。可以在你确认不需要更新组件时使用。

* componentWillUpdate在组件接收到新的props或者state但还没有render时被调用。在初始化时不会被调用。

* componentDidUpdate 在组件完成更新后立即调用。在初始化时不会被调用。

* componentWillUnmount在组件从 DOM 中移除的时候立刻被调用。

## React AJAX

* React 组件的数据可以通过 `componentDidMount` 方法中的 Ajax 来获取，当从服务端获取数据库可以将数据存储在 state 中，再用 this.setState 方法重新渲染 UI。

* 当使用异步加载数据时，在组件卸载前使用 `componentWillUnmount` 来取消未完成的请求。


## 事件events

React通过将`事件处理器`绑定到组件上来处理事件。在事件被触发的同时，`更新组件的内部状态`，由此触发组件的`重绘`。因此，**想要渲染出事件触发后的结果，所要做的就是在渲染函数render中读取组件的内部状态。**

React处理的事件本质上和原生js事件一样：MouseEvents事件用于点击处理器，Change事件用于表单元素变化。所有的事件在命名上与原生js规范一致，并且会在相同情景下被触发。

事件涉及知识：

* 事件和状态
* 根据状态进行渲染
* 更新状态
* 事件对象

### examples

**e.g.**

	var Content = React.createClass({
	  render: function() {
	    return  <div>
	            <input type="text" value={this.props.myDataProp} onChange={this.props.updateStateProp} /> 
	            <h4>{this.props.myDataProp}</h4>
	            </div>;
	  }
	});
	var HelloMessage = React.createClass({
	  getInitialState: function() {
	    return {value: 'Hello world!'};
	  },
	  handleChange: function(event) {
	    this.setState({value: event.target.value});
	  },
	  render: function() {
	    var value = this.state.value;
	    return <div>
	            <Content myDataProp = {value} 
	              updateStateProp = {this.handleChange}></Content>
	           </div>;
	  }
	});
	ReactDOM.render(
	  <HelloMessage />,
	  document.getElementById('example')
	);
	
本例中子组件(Content)使用表单，当你需要从子组件中更新父组件的 state 时，通过在父组件(HelloMessage)创建事件句柄 (`handleChange`) ，并作为 `prop (updateStateProp)` 传递到你的子组件上。
		
	
**小结：**

从用户输入到更新用户界面，处理步骤非常简单：

1. 在react组件上绑定事件处理器
2. 在事件处理器当中更新组件的内部状态。组件状态的更新会触发重绘
3. 实现组件的render函数用来渲染this.state数据


## 指向ref

React 支持一种非常特殊的属性 Ref ，你可以用来绑定到 render() 输出的任何组件上。

这个特殊的属性允许你引用render()返回的相应的 `backing instance`。

使用ref可以在讲子组件的接口暴露给父组件。例如：

	var ParentComponent = React.createClass({
	    render: function(){
	        return (
	            <div>
	                //其他组件
	                <ChildComponent ref="childRef"/>
	                //其他组件
	            </div>
	        );
	    }
	});
	
如果ChildComponent中定义了接口interfaceA,那么在父组件可以这样调用：`this.refs.childRef.interfaceA()`
	
	


## 双向数据流


## mixins


					
## 参考

* [菜鸟](http://www.runoob.com/react/react-tutorial.html)
* [react-webpack](https://github.com/zhuwei05/react-demo)
* [react](http://facebook.github.io/react/docs/getting-started.html)
* [React 入门实例教程](http://www.ruanyifeng.com/blog/2015/03/react.html)
 


