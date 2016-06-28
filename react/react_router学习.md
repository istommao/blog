title: React Router学习
date: 2016-06-28 10:43:00
tags:
- react
- router

# react router学习

React Router 是完整的 React 路由解决方案

React Router 保持 UI 与 URL 同步。它拥有简单的 API 与强大的功能例如代码缓冲加载、动态路由匹配、以及建立正确的位置过渡处理。你第一个念头想到的应该是 URL，而不是事后再想起。

## 安装

	npm install history react-router@latest
	
请注意，你还需要安装 [history](https://www.npmjs.com/package/history)，因为它也是 React Router 的依赖，而且在 npm 3+ 下不会自动安装。

## 基础使用

使用模块管理器或者 webpack：

	// 使用 ES6 的转译器，如 babel
	import { Router, Route, Link } from 'react-router'	

例子：

	import React from 'react'
	import { Router, Route, Link } from 'react-router'
	
	const App = React.createClass({/*...*/})
	const About = React.createClass({/*...*/})
	const Users = React.createClass({
		...
			<ul>
	       {/* 在应用中用 Link 去链接路由 */}
	       {this.state.users.map(user => (
	         <li key={user.id}><Link to={`/user/${user.id}`}>{user.name}</Link></li>
	       ))}
	     </ul>
		...
	})
	
	// 路由配置说明（你不用加载整个配置，
	// 只需加载一个你想要的根路由，
	// 也可以延迟加载这个配置）。
	React.render((
	  <Router>
	    <Route path="/" component={App}>
	      <Route path="about" component={About}/>
	      <Route path="users" component={Users}>
	        <Route path="/user/:userId" component={User}/>
	      </Route>
	      <Route path="*" component={NoMatch}/>
	    </Route>
	  </Router>
	), document.body)

**小结：**

* Router: 

	`Router` 会将你树级嵌套格式的 `<Route>` 转变成[路由配置](http://react-guide.github.io/react-router-cn/docs/guides/basics/RouteConfiguration.html)

* Route: 

	路由配置，将 `URL` 进行嵌套，并关联对应的`组件compoent`
	
* Link:

 	可替换`<a>`, 允许用户浏览应用的主要方式。`<Link>` 以适当的 `href` 去渲染一个可访问的锚标签。
 	
 	`<Link>` 可以知道哪个 `route` 的链接是激活状态的，并可以自动为该链接添加 `activeClassName` 或 `activeStyle`。

* 获取URL参数：`this.props.params.xxx` 或 `this.props.location.query.xxx`
* 使用 `<Redirect>` 重定向
* Hook: `onEnter`，`onLeave`, `routerWillLeave`...

### Router

`Router` 会将你树级嵌套格式的 `<Route>` 转变成[路由配置](http://react-guide.github.io/react-router-cn/docs/guides/basics/RouteConfiguration.html)


### Route


路由配置是一组指令，用来告诉 `router` 如何匹配 URL以及匹配后如何执行代码。

	React.render((
	  <Router>
	    <Route path="/" component={App}>
	      <Route path="about" component={About} />
	      <Route path="inbox" component={Inbox}>
	        <Route path="messages/:id" component={Message} />
	      </Route>
	    </Route>
	  </Router>
	), document.body)

通过上面的配置，这个应用知道如何渲染下面四个 URL：

|URL|	组件|
|---|---|
|/	|App|
|/about	|App -> About|
|/inbox	|App -> Inbox|
|/inbox/messages/:id	|App -> Inbox -> Message|

#### 绝对路由

在多层嵌套路由中使用绝对路径的能力让我们对 URL 拥有绝对的掌控。我们无需在 URL 中添加更多的层级，从而可以使用更简洁的 URL。

	React.render((
	  <Router>
	    <Route path="/" component={App}>
	      <IndexRoute component={Dashboard} />
	      <Route path="about" component={About} />
	      <Route path="inbox" component={Inbox}>
	        {/* 使用 /messages/:id 替换 messages/:id */}
	        <Route path="/messages/:id" component={Message} />
	      </Route>
	    </Route>
	  </Router>
	), document.body)

|URL|	组件|
|---|---|
|/	|App|
|/about	|App -> About|
|/inbox	|App -> Inbox|
|/messages/:id	|App -> Inbox -> Message|

**提醒：** 绝对路径可能在动态路由中无法使用。

#### 路由匹配原理

路由拥有三个属性来决定是否“匹配“一个 URL：

* 嵌套关系

	React Router 使用路由嵌套的概念来让你定义 view 的嵌套集合，当一个给定的 URL 被调用时，整个集合中（命中的部分）都会被渲染。嵌套路由被描述成一种树形结构。React Router 会深度优先遍历整个理由配置来寻找一个与给定的 URL 相匹配的路由。

* 路径语法

	路由路径是匹配一个（或一部分）URL 的 一个字符串模式。大部分的路由路径都可以直接按照字面量理解，除了以下几个特殊的符号：

	* `:paramName` – 匹配一段位于 /、? 或 # 之后的 URL。 命中的部分将被作为一个参数
	* `()` – 在它内部的内容被认为是可选的
	* `*` – 匹配任意字符（非贪婪的）直到命中下一个字符或者整个 URL 的末尾，并创建一个 `splat` 参数
	
举例：
		
	<Route path="/hello/:name">         // 匹配 /hello/michael 和 /hello/ryan
	<Route path="/hello(/:name)">       // 匹配 /hello, /hello/michael 和 /hello/ryan
	<Route path="/files/*.*">           // 匹配 /files/hello.jpg 和 /files/path/to/hello.jpg

* 优先级

	路由算法会根据定义的顺序自顶向下匹配路由


#### 添加首页

* `IndexRoute`（默认路由） 来设置一个默认页面
* `IndexLink`

	如果你在这个app中使用 `<Link to="/">Home</Link>` , 它会一直处于激活状态，因为所有的 URL 的开头都是 `/` 。 这确实是个问题，因为我们仅仅希望在 `Home` 被渲染后，激活并链接到它。

	如果需要在 `Home` 路由被渲染后才激活的指向 `/` 的链接，请使用 `<IndexLink to="/">Home</IndexLink>`



### Link

### 获取URL参数


* this.props.params.xxx

	当渲染组件时，React Router 会自动向 `Route` 组件中注入一些有用的信息，尤其是路径中动态部分的参数，比如：

		// 来自于路径 `/inbox/messages/:id`
		const id = this.props.params.id

* this.props.location.query.xxx

	也可以通过 `query` 字符串来访问参数。比如你访问 `/foo?bar=baz`，你可以通过访问 `this.props.location.query.bar` 从 Route 组件中获得 "baz" 的值。
	
### History

React Router 是建立在 [history](https://www.npmjs.com/package/history) 之上的。 简而言之，一个 history 知道如何去监听浏览器地址栏的变化， 并解析这个 URL 转化为 `location` 对象， 然后 `router` 使用它匹配到路由，最后正确地渲染对应的组件

常用的 history 有三种形式， 但是你也可以使用 React Router 实现自定义的 history。

* createHashHistory

	这是一个你会获取到的默认 history ，如果你不指定某个 history （即 `<Router>{/* your routes */}</Router>`）。它用到的是 URL 中的 `hash（#）`部分去创建形如 `example.com/#/some/path` 的路由。

* createBrowserHistory

	Browser history 是由 React Router 创建浏览器应用推荐的 history。它使用 History API 在浏览器中被创建用于处理 URL，新建一个像这样真实的 URL `example.com/some/path`。

* createMemoryHistory

	
	`Memory history` 不会在地址栏被操作或读取。这就解释了我们是如何实现服务器渲染的。同时它也非常适合测试和其他的渲染环境（像 React Native ）。

例子：

	React.render(
	  <Router history={createBrowserHistory()}>
	  </Router>,
	  document.getElementById('app')
	)	
	
## 高级用法

### 组件生命周期

* componentDidMount
* componentWillReceiveProps
* componentDidUpdate
* componentWillUnmount

详解：[组件生命周期](http://react-guide.github.io/react-router-cn/docs/guides/advanced/ComponentLifecycle.html)


### 动态路由

Route 可以定义 `getChildRoutes`，`getIndexRoute` 和 `getComponents` 这几个函数。它们都是异步执行，并且只有在需要时才被调用。我们将这种方式称之为 “逐渐匹配”。 React Router 会逐渐的匹配URL并只加载该URL对应页面所需的路径配置和组件。	

### 跳转前确认

React Router 提供一个 [routerWillLeave 生命周期钩子](http://react-guide.github.io/react-router-cn/docs/guides/advanced/docs/Glossary.md#routehook)，这使得 React 组件可以拦截正在发生的跳转，或在离开 route 前提示用户。routerWillLeave 返回值有以下两种：

* return false 取消此次跳转
* return 返回提示信息，在离开 route 前提示用户进行确认。


### 服务端渲染





## 参考

* [React Router 中文文档](http://react-guide.github.io/react-router-cn/index.html)
* [API接口](http://react-guide.github.io/react-router-cn/docs/API.html)