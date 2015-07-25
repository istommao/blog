#erlang的列表lists模块
===

##lists模块的一些常用函数介绍

##lists:foldl/3, lists:foldr/3	
**函数**

	foldl(Fun, Acc0, List) -> Acc1
	
	Types:

		Fun = fun((Elem :: T, AccIn) -> AccOut)
		Acc0 = Acc1 = AccIn = AccOut = term()
		List = [T]
		T = term()
		
	foldr类似，只是将列表从右边向左边进行Fun操作	
	
**解释**
	
	列表 List 里的每一个元素按从左向右的顺序，作为Fun的第一个参数，首次AccIn设为Acc0，进行Fun函数调用，返回的结果Accout作为下一次的AccIn，如此类推，直到调用完列表里的所有元素，最终一次的结果作为返回值。
	
	一种可能实现方法：	
	foldl(F, Accu, [Hd|Tail]) ->
		foldl(F, F(Hd, Accu), Tail);
	foldl(F, Accu, []) when is_function(F, 2) -> Accu.

**举例**

	> lists:foldl(fun(X, Sum) -> X + Sum end, 0, [1,2,3,4,5]).
	15
	> lists:foldl(fun(X, Prod) -> X * Prod end, 1, [1,2,3,4,5]).
	120

##lists:foreach/2

**函数**

	foreach(Fun, List) -> ok

	Types:

		Fun = fun((Elem :: T) -> term())
		List = [T]
		T = term()
		
**解释**

	该函数意思很明显，就是对List中每个元素都使用Fun操作一遍，最后返回ok。
	

##lists:map/2
**函数**

	map(Fun, List1) -> List2

	Types:
	
		Fun = fun((A) -> B)
		List1 = [A]
		List2 = [B]
		A = B = term()	

**解释**	

	对List中每个元素都使用Fun操作一遍，得到的结果组成新的列表。

##lists:mapfoldl/3, mapfoldr/3

**函数**

	mapfoldl(Fun, Acc0, List1) -> {List2, Acc1}

	Types:
	
		Fun = fun((A, AccIn) -> {B, AccOut})
		Acc0 = Acc1 = AccIn = AccOut = term()
		List1 = [A]
		List2 = [B]
		A = B = term()
	
	组合了map和foldl函数，先对列表List1中的函数进行map，得到列表List2。然后对列表List1和Acc0进行foldl操作，得到Acc1。结果返回元组{List2，Acc1}	

**举例**
	
	> lists:mapfoldl(fun(X, Sum) -> {2*X, X+Sum} end, 0,[1,2,3,4,5]).
	{[2,4,6,8,10],15}
	
##lists:filter/2	

**函数**

	filter(Pred, List1) -> List2

	Types:
	
		Pred = fun((Elem :: T) -> boolean())
		List1 = List2 = [T]
		T = term()
		
**解释**

	列表List1中的每个元素，所有执行Pred函数返回true的组成新的列表作为返回值。
	

##lists:unzip/1, unzip3/1
**函数**

	unzip(List1) -> {List2, List3}
	
	Types:
	
		List1 = [{A, B}]
		List2 = [A]
		List3 = [B]
		A = B = term()
		
	unzip3(List1) -> {List2, List3, List4}
	
	Types:
	
		List1 = [{A, B, C}]
		List2 = [A]
		List3 = [B]
		List4 = [C]
		A = B = C = term()
		

**解释**
	
	分解List1中每个Elem = {A, B}到List2, List3中
	分解List1中每个Elem = {A, B, C}到List2, List3, List4中
	
##lists:zip/2, zip3/3
**函数**

	zip(List1, List2) -> List3
	
	Types:
	
		List1 = [A]
		List2 = [B]
		List3 = [{A, B}]
		A = B = term()
	
	zip3(List1, List2, List3) -> List4
	
	Types:
	
		List1 = [A]
		List2 = [B]
		List3 = [C]
		List4 = [{A, B, C}]
		A = B = C = term()


**解释**

	unzip,unzip3的反向操作，将两个/三个列表合并为一个列表，该列表元素为元组，元组的每个元素分别为每个列表取出对应的元素组成的。
		

##lists:zipwith/3, zipwith3/4
**函数**

	zipwith(Combine, List1, List2) -> List3
	
	Types:
	
		Combine = fun((X, Y) -> T)
		List1 = [X]
		List2 = [Y]
		List3 = [T]
		X = Y = T = term()
		
	zipwith3(Combine, List1, List2, List3) -> List4
	
	Types:
	
		Combine = fun((X, Y, Z) -> T)
		List1 = [X]
		List2 = [Y]
		List3 = [Z]
		List4 = [T]
		X = Y = Z = T = term()		

**解释**
	
	取出List1,List2对应的Elem1, Elem2，进行Combile(Elem1, Elem2) -> T，由所有T组成新的列表List3
	
	zipwith3/4也是类似的。	
	
##lists模块的其他函数介绍	
	
##lists:all/2, any/2

**函数**

	all(Pred, List) -> boolean()
	
	Types:
	
		Pred = fun((Elem :: T) -> boolean())
		List = [T]
		T = term()
	
	any(Pred, List) -> boolean()

	Types:
	
		Pred = fun((Elem :: T) -> boolean())
		List = [T]
		T = term()		
**解释**

	all函数，列表所有元素通过Pred函数都返回true，才返回true。
	any函数，列表中存在一个元素进行Pred返回true，就返回true。
	
##lists:append/1,2

**函数**
	append(ListOfLists) -> List1
	
	Types:
	
		ListOfLists = [List]
		List = List1 = [T]
		T = term()		
	
	append(List1, List2) -> List3
	
	Types:
	
		List1 = List2 = List3 = [T]
		T = term()		
		
**解释**

	append/1拼接嵌套列表	, append/2将List1和List2合并为新的列表。
	
**举例**

	> lists:append([[1, 2, 3], [a, b], [4, 5, 6]]).
	[1,2,3,a,b,4,5,6]
		
	> lists:append("abc", "def").
	"abcdef"

##lists:concat/1

**函数**

	concat(Things) -> string()
	
	Types:
	
		Things = [Thing]
		Thing = atom() | integer() | float() | string()

**解释**

	将Things拼接成一个字符串
	
**举例**

	> lists:concat([doc, '/', file, '.', 3]).
	"doc/file.3"	

##lists:delete/2

**函数**

	delete(Elem, List1) -> List2
	
	Types:
	
		Elem = T
		List1 = List2 = [T]
		T = term()
**解释**

	把List1第一个匹配Elem的元素删除掉后作为新的列表List2
	
	
##lists:droplast/1

**函数**
	
	droplast(List) -> InitList
	
	Types:
	
		List = [T, ...]
		InitList = [T]
		T = term()

**解释**
	顾名思义，List中的最后一个元素。List不能为空。
	
##lists:dropwhile/2

**函数**
	
	dropwhile(Pred, List1) -> List2
	
	Types:
	
		Pred = fun((Elem :: T) -> boolean())
		List1 = List2 = [T]
		T = term()

**解释**	

	将List1中，Pred(Elem)返回true的元素都删除掉。

##lists:duplicate/2
**函数**

	duplicate(N, Elem) -> List
	
	Types:
	
		N = integer() >= 0
		Elem = T
		List = [T]
		T = term()

**解释**

	复制N份Elem，组成新的列表
	
**举例**

	> lists:duplicate(5, xx).
	[xx,xx,xx,xx,xx]	

##lists:filtermap/2

**函数**

	filtermap(Fun, List1) -> List2
	
	Types:
	
		Fun = fun((Elem) -> boolean() | {true, Value})
		List1 = [Elem]
		List2 = [Elem | Value]
		Elem = Value = term()

**解释**

	Fun函数的返回值为true或者{true, Value}，然后将Elem或者Value组成新的列表返回。
	
**举例**
	
	返回值为{true, X div2}，所以2/2=1, 4/2=2,组成列表[1, 2]
	
	> lists:filtermap(fun(X) -> case X rem 2 of 0 -> {true, X div 2}; _ -> false end end, [1,2,3,4,5]).
	[1,2]	

##lists:flatlength/1

**函数**

	flatlength(DeepList) -> integer() >= 0
	
	Types:
	
	DeepList = [term() | DeepList]

**解释**

	将嵌套列表的先flat，然后计算其长度。等于length(flatten(DeepList))，但是效率更高。
	
##lists:flatmap/2

**函数**

	flatmap(Fun, List1) -> List2
	
	Types:
	
		Fun = fun((A) -> [B])
		List1 = [A]
		List2 = [B]
		A = B = term()


**解释**
	
	与map的区别是，函数Fun的返回值是一个列表。两者结果类似，对List1中每个Elem进行Fun，这里得到的结果是个列表[B](而map得到的结果是元素B)，然后将[B]接在一起。
	
**举例**

	> lists:flatmap(fun(X)->[X,X] end, [a,b,c]).
	[a,a,b,b,c,c]	
	
##lists:flatten/1,2

**函数**

	flatten(DeepList) -> List
	
	Types:
	
		DeepList = [term() | DeepList]
		List = [term()]
	
	flatten(DeepList, Tail) -> List
	
	Types:
	
		DeepList = [term() | DeepList]
		Tail = List = [term()]
		
**解释**
	
	字面意思：将签到的DeepList展平。后者在尾部添上[T] + [Tail]


##lists:keydelete/3	
**函数**

	keydelete(Key, N, TupleList1) -> TupleList2
	
	Types:
	
		Key = term()
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList1 = TupleList2 = [Tuple]
		Tuple = tuple()

**解释**

	将TupleList1中第一次满足元组的第N个元素为Key的删除得到的结果作为返回值


##lists:keyfind/3

**函数**

	keyfind(Key, N, TupleList) -> Tuple | false
	
	Types:
	
		Key = term()
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList = [Tuple]
		Tuple = tuple()

**解释**

	类似lists:delete/3，返回第一个找到的元组，该元组中其第N个元素为Key。否则返回false
	
##lists:keymap/3	
**函数**

	keymap(Fun, N, TupleList1) -> TupleList2
	
	Types:
	
		Fun = fun((Term1 :: term()) -> Term2 :: term())
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList1 = TupleList2 = [Tuple]
		Tuple = tuple()


**解释**
	
	将TupleList1中每个tuple的第N个Elem进行Fun(Elem)操作
	
##lists:keymember/3
**函数**
	keymember(Key, N, TupleList) -> boolean()
	
	Types:
	
		Key = term()
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList = [Tuple]
		Tuple = tuple()

**解释**

	如果TupleList中存在tuple其第N个Elem为Key，返回true

##lists:keymerge/3
**函数**

	keymerge(N, TupleList1, TupleList2) -> TupleList3
	
	Types:
	
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList1 = [T1]
		TupleList2 = [T2]
		TupleList3 = [T1 | T2]
		T1 = T2 = Tuple
		Tuple = tuple()

**解释**

	根据Tuple的第N个元素排序，合并两个列表

##lists:keyreplace/4

**函数**

	keyreplace(Key, N, TupleList1, NewTuple) -> TupleList2
	
	Types:
	
		Key = term()
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList1 = TupleList2 = [Tuple]
		NewTuple = Tuple
		Tuple = tuple()

**解释**

	替换TuplistList1中第一个Tuple为NewTuple，它的第N个元素和Key相等，返回新的TupleList2
	
##lists:keysearch/3
**函数**
	
	keysearch(Key, N, TupleList) -> {value, Tuple} | false
	
	Types:
	
		Key = term()
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList = [Tuple]
		Tuple = tuple()


**解释**

	找TupleList中某个Tuple其第N个元素为Key，返回该Tuple。和keyfind类似。
	
##lists:keysort/2
**函数**

	keysort(N, TupleList1) -> TupleList2
	
	Types:
	
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList1 = TupleList2 = [Tuple]
		Tuple = tuple()

**解释**

	将TupleList1中每个Tuple按第N个元素排序。

##lists:keystore/4
**函数**

	keystore(Key, N, TupleList1, NewTuple) -> TupleList2
	
	Types:
	
		Key = term()
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList1 = [Tuple]
		TupleList2 = [Tuple, ...]
		NewTuple = Tuple
		Tuple = tuple()


**解释**

	替换TuplistList1中第一个Tuple为NewTuple，它的第N个元素和Key相等，返回新的TupleList2。如果不存在，NewTuple添加到TupleList1的尾部，返回新的列表。

##lists:keytake/3

**函数**

	keytake(Key, N, TupleList1) -> {value, Tuple, TupleList2} | false
	
	Types:
	
		Key = term()
		N = integer() >= 1
		1..tuple_size(Tuple)
		TupleList1 = TupleList2 = [tuple()]
		Tuple = tuple()

**解释**

	类似与keydelete/3函数，只是返回值不一样而已


##lists:lats/1, nth/2, nthtail/2
**函数**

	last(List) -> Last
	
	Types:
		
		List = [T, ...]
		Last = T
		T = term()
		
	nth(N, List) -> Elem

	Types:
	
	N = integer() >= 1
	1..length(List)
	List = [T, ...]
	Elem = T
	T = term()	
	
	nthtail(N, List) -> Tail
	
	Types:
	
		N = integer() >= 0
		0..length(List)
		List = [T, ...]
		Tail = [T]
		T = term()


**解释**

	返回列表最后一个Elem
	返回第N个Elem
	返回第N+1到最后的新列表

##lists:max/1, min/1, sum/1	
**函数**

	max(List) -> Max
	
	Types:
	
		List = [T, ...]
		Max = T
		T = term()
	
	
	min(List) -> Min
	
	Types:
	
		List = [T, ...]
		Min = T
		T = term()
	sum(List) -> number()

	Types:
	
		List = [number()]

**解释**

	返回最大/最小的元素(可能有多个)
	列表求和


##lists:member
**函数**

	member(Elem, List) -> boolean()
	
	Types:
	
		Elem = T
		List = [T]
		T = term()

**解释**

	判断Elem是否存在List中

##lists:merge/1,2,3

**函数**

	merge(ListOfLists) -> List1
	
	Types:
	
		ListOfLists = [List]
		List = List1 = [T]
		T = term()

	merge(List1, List2) -> List3
	
	Types:
	
		List1 = [X]
		List2 = [Y]
		List3 = [X | Y]
		X = Y = term()
	
	merge(Fun, List1, List2) -> List3
	
	Types:
	
		Fun = fun((A, B) -> boolean())
		List1 = [A]
		List2 = [B]
		List3 = [A | B]
		A = B = term()

**解释**

	合并嵌套列表，且排序；
	合并List1，List2，且排序；
	根据Fun进行排序的函数，合并List1,List2

##lists:merge3/3

**函数**

	merge3(List1, List2, List3) -> List4
	
	Types:
	
		List1 = [X]
		List2 = [Y]
		List3 = [Z]
		List4 = [X | Y | Z]
		X = Y = Z = term()

**解释**

	类似merge/2，合并3个列表，并排序

##lists:partition/2

**函数**

	partition(Pred, List) -> {Satisfying, NotSatisfying}
	
	Types:
	
		Pred = fun((Elem :: T) -> boolean())
		List = Satisfying = NotSatisfying = [T]
		T = term()

**解释**

	根据Pred将List分成符合条件和不符合条件的两个列表
	
##lists:prefix/2, suffix/2

**函数**

	prefix(List1, List2) -> boolean()
	
	Types:
	
		List1 = List2 = [T]
		T = term()
		
	suffix(List1, List2) -> boolean()

	Types:
	
		List1 = List2 = [T]
		T = term()	

**解释**

	判断List1是否是List2的前缀或后缀


##lists:reverse/1,2

**函数**

	reverse(List1) -> List2

	Types:
	
		List1 = List2 = [T]
		T = term()
		
	reverse(List1, Tail) -> List2

	Types:
	
		List1 = [T]
		Tail = term()
		List2 = [T]
		T = term()
		

**解释**

	反转列表
	反转后加上Tail

##lists:seq/2,3

**函数**

	seq(From, To) -> Seq
	seq(From, To, Incr) -> Seq
	
	Types:
	
		From = To = Incr = integer()
		Seq = [integer()]


**解释**

	产生列表序列

##lists:sort/1,2

**函数**

	sort(List1) -> List2
	
	Types:
	
		List1 = List2 = [T]
		T = term()
		
	sort(Fun, List1) -> List2

	Types:
	
		Fun = fun((A :: T, B :: T) -> boolean())
		List1 = List2 = [T]
		T = term()	

**解释**

	对列表排序

##lists:split/2

**函数**

	split(N, List1) -> {List2, List3}
	
	Types:
	
		N = integer() >= 0
		0..length(List1)
		List1 = List2 = List3 = [T]
		T = term()

**解释**

	将前N个元素作为List2，剩余的作为List3
	
##lists:splitwith/2

**函数**

	splitwith(Pred, List) -> {List1, List2}
	
	Types:
	
		Pred = fun((T) -> boolean())
		List = List1 = List2 = [T]
		T = term()
	
**解释**

	根据条件Pred函数分成两个新列表，和partition木有区别？
	

##lists:sublist/2,3

**函数**

	sublist(List1, Len) -> List2
	
	Types:
	
		List1 = List2 = [T]
		Len = integer() >= 0
		T = term()
	
	sublist(List1, Start, Len) -> List2
	
	Types:
	
		List1 = List2 = [T]
		Start = integer() >= 1
		1..(length(List1)+1)
		Len = integer() >= 0
		T = term()


**解释**

	取出[1...Len]/[Start, Start+Len-1]的子列表 

##lists:subtract/2

**函数**

	subtract(List1, List2) -> List3
	
	Types:
	
		List1 = List2 = List3 = [T]
		T = term()

**解释**

	从List1中删除List2，等价于List1 -- List2

##lists:takewhile/2

**函数**

	takewhile(Pred, List1) -> List2
	
	Types:
	
		Pred = fun((Elem :: T) -> boolean())
		List1 = List2 = [T]
		T = term()

**解释**

	遍历列表，返回Pred为真，直到出现false，不再遍历。



##lists:ukeymerge/3, ukeysort/2, umerge/1,2,3, umerge3/3, usort/1,2

**函数**


**解释**

	和lists:keymerge/3, keysort/2, merge/1,2,3, merge3/3, sort/1,2的功能类似，不同之处在于重复的数据只去一个(unique)
	
	

##lists:
**函数**


**解释**








	


		
		
