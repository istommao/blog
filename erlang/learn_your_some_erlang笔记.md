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

#记录
===
作为module的属性：

	-record(robot, {name,
							type=industrial,
							hobbies,
							details=[]}
				).
	
定义：

	first_robot() ->
		#robot{name="Mechatron",
				type=handmade,
				details=["Moved by a small man inside"]}.

提取记录的方法：

点语法

	Crusher = #robot{name="Crusher", hobbies=["Crushing people","petting cats"]}.
	
	Crusher#robot.hobbies.
	
在函数的参数或保护式中进行模式匹配：
	
	绑定整个记录
	SomeVar = #some_record{}	
	绑定记录的某个字段
	#some_record{some_field=SomeField}
		
===

#Key-Value
===

少量的数据可以用：problists、orddict

## proplist
proplist就是以元组构成的列表：

	 [{Key,Value}]
	 
proplists模块提供了很多函数操作problists。如果想要增加和更新list中的元素就需要结合列表特性和其提供的一些函数：
	
	[NewElement|OldList]和 lists:keyreplace/4之类的函数去实现
	
## orddict (ordered dictionaries)
	 orddict:store/3, orddict:find/2 (when you do not know whether the key is in the dictionaries), 
	 
	 orddict:fetch/2 (when you know it is there or that it must be there) and orddict:erase/2.

大量数据使用：dicts and gb_trees.		
## dicts
	
	 dict:store/3, dict:find/2, dict:fetch/2, dict:erase/2 and every other function, such as dict:map/2 and dict:fold/2 (pretty useful to work on the whole data structure!) Dicts are thus very good choices to scale orddicts up whenever it is needed.
	 	 

===


#Sets
===
 
 模块：ordsets, sets, gb_sets and sofs (sets of sets)
 
 
===

#有向图
====

模块：digraph and digraph_utils


====


#并发编程
===
这个章节不好解释，需要结合例子，这里就粗略介绍下，这里提到的几点体现了OTP模式设计的一些思想。OTP就是这么设计出来的。想要具体了解，最好去详细阅读相关章节：<http://learnyousomeerlang.com/more-on-multiprocessing>

##为什么会有state
state可以用来记录一些状态，以便在不同情况下的处理。

##隐藏message
把不需要用户了解的信息隐藏起来，比如涉及到的协议如何接收和发送，通过函数封装，不暴露给用户知道，用户只需要调用接口去执行他想要的操作即可。

##Timeout


##选择接收不同的消息

	receive
		Pattern1 -> Expression1;
		Pattern2 -> Expression2;
		Pattern3 -> Expression3;
		...
		PatternN -> ExpressionN;
		Unexpected ->
			io:format("unexpected message ~p~n", [Unexpected])
	end.


===

#Erros和Processes
===

##links
讲两个程序link起来

##process_trap

##monitors
erlang:monitor、demonitor

##命名处理
erlang:register、unregister


===


#OTP
======
OTP缩写为Open Telecom Platform，但不仅仅局限以此，只要具有通信应用的性质都适用这个OTP。

Erlang三大优势：并发，容错和OTP

##gen_server

### init/1

用来初始化server的状态及其只需要执行一次的工作。

返回值：

	{ok, State}：State被传到main loop中，作为之后状态的初始值。
	{ok, State, TimeOut}：超时设置，当超时发送时，'timeout'发送到server，通过handle_info处理这一事件
	{ok, State, hibernate}：主要处理当进程在reply前需要的时间较长，担心其占用过多内存，将其设置为hibernate
	{stop, Reason}： 初始化过程出错，返回
	
###handle_call

用于同步处理消息。

参数：

	(Request, From, State)
	
返回值：

	{reply,Reply,NewState}
	{reply,Reply,NewState,Timeout}
	{reply,Reply,NewState,hibernate}
	{noreply,NewState}
	{noreply,NewState,Timeout}
	{noreply,NewState,hibernate}
	{stop,Reason,Reply,NewState}
	{stop,Reason,NewState}	
	
	Timeout和hibernate	与 init中的一样。
	多数情况下，使用reply元组就可以满足要求了。
	例外：当你需要自己手动reply或者只是发送一个确认，但是希望其继续处理，这使用noreply。这个时候需要使用gen_server:reply/2。

###handle_cast

用来异步处理消息，处理方式与handle_call类似

参数：

	(Request, State)
	
返回值：

	{noreply,NewState}
	{noreply,NewState,Timeout}
	{noreply,NewState,hibernate}
	{stop,Reason,NewState}		

###handle_info

用来处理handle_call和handle_cast没有处理的消息，这些消息都是通过操作符!发送，或者是init中的'timeout'消息，或者是监视器monitor的发送的通知信号'EXIT'。

返回值：与handle_cast一样
	

###terminate

当handle_xxx返回	{stop, Reason, NewState} or {stop, Reason, Reply, NewState}时，该函数被调用。与init是反操作，可以用来处理一些结束工作，比如清除ets或者关闭所有端口。

参数：

	(Reason, State)
	
###code_change

	code_change(PreviousVersion, State, Extra)
	

##gen_fsm

gen_fsm是一种特殊的gen_server。

###init

与gen_server的init一样，用来初始化状态及其只需要执行一次的工作。

返回值：

	 {ok, StateName, Data}, {ok, StateName, Data, Timeout}, {ok, StateName, Data, hibernate} and {stop, Reason}
	 
	 hibernate和Timeout都与gen_server中具有相同的意思
	 StateName是一个原子，表示下一个被调用的回调函数。
	 
###StateName

StateName/2、3状态机各个状态的回调函数

参数：

	(Event, StateData)
	(Event, From, StateData)
	
返回值：

	StateName/2
	{next_state, NextStateName, NewStateData}
	{next_state, NextStateName, NewStateData, Timeout}, 	{next_state, NextStateName, NewStateData, hibernate} 
	{stop, Reason, NewStateData}. 

	StateName/3
	{reply, Reply, NextStateName, NewStateData}
	{reply, Reply, NextStateName, NewStateData, Timeout}
	{reply, Reply, NextStateName, NewStateData, hibernate}

	{next_state, NextStateName, NewStateData}
	{next_state, NextStateName, NewStateData, Timeout}
	{next_state, NextStateName, NewStateData, hibernate}

	{stop, Reason, Reply, NewStateData}
	{stop, Reason, NewStateData}


###handle_event
用来发送在所有状态都会触发的事件。回调相应的StateName/2函数


###handle_sync_event
用来发送在所有状态都会触发的事件。回调相应的StateName/3函数

###事件发送

	StateName/2 function are sent with send_event/2
	StateName/3 are to be sent with sync_send_event/2-3
	global events are send_all_state_event/2 and sync_send_all_state_event/2-3 

##Supervisor
<https://github.com/zhuwei05/blog/blob/master/erlang/erlang%E5%BA%94%E7%94%A8%E6%A8%A1%E5%9D%97.md>

##gen_event
====

gen_event

=====


#Type定义
====
内置：

	any()、none()、reference()、atom()、binary()
	term()、byte()、char()、string()

自定义：

	-type TypeName() :: TypeDefinition
	
	记录-->Field :: Type或Field = Default :: Type
	e.g.
	-record(user, {name="" :: string(),
							notes :: tree(),
							age :: non_neg_integer(),
							%% friends=[] :: [#user{}],
							friends=[] :: [user()],
							bio :: string() | binary()}).
			
	-type user() :: #user{}.

函数类型指定：

	-spec FunctionName(ArgumentTypes) -> ReturnTypes..

	e.g.
	-spec convert(tuple()) -> list();
						(list()) -> tuple().
	convert(Tup) when is_tuple(Tup) -> tuple_to_list(Tup);
	convert(L = [_|_]) -> list_to_tuple(L).

行为模式定义使用：-callback

	需要注意的是，-callback和behaviour_info/1不能同时使用	

====


#sockets

====

sockets

=====

#EUnit和Common Test

====

EUnit和Common TestE

=====

#ETS和DETS

====

ETS和DETS

=====

#分布式
====

分布式

===

#Mnesia
====

Mnesia

=====




















