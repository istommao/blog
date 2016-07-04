title: react-redux总结和开发笔记
date: 2016-07-02 11:17:00
tags:
- react
- redux


# react-redux总结和开发笔记

## 简介

> 对于复杂的单页面应用，状态（state）管理非常重要。state 可能包括：服务端的响应数据、本地对响应数据的缓存、本地创建的数据（比如，表单数据）以及一些 UI 的状态信息（比如，路由、选中的 tab、是否显示下拉列表、页码控制等等）。如果 state 变化不可预测，就会难于调试（state 不易重现，很难复现一些 bug）和不易于扩展（比如，优化更新渲染、服务端渲染、路由切换时获取数据等等）。

Redux 就是用来确保 state 变化的可预测性，主要的约束有：

* state 以单一对象存储在 `store` 对象中
* state 只读
* 使用纯函数 `reducer` 执行 state 更新


flux和redux对比图：

![image](https://segmentfault.com/img/bVoR1E)
![image](https://segmentfault.com/img/bVoR1G)


貌似解释起来挺麻烦的啊(也可能是自己也不太明白的缘故)，只能先介绍各个概念，希望通过各个概念把redux讲明白吧，如果还是没明白可以通过[官方例子](http://redux.js.org/docs/introduction/Examples.html)或者自己多练习去体会吧。

## 概念解析

### 先来看`Store`：

* `Store`：是一个对象，用来管理组件的`State`。

	* 如何管理？通过`dispatch`将联系`Action` 和 `Reducers`联系到一起，进而触发`State`更新
	* 提供 `getState()` 方法获取 `state`；
	* 提供 `dispatch(action)` 方法更新 `state`；
	* 通过 `subscribe(listener)` 注册监听器
	
* 创建`Store`

	* createStore():
	
		* 第一个参数是`Reducers`，由于我们的`reducers`往往需要拆分（详见Reducers小节），而拆分后合并可以通过`combineReducers`进行组合，因此第一个参数一般都是`combineReducers`
		* 第二个参数可以设置初始状态。 这对开发同构应用时非常有用，可以用于把服务器端生成的 `state` 转变后在浏览器端传给应用。
		
### 再来看看`Actions`：

* `Store`通过`dispatch`将`Actions`（中间可能经过一系列`Middleware`s, 详见Middlewares小节）告知`Reducers`
* `action` 可以理解为应用向 `store` 传递的数据信息。在实际应用中，传递的信息可以约定一个固定的数据格式

	* `Action` 是把数据从应用（译者注：这里之所以不叫 view 是因为这些数据有可能是服务器响应，用户输入或其它非 view 的数据 ）传到 `store` 的有效载荷。它是 store 数据的唯一来源。一般来说你会通过 `store.dispatch()` 将 `action` 传到 `store。`

* `Action` 本质上是 JavaScript 普通对象。我们约定，`action` 内使用一个字符串类型的 `type` 字段来表示将要执行的动作。多数情况下，`type` 会被定义成字符串常量。当应用规模越来越大时，建议使用单独的模块或文件来存放 action
* `Action`是一个对象，`创建Action的函数`仅仅返回一个 action 对象，将函数的返回结果传给`dispatch`

### 接着看看`Reducers`：

* `Reducers`根据收到的`Actions`去决定如何更新`State`

	* reducer 实际上就是一个函数：`(previousState, action) => newState。`
	* 根据指定 `action` 来，执行对应 `state` 的更新逻辑
	
* 通过 `combineReducers(reducers)` 可以把多个 `reducer` 合并成一个 `root reducer`
* reducer 不存储 state, reducer 函数逻辑中不应该直接改变 state 对象, 而是返回新的 state 对象（可以考虑使用 [immutable-js](http://facebook.github.io/immutable-js/)）


### 再看看react-redux的接口`Provider`和`connect`

`Redux`跟`React`没有直接的关系，本身可以支持`React`、`Angular`、`Ember`等等框架。

通过`react-redux`这个库，可以方便的将react和redux结合起来：react负责页面展现，redux负责维护/更新数据状态。

`react-redux`中提供了两个重要功能模块`Provider`和`connect`，这两个模块保证了`react`和`redux`之间的通信，下面就分别看看这两个模块: 

* `<Provider store>`：通过`Provider`将应用的`store`和`根组件`或`Router`（详见react-router）进行包装，使得它们可以通过`connect`连接在一起

	从[Provider源码](https://github.com/reactjs/react-redux/blob/master/src/components/Provider.js)可以看到，Provide本质上是一个react组件，它主要用到了react通过[context](https://facebook.github.io/react/docs/context.html)属性，可以将属性(props)直接给子孙component，无须通过props层层传递，从而减少组件的依赖关系

* `connect`方法将`Store`（需要的state中的数据和actions中的方法）绑定到组件的`props`上

	* connect方法的主要作用就是让`Component`与`Store`进行关联， Store的数据变化可以及时通知Views重新渲染
	* 任何一个通过`connect()`函数处理过的组件都可以得到一个`dispatch`方法作为组件的`props`，以及得到全局`state`中的所有内容
	* connect方法: 第一个参数，必须是function，作用是绑定state的指定值到props上面(一般命名为mapStateToProps); 第二个参数，可以是function，也可以是对象，作用是绑定action创建函数到props上。
	* 还可以不写第二个参数，后面通过在组件中直接使用`dispatch()`来触发action创建函数

### 再来看看Middlewares

* `middleware` 其实就是高阶函数，作用于 `dispatch` 返回一个`新的 dispatch`（附加了该中间件功能）。可以形式化为：

		newDispatch = middleware1(middleware2(...(dispatch)...))。

### 再看看异步Actions

单页面应用中充斥着大量的异步请求（ajax）。`dispatch(action)` 是`同步`的，如果要处理异步 `action`，需要使用一些中间件。 
`redux-thunks` 和 `redux-promise` 分别是使用异步回调和 Promise 来解决异步 action 问题的。

* `thunk`作用使action创建函数可以返回一个function代替一个action对象

	
### 下面通过代码片段进一步解释	

#### react + redux + react-redux方案


#### react + redux + react-redux + react-router


## 参考

* [Redux 介绍](https://segmentfault.com/a/1190000003503338)
* [通过三张图了解Redux中的重要概念](http://www.cnblogs.com/wilber2013/p/5403350.html)
* [react+redux教程（一）](http://www.cnblogs.com/lewis617/p/5145073.html)
* [Redux](http://redux.js.org/)
* [Redux-CN](http://cn.redux.js.org/)
* [a-cartoon-intro-to-redux-cn](https://github.com/zhuwei05/a-cartoon-intro-to-redux-cn/tree/gh-pages)
