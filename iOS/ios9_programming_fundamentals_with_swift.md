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

Swift的函数是闭包。闭包可以捕获外部变量的引用在函数体内使用。

### 柯里化函数

一个函数返回值是带参数的函数

*e.g.:*
	
	func makeRoundedRectangleMaker(sz:CGSize) -> (CGFloat) -> UIImage {
	    return {
	        r in
	        imageOfSize(sz) {
	            let p = UIBezierPath(
	                roundedRect: CGRect(origin:CGPointZero, size:sz),
	                cornerRadius: r)
	            p.stroke()
	        }
	  	   }
		}

省略箭头操作符：

	func makeRoundedRectangleMaker(sz:CGSize)(_ r:CGFloat) -> UIImage {
	    return imageOfSize(sz) {
	        let p = UIBezierPath(
	            roundedRect: CGRect(origin:CGPointZero, size:sz),
	            cornerRadius: r)
	        p.stroke()
	    }
	}
	
	
## 变量和简单类型（非集合类型）

### 变量作用域和生命周期

#### 全局变量

在swift文件中的最顶层定义的变量

* 在本文件任何位置都可见
* 同模块的其他文件中的最顶层

#### 属性

在swift文件顶层定义的object type declaration（enum、struct、class）。

用两种properties：实例化properties和static/class properties

* 实例化properties

	和实例化对象同时存在
	
* static/class properties

	通过关键字*static和class*定义
	
	生命周期和*object type*一致
	
属性在object declaration中可见。

#### 局部变量

在函数体中定义的变量

### 变量定义

**var（变量）**和**let(常量)**	

显式定义

	var x: Int
	
隐式定义	

	var x = 1

当然有可以：

	var x: Int = 1

多少情况下是不需要这样进行变量定义的，采用隐式定义即可。但存在如下情况：

* swift类型推断不正确

		let separator: CGFloat = 2.0
		
* 开发者不好推断类型时

### Computed Initializer

计算变量的初始值：使用匿名函数

### Computed Variables

变量不是存储值，而是存储函数。定义*getter*和*setter*函数

	var now : String { 
	    get { 
	        return NSDate().description 
	    }
	    set { 
	        print(newValue) 
	    }
	}
	
	
给计算变量赋值会调用setter函数，使用计算变量会调用getter函数

	now = "Howdy" // Howdy 
	print(now) // 2015-06-26 17:03:30 +0000

上面例子可以看出，computed variable不能存储值，其set方法可以，computed variable是调用getter和setter方法的缩写。

setter方法非必须（只读变量），但是getter方法必须有。

#### 用途

* 只读变量
* 装饰函数
	
		var mp : MPMusicPlayerController {
		    return MPMusicPlayerController.systemMusicPlayer()
		}

* 装饰其他变量

		private var _p : String = ""
		var p : String {
		    get {
		        return self._p
		    }
		    set {
		        self._p = newValue
		    }
		} 


*another e.g.*

	var myBigData : NSData! {
	    set (newdata) {
	        self.myBigDataReal = newdata
	    }
	    get {
	        if myBigDataReal == nil {
	            // ... get a reference to file on disk, f ...
	            self.myBigDataReal = NSData(contentsOfFile: f)
	            // ... erase the file ...
	        }
	        return self.myBigDataReal
	    }
	}


### setter观察者

willSet和didSet

	var s = "whatever" { 
	    willSet { 
	        print(newValue) 
	    }
	    didSet { 
	        print(oldValue) 
	        // self.s = "something else"
	    }
	}

### lazy初始化

三种类型的变量可以懒加载：

* 全局变量：自动懒加载
* static properties
* Instance properties：关键字*lazy*

lazy initialization通常用于单例的实现

	class MyClass {
	    static let sharedMyClassSingleton = MyClass()
	}

lazy初始化可以引用对象的实例，因为这时候后对象已经实例化了，而普通的初始化则不行。

结合*define-and-call*实现对实例对象的初始化：

	lazy var prog : UIProgressView = {
	    let p = UIProgressView(progressViewStyle: .Default)
	    p.alpha = 0.7
	    p.trackTintColor = UIColor.clearColor()
	    p.progressTintColor = UIColor.blackColor()
	    p.frame = CGRectMake(0, 0, self.view.bounds.size.width, 20)
	    p.progress = 1.0
	    return p
	}()

	
> 注意：lazy instance properties不能有*setter observer*和不能是*let*

通过手动实现lazy property，可以让普通的computed property实现lazy加载，同时又可以让其拥有*setter observer*

	private var lazyOncer : dispatch_once_t = 0
	private var lazyBacker : Int = 0
	var lazyFront : Int {
	    get {
	        dispatch_once(&self.lazyOncer) {
	            self.lazyBacker = 42 // expensive initial value
	        }
	        return self.lazyBacker
	    }
	    set {
	        dispatch_once(&self.lazyOncer) {}
	        // will set
	        self.lazyBacker = newValue
	        // did set
	    }
	}

### 内置简单类型

### Bool

	var selected : Bool = false
	
操作符：*！、&&、||*

### Numbers

#### Int

* Int.max
* Int.min
* 进制：0b，0o,0x

#### Double

#### 转换Coercion

* 显式


	

* 隐式



#### 其他numeric

* Int8, Int16, Int32, Int64	
* UInt8, UInt16, UInt32, UInt64
* CFloat, CDouble

在swift中，需要显示转换为对应的Cocoa类型

	var szCG = CGSizeMake(
	    CGFloat(CGImageGetWidth(marsCG)),
	    CGFloat(CGImageGetHeight(marsCG))
	 )

#### 算术操作

* +, -, *, /, %, &, |, ^, ~, <<, >>

溢出操作：

* &+, &-, &*
* +=, -=, *=, /=, %=, |=, &=, ^=, ~=, <<=, >>=
* ++, --

#### 比较

* ==, !=, <, <=, >, >=, 

### 字符串类型

	let greeting = "hello"

unicode: *\u{...}*	
	
	let leftTripleArrow = "\u{21DA}"

字符串解释：*\(...)*

	let n = 5
	let s = "You have \(n) widgets."
	
	
### 字符

单个Unicode

* s.characters
* uppercaseString
* s.characters.first/last
* s.characters.indexOf()
* s.characters.contains()
* s.characters.dropFirst()
* s.characters.prefix()
* s.characters.split()
* s[index]
* s.characters.startIndex
* s.characters.endIndex
* s.insertContentOf()
* s.characters.indices
* s.characters.indices.startIndex/endIndex




### Range

* a...b: [a, b]
* a..<b: [a, b)

### Tuple

	var pair: (Int, String)
	
### optional

	// Optional<String>
	var stringMaybe = Optional("howdy")
	// 语法糖
	var stringMaybe : String?
	var stringMaybe : String? = "howdy"
	
#### 解包
**!**

	let upper = stringMaybe!.uppercaseString
	
隐式解包：**ImplicitlyUnwrappedOptional**
	
	func realStringExpecter(s:String) {}
	var stringMaybe : ImplicitlyUnwrappedOptional<String> = "howdy"
	realStringExpecter(stringMaybe) // no problem

#### nil

#### optional chains

optinally解包**?**

	let upper	= stringMaybe?.uppercaseString
	
#### Optional的比较

#### optional的作用

* 与OC的交互
* defer initialization
* 允许值为空（最重要作用）	
	






	

	









	
	