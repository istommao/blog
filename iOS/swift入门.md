#swift入门

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

	Option变量会自动解包：

		
	
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
	
##函数和闭包

使用关键字`func`定义，后面跟的括号里是参数列表。括号之后的->指定返回值类型，最后是函数体{}

	func greet(name: String, day: String) -> String {
		return "Hello \(name), today is \(day)."
	}
	
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

	

		
	
	

	
	
	
	
	
	