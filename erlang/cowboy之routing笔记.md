title: Cowboy之routing笔记
date: 2016-02-29 17:30:30
tags: 
- cowboy
- routing
- route

-----



# Cowboy之routing笔记
----

## 简介
cowboy默认什么都不做，要想cowboy可以处理请求，需要将URLs映射到用于处理请求的Erlang模块中。这个过程称为routing。

当cowboy收到一个request，它会尝试比较请求中的host和path是否和routing指定的dispatch rules一致。如果一致，相应的Erlang代码就会执行。

每个host都可以有多个routing rules。Cowboy会先根据host去match，然后在找一个匹配的path。

Routes要先在Cowboy中compile，然后才可以使用。


## Routes的结构

主要由Hosts、Paths构成。

Routes可以包含多个Host

	Routes = [Host1, Host2, ... HostN].

每个Host包括匹配的规则，以及可选constrains，结构为：

	Host1 = {HostMatch, PathsList}.
	Host2 = {HostMatch, Constraints, PathsList}.
	
PathsList的组成和Hosts的组成类似：

	Path1 = {PathMatch, Handler, Opts}.
	Path2 = {PathMatch, Constraints, Handler, Opts}.

## Match的语法

Match语法用来将host names、paths与它们各自的handles关联起来。

Host和Path的语法基本一致，只有细微的差别。

最简单的格式：

	PathMatch1 = "/".
	PathMatch2 = "/path/to/resource".
	
	HostMatch1 = "cowboy.example.org".

Path定义必须以斜线** '/' **开头。

而且在最后有没有斜线** '/'  **都是一样的，比如下面两个就是一样的。
	
	PathMatch2 = "/path/to/resource".
	PathMatch3 = "/path/to/resource/".
	
类似的，对Host来说，前后有没有句点** '.'  **都是一样的。下面三个Host都是一样的。

	HostMatch1 = "cowboy.example.org".
	HostMatch2 = "cowboy.example.org.".
	HostMatch3 = ".cowboy.example.org".	
	
通过使用冒号** ':' **，可以将host和path的一部分（segment）提取并保存起来，这种方式成为bingding。

比如：

	PathMatch = "/hats/:name/prices".
	HostMatch = ":subdomain.example.org".

当我们的URL是：
	
	http://test.example.org/hats/wild_cowboy_legendary/prices
	
那么 
	
		test就绑到subdomain，
		而wild_cowboy_legendary就被绑到name。
		
之后，我们可以通过**cowboy_req:binding/{2,3}**取回这两个值。

特殊的bingding名字：**'_'**。它可以binging对应的segment，但是并不会存储起来。这个方法在有很多不同的域名的时候很有用。比如：

	HostMatch = "ninenines.:_".
	
类似的，存在可选的segments，比如：

	PathMatch = "/hats/[page/:number]".
	HostMatch = "[www.]ninenines.eu".
	
还可以嵌套使用：

	PathMatch = "/hats/[page/[:number]]".		
可以通过** [...] **去match在host前面的所有部分，或者是path后面的所有部分。

	PathMatch = "/hats/[...]".
	HostMatch = "[...]ninenines.eu".

如果一个bingding多次出现，它们必须保证所得的值都一样才可以成功的match。

在host match中还有一个特殊的符号：** \* **。它是通配的，可以匹配所有的路径，一般和OPTIONS方法搭配使用。



## Constrains

在完成matching后，产生的bindings可以通过constraints进行测试。只有定义了binding之后，constrains测试才会进行。它们会根据定义的顺序有序进行，只有全部成功后，匹配才成功。

constrains一般都是2或3的元组。第一个元素是bingding的名字，第二个元素是constrain的名字，可选的第三个元素是constrain的参数。

	{Name, int}
	{Name, function, fun ((Value) -> true | {true, NewValue} | false)}	
	
## Compilation
Routes要先在Cowboy中compile，然后才可以使用。使用cowboy_router:compile/1进行compile。

来看例子：

	Dispatch = cowboy_router:compile([
    	%% {HostMatch, list({PathMatch, Handler, Opts})}
    	{'_', [{'_', my_handler, []}]}
	]),
	%% Name, NbAcceptors, TransOpts, ProtoOpts
	cowboy:start_http(my_http_listener, 100,
    	[{port, 8080}],
    	[{env, [{dispatch, Dispatch}]}]
	).	

如果structure不正确，这个函数会返回{error, badarg}。

## 在线更新

可以通过cowboy:set_env/3在线更新dispatch。

	cowboy:set_env(my_http_listener, dispatch,
    		cowboy_router:compile(Dispatch)).	
	
## Cowboy和socket.io实例


	Dispatch = cowboy_router:compile([
                                      {'_', [
                                             {"/socket.io/1/[...]", socketio_handler, [socketio_session:configure([{heartbeat, 5000},
                                                                                                                   {heartbeat_timeout, 30000},
                                                                                                                   {session_timeout, 30000},
                                                                                                                   {callback, ?MODULE},
                                                                                                                   {protocol, socketio_data_protocol}])]},
                                             {"/[...]", cowboy_static, [
                                                                        {directory, <<"./priv">>},
                                                                        {mimetypes, [
                                                                                     {<<".html">>, [<<"text/html">>]},
                                                                                     {<<".css">>, [<<"text/css">>]},
                                                                                     {<<".js">>, [<<"application/javascript">>]}]}
                                                                       ]}
                                            ]}
                                     ]),

    
    cowboy:start_http(socketio_http_listener, 100, [{host, "127.0.0.1"},
                                                    {port, 8080}], [{env, [{dispatch, Dispatch}]}]).
	
	
上面的格式：

1. 有1个host
2. host里有两个path
3. hostmatch使用'_'
4. 两个path match分别为：/socket.io/1/[...]和/[...]
5. 对应的handler分别为：socketio_handler、cowboy_static
6. 剩下的最后一项是参数。


开发自己的websocket模块需要注意的几点：

1. 端口号要能用；
2. 要实现自己的callback模块；
3. 要实现自己的'socketio_handler'；
4. 使用自己的线程'‘socketio_http_listener'

## 参考

* [Routing](http://ninenines.eu/docs/en/cowboy/HEAD/guide/routing/)
* [cowboy_router](http://ninenines.eu/docs/en/cowboy/HEAD/manual/cowboy_router/)
	

