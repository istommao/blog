title: vuex概述
date: 2016-07-09 23:17:00
tags:
- vue
- vuex


# vuex概述

学习 [vuex中文版](http://vuex.vuejs.org/zh-cn/tutorial.html) ， 将其中的一些关键点摘出，方便快速查阅。

## action

* action 是一种专门用来被 component 调用的函数。action 函数能够通过分发相应的 mutation 函数，来触发对 store 的更新。action 也可以先从 HTTP 后端或 store 中读取其他数据之后再分发更新事件。

* action 会收到 store 作为它的第一个参数，附加上可选的自定义参数。

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

* 在组件中调用 Actions更好的做法是把 action 暴露到组件的方法中，便可以直接在模板中引用它。我们可以使用 `vuex.actions` 选项来这么做

		// 组件内部
		import { incrementBy } from './actions'
		
		const vm = new Vue({
		  vuex: {
		    getters: { ... }, // state getters
		    actions: {
		      incrementBy // ES6 同名对象字面量缩写
		    }
		  }
		})


* 在 action 内部执行异步操作时，往往涉及到调用异步 API 和 分发多重 mutations


## 参考

* [vuex中文版](http://vuex.vuejs.org/zh-cn/tutorial.html)