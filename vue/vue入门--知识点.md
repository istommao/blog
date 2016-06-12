title: vue入门--知识点
date: 2016-06-12 22:48:00
tags:
- vue.js
- vue

# vue入门--知识点

学习[vue官方中文教程的笔记](http://vuejs.org.cn/guide)摘录，便于参考。

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

## Vue 实例

[Vue 实例](http://vuejs.org.cn/guide/instance.html)

### 构造器

每个 `Vue.js` 应用的起步都是通过构造函数 `Vue` 创建一个 `Vue 的根实例`：

	var vm = new Vue({
	  // 选项
	})

一个 Vue 实例其实正是一个 [MVVM](https://en.wikipedia.org/wiki/Model_View_ViewModel) 模式中所描述的 ViewModel - 因此在文档中经常会使用 `vm` 这个变量名。

#### 组件构造器

	var MyComponent = Vue.extend({
	  // 扩展选项
	})
	
	// 所有的 `MyComponent` 实例都将以预定义的扩展选项被创建
	var myComponentInstance = new MyComponent()


### 属性与方法

每个 `Vue` 实例都会代理其 `data` 对象里`所有的属性`：

	var data = { a: 1 }
	var vm = new Vue({
	  data: data
	})
	
	vm.a === data.a // -> true
	
	// 设置属性也会影响到原始数据
	vm.a = 2
	data.a // -> 2
	
	// ... 反之亦然
	data.a = 3
	vm.a // -> 3

注意`只有这些被代理的属性是响应的`。如果在实例创建之后添加新的属性到实例上，它不会触发视图更新。

除了这些数据属性，`Vue` 实例暴露了一些有用的实例属性与方法。这些属性与方法都有前缀 `$`(比如：`$data`、`$el`、`$watch`...)，以便与代理的数据属性区分。参考 [API 文档](http://vuejs.org.cn/api/)查看全部的实例属性与方法。

### 实例生命周期

`vue` 实例在创建时有一系列初始化步骤 -- 例如，它需要建立数据观察，编译模板，创建必要的数据绑定。在此过程中，它也将调用一些`生命周期钩子`，如：`created`、 `compiled`、 `ready` 、`destroyed`，给自定义逻辑提供运行机会。

![vue实例生命周期图](http://vuejs.org.cn/images/lifecycle.png)


## 数据绑定语法

[数据绑定语法](http://vuejs.org.cn/guide/syntax.html)

### 插值
#### 文本

数据绑定最基础的形式是文本插值，使用 “Mustache” 语法（`双大括号`）：

	<span>Message: {{ msg }}</span>
	
#### 原始HTML

`三 Mustache 标签`		

	<div>{{{ raw_html }}}</div>
	
#### HTML属性

`Mustache` 标签也可以用在 `HTML` 特性 (`Attributes`) 		

	<div id="item-{{ id }}"></div>
	
### 绑定表达式	

放在 `Mustache` 标签内的文本称为`绑定表达式`。注意是`表达式`。

#### js表达式

支持全功能的`js表达式`，一个限制是每个绑定只能包含单个表达式。

	{{ number + 1 }}  <!-- 正确 -->
	{{ var a = 1 }}	  <!-- 错误：这是一个语句，不是一个表达式： -->
	
### 过滤器

在表达式后添加可选的 `过滤器 (Filter) `，以 `管道符` 指示：	

	{{ message | capitalize }}
	
而且：过滤器可以串联, 接受参数。	

### 指令

`指令 (Directives)` 是特殊的带有*前缀* `v-`的特性。指令的值`限定为绑定表达式`，因此上面提到的 JavaScript 表达式及过滤器规则在这里也适用。指令的职责: **就是当其表达式的值改变时把某些特殊的行为应用到 DOM 上**。

	<p v-if="greeting">Hello!</p>

#### 参数

有些指令可以在其名称后面带一个“参数” (Argument)，中间放一个`冒号:`隔开
	
	<a v-bind:href="url"></a>
	
这里 `href` 是参数，它告诉 `v-bind` 指令将元素的 `href` 特性跟表达式 `url` 的值绑定。可能你已注意到可以用特性插值 `href="{{url}}"` 获得同样的结果：这样没错，并且实际上在内部特性插值会转为 `v-bind` 绑定。	

#### 修饰符

修饰符 (Modifiers) 是以`半角句号 . `开始的特殊后缀，用于表示指令应当以特殊方式绑定。

	<a v-bind:href.literal="/a/b/c"></a>
	
### 缩写

`v- `前缀是一种标识模板中特定的 `Vue` 特性的视觉暗示。对两个最常用的指令的`v-bind`和`v-on`提供缩写：

	<!-- 完整语法 -->
	<a v-bind:href="url"></a>

	<!-- 缩写 -->
	<a :href="url"></a>	

	<!-- 完整语法 -->
	<a v-on:click="doSomething"></a>

	<!-- 缩写 -->
	<a @click="doSomething"></a>
	
## 计算属性

[计算属性](http://vuejs.org.cn/guide/computed.html)	

在模板中绑定表达式是非常便利的，但是它们实际上只用于简单的操作。模板是为了描述视图的结构。在模板中放入太多的逻辑会让模板过重且难以维护。**这就是为什么 Vue.js 将绑定表达式限制为一个表达式**。如果需要多于一个表达式的逻辑，应当使用`计算属性`。

	<div id="example">
	  a={{ a }}, b={{ b }}
	</div>
	
	var vm = new Vue({
	  el: '#example',
	  data: {
	    a: 1
	  },
	  computed: {
	    // 一个计算属性的 getter
	    b: function () {
	      // `this` 指向 vm 实例
	      return this.a + 1
	    }
	  }
	})
	
例子中，假设`b`这个属性逻辑比较复杂，不适合直接用表达式表示，通过指定计算属性`computed`完成`b`的逻辑。


### 计算属性 vs $watch

Vue.js 提供了一个方法 `$watch`，它用于观察 Vue 实例上的数据变动。当一些数据需要根据其它数据变化时， `$watch` 很诱人 —— 特别是如果你来自 AngularJS。不过，通常更好的办法是使用计算属性而不是一个命令式的 `$watch` 回调。为什么？参考[例子](http://vuejs.org.cn/guide/computed.html#计算属性-vs-watch)

### 计算setter

计算属性默认只是 getter，不过在需要时你也可以提供一个 `setter`：

	// ...
	computed: {
	  fullName: {
	    // getter
	    get: function () {
	      return this.firstName + ' ' + this.lastName
	    },
	    // setter
	    set: function (newValue) {
	      var names = newValue.split(' ')
	      this.firstName = names[0]
	      this.lastName = names[names.length - 1]
	    }
	  }
	}
	// ...
	
	

	


## 参考	

* [vuejs官网](http://vuejs.org/)
* [vue api](http://vuejs.org.cn/api/)