#erlang语法进阶

##二进制拼接

	Old = <<"join">>,
	New = <<Old/binary, "_together">>,
	io:format("Old: ~p, New: ~p", [Old, New]).
	
##列表操作

	[H|T],这种方法要求T必需为一个列表，否则大部分情况下出错。
	ThingsToBuy = [{<<"apple">>, 10}, {<<"pears">>, 6}].
	ThingsToBuy1 = [{<<"oranges">>, 4} | ThingsToBuy].

###列表解析

	 NewList = [Expression || Pattern <- List, Condition1,
	  										Condition2, ... ConditionN]
	 Pattern <- List是表达式生成器，可以有多个。比如：
	 	[X+Y || X <- [1,2], Y <- [2,3]].
	 	
	
	
##记录的用法分析

**定义记录**

	-record(employee, {name :: term()
								,id :: number()
								,phone = <<"">>:: binary()
								}).

**创建记录**
	
	EmployeeOne = #employee{name="abc", id=1, phone=<<"123">>}

**获取记录的某个字段**
	
	dot方法
	Name = EmployeeOne#employer.name
	如果有嵌套，则需要用():(Nest#record1.data1)#record2.data2
	
	如果仅仅是#employer.name,返回的是一个整数，该字段位于记录（元组）的第几个。
	
	绑定某个或某几个变量到记录的某些字段：使用模式匹配过滤得到结果
	bind_var(#employee{name=Name, phone=Phone}) -> ...
	绑定整个记录: SomeVar = #some_record{}
	bind(Employee = #employee{})
	
**记录更新**

	EmployeeTwo = EmployeeOne#employee{name="def"}
	

##算术操作和逻辑运算

**算术操作**

	+ - * /(带小数点) div(求商) rem(求余)
	优先级应该和其他语言一样。
	
**各种进制表示**	
	
	Base#Value （Base为2..36）

**bool运算和比较运算**	

	非短路：and or xor not
	短路: andals orelse
	
	=:= =/=
	== /=
	> >=
	< =<(注意不是<=,因为这个像箭头，而且用到字典里)
	
	不同类型之间的比较
	number < atom < reference < fun < port < pid < tuple < list < bit string
	
	
	
	
	
	
	
	
	

		
		