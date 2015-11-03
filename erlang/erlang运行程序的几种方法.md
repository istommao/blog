#erlang运行程序的几种方法

##在erlang shell中编译运行
	
	$ erl
	> c(hello).
	> hello:start().
	
##在命令提示符下编译运行

	$ erlc hello.erl
	$ erl -noshell -s hello start -s init stop
	
-noshell: 启动erlang，但关闭shell

-s hello start: 运行函数hello:start()。apply(hello, start, [])

##当作escript脚本运行

	#!/usr/bin/env escript
	
	main(_) ->
		io:format("Hello world\n").
		
	$ ./hello	
	
如果需要在命令行传参：

	main([Arg])			
	
另外，如果遇到匿名函数不能通过或其他，可以添加
	
	-mode(compile).	