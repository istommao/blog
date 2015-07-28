#erlang函数式编程的常见的几种方法

##列表解析

	[Expr(E) || E <- List]
	
	erlang列表解析在运行时会转换成一个临时函数：
	
	'lc^0'([E|Tail], Expr) ->
	    [Expr(E)|'lc^0'(Tail, Expr)];
	'lc^0'([], _Expr) -> [].
	
**举例**
	
	简单匹配
	> [X || {A,X} <- [{a,1},{b,2},{c,3},{a,4},hello,"wow"]].
	[1,2,3,4]
	
	进行*2运算
	> L=[1,2,3,4].
	> [2*X || X <- L].
	[2,4,6,8]

	快排
	
	qsort([]) -> [];
	qsort([Pivot|T]) ->
	qsort([X || X <- T, X < Pivot])
	++ [Pivot] ++
	qsort([X || X <- T,X >= Pivot]).		
	毕达哥拉斯三元组
	
	pythag(N) ->
    [{A,B,C} ||
        A <- lists:seq(1,N),
        B <- lists:seq(1,N),
        C <- lists:seq(1,N),
        A+B+C =< N,
        A*A+B*B =:= C*C
    ].	

##fun函数

**举例**

	lists模块的map, filter, foldl, foldr等函数
	
	使用map进行*2运算
		L=[1,2,3,4] .
		lists:map(fun(X) -> 2*X end,L).
		[2,4,6,8]
	 
	列表求和(使用foldl)
		lists:foldl(fun(X, Sum) -> X + Sum end, 0, L),
	  
	自己写的函数，参数为函数
		helper(Fun, X) ->
			Fun(X)
   
    列表交集 List1 -- List1 -- List2
	  方法1：  
	    pred1(_Elem, []) ->
		  'false';
		 pred1(Elem, [H|T]) ->
		  case Elem =:= H of
		    'true' -> 'true';
		    'false' -> pred1(Elem, T)
		  end.
		
		 get_intersection_list(List1, List2, Fun) ->
		  List3 = lists:filter(fun(X) -> Fun(X, List1) end, List2),
		  io:format("List: ~p~n", [List3]). 
		  
		方法2：
			get_intersection_list2(List1, List2) ->
			 List3 = lists:filter(fun(X) ->
			                       lists:any(fun(T) ->
			                         case T == X of
			                           'true' -> 'true';
			                           'false' -> false end end,
			                       List1) end,
			                     List2),
			 io:format("List: ~p~n", [List3]).
			 
**小结**

	将函数作为参数的时候，比如Fun1的参数有一个为函数Fun2(args...),那么在Fun1可以直接调用Fun2, Fun2的参数可以在Fun1中计算，或者直接从Fun1的其他参数中获得。
	
				 		
			  
    
    
    
    
    
    
    