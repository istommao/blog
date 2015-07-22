#Match specifications in Erlang
===

##简介
Match specification(match_spec)是erlang的一种语法，是一种用来做匹配的小“程序”。主要用在：erlang:trace_pattern/2和ets查询。

##语法格式：

###A match_spec used in tracing can be described in this informal grammar:

	MatchExpression ::= [ MatchFunction, ... ]
	MatchFunction ::= { MatchHead, MatchConditions, MatchBody }
	MatchHead ::= MatchVariable | '_' | [ MatchHeadPart, ... ]
	MatchHeadPart ::= term() | MatchVariable | '_'
	MatchVariable ::= '$<number>'
	MatchConditions ::= [ MatchCondition, ...] | []
	MatchCondition ::= { GuardFunction } | { GuardFunction, ConditionExpression, ... }
	BoolFunction ::= is_atom | is_float | is_integer | is_list | is_number | is_pid | is_port | is_reference | is_tuple | is_map | is_binary | is_function | is_record | is_seq_trace | 'and' | 'or' | 'not' | 'xor' | andalso | orelse
	ConditionExpression ::= ExprMatchVariable | { GuardFunction } | { GuardFunction, ConditionExpression, ... } | TermConstruct
	ExprMatchVariable ::= MatchVariable (bound in the MatchHead) | '$_' | '$$'
	TermConstruct = {{}} | {{ ConditionExpression, ... }} | [] | [ConditionExpression, ...] | #{} | #{term() => ConditionExpression, ...} | NonCompositeTerm | Constant
	NonCompositeTerm ::= term() (not list or tuple or map)
	Constant ::= {const, term()}
	GuardFunction ::= BoolFunction | abs | element | hd | length | node | round | size | tl | trunc | '+' | '-' | '*' | 'div' | 'rem' | 'band' | 'bor' | 'bxor' | 'bnot' | 'bsl' | 'bsr' | '>' | '>=' | '<' | '=<' | '=:=' | '==' | '=/=' | '/=' | self | get_tcw
	MatchBody ::= [ ActionTerm ]
	ActionTerm ::= ConditionExpression | ActionCall
	ActionCall ::= {ActionFunction} | {ActionFunction, ActionTerm, ...}
	ActionFunction ::= set_seq_token | get_seq_token | message | return_trace | exception_trace | process_dump | enable_trace | disable_trace | trace | display | caller | set_tcw | silent

###A match_spec used in ets can be described in this informal grammar:

	MatchExpression ::= [ MatchFunction, ... ]
	MatchFunction ::= { MatchHead, MatchConditions, MatchBody }
	MatchHead ::= MatchVariable | '_' | { MatchHeadPart, ... }
	MatchHeadPart ::= term() | MatchVariable | '_'
	MatchVariable ::= '$<number>'
	MatchConditions ::= [ MatchCondition, ...] | []
	MatchCondition ::= { GuardFunction } | { GuardFunction, ConditionExpression, ... }
	BoolFunction ::= is_atom | is_float | is_integer | is_list | is_number | is_pid | is_port | is_reference | is_tuple | is_map | is_binary | is_function | is_record | is_seq_trace | 'and' | 'or' | 'not' | 'xor' | andalso | orelse
	ConditionExpression ::= ExprMatchVariable | { GuardFunction } | { GuardFunction, ConditionExpression, ... } | TermConstruct
	ExprMatchVariable ::= MatchVariable (bound in the MatchHead) | '$_' | '$$'
	TermConstruct = {{}} | {{ ConditionExpression, ... }} | [] | [ConditionExpression, ...] | #{} | #{term() => ConditionExpression, ...} | NonCompositeTerm | Constant
	NonCompositeTerm ::= term() (not list or tuple or map)
	Constant ::= {const, term()}
	GuardFunction ::= BoolFunction | abs | element | hd | length | node | round | size | tl | trunc | '+' | '-' | '*' | 'div' | 'rem' | 'band' | 'bor' | 'bxor' | 'bnot' | 'bsl' | 'bsr' | '>' | '>=' | '<' | '=<' | '=:=' | '==' | '=/=' | '/=' | self | get_tcw
	MatchBody ::= [ ConditionExpression, ... ]
	
简单来说：由3部分组成

* 第一部分是匹配的头（内容），其主要通过`$<number>`作为变量表示。
* 第二部分是条件
* 第三部分是返回值。有两种特殊的返回值`$_`表示返回匹配的整条结果，`$$`按变量的顺序返回。

##举例

<http://www.erlang.org/doc/apps/erts/match_spec.html>

三个参数，且1、3相等

	[{['$1', '_', '$1'],
	  [],
	  []}]

第一个参数为元组，且元组第一个值为列表，且列表的头是第二个参数的2倍

	[{['$1', '$2'],[{'=:=', {'*', 2, '$2'}, {hd, {element, 1, '$1'}}}],
	  []}]

3个参数，且若第三个参数是一个元组，则由第一二参数组成，若为列表，则列表开始为第一二参数

	[{['$1', '$2', '$3'],
	  [{orelse, 
	      {'=:=', '$3', {{'$1','$2'}}},
	      {'and', 
	        {'=:=', '$1', {hd, '$3'}},
	        {'=:=', '$2', {hd, {tl, '$3'}}}}}],
	  []}]

在ets表中，参数大于1，且第一个元素为gandalf,则返回第二个元素

	[{'$1',
	  [{'==', gandalf, {element, 1, '$1'}},{'>=',{size, '$1'},2}],
	  [{element,2,'$1'}]}]

匹配一个元组，第二个参数为merry或pipin

	[{{'_',merry,'_'},
	  [],
	  ['$_']},
	 {{'_',pippin,'_'},
	  [],
	  ['$_']}]

返回的是符合条件的整条数据记录

	ets:new(task_table, [set, protected,named_table, {keypos, 1}]),
	ets:insert(task_table ,{1, "hi", 100 }),
	ets:insert(task_table ,{2, "hi", 200 }),
	ets:insert(task_table,{3, "ab",300}),

	ets:select(task_table,[{{'_', "hi", '_'},[],['$_']}]).
 	[{1,"hi",100},{2,"hi",200}]

'$$'符号,它的作用是按照顺序输出所有变量

	ets:select(task_table,[{{'$2', "hi", '$1'},[],['$$']}]).
	[[100,1],[200,2]]
	
	 ets:select(task_table,[{{'$3', "hi", '$1'},[],['$$']}]).
	[[100,1],[200,2]]	


##Math_spec函数

	ets:fun2ms/1
	ets:test_ms/2








