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


## 列表渲染

[列表渲染](http://vuejs.org.cn/guide/list.html)

### v-for

可以使用 `v-for` 指令基于一个数组渲染一个列表。这个指令使用特殊的语法，形式为 `item in items`，`items` 是数据数组，`item` 是当前数组元素的别名：

	<ul id="example-1">
	  <li v-for="item in items">
	    {{ item.message }}
	  </li>
	</ul>
	
	var example1 = new Vue({
	  el: '#example-1',
	  data: {
	    items: [
	      { message: 'Foo' },
	      { message: 'Bar' }
	    ]
	  }
	})

在 `v-for` 块内我们能完全`访问父组件`作用域内的属性，另有一个特殊变量 `$index`，是当前数组元素的索引

另外，你可以为索引指定一个`别名`（如果 `v-for` 用于一个`对象`，则可以为对象的键指定一个别名）

从 1.0.17 开始可以使用 `of` 分隔符，更接近 JavaScript 遍历器语：

	<div v-for="item of items"></div>
	
### template v-for	

类似于 `template v-if`，也可以将 `v-for` 用在 `<template>` 标签上，以渲染一个包含多个元素的块。

	<ul>
	  <template v-for="item in items">
	    <li>{{ item.msg }}</li>
	    <li class="divider"></li>
	  </template>
	</ul>
	
### 数组变动检测

#### 变异方法

Vue.js 包装了被观察数组的变异方法，故它们能触发视图更新。被包装的方法有：

* push()
* pop()
* shift()
* unshift()
* splice()
* sort()
* reverse()	

#### 替换数组

变异方法，如名字所示，修改了原始数组。相比之下，也有非变异方法，如 `filter()`, `concat()` 和 `slice()`，不会修改原始数组而是返回一个新数组。在使用非变异方法时，可以直接用新数组替换旧数组。

可能你觉得这将导致 Vue.js 弃用已有 DOM 并重新渲染整个列表——幸运的是并非如此。 Vue.js 实现了一些启发算法，以最大化复用 DOM 元素，因而用另一个数组替换数组是一个非常高效的操作。

#### track-by

有时需要用全新对象（例如通过 API 调用创建的对象）替换数组。因为 `v-for` 默认通过数据对象的特征来决定对已有作用域和 DOM 元素的复用程度，这可能导致重新渲染整个列表。但是，如果每个对象都有一个`唯一 ID` 的属性，便可以使用 `track-by` 特性给 Vue.js 一个提示，Vue.js 因而能尽可能地复用已有实例。

	{
	  items: [
	    { _uid: '88f869d', ... },
	    { _uid: '7496c10', ... }
	  ]
	}
	
	<div v-for="item in items" track-by="_uid">
	  <!-- content -->
	</div>

然后在替换数组 `items` 时，如果 Vue.js 遇到一个包含 `_uid: '88f869d'` 的新对象，它知道它可以复用这个已有对象的作用域与 DOM 元素。

#### track-by $index

如果没有唯一的键供追踪，可以使用 `track-by="$index"`，它强制让 `v-for` 进入原位更新模式：片断不会被移动，而是简单地以对应索引的新值刷新。这种模式也能处理数据数组中重复的值。

这让数据替换非常高效，但是也会付出一定的代价。因为这时 DOM 节点不再映射数组元素顺序的改变，不能同步临时状态（比如 `<input>` 元素的值）以及组件的私有状态。因此，如果 `v-for` 块包含 `<input>` 元素或子组件，要小心使用 `track-by="$index"`


#### 问题

因为 JavaScript 的限制，Vue.js 不能检测到下面数组变化：

1. 直接用索引设置元素，如 `vm.items[0] = {}`；
2. 修改数据的长度，如 `vm.items.length = 0`。

为了解决问题 (1)，Vue.js 扩展了观察数组，为它添加了一个 `$set()` 方法：

	// 与 `example1.items[0] = ...` 相同，但是能触发视图更新
	example1.items.$set(0, { childMsg: 'Changed!'})

至于问题 (2)，只需用一个空数组替换 `items`。

除了 `$set()`， Vue.js 也为观察数组添加了 `$remove()` 方法，用于从目标数组中`查找并删除元素`，在内部它调用 `splice()` 。因此，不必这样：

	var index = this.items.indexOf(item)
	if (index !== -1) {
	  this.items.splice(index, 1)
	}
	
只用这样：

	this.items.$remove(item)

#### Object.freeze()

在遍历一个数组时，如果数组元素是对象并且对象用 `Object.freeze() `冻结，你需要明确指定 `track-by`。在这种情况下如果 Vue.js 不能自动追踪对象，将给出一条警告。


### 对象 v-for

也可以使用 `v-for` 遍历对象。除了 `$index` 之外，作用域内还可以访问另外一个特殊变量` $key`

	<ul id="repeat-object" class="demo">
	  <li v-for="value in object">
	    {{ $key }} : {{ value }}
	  </li>
	</ul>
	
	new Vue({
	  el: '#repeat-object',
	  data: {
	    object: {
	      FirstName: 'John',
	      LastName: 'Doe',
	      Age: 30
	    }
	  }
	})

也可以给对象的键提供一个别名。

> 在遍历对象时，是按 `Object.keys() `的结果遍历，但是不能保证它的结果在不同的 JavaScript 引擎下是一致的。

### 值域 v-for

`v-for` 也可以接收一个整数，此时它将重复模板数次。

	<div>
	  <span v-for="n in 10">{{ n }} </span>
	</div>

### 显示过滤、排序的结果

有时我们想显示过滤/排序过的数组，同时不实际修改或重置原始数据。有两个办法：

* 创建一个计算属性，返回过滤/排序过的数组；
* 使用内置的过滤器 filterBy 和 orderBy。

计算属性有更好的控制力，也更灵活，因为它是全功能 JavaScript。但是通常[过滤器](http://vuejs.org.cn/api/#filterBy)更方便。

## 方法和事件处理

[方法和事件处理](http://vuejs.org.cn/guide/events.html)

### 方法处理器

用 `v-on` 指令监听 `DOM` 事件：

<div id="example">
  <button v-on:click="greet">Greet</button>
</div>

	var vm = new Vue({
	  el: '#example',
	  data: {
	    name: 'Vue.js'
	  },
	  // 在 `methods` 对象中定义方法
	  methods: {
	    greet: function (event) {
	      // 方法内 `this` 指向 vm
	      alert('Hello ' + this.name + '!')
	      // `event` 是原生 DOM 事件
	      alert(event.target.tagName)
	    }
	  }
	})
	
	// 也可以在 JavaScript 代码中调用方法
	vm.greet() // -> 'Hello Vue.js!'
	
### 内联语句处理器	

除了直接绑定到一个方法，也可以用内联 JavaScript 语句：

	<div id="example-2">
	  <button v-on:click="say('hi')">Say Hi</button>
	  <button v-on:click="say('what')">Say What</button>
	</div>
	
	new Vue({
	  el: '#example-2',
	  methods: {
	    say: function (msg) {
	      alert(msg)
	    }
	  }
	})
	
类似于内联表达式，事件处理器限制为`一个语句`。

有时也需要在内联语句处理器中访问原生 DOM 事件。可以用特殊变量 `$event` 把它传入方法	

### 事件修饰符

在事件处理器中经常需要调用 `event.preventDefault()` 或 `event.stopPropagation()`。尽管我们在方法内可以轻松做到，不过让方法是纯粹的数据逻辑而不处理 DOM 事件细节会更好。

为了解决这个问题，Vue.js 为 `v-on` 提供两个 事件修饰符：`.prevent` 与 `.stop`。你是否还记得修饰符是点号打头的指令后缀？

	<!-- 阻止单击事件冒泡 -->
	<a v-on:click.stop="doThis"></a>
	
	<!-- 提交事件不再重载页面 -->
	<form v-on:submit.prevent="onSubmit"></form>
	
	<!-- 修饰符可以串联 -->
	<a v-on:click.stop.prevent="doThat">
	
	<!-- 只有修饰符 -->
	<form v-on:submit.prevent></form>

1.0.16 添加了两个额外的修饰符：

	<!-- 添加事件侦听器时使用 capture 模式 -->
	<div v-on:click.capture="doThis">...</div>
	
	<!-- 只当事件在该元素本身（而不是子元素）触发时触发回调 -->
	<div v-on:click.self="doThat">...</div>

### 按键修饰符

在监听键盘事件时，我们经常需要检测 keyCode。Vue.js 允许为 v-on 添加按键修饰符：

	<!-- 只有在 keyCode 是 13 时调用 vm.submit() -->
	<input v-on:keyup.13="submit">
	
记住所有的 keyCode 比较困难，Vue.js 为最常用的按键提供[别名](http://vuejs.org.cn/guide/events.html#按键修饰符)

### 为什么在HTML中监听事件

你可能注意到这种事件监听的方式违背了传统理念 “separation of concern”。不必担心，因为所有的 Vue.js 事件处理方法和表达式都严格绑定在当前视图的 ViewModel 上，它不会导致任何维护困难。实际上，使用 v-on 有几个好处：

* 扫一眼 HTML 模板便能轻松定位在 JavaScript 代码里对应的方法。
* 因为你无须在 JavaScript 里手动绑定事件，你的 ViewModel 代码可以是非常纯粹的逻辑，和 DOM 完全解耦，更易于测试。
* 当一个 ViewModel 被销毁时，所有的事件处理器都会自动被删除。你无须担心如何自己清理它们。

## 表单控件绑定
	
[表单控件绑定](http://vuejs.org.cn/guide/forms.html)

用 `v-model` 指令在表单控件元素上`创建双向数据绑定`。根据控件类型它自`动选取正确的方法更新元素`。尽管有点神奇，`v-model `不过是`语法糖`，在`用户输入事件中`*更新数据*，以及特别处理一些极端例子。	

### text

	<span>Message is: {{ message }}</span>
	<br>
	<input type="text" v-model="message" placeholder="edit me">

### checkbox

	<input type="checkbox" id="checkbox" v-model="checked">
	<label for="checkbox">{{ checked }}</label>

多个勾选框，绑定到同一个数组：

	<input type="checkbox" id="jack" value="Jack" v-model="checkedNames">
	<label for="jack">Jack</label>
	<input type="checkbox" id="john" value="John" v-model="checkedNames">
	<label for="john">John</label>
	<input type="checkbox" id="mike" value="Mike" v-model="checkedNames">
	<label for="mike">Mike</label>
	<br>
	<span>Checked names: {{ checkedNames | json }}</span>
	
	new Vue({
	  el: '...',
	  data: {
	    checkedNames: []
	  }
	})
	
### radio

类似`checkbox`

### select

类似`checkbox`。

对于动态选项，用 `v-for` 渲染：

	<select v-model="selected">
	  <option v-for="option in options" v-bind:value="option.value">
	    {{ option.text }}
	  </option>
	</select>
	<span>Selected: {{ selected }}</span>
	new Vue({
	  el: '...',
	  data: {
	    selected: 'A',
	    options: [
	      { text: 'One', value: 'A' },
	      { text: 'Two', value: 'B' },
	      { text: 'Three', value: 'C' }
	    ]
	  }
	})
	
### 绑定value

对于单选按钮，勾选框及选择框选项，`v-model` 绑定的 `value` 通常是静态字符串（对于勾选框是逻辑值）：

	<!-- 当选中时，`picked` 为字符串 "a" -->
	<input type="radio" v-model="picked" value="a">
	
	<!-- `toggle` 为 true 或 false -->
	<input type="checkbox" v-model="toggle">
	
	<!-- 当选中时，`selected` 为字符串 "abc" -->
	<select v-model="selected">
	  <option value="abc">ABC</option>
	</select>


但是有时我们想绑定 `value` 到 `Vue` 实例的一个`动态属性`上，这时可以用 `v-bind` 实现，并且这个属性的值可以不是字符串：

	<input
	  type="checkbox"
	  v-model="toggle"
	  v-bind:true-value="a"
	  v-bind:false-value="b">
	  
	<input type="radio" v-model="pick" v-bind:value="a">
	
	<select v-model="selected">
	  <!-- 对象字面量 -->
	  <option v-bind:value="{ number: 123 }">123</option>
	</select>  	

### 参数特性

#### lazy

在默认情况下，`v-model` 在`input` 事件中同步输入框值与数据，可以添加一个特性 `lazy`，从而改到在 `change` 事件中同步。

	<!-- 在 "change" 而不是 "input" 事件中更新 -->
	<input v-model="msg" lazy>

#### 数字

如果想自动将用户的输入转为 `Number` 类型（如果原值的转换结果为 NaN 则返回原值），可以添加一个特性 `number`

#### debounce

`debounce` 设置一个最小的延时，在每次敲击之后延时同步输入框的值与数据。如果每次更新都要进行高耗操作（例如在输入提示中 Ajax 请求），它较为有用。

	<input v-model="msg" debounce="500">
	
注意 `debounce` 参数不会延迟 `input` 事件：它延迟“写入”底层数据。因此在使用 `debounce` 时应当用 `vm.$watch()` 响应数据的变化。若想延迟 DOM 事件，应当使用 [debounce 过滤器](http://vuejs.org.cn/api/#debounce)。	


## 过渡

[过渡](http://vuejs.org.cn/guide/transitions.html)


## 参考	

* [vuejs官网](http://vuejs.org/)
* [vue api](http://vuejs.org.cn/api/)