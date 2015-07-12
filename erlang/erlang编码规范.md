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

	