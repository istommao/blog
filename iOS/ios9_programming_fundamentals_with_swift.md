title: iOS9 Programming Fundamentals with Swift
date: 2016-02-13 19:50:50
tags:
- iOS
- swift


# iOS9 Programming Fundamentals with Swift

## variable

These are both variable declarations (and initializations):

	let one = 1
	var two = 2
	
## 对象类型

* class
* struct
* enum	
	
## Functions

## swift文件结构

* 模块导入
* 变量声明
* 函数声明
* 对象声明

*e.g.*

	import UIKit
	var one = 1
	func changeOne() {
	}
	class Manny {
	}
	struct Moe {
	}
	enum Jack {
	}


## 对象成员

* property
* method


## Functions

**e.g.:**

	func sum (x:Int, _ y:Int) -> Int {
	    let result = x + y
	    return result
	}
	
* func
* 参数列表
* 返回值

空返回值

	func say1(s:String) -> Void { print(s) }
	func say2(s:String) -> () { print(s) }
	func say3(s:String) { print(s) }


### 函数签名

输入和输出的类型：

	(Int, Int) -> Int
	
### External参数名

外部(External)参数名：位于（内部）参数名前的名字

好处：

* 指定参数的作用
* 区分函数，两个函数可以：相同的函数名和函数签名，但不同的External参数名
* 利于与OC、Cocoa交互

特点：

* 外部参数名和内部参数名可以相同也可以不相同
* 除了第一个参数外，其他参数都自动使用其内部参数名作为外部参数名（p.s. 第一个参数没有外部参数名的原因：1. 函数名往往就表示了第一个参数名； 2. 为了和OC、Cocoa交互）


### 重载

相同函数名，不同函数签名（参数类型和返回值）：

	func say (what:String) {
	}
	func say (what:Int) {
	}


### 默认参数值

在参数类型后： *= defaultValue*	

	class Dog {
	    func say(s:String, times:Int = 1) {
	        for _ in 1...times {
	            print(s)
	        }
	    }
	}
	
	let d = Dog()
	d.say("woof") // same as saying d.say("woof", times:1)
	
### 可变参数

**...**

	func sayStrings(arrayOfStrings:String ...) {
	    for s in arrayOfStrings { print(s) }
	}

	sayStrings("hey", "ho", "nonny nonny no")
	
### 忽略参数

	func say(s:String, times:Int, loudly _:Bool) {
	
### 可修改参数

**var关键字指定参数**
	
	func say(s:String, times:Int, var loudly:Bool) {
	    loudly = true // no problem
	} 	

### Function in Function

### 递归

### 函数作为值

	func doThis(f:()->()) {  
		f()
	}
	
### 匿名函数

	func whatToAnimate() {
	    self.myButton.frame.origin.y += 20
	}
	
	其匿名函数：
	
	{
	    () -> () in
	    self.myButton.frame.origin.y += 20
	}	

由于匿名函数使用非常频繁，因此可以省略匿名函数的一些部分，进行缩写：

#### 省略返回值

如果编译器可以得知返回值，可以省略箭头和返回值：

	UIView.animateWithDuration(0.4, animations: {
	    () in
	    self.myButton.frame.origin.y += 20
	    }, completion: {
	        (finished:Bool) in
	        print("finished: \(finished)")
	})

#### 省略in

如果没有参数，可以省略*in和()*：
	
	UIView.animateWithDuration(0.4, animations: {
	    self.myButton.frame.origin.y += 20
	    }, completion: {
	        (finished:Bool) in
	        print("finished: \(finished)")
	})

#### 省略参数类型

	UIView.animateWithDuration(0.4, animations: {
	    self.myButton.frame.origin.y += 20
	    }, completion: {
	        (finished) in
	        print("finished: \(finished)")
	})

#### 省略括号

	UIView.animateWithDuration(0.4, animations: {
	    self.myButton.frame.origin.y += 20
	    }, completion: {
	        finished in
	        print("finished: \(finished)")
	})
	
#### 使用$0, $1等

	UIView.animateWithDuration(0.4, animations: {
	    self.myButton.frame.origin.y += 20
	    }, completion: {
	        print("finished: \($0)")
	})

#### 省略参数名

	UIView.animateWithDuration(0.4, animations: {
	    self.myButton.frame.origin.y += 20
	    }, completion: {
	        _ in
	        print("finished!")
	})

#### 省略函数参数label（尾函数）

	UIView.animateWithDuration(0.4, animations: {
	    self.myButton.frame.origin.y += 20
	    }) {
	        _ in
	        print("finished!")
	}

#### 省略调用函数的()

如果符合尾函数语法并且调用无参数的函数：

	func doThis(f:()->()) {
	    f()
	}
	doThis { // no parentheses!
	    print("Howdy")
	}	

#### 省略关键字return

### 定义函数并调用

	{
	    // ... code goes here
	}()


### 闭包



	