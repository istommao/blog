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


## Object Types

### 声明

	class Manny {
	}
	struct Moe {
	}
	enum Jack {
	}	

### 构造器--Initializers

用于构造对象的实例。

* 使用关键字*init*定义
* 可以有多个构造器
* 除了用于设置属性外，不能使用self，直到所有实例属性被初始化

#### 隐式构造器

#### delegating构造器

调用其他构造器的构造器。

要求：必须首先调用被代理的的构造器，然后在能进行其他操作。


#### Failable构造器

构造器可能返回一个Optional的实例。

在构造器关键字*init*后添加Optional符号：*?或!*，如果failable构造器需要返回*nil*，需要显式指定：

	class Dog {
	    let name : String
	    let license : Int
	    init!(name:String, license:Int) {
	        self.name = name
	        self.license = license
	        if name.isEmpty {
	            return nil
	        }
	        if license <= 0 {
	            return nil
	        }
	    }
	}


### 属性--Properties

在对象类型声明的top level中声明的变量。

属性是变量，所以它具备变量的所有特征：

* 固定类型
* 使用var或let声明
* 是stored或computed
* 可以设置setter observers
* lazy
* ...




### 方法--Methods

在对象类型声明的top level中声明的函数。

方法默认是实例方法。

static/class方法通过类型访问，其*self*指类型本身


### 下标--Subscripts

subscript是一个特殊的实例访问，使用*[]*进行调用。

### 嵌套对象

增加了namespace

### 实例引用


### 枚举--Enums

定义一系列唯一的可替换的值。使用*case*语法

	enum Filter {
	    case Albums
	    case Playlists
	    case Podcasts
	    case Books
	}

#### 构造器

最常用构造器：枚举名.cases之一

	let type = Filter.Albums
	
如果类型可知，还可缩写：

	let type : Filter = .Albums
	
#### 指定类型

	enum Filter : String {
	    case Albums
	    case Playlists
	    case Podcasts
	    case Books
	}		
	
指定值：

	enum Filter : String {
	    case Albums = "Albums"
	    case Playlists = "Playlists"
	    case Podcasts = "Podcasts"
	    case Books = "Audiobooks"
	}


可通过*rawValue访问*

#### case中指定类型

	enum Error {
	    case Number(Int)
	    case Message(String)
	    case Fatal
	}

#### 构造器

显式构造器，需要指定特定的case给self

	enum Filter : String {
	    case Albums = "Albums"
	    case Playlists = "Playlists"
	    case Podcasts = "Podcasts"
	    case Books = "Audiobooks"
	    static var cases : [Filter] = [Albums, Playlists, Podcasts, Books]
	    init(_ ix:Int) {
	        self = Filter.cases[ix]
	    }
	}	
	
三种实例化Filter方法：

	let type1 = Filter.Albums
	let type2 = Filter(rawValue:"Playlists")!
	let type3 = Filter(2) // .Podcasts

##### failable

	init!(_ ix:Int) {
        if !(0...3).contains(ix) {
            return nil
        }
        self = Filter.cases[ix]
    }
    
#### enum属性

#### enum方法

### 结构体--struct     

#### 构造器

不需要直接指定构造器，

### 类--Classes

类与结构体类似，但是有如下不同：

* 类是引用类型
* 类的可变性
* 可以多次引用
* 可继承


#### 子类和父类

#### 类构造器

##### 默认构造器

> A class with no stored properties, or with stored properties all of which are initialized as part of their declaration, and that has no explicit initializers, has an implicit initializer init().


##### 命名构造器

不能代理其他构造器，即不可使用`self.init(...)`

##### Convenience构造器

关键字*convenience*修饰，且为代理构造器，必须调用`self.init(...)`


#### 子类构造器

##### 无构造器

调用父类构造器

##### Convenience构造器

##### 命名构造器

构造器不在继承，需要自己手动完成构造器（包括父类，调用`super.init(...)`）

##### 覆盖构造器

* 相同的签名
* 签名不同，但是标注有关键字`override`

一般来说，子类有命名构造器的化，不会继承构造器，但是如果其覆盖了所有父类的构造器，它会继承父类的convenience构造器

##### Failable构造器

optional的限制：

* init can override init?, but not vice versa.
* init? can call init.
* init can call init? by saying init and unwrapping the result (with an exclamation mark, because if the init? fails, you’ll crash).

	
	
	class A:NSObject {
	    init?(ok:Bool) {
	        super.init()         // init? can call init
	    }
	}
	class B:A {
	    override init(ok:Bool) { // init can override init?
	        super.init(ok:ok)!   // init can call init? using "!"
	    }
	}


##### required构造器

关键字*required*，表明子类必须继承或者重写该构造器






	

	









	
	