#Learn your some erlang笔记
====

#Numbers
====

用其他进制表示整数： 
	
	Base#Value

====
#不可变的变量

变量名要求大写字母开头。推荐每个单词首字母大写，如HttpState

函数式编程里，变量一经“赋值”就是不可变的。

“=”：不叫赋值，而是称作“模式匹配（pattern match）”

已“_”开头的变量，_Var，说明该变量不会被使用


===

#原子
====

* 已小写字母开头（一般全部问小写字母）
* 或者是用单引号''括起的，整个作为原子

====

#Boolean代数和比较操作
===

	true false and or xor not andalso orelse

	=:= 恒等，类型和大小一样
	=/= 恒不等，类型或大小不同
	==  相等，类型可以不同
	/=  不相等，类型和大小都不同
	< > =< >=
	
不同类型的比较

	number < atom < reference < fun < port < pid < tuple < list < bit string
	
===

#元组
====

用花括号括起来（Python中元组用小括号）：

	{Element1, Element2, ..., ElementN}

元组信息提取：模式匹配

	Point = {4, 5}.
	{X, Y} = Point.
	{X, _} = Point.

====


#列表

====

用中括号括起来：

	[Element1, Element2, ..., ElementN]
	
列表可以包含任意文件

列表组合操作，需要注意的时该操作从右到左进行：

	操作符：++， --	
	> [1,2,3] -- [1,2] -- [3].
	[3]
	
列表头和尾（除头外的其他）：
	
	hd([...]), tl([...])	
	或者
	使用模式匹配分出列表头和尾：[H|T]

任何列表都可以使用：

	[Term1| [Term2 | [... | [TermN]]]].... 
	
列表解析：和数学的函数表示很像，f(A):={f(x):x 属于全体实数}

	[2*N || N <- [1,2,3,4]].	

===

#位语法
===

	使用<<和>>括起来
	
二进制分段：

	Value
	Value:Size
	Value/TypeSpecifierList
	Value:Size/TypeSpecifierList

	Size：bits大小或是bytes大小
	TypeSpecifierList:可以下面一个或多个,多个通过‘-’相连, 比如：integer-signed-little.
		Type: integer | float | binary | bytes | bitstring | bits | utf8 | utf16 | utf32
		Signedness: signed | unsigned
		Endianness: big | little | native
		Unit: unit:Integer
		
		
二进制操作：bsl(位左移), bsr, band, bor, bxor

二进制解析：类似列表解析

	<< <<Bin/binary>> || Bin <- [<<3,7,5,4,7>>] >>.	

====

	

#Modules
=====

模块的属性格式：
	
	-Name(Attribute).

比如：
	-module(mod).
	-export([start/0]).	
	-define().
	-import().
	
=====


#动态强类型
====

强类型：类型之间不会自动进行转换

=====

#递归
===
没有while和for，循环都是通过递归实现的

递归注意点：

* 先写基准情况
* 自己调用自己
* 列表（终止条件）

如何修改为尾递归：
	
	增加一个初始参数，其实就是将非尾递归的结构保存到这个参数里。
	
e.g.
	
	1. len
	len([]) -> 0;
	len([_|T]) -> 1 + len(T).
	
	==>
	
	tail_len(L) -> tail_len(L,0).
 
	tail_len([], Acc) -> Acc;
	tail_len([_|T], Acc) -> tail_len(T,Acc+1).

	2. duplicate
	duplicate(0,_) ->
		[];
	duplicate(N,Term) when N > 0 ->
		[Term|duplicate(N-1,Term)].
		
	==>
	
	tail_duplicate(N,Term) ->
		tail_duplicate(N,Term,[]).
	 
	tail_duplicate(0,_,List) ->
		List;
	tail_duplicate(N,Term,List) when N > 0 ->
		tail_duplicate(N-1, Term, [Term|List]).	
	3. reverse
	
	reverse([]) -> [];
	reverse([H|T]) -> reverse(T)++[H].
	
	==>
	tail_reverse(L) -> tail_reverse(L,[]).
 
	tail_reverse([],Acc) -> Acc;
	tail_reverse([H|T],Acc) -> tail_reverse(T, [H|Acc]).	
	
	4.quicksort
	
	quicksort([]) -> [];
	quicksort([Pivot|Rest]) ->
		{Smaller, Larger} = partition(Pivot,Rest,[],[]),
		quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).
	
	partition(_,[], Smaller, Larger) -> {Smaller, Larger};
	partition(Pivot, [H|T], Smaller, Larger) ->
		if H =< Pivot -> partition(Pivot, T, [H|Smaller], Larger);
			H >  Pivot -> partition(Pivot, T, Smaller, [H|Larger])
		end.

	lc_quicksort([]) -> [];
	lc_quicksort([Pivot|Rest]) ->
		lc_quicksort([Smaller || Smaller <- Rest, Smaller =< Pivot])
		++ [Pivot] ++
		lc_quicksort([Larger || Larger <- Rest, Larger > Pivot]).

lists标准库提供很多函数：*lists:map/filter/foldl/foldr/flattern/merge/nth/nthtail/split...*

===

#Error
======

try ... catch, try of之间的Expression可以有多个

	try Expression of
		SuccessfulPattern1 [Guards] ->
			Expression1;
		SuccessfulPattern2 [Guards] ->
			Expression2
	catch
		TypeOfError:ExceptionPattern1 ->
			Expression3;
		TypeOfError:ExceptionPattern2 ->
			Expression4
	end.

after
	
	try Expr of
		Pattern -> Expr1
	catch
		Type:Exception -> Expr2
	after % this always gets executed
		Expr3
	end

catch: 也存在这种表示
	
	catch Expression of
		...
	

======


#OTP
======
OTP缩写为Open Telecom Platform，但不仅仅局限以此，只要具有通信应用的性质都适用这个OTP。

Erlang三大优势：并发，容错和OTP


=====


















