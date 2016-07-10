title: vuex概述
date: 2016-07-09 23:17:00
tags:
- vue
- vuex


# vuex概述

学习 [vuex中文版](http://vuex.vuejs.org/zh-cn/tutorial.html) ， 将其中的一些关键点摘出，方便快速查阅。

## action

* action 是一种专门用来被 component 调用的函数。action 函数能够通过分发相应的 mutation 函数，来触发对 store 的更新。action 也可以先从 HTTP 后端或 store 中读取其他数据之后再分发更新事件。

* action 会收到 `store` 作为它的`第一个参数`，附加上可选的自定义参数。

	最简单的 action
	
		function increment (store) {
		  store.dispatch('INCREMENT')
		}

	利用解构，只关心我们需要的对象
			
		// 既然我们只对事件的分发（dispatch 对象）感兴趣。（state 也可以作为可选项放入）
		// 我们可以利用 ES6 的解构（destructuring）功能来简化对参数的导入
		
		// ex1:
		function incrementBy ({ dispatch }, amount) {
		  dispatch('INCREMENT', amount)
		}

		// ex2:
		export const incrementCounter = function ({ dispatch, state }) {
		  dispatch('INCREMENT', 1)
		}	

* 从技术上讲，我们可以在`组件的方法内部`调用 `action(this.$store)` 来触发一个 action，但这样写起来有失优雅。在组件中调用 Actions`更好的做法`是把 `action` 暴露到`组件的方法`中，便可以直接在模板中引用它。我们可以使用 `vuex.actions` 选项来这么做

		// 组件内部
		
		<template>
		  <div>
		    <button @click='incrementBy'>Increment +1</button>
		  </div>
		</template>


		import { incrementBy } from './actions'
		
		const vm = new Vue({
		  vuex: {
		    getters: { ... }, // state getters
		    actions: {
		      incrementBy // ES6 同名对象字面量缩写
		      // 还可以给 action 取别名：
		      // plus: incrementBy
		      // 如果一个 action 只跟一个组件相关，可以采用简写语法把它定义成一行
		      // plus: ({ dispatch }) => dispatch('INCREMENT')
		    }
		  }
		})
		
	上述代码所做的就是把原生的 `incrementBy` action 绑定到组件的 store 实例中，暴露给组件一个`vm.increamentBy` 实例方法。所有传递给 `vm.increamentBy` 的参数变量都会排列在 store 变量后面然后一起传递给原生的 action 函数，所以调用：
	
		vm.incrementBy(1)

	等价于：

		incrementBy(vm.$store, 1)
		
		
	`p.s.:` 添加的内容背后所潜藏的一些有趣的点：

	* 	我们有了一个新对象 `vuex.actions`，包含着新的 action。
	* 	我们没有指定特定的 `store`, `object`, `state` 等等。Vuex 会自动把它们串联好。
	* 	我们可以用 `this.increment()` 在任何方法中调用此 action。
	* 	我们也可以通过 `@click` 参数调用它，与使用其他普通的 Vue 组件方法并无二致。
	* 	我们给 `action` 起名叫 `incrementBy`，但是在具体使用时，我们可以根据需要进行重新命名。	
* 绑定所有 Actions。如果你想简单地把所有引入的 actions 都绑定到组件中：
	
		import * as actions from './actions'
		
		const vm = new Vue({
		  vuex: {
		    getters: { ... },
		    actions // 绑定所有 actions
		  }
		})		

* 在 `action` 内部执行异步操作时，往往涉及到`调用异步 API` 和 `分发多重 mutations`


## mutation

* `Mutations` 本质上是一个事件系统：每个 mutation 都有一个 `事件名 (name)` 和 一个 `回调函数 (handler)`
* 任何一个 Mutation handler 的`第一个参数`永远为`所属` `store` 的整个 `state` 对象。你可以在函数里修改 `state`
* 用全部大写命名 mutation 是一个惯例，方便将它和 actions 区分开。

	  mutations: {
	    INCREMENT (state) {
	      // 改变 state
	      state.count++
	    }
	  }

* 你不能直接调用 mutation handler. 这里传入 Store 构造函数的选项更像是在注册事件回调：『当 INCREMENT 事件被触发时，调用这个 handler』。触发 mutation handler 的方法是 dispatch 一个 mutation 的事件名：

		store.dispatch('INCREMENT')

* `store.dispatch` 可以接受额外的参数，该参数会作为第二个（及其他）参数传给`mutation handler`。所有额外的参数被称为该 mutation 的 payload.

		store.dispatch('INCREMENT', 10)
		
		mutations: {
		  INCREMENT (state, n) {
		    state.count += n
		  }
		}

* Object 风格的 Dispatch。当使用对象风格参数时，你应该把全部传入参数作为对象的属性传入。整个对象都会被作为 mutation 函数的第二个参数被传入

		store.dispatch({
		  type: 'INCREMENT',
		  payload: 10
		})
		
		mutations: {
		  INCREMENT (state, mutation) {
		    state.count += mutation.payload
		  }
		}
	
* mutation 必须是同步函数
* 用常量为 Mutations 命名

	为了可以使 linters 之类的工具发挥作用，通常我们建议使用常量去命名一个 mutation, 并且把这些常量放在单独的地方。这样做可以让你的代码合作者对整个 app 包含的 mutations 一目了然
	
		// mutation-types.js
		export const SOME_MUTATION = 'SOME_MUTATION'

		// store.js
		import Vuex from 'vuex'
		import { SOME_MUTATION } from './mutation-types'
		const store = new Vuex.Store({
		  state: { ... },
		  actions: { ... },
		  mutations: {
		    // we can use the ES2015 computed property name feature
		    // to use a constant as the function name
		    [SOME_MUTATION] (state) {
		      // mutate state
		    }
		  }
		})
		
	用不用常量取决于你 —— 在需要多人协作的大型项目中，这会很有帮助。但如果你不喜欢，你完全可以不这样做。	

* Mutations 应当遵守 Vue 的响应系统规则

	* 尽可能在创建 store 时就初始化 state 所需要的所有属性；（就像创建 Vue 实例时应当初始化 data 一样）
	* 当添加一个原本不存在的属性时，需要：
		* 使用 `Vue.set(obj, 'newProp', 123)`
		* 拷贝并替换原本的对象。利用 stage 2 的语言特性 object spread syntax，我们可以使用这样的语法: `state.obj = { ...state.obj, newProp: 123 }`


## store

* store 存储应用所需的数据。所有组件都从 store 中读取数据
* 创建store

	* 创建一个对象来保存状态
	* 创建一个对象保存`一系列`的 mutation 函数
	* 整合 `状态 state` 和 `mutation 函数`
	* 在根组件加入`store`, 注入 store
	
	ex:
	
		// vuex/store.js
		const state = {
		  // TODO: 放置初始状态
		}
		// 创建一个对象存储一系列我们接下来要写的 mutation 函数
		const mutations = {
		  // TODO: 放置我们的状态变更函数
		}
		// 整合初始状态和变更函数，我们就得到了我们所需的 store
		// 至此，这个 store 就可以连接到我们的应用中
		export default new Vuex.Store({
		  state,
		  mutations
		})	
		
		// App.vue
		export default {
			...
			store: store // 在根组件加入 store，让它的子组件和 store 连接
		}	
		
	
## getters

* getter函数仅接收 `store` 的整个状态树作为其唯一参数
* 在组件的`vuex.getters`属性中添加对应的`getter`函数就可以给组件绑定`store`中某些属性
* 在组件获取值，在组件里加入这个 getter 函数。通过在 `vuex.getters` 选项里定义的 `getter` 方法来读取状态

	ex:
	
	`bad:` 使用vue计算属性获取state值
	
		// 在某个 Vue 组件的定义对象里
		computed: {
		  count: function () {
		    return store.state.count
		  }
		}
		
	`good:` 使用 `vuex.getters`属性的`getter`函数
	
		import { getCount } from '../vuex/getters'
		export default {
		  vuex: {
		    getters: {
		      // 注意在这里你需要 `getCount` 函数本身而不是它的执行结果 'getCount()'
		      // 该 getter 函数将会把仓库的 `store.state.count` 绑定为组件的 `this.counterValue`
		      counterValue: getCount
		      // 简单getter函数可以直接用箭头函数实现
		      // counterValue: state => state.count
		    }
		  }
		}	

	* 请留意 vuex 的 `getters` 子对象这个特殊选项
	* 它是我们指定当前组件能从 store 里获取哪些状态信息的地方
	* 它的每个属性名将对应一个 `getter` 函数
	* 该函数仅接收 `store` 的整个状态树作为其唯一参数，之后既可以返回状态树的一部分，也可以返回从状态树中求取的计算值
	* 而返回结果，则会依据这个 `getter` 的`属性名`添加到组件上，用法与组件自身的`计算属性`

* Getter 函数必须是纯函数。这也意味着：在 `getter` 里你不能依赖 `this` 关键字	

	如果你确实需要使用 this，例如需要用到组件内部的本地状态来计算些派生属性，那么你需要另外单开一个计算属性

* getter 函数可以返回派生状态

	Vuex 状态的 getters 内部其实就是计算属性，这就意味着你能够以响应式的方式（并且更高效）地计算派生属性

* 组件永远都不应该直接改变 Vuex store 的状态

	因为我们想要让状态的每次改变都很明确且可追踪


* 需要用 `getter` 函数而不是直接从 state 里读取数据。这个概念更多的是一种最佳实践，在大型应用里更加适用。它有这么几种独特优势

	* 我们可能需要使用 getter 函数返回需经过计算的值（比如总数，平均值等）
	* 在大型应用里，很多组件之间可以复用同一个 getter 函数
	* 如果这个值的位置改变了（比如从 store.count 变成了 store.counter.value），你只需要改一个 getter 方法，而不是一堆组件




## 参考

* [vuex中文版](http://vuex.vuejs.org/zh-cn/tutorial.html)