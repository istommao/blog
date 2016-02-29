title: cowboy websocket
date: 2016-02-29 17:21:21
tags:
- cowboy
- websocket

-----


# cowboy实现websocket服务端

cowboy和ranch实现websocket的服务端，通过调用`cowboy:start_http`的完成。其流程如下：

![cowboy实现websocket](http://image17-c.poco.cn/mypoco/myphoto/20160229/16/17349718220160229165823019_640.jpg?1719x831_130)

代码example：参考cowboy的example中的[例子(cowboy1.0.x)](https://github.com/ninenines/cowboy/blob/1.0.x/examples%2Fwebsocket%2Fsrc%2Fws_handler.erl)。

稍作修改：


	-module(ws_handler).
	-author("zhuwei").
	-behaviour(cowboy_websocket_handler).
	
	-export([init/3]).
	-export([websocket_init/3]).
	-export([websocket_handle/3]).
	-export([websocket_info/3]).
	-export([websocket_terminate/3]).
	
	-record(config, {heartbeat,
	                 heartbeat_timeout
	                 opts}
	).
	
	
	init({tcp, http}, _Req, _Opts) ->
	    {upgrade, protocol, cowboy_websocket}.
	
	%% Websocket handlers
	websocket_init(_TransportName, Req, Opts) ->
	    {{IP, _}, _} = cowboy_req:peer(Req),
	    _ClientIP = wh_util:to_binary(inet_parse:ntoa(IP)),
	    Config = configure(Opts),
	    erlang:start_timer(Config#config.heartbeat, self(), <<"Hello!">>),
	    %% 设置timeout
	    {ok, Req, configure(Opts), Config#config.heartbeat_timeout}.
	
	websocket_handle({text, Msg}, Req, State) ->
	    {reply, {text, << "That's what she said! ", Msg/binary >>}, Req, State};
	websocket_handle(_Data, Req, State) ->
	    {ok, Req, State}.
	
	websocket_info({timeout, _TRef, Msg}, Req, #config{heartbeat = Heartbeat} = State) ->
	    erlang:start_timer(Heartbeat, self(), <<"How' you doin'?">>),
	    {reply, {text, Msg}, Req, State};
	websocket_info(_Info, Req, State) ->
	    {ok, Req, State}.
	
	websocket_terminate(Reason, Req, _State) ->
	    ok.
	
	
	configure(Opts) ->
	    #config{heartbeat = proplists:get_value(heartbeat, Opts, 5000),
	            heartbeat_timeout = proplists:get_value(heartbeat_timeout, Opts, 30000),
	            opts = proplists:get_value(opts, Opts, undefined)
	    }.
	

增加Opts参数：


	Dispatch = cowboy_router:compile([
			{'_', [
				{"/", cowboy_static, {priv_file, websocket, "index.html"}},
				{"/websocket", ws_handler, [{'heartbeat', 5000},
                                                                            {'heartbeat_timeout', 30000}]},
				{"/static/[...]", cowboy_static, {priv_dir, websocket, "static"}}
			]}
		]),



## 参考

* [cowboy_websocket_handler](http://ninenines.eu/docs/en/cowboy/1.0/manual/cowboy_websocket_handler/)
* [Handling Websocket connections](http://ninenines.eu/docs/en/cowboy/HEAD/guide/ws_handlers/)
* [cowboy之routing笔记](https://github.com/zhuwei05/blog/blob/master/erlang/cowboy%E4%B9%8Brouting%E7%AC%94%E8%AE%B0.md)
