#javascript对象和继承小结
====

##对象
###对象创建

Javascript对象创建⽅方式 
	
	var obj = {};	var obj = Object.create();	var obj = new Object(); 
	var obj = new constructor;

###JSON
格式描述：

	{ string : value}	{ string : value , string : value }
key必须为string类型，所以
> Javascript的对象字⾯面量不是JSON。JSON不是对象,只是对象的描述格式

###Object.create		Object.create(proto, [ propertiesObject ])* proto        一个对象,作为新创建对象的原型。* propertiesObject    一个对象值,可以包含若干个属性,  属性名为新建对象的属性名,属性值为那个属性的属性描述符对象。
###Object构造器

**举例：**
	var obj = new Object({
			"p1" : 100		});
	Object {p1: 100}###new constructor
	new constructor[([arguments])] 
* 构造函数(constructor)	一个指明了对象类型的函数。* 传参(arguments) 
	一个⽤用来被构造函数调⽤用的参数列表。**举例**
	function Foo() {
		this.p1 = 100;	}
	var f = new Foo;
###对象属性的访问
	obj.name
	obj["name"]
	
##继承

##属性查询

* 原⽣生对象属性查寻

obj --> Object.prototype --> null

* funtion属性查询

Fn --> Funtion.prototype --> Object.prototype --> null

###原型链

> 每个由构造器创建的对象都有一个隐式引⽤(叫做对象 的原型)链接到构造器的“prototype”属性值。再者,原型可能有一个非空隐式引用链接到它⾃己的原型,以此类推,这叫做原型链。		
###基于prototype实现继承

**举例**

	1.
	var base = {
		name: "base"
	};
	
	funtion Sub() {
	}	
	Sub.prototype = base;
	var sub = new Sub;
	sub.name; # "base"
	
	2.
	funtion Base() {
		
	}
	
	Base.prototype = {
		show : fuction() {
			console.log("I am showing");
		}
	};
	
	funtion Sub() {
	
	}
	
	Sub.prototype = new Base;
	Sub.prototype.play = funtion() {
		console.log("I am playing");
	};
	
	var base = new Base;
	var sub = new Sub;
	
	sub.show();  #I am showing
	sub.play();  #I am playing
	base.show(); #I am showing
	base.play(); #TypeError
	
	> this绑定:指定该执⾏行环境内的 ECMA 脚本代码中 this 关键字所关联的值。
	
	3.
	funtion Base(name) {
			this.name = name
	}
	
	Base.prototype = {
		show : fuction() {
			console.log(this.name + " showing");
		}
	};
	
	funtion Sub(name) {
		 this.name = name
	}
	
	Sub.prototype = new Base;
	Sub.prototype.play = funtion() {
		console.log(this.name + " playing");
	};
	
	var base = new Base("base");
	var sub = new Sub("sub");
	
	sub.show();  #sub showing
	sub.play();  #sub playing
	base.show(); #base showing
	
	
###Object.create实现继承
Object.create继承原理
	Object.create = function(o){	  var F = function();	  F.prototype = o;	  return new F();	}
		  	