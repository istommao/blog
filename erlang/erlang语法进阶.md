#erlang语法进阶

##二进制拼接

	Old = <<"join">>,
	New = <<Old/binary, "_together">>,
	io:format("Old: ~p, New: ~p", [Old, New]).
	
##列表操作

	[H|T],这种方法要求T必需为一个列表，否则大部分情况下出错。
	ThingsToBuy = [{<<"apple">>, 10}, {<<"pears">>, 6}].
	ThingsToBuy1 = [{<<"oranges">>, 4} | ThingsToBuy].	