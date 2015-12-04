#swift guide

##变量和常量

###变量

	var myVariable = 42
	myVariable = 11

###常量
	
	let myConstant = 10
	
如果初始值不能推导出想要的类型，需要指定类型

	let implicitInteger = 70
	let implicitDouble = 70.0
	let explicitDouble: Double = 70
	
类型之间不会隐式转换，需要显式指定

	let label = "The width is "
	let width = 94
	let widthLabel = label + String(width)

值转换成字符串的简化写法：`\(value)` == `String(value)`

	let apples = 3
	let oranges = 5
	let appleSummary = "I have \(apples) apples."
	let fruitSummary = "I have \(apples + oranges) pieces of fruit."		
	
###Option变量

是一个值或者为nil。通过在type后加`?`声明

	var optionalString: String? = "hello"

	Option变量会自动解包：optionalString!
	
Optional bingding:

	if let constantName = someOptional {
    	statements
	}

隐式解包

	使用!而不是?
	
	let possibleString: String? = "An optional string."
	let forcedString: String = possibleString! // requires an exclamation mark
 
	let assumedString: String! = "An implicitly unwrapped optional string."
	let implicitString: String = assumedString // no need for an exclamation mark
	
		


##类型

###Integers

	与系统向适应的：Int, UInt
	其他：Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64
	界限: UInt8.min, UInt8.max...

###float, double

###Boolean

###类型别名

	typealias AudioSample = UInt16
	
###元组

	let htt404Error = (404, "Not Found")
	let (statusCode, statusMessage) = http404Error
	忽略不想要的：_
	let (statusCode, _) = http404Error
	也可通过索引获取：
	http404Error.0
	也可给每个元素命名:
	let htt404Error = (statusCode:404, statusMessage:"Not Found")
	htt404Error.statusCode

###字符串String和字符Character

字符串的mutablity不在通过指定不同的类(OC:NSString和NSMutableString)，只是在定义字符串的时候将其设置为var或let即可。

String是value type，
	
###Unicode
	
		
##控制流

###if

	if boolean expression {
	
	} else {}

###switch 
	
	switch statement {
	case expression:
	...
	default:
		...
	}
	
###for-in

	for (k, v) in maps {
		
	}
	
可以使用`..<`获取一个范围的值：

	for i in 0..<4 {
		...
	}	
	
##基本运算符
swift支持大部分C的运算符，同时改善了一些容易造成错误的运算符

	算术：+, -, *, /, %	
	范围： a..<b, a...b
	赋值： +, +=, -=,...
	自增减：++, --
	一元： 负号-， 
	比较： ==, !=, >, <, >=, <=	
	三元： ?:
	nil coalescing: a ?? b  a是一个optional 
	逻辑： !, &&, ||
	
	
##函数和闭包

使用关键字`func`定义，后面跟的括号里是参数列表。括号之后的->指定返回值类型，最后是函数体{}

	func greet(name: String, day: String) -> String {
		return "Hello \(name), today is \(day)."
	}
	
也可以给参数指定标签（类似于命名参数）

	func greet(myName name: String, day: String) -> String {
		return "Hello \(name), today is \(day)."
	}
	
	调用的时候
	greet(myName:"abc", "20");	
	
	
返回值可以复合类型，使用元组即可做到:
	
	func calcStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
		...
		(min, max, sum)
	}
	
	
不定参数

	func sumOf(numbers: Int...) -> Int	
嵌套函数

	func returnFifteen() -> Int {
		var y = 10
		func add() {
			y += 5
		}
		add()
		return y
	}	

函数是第一等公民，所以函数可作为参数和返回值。

	func makeIncrement() -> (Int -> Int){
		func addOne(number: Int) -> Int {
			return 1 + number
		}
		return addOne
	}	
	
	func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
		for item in list {
			if condition(item) {
				return true
			}
		}
		return false
	}
	func lessThanTen(number: Int) -> Bool {
		return number < 10
	}
	var numbers = [20, 19, 7, 12]
	hasAnyMatches(numbers, lessThanTen)
	
###闭包

函数是一种特殊的闭包。匿名的闭包使用`{}`，参数和返回值与body之间通过`in`分割

	numbers.map({
		(number: Int) -> Int in
		let result = 3 * number
		return result
	})
	
当一个闭包的类型可推导，那么它的参数类型和返回值类型都可不写。**（switft的一个特点，凡是可推导的类型都可省略）**

	let mappedNumbers = numbers.map({ number in 3 * number })
	
参数也可以通过位置进行指定：

	let sortedNumbers = sorted(numbers) { $0 > $1 }		

闭包可用在两个对象之间通信。

	func hasClosureMatch(arr: Int[], value: Int, 
		cb:(num: Int, value: Int) -> Bool )-> Bool {
		
		for item in arr {
			if (cb(num: item, value:value)) {
				return true
			}
		}
		return false;		
	}
	
	var arr = [20, 8, 110, 22, 33];
	
	var v1 = hasClosureMatch(arr, 40, {
		(num: Int, value:Int) -> Bool in
		return num >= value;
	});
	println("v1 is \(v1)");

	
##基本数据结构

###String

###数组

下标、append等

###字典

	定义
	var p = [
		"name": "abc",
		"age" : "11",
	]
	
	for (k, v) in p
	
	追加： p["course"] = "ios"
	
	for key in p.keys {
		let v = p[key]
	}
	
	
##结构体
和C的不一样，可以包含函数。结构体有构造函数，但是没有析构函数

	struct QFTest {
		var x = 0;
		var y = 0;
		// 定义构造函数, init开头，自动调用
		init () {
			
		}
		init(x:Int, y:Int) {
		
		}
		_ 表示调用的时候可以不用指定x:100, y:100
		init(_ x:Int, _ y:Int) {
		
		}
		
		mutating func addOffset(deltaX:Int, deltaY:Int) {
			// 结构体是一个拷贝对象，除了在init可以修改变量
			// 否则想要修改，需要关键字mutating
			x += deltaX;
			y += deltaY;
		}
	};
	结构体定义： 结构体名字
	var s = QFTest()
	var s = QFTest(x:100, y:100)	
	s.x, s.y
	
##类

	类的定义，关键字class
	class Person {
		类的字段为public，每个属性都必须进行初始化（声明时或在构造函数中）
		var age :Int = 0;
		// ?表示可为空（nil）或者没有设置，表明name可选
		var name :String?;
		
		// 构造方法
		// 构造函数的标签都必须写，普通函数第一个标签不用写，第二个之后都要写
		init () {
			age = 5;
			name = "aaa";
		}
		
		// 当不能区分属性和参数时，使用self用来区分
		init (name:String, age:Int) {
			self.age = age;
			self.name = name;
		}
		
		// 析构
		deinit (){}
		
		// 成员方法
		func getAge() -> Int {
			return age;
		}
		
		func getName() -> String {
			// ! 可以返回nil
			return name!;
		}
		
		// 类方法：以class开头
		class func MaxAge() -> Int {
			return 200;
		}
		
	}	
	
	func testClass() {
		var xiaoming = Person();
		println("xiaoming \(xiaoming.getAge())");
		
		var maxAge = Person.MaxAge();
	}	
	
###Setter Getter

	strcut Point {
		var x = 0.0, y = 0.0;
	};	
	
	strcut Size {
		var width = 0.0, height = 0.0;
	};	
	
	strcut Rect {
		var origin = Point();
		@lazy var size = Size(); //懒加载
		// center不是用来存储内容的，是用于计算
		var center:Point {
			get { //getter
				let x = origin.x + (size.width /2);
				let y = origin.y + (sieze.height / 2);
				return (x,y);
			}
			set(newCenter) { //getter
				origin.x = newCenter.x - (size.width /2);
				origin.y = newCenter.x -  (sieze.height / 2);
			}
			
		};
		func getCenter() -> (Double, Double) {
			let x = origin.x + (size.width /2);
			let y = origin.y + (sieze.height / 2);
			return (x,y);
		} 
	};	
	
	var rect = Rect(origin:Point(x:100, y:200),
		size: Size(width:400, height:40));
	var (x, y) = rect.getCenter();
	var p2 = rect.center; // 好像是去rect的center属性
	
	var p3 = Point(x:300, y:400);
	rect.center = p3; // 把rect的中心店设置为p3

###继承

	class Derived: Base {}
	
	继承的类构造函数：
	1. 设定本身的属性
	2. 调用父类的构造函数
	3. 改变父类属性或调用各种方法	

###willSet和didSet

##枚举


##协议Protocol
接口

协议也有基协议，协议可以多继承

定义

	@objc protocol SortProtocol: NSObjectProtocol {
		// 协议方法必须实现 @require
		func compare(value:Int) -> Bool;
		// 定义一个可选协议，可实现也可以不实现，则协议定义前需要添加@objc
		@optional func beginCompare() -> Bool;
	}
	
	protocol SortProtocol2 {}
	
	protocol SortProtocol3 {}
	
	class ClassA: NSObject,	SortProtocol, SortProtocol2, SortProtocol3 {
		var age = 0;
		init(age:Int) {
			self.age = age;
		}
		func compare(value:Int) -> Bool {
			if age > value {
				return true;
			} else {
				return false;
			}
		}
		
	}
	
	// 声明一个类
	let classA = ClassA(age:100);
	let ret = classA.compare(50);
	// 把类强制转换为SortProtocol
	let p1 = classA as SortProtocol
	// 可选方法不能直接调用，通过?
	p1.beginCompare?()
	
	
##泛型
函数、枚举、类都可使用泛型`<>`

	func repeat<Item>(item: Item, times: Int) -> [Item] {
    	var result = [Item]()
    	for i in 0..<times {
     		result.append(item)
    	}
    	return result
	}
	repeat("knock", 4)	
	

##assertion

	