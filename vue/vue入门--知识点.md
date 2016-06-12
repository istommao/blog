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
	
## Class 与 Style 绑定

[Class 与 Style 绑定](http://vuejs.org.cn/guide/class-and-style.html)	

**数据绑定**一个常见需求是操作元素的 `class 列表`和它的`内联样式`。因为它们都是 `attribute`，我们可以用 `v-bind` 处理它们：只需要计算出表达式最终的字符串。不过，字符串拼接麻烦又易错。因此，在 `v-bind` 用于 `class` 和 `style` 时，`Vue.js` 专门增强了它。表达式的结果类型除了字符串之外，还可以是`对象或数组`。

### 绑定 HTML Class

> 尽管可以用 Mustache 标签绑定 class，比如 `class="{{ className }}"`，但是我们不推荐这种写法和 `v-bind:class` 混用。两者只能选其一！
	

#### 对象语法

我们可以传给 `v-bind:class` 一个对象，以动态地切换 `class`。注意 `v-bind:class` 指令可以与普通的 `class` 特性共存：

	<div class="static" v-bind:class="{ 'class-a': isA, 'class-b': isB }"></div>
	
	data: {
	  isA: true,
	  isB: false
	}	
	
渲染为：

	<div class="static class-a"></div>
	
也可以直接绑定数据里的一个对象（**推荐这种方法，更直观**）：

	<div v-bind:class="classObject"></div>
	
	data: {
	  classObject: {
	    'class-a': true,
	    'class-b': false
	  }
	}

我们也可以在这里绑定一个返回[对象的计算属性](http://vuejs.org.cn/guide/computed.html)。这是一个常用且强大的模式。	

#### 数组语法

我们可以把一个数组传给 `v-bind:class`，以应用一个 `class` 列表：

	<div v-bind:class="[classA, classB]">
	
	data: {
	  classA: 'class-a',
	  classB: 'class-b'
	}
	
### 绑定内联样式

#### 对象语法

`v-bind:style` 的对象语法十分直观——看着非常像 `CSS`，其实它是一个 `JavaScript` 对象。`CSS` 属性名可以用`驼峰式（camelCase）`或`短横分隔命名（kebab-case）`：

	<div v-bind:style="{ color: activeColor, fontSize: fontSize + 'px' }"></div>
	data: {
	  activeColor: 'red',
	  fontSize: 30
	}

直接绑定到一个样式对象通常更好，让模板更清晰**（推荐）**：

	<div v-bind:style="styleObject"></div>
	data: {
	  styleObject: {
	    color: 'red',
	    fontSize: '13px'
	  }
	}
	
同样的，对象语法常常结合返回对象的计算属性使用。	
#### 数组语法

`v-bind:style` 的数组语法可以将多个样式对象应用到一个元素上：

	<div v-bind:style="[styleObjectA, styleObjectB]">

#### 自动添加前缀

当 `v-bind:style` 使用需要厂商前缀的 `CSS` 属性时，如 `transform`，`Vue.js` 会自动侦测并添加相应的前缀。

## 条件渲染

[条件渲染](http://vuejs.org.cn/guide/conditional.html)

### v-if

	<h1 v-if="ok">Yes</h1>
	<h1 v-else>No</h1>

### template v-if

因为 `v-if` 是一个指令，需要将它添加到一个元素上。但是如果我们想切换多个元素呢？此时我们可以把一个 `<template>` 元素当做包装元素，并在上面使用 `v-if`，最终的渲染结果不会包含它。

	<template v-if="ok">
	  <h1>Title</h1>
	  <p>Paragraph 1</p>
	  <p>Paragraph 2</p>
	</template>

### v-show

另一个根据条件展示元素的选项是 `v-show` 指令。用法大体上一样：

	<h1 v-show="ok">Hello!</h1>
	
不同的是有 `v-show` 的元素会始终渲染并保持在 `DOM` 中。`v-show` 是简单的切换元素的 `CSS` 属性 `display`。

注意 `v-show` 不支持 `<template>` 语法。

### v-else

可以用 `v-else` 指令给 `v-if` 或 `v-show` 添加一个 “else 块”。`v-else` 元素必须立即跟在 `v-if` 或 `v-show` 元素的后面——否则它不能被识别。

### v-if vs. v-show

在切换 `v-if` 块时，Vue.js 有一个局部编译/卸载过程，因为 v-if 之中的模板也可能包括数据绑定或子组件。`v-if` 是真实的条件渲染，因为它会确保条件块在切换当中合适地销毁与重建条件块内的事件监听器和子组件。

`v-if` 也是惰性的：如果在初始渲染时条件为假，则什么也不做——在条件第一次变为真时才开始局部编译（编译会被缓存起来）。

相比之下，`v-show` 简单得多——元素始终被编译并保留，只是简单地基于 CSS 切换。

一般来说，`v-if` 有更高的切换消耗而 `v-show` 有更高的初始渲染消耗。因此，如果需要频繁切换 `v-show` 较好，如果在运行时条件不大可能改变 `v-if` 较好。







## 参考	

* [vuejs官网](http://vuejs.org/)
* [vue api](http://vuejs.org.cn/api/)