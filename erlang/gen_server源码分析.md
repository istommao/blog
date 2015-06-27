#gen_server源码分析

##gen_Server概要

> gen_server行为模式的基本流程如下： 回调模块的start调用gen_server:start_link（或gen_server:start）来启动服务器，并进入主循环，在回调模块的接口函数（处理具体的业务逻辑）中调用gen_server的call或cast来处理请求，在gen_server的call和cast中进一步调用回调模块中的handle_call和handle_cast来执行具体的业务逻辑处理，回调模块的terminate来终止进程。



##源码分析
*参考链接：*[gen_server图解分析](http://blog.csdn.net/zhangzhizhen1988/article/details/7932449)

##gen_server:start和gen_server:start_link

###概要
####gen_server:start、start_link定义和参数
	%%%  -----------------------------------------------------------------
	%%% Starts a generic server.
	%%% start(Mod, Args, Options)
	%%% start(Name, Mod, Args, Options)
	%%% start_link(Mod, Args, Options)
	%%% start_link(Name, Mod, Args, Options) where:
	%%%    Name ::= {local, atom()} | {global, atom()} | {via, atom(), term()}
	%%%    Mod  ::= atom(), callback module implementing the 'real' server
	%%%    Args ::= term(), init arguments (to Mod:init/1)
	%%%    Options ::= [{timeout, Timeout} | {debug, [Flag]}]
	%%%      Flag ::= trace | log | {logfile, File} | statistics | debug
	%%%          (debug == log && statistics)
	%%% Returns: {ok, Pid} |
	%%%          {error, {already_started, Pid}} |
	%%%          {error, Reason}
	%%% -----------------------------------------------------------------
	start(Mod, Args, Options) ->
	    gen:start(?MODULE, nolink, Mod, Args, Options).
	
	start(Name, Mod, Args, Options) ->
	    gen:start(?MODULE, nolink, Name, Mod, Args, Options).
	
	start_link(Mod, Args, Options) ->
	    gen:start(?MODULE, link, Mod, Args, Options).
	
	start_link(Name, Mod, Args, Options) ->
	    gen:start(?MODULE, link, Name, Mod, Args, Options).

####工作流
	%%% The work flow (of the server) can be described as follows:
	%%%
	%%%   User module                          Generic
	%%%   -----------                          -------
	%%%     start            ----->             start
	%%%     init             <-----              .
	%%%
	%%%                                         loop

####Mod:init函数的返回值	
	%%%   init(Args)  
	%%%     ==> {ok, State}
	%%%         {ok, State, Timeout}
	%%%         ignore
	%%%         {stop, Reason}

####gen_server:start工作流程图
![gen_server工作流程图](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/erlang-gen_server-start_link.png)	


###gen_server:start/3	    
	gen_server:start(Mod, Args, Options) ->
		 gen:start(?MODULE, nolink, Mod, Args, Options).

	gen:start(GenMod, LinkP, Mod, Args, Options) ->
	    do_spawn(GenMod, LinkP, Mod, Args, Options).	
	gen:do_spawn(GenMod, _, Mod, Args, Options) ->
    	Time = timeout(Options),
    	proc_lib:start(?MODULE, init_it,
		   [GenMod, self(), self, Mod, Args, Options], 
		   Time,
		   spawn_opts(Options)).  
		   
	proc_lib:start(M, F, A, Timeout, SpawnOpts) when is_atom(M), is_atom(F), is_list(A) ->
    	PidRef = spawn_opt_mon(M, F, A, SpawnOpts),
    	sync_wait_mon(PidRef, Timeout).	   

**注：**	
	
> 对于start/3, start/4和start_link/3，start_link/4来说，其调用的do_spawn并不一样，主要区别体现在是调用pro_lib:start还是pro_lib:start_link，以及该函数的的第三个参数不一样：
	
<table>
<tr>
<td>gen_server:start/3</td> 
<td>pro_lib:start(_, _, [GenMod, self(), self, Mod, Args, Options])</td>
</tr>
<tr>
<td>gen_server:start_link/3</td>
<td>pro_lib:start_link(_, _, [GenMod, self(), self(), Mod, Args, Options])</td>
</tr>
<tr>
<td>gen_server:start/4</td> 
<td>pro_lib:start(_, _, [GenMod, self(), self, Name, Mod, Args, Options])</td>
</tr>
<tr>
<td>gen_server:start_link/3</td>
<td>pro_lib:start_link(_, _, [GenMod, self(), self(), Name, Mod, Args, Options])</td>
</tr></tr>
</table>
		 	
     
####proc_lib:start
    
> proc_lib:start调用两个函数，一个是proc_lib:spawn_opt_mon去实现新进程的创建，而另一个是proc_lib:sync_wait_mon等待由proc_lib:spawn_opt_mon创建的新进程返回。下面先对spawn_opt_mon进行分析
    		 	    
* proc_lib:spawn_opt_mon就是创建一个新的进程，执行**proc_lib:init_p([Parent,Ancestors,M,F,A])**，并调用**proc_lib:sync_wait_mon(PidRef, Timeout)**进行等待。

		proc_lib:spawn_opt_mon(M, F, A, Opts) when is_atom(M), is_atom(F), is_list(A) ->
	    	Parent = get_my_name(),
	    	Ancestors = get_ancestors(),
	    	...
	    	erlang:spawn_opt(?MODULE, init_p, [Parent,Ancestors,M,F,A], [monitor|Opts]).

		proc_lib:init_p(Parent, Ancestors, M, F, A) when is_atom(M), is_atom(F), is_list(A) ->
		    ...
		    init_p_do_apply(M, F, A).
		
		proc_lib:init_p_do_apply(M, F, A) ->
		    ...
		    apply(M, F, A) 
		    ...
	
	分析proc_lib:init_p，它实际上就是调用**apply(M, F, A)**，所以，绕了一个大圈，gen:do_spawn其实就是创建一个新的进程并执行apply(M, F, A)，其中M为gen，F为init, A为[GenMod, self(), self, Mod, Args, Options]，所以
	
		gen:init_it([GenMod, self(), self, Mod, Args, Options])
	
	gen:init_it代码为：
	
		init_it(GenMod, Starter, Parent, Mod, Args, Options) ->
		    init_it2(GenMod, Starter, Parent, self(), Mod, Args, Options).
		
		init_it(GenMod, Starter, Parent, Name, Mod, Args, Options) ->
		    case name_register(Name) of
			true ->
			    init_it2(GenMod, Starter, Parent, Name, Mod, Args, Options);
			{false, Pid} ->
			    proc_lib:init_ack(Starter, {error, {already_started, Pid}})
		    end.
		
		init_it2(GenMod, Starter, Parent, Name, Mod, Args, Options) ->
		    GenMod:init_it(Starter, Parent, Name, Mod, Args, Options).

	追溯下来，
		
		GenMod：gen_server；
		Starter：gen的pid；
		Parent：gen_server:start为self或者gen_server:start_link为self()
		Name：self()，或者gen_server:start/4提供的Name参数；
		Mod：你自己实现的行为模式为gen_server的模块名；
		Args和Option都是你自己的模块调用gen_server:start/3传进来的参数。
	
	
* 分析proc_lib:sync_wait_mon

		sync_wait_mon({Pid, Ref}, Timeout) ->
		    receive
			{ack, Pid, Return} ->
			    erlang:demonitor(Ref, [flush]),
			    Return;
			{'DOWN', Ref, _Type, Pid, Reason} ->
			    {error, Reason};
			{'EXIT', Pid, Reason} -> %% link as spawn_opt?
			    erlang:demonitor(Ref, [flush]),
			    {error, Reason}
		    after Timeout ->
			    erlang:demonitor(Ref, [flush]),
			    exit(Pid, kill),
			    flush(Pid),
			    {error, timeout}
		    end.
	
	proc_lib:sync_wait_mon等待由spawn_opt_mon创建的新进程返回，实际上就是**等待gen_server:init_it调用proc_lib:init_ack返回**。这点下面会分析到。

###gen_server:init_it

gen_server:init_it代码为：

	init_it(Starter, self, Name, Mod, Args, Options) ->
	    init_it(Starter, self(), Name, Mod, Args, Options);
	init_it(Starter, Parent, Name0, Mod, Args, Options) ->
	    Name = name(Name0),
	  	 ...
	    case catch Mod:init(Args) of
		{ok, State} ->
		    proc_lib:init_ack(Starter, {ok, self()}), 
		    loop(Parent, Name, State, Mod, infinity, Debug);
		{ok, State, Timeout} ->
		    proc_lib:init_ack(Starter, {ok, self()}),    
		    loop(Parent, Name, State, Mod, Timeout, Debug);
		{stop, Reason} ->
		    unregister_name(Name0),
		    proc_lib:init_ack(Starter, {error, Reason}),
		    exit(Reason);
		ignore ->
		    unregister_name(Name0),
		    proc_lib:init_ack(Starter, ignore),
		    exit(normal);
		{'EXIT', Reason} ->
		    unregister_name(Name0),
		    proc_lib:init_ack(Starter, {error, Reason}),
		    exit(Reason);
		Else ->
		    Error = {bad_return_value, Else},
		    proc_lib:init_ack(Starter, {error, Error}),
		    exit(Error)
	    end.   

* 首先，可以看到，gen_server:init_it会去调用Mod:init(Args)，这就是自己的模块的init函数调用。
* 其次，会根据Mod:init(Args)的返回值判断处理流程。
* 调用proc_lib:init_ack，前面的sync_wait_mon就是等待该函数的返回，sync_wait_mon收到该消息后结束阻塞，并返回init_ack的第二个参数。
* 最后，如果收到ok，正常执行则进入loop循环，其他则执行exit。

	分析gen_server:loop函数：
	
		loop(Parent, Name, State, Mod, hibernate, Debug) ->
	    	proc_lib:hibernate(?MODULE,wake_hib,[Parent, Name, State, Mod, Debug]);
		loop(Parent, Name, State, Mod, Time, Debug) ->
		    Msg = receive
			      Input ->
				    Input
			  after Time ->
				  timeout
			  end,
		    decode_msg(Msg, Parent, Name, State, Mod, Time, Debug, false).
		
      参数：
      	Parent：gen_server:start为self或者gen_server:start_link为self()
      	Name：注册的名字，这个如果是gen_server:start/3则为self()，如果gen_server:start/4则是参数Name；
      	State：Mod:init函数返回的State值；
      	Mod：自己的模块名；
      	Debug：gen_server:start/3、4的最后一个参数；
      	Time: 超时时间
      	
    **loop等待调用进程下次发送的消息，比如调用gen_server:call、cast、info等，收到消息后通过gen_server:decode_msg去解析并执行对应的操作**  
 
###gen_server:start/3与/4和start_link/3与/4的区别   

先来看这四个函数的定义：

	start(Mod, Args, Options)
	start(Name, Mod, Args, Options)
	start_link(Mod, Args, Options)
	start_link(Name, Mod, Args, Options)    
  
提供Name参数可以给启动的gen进程命名。
  
> 从前文gen:init_it代码可以发现，对没有提供Name参数的，会将Name这个参数设置为self()，而提供Name参数的会去case name_regeister(Name)，如果

	init_it(GenMod, Starter, Parent, Mod, Args, Options) ->
		    init_it2(GenMod, Starter, Parent, self(), Mod, Args, Options).
		
	init_it(GenMod, Starter, Parent, Name, Mod, Args, Options) ->
	    case name_register(Name) of
		true ->
		    init_it2(GenMod, Starter, Parent, Name, Mod, Args, Options);
		{false, Pid} ->
		    proc_lib:init_ack(Starter, {error, {already_started, Pid}})
	    end.
	
	init_it2(GenMod, Starter, Parent, Name, Mod, Args, Options) ->
	    GenMod:init_it(Starter, Parent, Name, Mod, Args, Options).

		    
    	
##gen_server:call

###概要

####定义和参数

	gen_server:call(Name, Request) ->
	    case catch gen:call(Name, '$gen_call', Request) of
		{ok,Res} ->
		    Res;
		{'EXIT',Reason} ->
		    exit({Reason, {?MODULE, call, [Name, Request]}})
	    end.
	
	gen_server:call(Name, Request, Timeout) ->
	    case catch gen:call(Name, '$gen_call', Request, Timeout) of
		{ok,Res} ->
		    Res;
		{'EXIT',Reason} ->
		    exit({Reason, {?MODULE, call, [Name, Request, Timeout]}})
	    end.

####工作流
	%%%   User module                          Generic
	%%%   -----------                          -------
	%%%     handle_call      <-----              .
	%%%                      ----->             reply

####Mod:hand_call返回值

	%%%   handle_call(Msg, {From, Tag}, State)
	%%%
	%%%    ==> {reply, Reply, State}
	%%%        {reply, Reply, State, Timeout}
	%%%        {noreply, State}
	%%%        {noreply, State, Timeout}
	%%%        {stop, Reason, Reply, State}  
	%%%              Reason = normal | shutdown | Term terminate(State) is called

####gen_server:call工作流程图
(个人认为这图有问题，大体是对的)
![gen_server:call工作流程图](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/erlang-gen_server-call.png)

###gen:call
	call(Process, Label, Request) -> 
		call(Process, Label, Request, ?default_timeout).
		call(Pid, Label, Request, Timeout) ->
	    	do_call(Pid, Label, Request, Timeout);
	
	do_call(Process, Label, Request, Timeout) ->
	    try erlang:monitor(process, Process) of
			Mref ->
		    catch erlang:send(Process, {Label, {self(), Mref}, Request},
			  [noconnect]),
			  
		    receive
			{Mref, Reply} ->
			    erlang:demonitor(Mref, [flush]),
			    {ok, Reply};
			{'DOWN', Mref, _, _, noconnection} ->
			    Node = get_node(Process),
			    exit({nodedown, Node});
			{'DOWN', Mref, _, _, Reason} ->
			    exit(Reason)
		    after Timeout ->
			    erlang:demonitor(Mref, [flush]),
			    exit(timeout)
		    end
	    catch
		error:_ ->
		   ...
	    end.

* gen:call会根据被调用时的参数个数以及第一个参数的类型进行区分，但是不论是哪一个都会去调用do_call
* gen:do_call通过erlang:send发送消息，该消息会被处于gen_server:loop的gen_server进程接收到。
* gen:do_call阻塞receive，等待gen_server:loop的返回

参数分析：

	Process: 可以简单的将其看成做事调用gen_server:call时传入的第一个参数；
	Label: '$gen_call'；
	Request: gen_server:call的第二个参数；
	Timeout: gen_server:call的第三个参数或者是默认值
   	
###gen_server:loop	

	loop(Parent, Name, State, Mod, hibernate, Debug) ->
	    proc_lib:hibernate(?MODULE,wake_hib,[Parent, Name, State, Mod, Debug]);
	loop(Parent, Name, State, Mod, Time, Debug) ->
	    Msg = receive
		      Input ->
			    Input
		  after Time ->
			  timeout
		  end,
	    decode_msg(Msg, Parent, Name, State, Mod, Time, Debug, false).

###gen_server:decode_msg
	decode_msg(Msg, Parent, Name, State, Mod, Time, Debug, Hib) ->
	    case Msg of
			
			...
			
			_Msg when Debug =:= [] ->
			    handle_msg(Msg, Parent, Name, State, Mod);
			_Msg ->
			    Debug1 = sys:handle_debug(Debug, fun print_event/3,
						      Name, {in, Msg}),
			    handle_msg(Msg, Parent, Name, State, Mod, Debug1)
		    end.

gen_server:handle_msg会根据Msg去判断是gen_server:call发送的消息，还是gen_server:cast，亦或是其他发送的。

	handle_msg({'$gen_call', From, Msg}, Parent, Name, State, Mod) ->
	    Result = try_handle_call(Mod, Msg, From, State),
	    case Result of
			{ok, {reply, Reply, NState}} ->
			    reply(From, Reply),
			    loop(Parent, Name, NState, Mod, infinity, []);
			
			...
			
			Other -> handle_common_reply(Other, Parent, Name, Msg, Mod, State)
		    end;	
	
	try_handle_call(Mod, Msg, From, State) ->
    try
	{ok, Mod:handle_call(Msg, From, State)}
    catch
	throw:R ->
	    {ok, R};
	error:R ->
	    Stacktrace = erlang:get_stacktrace(),
	    {'EXIT', {R, Stacktrace}, {R, Stacktrace}};
	exit:R ->
	    Stacktrace = erlang:get_stacktrace(),
	    {'EXIT', R, {R, Stacktrace}}
    end.
    
可以看到：
> 执行gen_server:call时，最终会去调用你自己的模块里的Mod:handle_call。然后根据Mod:handle_call的返回值进入调用gen_server:reply将返回值发回给From，并重新进入gen_server:loop循环等待下一次发送过来的消息。

> 这里的:
>
* Mod: 你自己实现gen_server behavior的模块名
* Msg: 调用gen_server:call时的Request参数
* From: 调用gen_server进行的self()
* State: gen_server的State值   


##gen_server:cast

gen_server:cast和gen_server:call基本是一样的，只不过它会创建一个新进程去执行erlang:send，而不用阻塞。

###概述

####定义和参数
	cast({global,Name}, Request) ->
	    catch global:send(Name, cast_msg(Request)),
	    ok;
	cast({via, Mod, Name}, Request) ->
	    catch Mod:send(Name, cast_msg(Request)),
	    ok;
	cast({Name,Node}=Dest, Request) when is_atom(Name), is_atom(Node) -> 
	    do_cast(Dest, Request);
	cast(Dest, Request) when is_atom(Dest) ->
	    do_cast(Dest, Request);
	cast(Dest, Request) when is_pid(Dest) ->
	    do_cast(Dest, Request).

####工作流

	%%% The work flow (of the server) can be described as follows:
	%%%
	%%%   User module                          Generic
	%%%   -----------                          -------
	%%%     handle_cast      <-----              .
	

####Mod:handle_cast
	%%%   handle_cast(Msg, State)
	%%%
	%%%    ==> {noreply, State}
	%%%        {noreply, State, Timeout}
	%%%        {stop, Reason, State} 
	%%%              Reason = normal | shutdown | Term terminate(State) is called

####gen_server:cast工作流程图
(个人认为这图有问题，大体是对的)
![gen_server:cast工作流程图](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/erlang-gen_server-cast.png)

###gen_server:do_cast

	do_cast(Dest, Request) -> 
    do_send(Dest, cast_msg(Request)),
    ok.
    
	cast_msg(Request) -> {'$gen_cast',Request}.
	
	do_send(Dest, Msg) ->
	    case catch erlang:send(Dest, Msg, [noconnect]) of
		noconnect ->
		    spawn(erlang, send, [Dest,Msg]);
		Other ->
		    Other
	    end.	

从这里可以看到创建了一个新进程*spawn(erlang, send, [Dest,Msg])*,所以gen_server:cast不会阻塞，是异步执行的。

同样的gen_server:loop在收到erlang:send发送的Msg后，就会去做相应的处理。

处理gen_server:cast时，与gen_server:call类似：
	
	gen_server:loop -> gen_server:decode_msg -> gen_server:hangle_msg
	
	handle_msg(Msg, Parent, Name, State, Mod, Debug) ->
    	Reply = try_dispatch(Msg, Mod, State),
    	handle_common_reply(Reply, Parent, Name, Msg, Mod, State, Debug).
	
	try_dispatch({'$gen_cast', Msg}, Mod, State) ->
	    try_dispatch(Mod, handle_cast, Msg, State);
	try_dispatch(Info, Mod, State) ->
	    try_dispatch(Mod, handle_info, Info, State).
	
	try_dispatch(Mod, Func, Msg, State) ->
	    try
		{ok, Mod:Func(Msg, State)}
	    catch
		throw:R ->
		    {ok, R};
		error:R ->
		    Stacktrace = erlang:get_stacktrace(),
		    {'EXIT', {R, Stacktrace}, {R, Stacktrace}};
		exit:R ->
		    Stacktrace = erlang:get_stacktrace(),
		    {'EXIT', R, {R, Stacktrace}}
	    end.
	    
	handle_common_reply(Reply, Parent, Name, Msg, Mod, State) ->
	   case Reply of
		{ok, {noreply, NState}} ->
		    loop(Parent, Name, NState, Mod, infinity, []);
		
		...
	   end.	  
	    

可以看到，

> 执行gen_server:cast(gen_server:info也是一样)时，最终会去调用你自己的模块里的Mod:handle_cast。然后根据Mod:handle_cast的返回值手动调用handle_comman_reply将返回值发回给From，并重新进gen_server:loop循环等待下一次发送过来的消息。


##gen_server:info和gen_server:stop

gen_server:info和gen_server:cast类似，就不在分析了。

gen_server:stop也比较简单。

####gen_sever:info流程图
![gen_server:info工作流程图](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/erlang-gen_server-info.png)

####gen_server:stop流程图
![gen_server:stop工作流程图](https://raw.githubusercontent.com/zhuwei05/blog/master/Res/erlang-gen_server-terminate.png)

##gen_server:reply

主要用于需要自己显示发送返回值给那些调用call/2,3 或multi_call/2,3,4客户端，并且其在返回值不能在call或multi_call中定义。

##gen_server:multi_call

给本地或Nodes上所有注册了Name的gen_server发gen_server:call。

##gen_Server:abcast

给本地或Nodes上所有注册了Name的gen_server发gen_server:cast。

##gen_server:enter_loop











	