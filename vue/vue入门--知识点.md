title: vue入门--知识点
date: 2016-06-12 22:48:00
tags:
- vue.js
- vue

# vue入门--知识点

## 起步

[vue起步](http://vuejs.org.cn/guide/)

### 例子--Hello World

	<!-- HTML -->
	<div id="app">
	  {{ message }}
	</div>
	
	
	<!-- JS -->
	new Vue({
	  el: '#app',
	  data: {
	    message: 'Hello Vue.js!'
	  }
	})
	Hello Vue.js!

### 双向绑定

主要使用了`v-model`指令绑定页面和js中的`message`

	<!-- HTML -->
	<div id="app">
	  <p>{{ message }}</p>
	  <input v-model="message">
	</div>
	
	<!-- JS -->
	new Vue({
	  el: '#app',
	  data: {
	    message: 'Hello Vue.js!'
	  }
	})


### 列表渲染

`v-for`指令

	<!-- HTML -->
	<div id="app">
	  <ul>
	    <li v-for="todo in todos">
	      {{ todo.text }}
	    </li>
	  </ul>
	</div>
	
	<!-- JS -->
	new Vue({
	  el: '#app',
	  data: {
	    todos: [
	      { text: 'Learn JavaScript' },
	      { text: 'Learn Vue.js' },
	      { text: 'Build Something Awesome' }
	    ]
	  }
	})

## 两大基础

`响应的数据绑定`和`组合的视图组件`

### 响应的数据绑定

在普通 HTML 模板中使用`特殊的语法`将 `DOM` “绑定”到`底层数据`。一旦创建了绑定，`DOM` 将与数据保持同步。每当修改了数据，DOM 便相应地更新。这样我们应用中的逻辑就几乎都是`直接修改数据`了，不必与 `DOM` 更新搅在一起。这让我们的代码更容易撰写、理解与维护。

![MVVM--ViewModel](http://vuejs.org.cn/images/mvvm.png)

### 组件系统

组件系统是 Vue.js 另一个重要概念，因为它提供了一种抽象，让我们可以用独立可复用的小组件来构建大型应用。如果我们考虑到这点，几乎任意类型的应用的界面都可以抽象为一个组件树。

组件系统是用 Vue.js 构建大型应用的基础。另外，Vue.js 生态系统也提供了高级工具与多种支持库，它们和 Vue.js 一起构成了一个更加“框架”性的系统。

![vue-components](http://vuejs.org.cn/images/components.png)




## 参考

* [vuejs官网](http://vuejs.org/)