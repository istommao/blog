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

> 通过 Vue.js 的过渡系统，可以在元素从 DOM 中插入或移除时自动应用过渡效果。Vue.js 会在适当的时机为你触发 CSS 过渡或动画，你也可以提供相应的 JavaScript 钩子函数在过渡过程中执行自定义的 DOM 操作

## 组件

[组件](http://vuejs.org.cn/guide/components.html)

### 使用组件

#### 注册

`Vue.extend()` 创建一个组件构造器：

	var MyComponent = Vue.extend({
	  // 选项...
	})

要把这个构造器用作组件，需要用 Vue.component(tag, constructor) 注册：

	// 全局注册组件，tag 为 my-component
	Vue.component('my-component', MyComponent)

组件在注册之后，便可以在父实例的模块中以自定义元素 `<my-component>` 的形式使用

#### 局部注册

不需要全局注册每个组件。可以让组件只能用在其它组件内，用实例选项 `components` 注册：

	var Child = Vue.extend({ /* ... */ })
	
	var Parent = Vue.extend({
	  template: '...',
	  components: {
	    // <my-component> 只能用在父组件模板内
	    'my-component': Child
	  }
	})

这种封装也适用于其它资源，如`指令`、`过滤器`和`过渡`。


#### 注册语法糖

为了让事件更简单，可以直接传入选项对象而不是构造器给 `Vue.component()` 和 `component` 选项。Vue.js 在背后自动调用 `Vue.extend()`

	// 在一个步骤中扩展与注册
	Vue.component('my-component', {
	  template: '<div>A custom component!</div>'
	})
	
	// 局部注册也可以这么做
	var Parent = Vue.extend({
	  components: {
	    'my-component': {
	      template: '<div>A custom component!</div>'
	    }
	  }
	})

#### 组件选项问题

传入 `Vue` 构造器的多数选项也可以用在 `Vue.extend()` 中，不过有两个特例： `data` 和 `el`。要使用`函数`返回一个对象，不然会是的所有实例共享`data` 或 `el`

	var MyComponent = Vue.extend({
	  data: function () {
	    return { a: 1 }
	  }
	})

#### 模板解析

`Vue` 的模板是 `DOM` 模板，使用浏览器原生的解析器而不是自己实现一个。相比字符串模板，DOM 模板有一些好处，但是也有问题，它必须是有效的 HTML 片段。一些 HTML 元素对什么元素可以放在它里面有限制。常见的限制：

### props

组件实例的作用域是孤立的。这意味着不能并且不应该在子组件的模板内直接引用父组件的数据。可以使用 `props` 把数据传给子组件。

“prop” 是组件数据的一个字段，期望从父组件传下来。子组件需要显式地用 props [选项](http://vuejs.org.cn/api/#props) 声明 props：

	Vue.component('child', {
	  // 声明 props
	  props: ['msg'],
	  // prop 可以用在模板内
	  // 可以用 `this.msg` 设置
	  template: '<span>{{ msg }}</span>'
	})

然后向它传入一个普通字符串：

	<child msg="hello!"></child>


#### cacmelCase vs. kebab-case

HTML 特性不区分大小写。名字形式为 camelCase 的 prop 用作特性时，需要转为 kebab-case（短横线隔开）：


	Vue.component('child', {
	  // camelCase in JavaScript
	  props: ['myMessage'],
	  template: '<span>{{ myMessage }}</span>'
	})
	<!-- kebab-case in HTML -->
	<child my-message="hello!"></child>

#### 动态props

类似于用 `v-bind` 绑定 HTML 特性到一个表达式，也可以用 v-bind 绑定动态 Props 到父组件的数据。每当父组件的数据变化时，也会传导给子组件：

	<child v-bind:my-message="parentMsg"></child>
	<!-- 缩写 -->
	<child :my-message="parentMsg"></child>
	
#### 字面量语法 vs. 动态语法

如果想传递一个实际的 JavaScript 数字，需要使用动态语法，从而让它的值被当作 JavaScript 表达式计算：

	<!-- 传递实际的数字  -->
	<comp :some-prop="1"></comp>

#### props绑定类型

prop 默认是单向绑定：当父组件的属性变化时，将传导给子组件，但是反过来不会。这是为了`防止子组件`无意修改了父组件的状态——这会让应用的数据流难以理解。不过，也可以使用 `.sync` 或 `.once` 绑定修饰符显式地强制双向或单次绑定


#### props验证

组件可以为 props 指定验证要求。当组件给其他人使用时这很有用，因为这些验证要求构成了组件的 API，确保其他人正确地使用组件。此时 props 的值是一个对象，包含验证要求

### 父子组件通信

#### 父链

子组件可以用 `this.$parent` 访问它的父组件。根实例的后代可以用 `this.$root` 访问它。父组件有一个数组 `this.$children`，包含它所有的子元素。
	
#### 自定义事件


Vue 实例实现了一个自定义事件接口，用于在组件树中通信。这个事件系统独立于原生 DOM 事件，用法也不同。

每个 Vue 实例都是一个事件触发器：

* 使用 `$on()` 监听事件；
* 使用 `$emit()` 在它上面触发事件；
* 使用 `$dispatch()` 派发事件，事件沿着父链冒泡；
* 使用 `$broadcast()` 广播事件，事件向下传导给所有的后代。

不同于DOM事件，这些事件会在第一次触发回调后停止冒泡。


#### 使用`v-on`绑定自定义事件

	<child v-on:child-msg="handleIt"></child>
	
#### 子组件索引

尽管有 `props` 和 `events`，但是有时仍然需要在 JavaScript 中直接访问子组件。为此可以使用 `v-ref` 为子组件指定一个`索引 ID`：

	<div id="parent">
	  <user-profile v-ref:profile></user-profile>
	</div>

	var parent = new Vue({ el: '#parent' })
	// 访问子组件
	var child = parent.$refs.profile

`v-ref` 和 `v-for` 一起用时，ref 是一个数组或对象，包含相应的子组件。

### 使用slots分发内容

为了让组件可以组合，我们需要一种方式来混合父组件的内容与子组件自己的模板。这个处理称为内容分发（或 “transclusion”，如果你熟悉 Angular）。Vue.js 实现了一个内容分发 API，参照了当前 [Web 组件规范草稿](https://github.com/w3c/webcomponents/blob/gh-pages/proposals/Slots-Proposal.md)，使用特殊的 `<slot>` 元素作为原始内容的插槽。

#### 编译作用域

> 父组件模板的内容在父组件作用域内编译；子组件模板的内容在子组件作用域内编译

#### 单个slot

父组件的内容将被抛弃，除非子组件模板包含 `<slot>`。如果子组件模板只有一个没有特性的 slot，父组件的整个内容将插到 slot 所在的地方并替换它。

`<slot>` 标签的内容视为`回退内容`。回退内容在子组件的作用域内编译，当宿主元素为空并且没有内容供插入时显示这个回退内容。


#### 具名slot


`<slot>` 元素可以用一个特殊特性 `name` 配置如何分发内容。多个 slot 可以有不同的名字。`具名 slot `将匹配内容片段中有对应 slot 特性的元素。

仍然可以有一个匿名 slot，它是默认 slot，作为找不到匹配的内容片段的回退插槽。如果没有默认的 slot，这些找不到匹配的内容片段将被抛弃。


### 动态组件


多个组件可以使用同一个挂载点，然后动态地在它们之间切换。使用保留的 `<component>` 元素，动态地绑定到它的 `is` 特性：

	new Vue({
	  el: 'body',
	  data: {
	    currentView: 'home'
	  },
	  components: {
	    home: { /* ... */ },
	    posts: { /* ... */ },
	    archive: { /* ... */ }
	  }
	})
	
	<component :is="currentView">
	  <!-- 组件在 vm.currentview 变化时改变 -->
	</component>


#### keep-alive

如果把切换出去的组件保留在内存中，可以保留它的状态或避免重新渲染。为此可以添加一个 `keep-alive` 指令参数


#### activate 钩子

在切换组件时，切入组件在切入前可能需要进行一些异步操作。为了控制组件切换时长，给切入组件添加 `activate` 钩子

#### transition-mode

`transition-mode` 特性用于指定两个动态组件之间如何过渡。

在默认情况下，进入与离开平滑地过渡。这个特性可以指定另外两种模式：

* `in-out`：新组件先过渡进入，等它的过渡完成之后当前组件过渡出去。
* `out-in`：当前组件先过渡出去，等它的过渡完成之后新组件过渡进入。


### 杂项

[杂项](http://vuejs.org.cn/guide/components.html#杂项)


## 深入响应式原理

[响应式原理](http://vuejs.org.cn/guide/reactivity.html)

Vue.js 最显著的一个功能是响应系统 —— 模型只是普通对象，修改它则更新视图。这让状态管理非常简单且直观，不过理解它的原理也很重要，可以避免一些常见问题。下面我们开始深挖 Vue.js 响应系统的底层细节。

### 如何追踪变化

把一个普通对象传给 Vue 实例作为它的 `data` 选项，Vue.js 将遍历它的属性，用 `Object.defineProperty` 将它们转为 `getter/setter`。这是 ES5 特性，不能打补丁实现，这便是为什么 Vue.js 不支持 IE8 及更低版本。

用户看不到 `getter/setters`，但是在内部它们让 Vue.js 追踪依赖，在属性被访问和修改时通知变化。一个问题是在浏览器控制台打印数据对象时 getter/setter 的格式化不同，使用 `vm.$log()` 实例方法可以得到更友好的输出。

模板中每个指令/数据绑定都有一个对应的 `watcher` 对象，在计算过程中它把属性记录为依赖。之后当依赖的 `setter` 被调用时，会触发 `watcher` 重新计算 ，也就会导致它的关联指令`更新 DOM`。

![image](http://vuejs.org.cn/images/data.png)

### 变化检测问题

受 ES5 的限制，`Vue.js` 不能检测到对象属性的添加或删除。因为 Vue.js 在初始化实例时将属性转为 `getter/setter`，所以属性必须在 `data` 对象上才能让 Vue.js 转换它，才能让它是响应的。

不过，有办法在实例创建之后`添加属性并且让它是响应的， 但是不建议这么做，最好在初始化data的时候就指定好，即使让其为空字符串也可以`。

* 对于 Vue 实例，可以使用` $set(key, value)` 实例方法
* 对于普通数据对象，可以使用全局方法 `Vue.set(object, key, value)`
* 有时你想向已有对象上添加一些属性，例如使用 `Object.assign()` 或 `_.extend()` 添加属性。但是，添加到对象上的新属性不会触发更新。这时可以创建一个新的对象，包含原对象的属性和新的属性


## 自定义指令

[自定义指令](http://vuejs.org.cn/guide/custom-directive.html)

除了内置指令，Vue.js 也允许注册自定义指令。自定义指令提供一种机制将数据的变化映射为 DOM 行为。

* 可以用 `Vue.directive(id, definition) `方法注册一个全局自定义指令，它接收两个参数`指令 ID` 与`定义对象`。
* 也可以用组件的 `directives 选项`注册一个`局部自定义指令`。

### 钩子函数

定义对象可以提供几个钩子函数（都是可选的）：

* bind：只调用一次，在指令第一次绑定到元素上时调用。
* update： 在 bind 之后立即以初始值为参数第一次调用，之后每当绑定值变化时调用，参数为新值与旧值。
* unbind：只调用一次，在指令从元素上解绑时调用。


示例

	Vue.directive('my-directive', {
	  bind: function () {
	    // 准备工作
	    // 例如，添加事件处理器或只需要运行一次的高耗任务
	  },
	  update: function (newValue, oldValue) {
	    // 值更新时的工作
	    // 也会以初始值为参数调用一次
	  },
	  unbind: function () {
	    // 清理工作
	    // 例如，删除 bind() 添加的事件监听器
	  }
	})

在注册之后，便可以在 Vue.js 模板中这样用（记着添加前缀 v-）：

	<div v-my-directive="someValue"></div>
	
当只需要 `update` 函数时，可以传入一个函数替代定义对象：

	Vue.directive('my-directive', function (value) {
	  // 这个函数用作 update()
	})

### 指令实例属性

所有的钩子函数将被复制到实际的指令对象中，钩子内 this 指向这个指令对象。这个对象暴露了一些有用的属性：

* el: 指令绑定的元素。
* vm: 拥有该指令的上下文 ViewModel。
* expression: 指令的表达式，不包括参数和过滤器。
* arg: 指令的参数。
* name: 指令的名字，不包含前缀。
* modifiers: 一个对象，包含指令的修饰符。
* descriptor: 一个对象，包含指令的解析结果。


> 你应当将这些属性视为只读的，不要修改它们。你也可以给指令对象添加自定义属性，但是注意不要覆盖已有的内部属性。

## 自定义过滤器

[自定义过滤器](http://vuejs.org.cn/guide/custom-filter.html)


类似于自定义指令，可以用全局方法 `Vue.filter()` 注册一个自定义过滤器，它接收两个参数：`过滤器 ID 和过滤器函数`。过滤器函数以值为参数，返回转换后的值

## 混合

[混合](http://vuejs.org.cn/guide/mixins.html)

> 混合以一种灵活的方式为组件提供分布复用功能。混合对象可以包含任意的组件选项。当组件使用了混合对象时，混合对象的所有选项将被“混入”组件自己的选项中。

示例：

	// 定义一个混合对象
	var myMixin = {
	  created: function () {
	    this.hello()
	  },
	  methods: {
	    hello: function () {
	      console.log('hello from mixin!')
	    }
	  }
	}
	
	// 定义一个组件，使用这个混合对象
	var Component = Vue.extend({
	  mixins: [myMixin]
	})
	
	var component = new Component() // -> "hello from mixin!"


## 插件

[插件](http://vuejs.org.cn/guide/plugins.html)

插件通常会为 Vue 添加全局功能。插件的范围没有限制——通常是下面几种：

* 添加全局方法或属性，如 [vue-element](https://github.com/vuejs/vue-element)
* 添加全局资源：指令/过滤器/过渡等，如 [vue-touch](https://github.com/vuejs/vue-touch)
* 添加 Vue 实例方法，通过把它们添加到 Vue.prototype 上实现。
* 一个库，提供自己的 API，同时提供上面提到的一个或多个功能，如 [vue-router](https://github.com/vuejs/vue-router)



Vue.js 的插件应当有一个公开方法 `install`。这个方法的第一个参数是 Vue 构造器，第二个参数是一个可选的选项对象：

	MyPlugin.install = function (Vue, options) {
	  // 1. 添加全局方法或属性
	  Vue.myGlobalMethod = ...
	  // 2. 添加全局资源
	  Vue.directive('my-directive', {})
	  // 3. 添加实例方法
	  Vue.prototype.$myMethod = ...
	}

通过 `Vue.use()` 全局方法使用插件：

	// 调用 `MyPlugin.install(Vue)`
	Vue.use(MyPlugin)
	

## 构建大型应用

[构建大型应用](http://vuejs.org.cn/guide/application.html)

使用脚手架工具 [vue-cli](https://github.com/vuejs/vue-cli) 可以快速地构建项目：单文件 Vue 组件，热加载，保存时检查代码，单元测试等。	

**Vue.js 的设计思想是专注与灵活——它只是一个界面库**，不强制使用哪个架构。它能很好地与已有项目整合，不过对于经验欠缺的开发者，从头开始构建大型应用可能是一个挑战。

`Vue.js` 生态系统提供了一系列的工具与库，用于构建大型单页应用。这些部分会感觉开始更像一个『框架』，但是它们`本质上只是一套推荐的技术栈`而已 - 你依然可以对各个部分进行选择和替换。

### 模块化

对于大型项目，为了更好地管理代码使用模块构建系统非常必要。推荐代码使用 CommonJS 或 ES6 模块，然后使用 `Webpack` 或 `Browserify` 打包。

### 单文件组件

在典型的 `Vue.js` 项目中，我们会把界面拆分为多个小组件，每个组件在同一地方封装它的 `CSS 样式`，`模板` 和 `JavaScript` 定义，这么做比较好。

### 路由

推荐使用官方库 [vue-router](https://github.com/vuejs/vue-router)。详细请查看它的[文档](http://vuejs.github.io/vue-router/)

如果你只需要非常简单的路由逻辑，可以这么做，监听 `hashchange` 事件并使用动态组件。利用这种机制也可以非常容易地配合其它路由库，如 [Page.js](https://github.com/visionmedia/page.js) 或 [Director](https://github.com/flatiron/director)

### 与服务器通信

Vue 实例的原始数据 `$data` 能直接用 `JSON.stringify()` 序列化。社区贡献了一个插件 [vue-resource](https://github.com/vuejs/vue-resource)，提供一种容易的方式与 RESTful APIs 配合。也可以使用任何自己喜欢的 Ajax 库，如 `$.ajax` 或 `SuperAgent`。Vue.js 也能很好地与无后端服务配合，如 Firebase 和 Parse。

	
### 状态管理

如果我们约定，组件不可以直接修改 `store` 的状态，而应当派发事件，通知 `store` 执行 `action`，那么我们基本上实现了 [Flux](https://facebook.github.io/flux/) 架构。此约定的好处是，我们能记录 store 所有的状态变化，并且在此之上实现高级的调试帮助函数，如修改日志，快照，历史回滚等。

Flux 架构常用于 React 应用中，但它的核心理念也可以适用于 Vue.js 应用。比如 [Vuex](https://github.com/vuejs/vuex/) 就是一个借鉴于 Flux，但是专门为 Vue.js 所设计的状态管理方案。React 生态圈中最流行的 Flux 实现 [Redux](https://github.com/rackt/redux/) 也可以通过[简单的绑定](https://github.com/egoist/revue)和 Vue 一起使用。

### 单元测试

任何支持模块构建系统的单元测试工具都可以。推荐使用 [Karma](http://karma-runner.github.io/0.12/index.html)。它有许多插件，支持 Webpack 和 Browserify。


### 生产发布

为了更小的文件体积，Vue.js 的压缩版本删除所有的警告，但是在使用 Browserify 或 Webpack 等工具构建 Vue.js 应用时，压缩需要一些配置。

## 对比其他框架

[对比其他框架](http://vuejs.org.cn/guide/comparison.html)

	

## 参考	

* [vuejs官网](http://vuejs.org/)
* [vue api](http://vuejs.org.cn/api/)