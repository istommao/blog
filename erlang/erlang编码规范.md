#erlang编码规范
====
##模块组成顺序

	-module
	-behaviour
	-export([a/1
			,b/0
			,...
			]).
	-include
	-define
	-record
	-type
	
	%% export functions
	
	%% callbacks
	
	%% Internal functions

##变量：单词首字母大写

	SomeVar

##宏定义：全大写+下划线分隔

	MACRO_KEY
	
##函数名:小写+下划线分隔

	function_test	


##-spec,-type

	%% 限定函数的参数和返回值
	-spec start_link(atom(), list() | wh_timeout()) -> startlink_ret().
	
	%% 定义自己的类型
	-type startlink_err() :: {'already_started', pid()} | 'shutdown' | term().
	-type startlink_ret() :: {'ok', pid()} | 'ignore' | {'error', startlink_err()}.
	
	%% 定义回调函数的类型
	-type callback_fun() :: fun((_, _, 'flush' | 'erase' | 'expire') -> _).
	
## 记录

### 定义记录

	-record(websocket_context, {
           auth_token = <<>> :: binary() | 'undefined'
          ,auth_account_id :: api_binary()
          ,account_id :: api_binary()
          ,binding :: api_binary()
          ,websocket_session_id :: api_binary()
          ,websocket_pid :: api_pid()
         }).
         
         
	
	
	