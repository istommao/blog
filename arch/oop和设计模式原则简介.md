title: OOP和设计模式原则简介
date: 2016-06-08 13:26:00
tags:
- OOP
- DP

# OOP和设计模式原则简介

## OOP三大基本特性

* 封装
* 继承
* 多态

## OOD原则

OOD：面向对象设计

* 开闭原则(OCP, Open-Close Principle)

	对扩展开放, 对修改关闭
	
* 里氏替换原则(LSP, Liskov Substitution Principle)

	子类必须能够替换其父类，否则不应当设计为其子类。子类只能去扩展基类，而不是隐藏或者覆盖基类。
	
* 依赖倒置原则(DIP, Dependence Inversion Principle)

	设计和实现要依赖于抽象而非具体
	
* 	接口隔离原则(ISP, Interface Segration Principle)

	将大的接口打散成多个小的独立的接口
	
* 单一职责原则(SRP, Single Responsibility Principle)

	不要存在多于一个导致类变更的原因，是高内聚低耦合的一个体现
	
* 迪米特法则/最少知道原则(LoD/LKP, Law of Demeter or Least Knowledge Principle)

	一个对象就尽可能少的去了解其它对象, 从而实现松耦合
	
* 合成/聚合复用原则(CARP / CRP, Composite/Aggregate Reuse Principle)

	如果新对象的某些功能在别的已经创建好的对象里面已经实现，那么应当尽量使用别的对象提供的功能，使之成为新对象的一部分，而不要再重新创建。要尽量使用合成/聚合，而非使用继承。
	
		



		
	

	

