#erlang的常见用法、函数、技巧等
========

##supervisor:which_children(SupRef) -> [{Id, Child, Type, Modules}]

	Types:
	
	SupRef = sup_ref()
	Id = child_id() | undefined
	Child = child() | restarting
	Type = worker()
	Modules = modules()
	
> 返回Supref的所有Child的标示Child的Id， Pid，类型(worker还是supervisor)和回调函数Module名。这几个参数和Supervisor中的init函数的子进程规格ChildSpec一样的。

##supervisor:start_child(SupRef, ChildSpec) -> startchild_ret()	

> 根据ChilSpec动态启动该督程下的一个子进程, 返回ok和子进程pid号

	
##记录record和type
	
	-record(state, {
	          queue :: api_binary()
	         ,is_consuming = 'false' :: boolean()
	         ,responders = [] :: listener_utils:responders() %% { {EvtCat, EvtName}, Module }
	         ,bindings = [] :: bindings() %% {authentication, [{key, value},...]}
	         ,params = [] :: wh_proplist()
	         ,module :: atom()
	         ,module_state :: module_state()
	         ,module_timeout_ref :: reference() % when the client sets a timeout, gen_listener calls shouldn't negate it, only calls that pass through to the client
	         ,other_queues = [] :: [{ne_binary(), {wh_proplist(), wh_proplist()}},...] | [] %% {QueueName, {proplist(), wh_proplist()}}
	         ,federators = [] :: federator_listeners()
	         ,self = self() :: pid()
	         ,consumer_key = wh_amqp_channel:consumer_pid()
	         ,consumer_tags = [] :: binaries()
	         }).
	
	-type state() :: #state{}.	
	-type module_state() :: term().
	
	-callback handle_call(term(), {pid(), term()}, module_state()) -> handle_call_return().
	
	
	
**双冒号::**用来指示该字段的类型 	


##put('callid', Module),


##lists:foldr(fun maybe_add_mapping/2, Responders, [{Evt, Responder} || Evt <- Keys]). 以及lists:foldl
	
	foldl(Fun, Acc0, List) -> Acc1
	列表 List 里的每一个元素按从左向右的顺序，依次跟一个累积器（accumulator）参数 Acc0 作为 Fun 的参数被调用执行，并返回一个新的累积器 Acc1 跟列表的下一个元素调用，直到调用完列表里的所有元素，最终返回累积器 Acc 的结果值。
	简单说来就是以Acc0初始化为Fun的第二个参数，列表的头作为第一个参数，得出的结果作为新的Acc，与列表新的头组成Fun的新参数调用，以此类推。
	
	foldl(F, Accu, [Hd|Tail]) ->
		foldl(F, F(Hd, Accu), Tail);
	foldl(F, Accu, []) when is_function(F, 2) -> Accu.
	
	




##函数和Guard与Case相比较

	execute(PoolId, Query) when (is_list(Query) orelse is_binary(Query)) ->
	    execute(PoolId, Query, []);
	
	execute(PoolId, StmtName) when is_atom(StmtName) ->
	    execute(PoolId, StmtName, []).

> 这种用法相比case的好处是，不但可以作为分支的功能使用，而且它还可以作为不同类型进行区分。


##proc_lib:spawn/spawn_opt

##erlang:function_exported


维护websocket中 user 和 agentid sessionid的ets关系
