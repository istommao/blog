#erlang异常
----

##运行时错误

* function_clause
	
	所有guard clauses都不成功或者是函数的所有clauses都不成功
	
* case_clause

	缺少case的某种匹配
	
* if_clause
	
	找不到if分支，类似case_clause

* badmatch

	模式匹配失败。一般是尝试第二次绑定一个变量或者是'='两边匹配。
	
* badarg

	调用函数时，参数不符
	
* undef

	调用一个没有定义的函数。检查函数有没有被export，模块和函数名拼写有没有错，以及erlang search path是否设置正确。code:add_path/1和code:add_pathz/1
	
* badarith

	进行不正确的算术操作
	
* badfun

	大多时候是由于将一个非函数的变量作为函数使用
	
* badarity

	是badfun的一种特殊case，当你使用高阶函数，却传给一个低阶的函数
	
* system_limit

	超过一些系统的限制，比如太多原子，原子数太长或函数参数太多
	
##异常产生

* errors

	调用erlang:error(Reason)，终止当前的程序，通过catch可以获取stack trace

* throws

	throw是异常类。用于处理程序员对异常进行处理。
	语法：
		throw(permission_denied).
	

* exits

	两种exit，内部和外部。内部exit通过调用exit/1触发，并使当前程序停止。外部exit通过调用exit/2触发。

##异常处理

	try Expression of
		SuccessfulPattern1 [Guards] ->
			Expression1;
		SuccessfulPattern2 [Guards] ->
			Expression2
	catch
		TypeOfError:ExceptionPattern1 ->
			Expression3;
		TypeOfError:ExceptionPattern2 ->
			Expression4
	end.
	
	TypeOfError是throw，error或exit其中之一，如果没有，默认为throw。当然如果想要获取所有，可以使用"_:_"
	
	当然也有附加的after子句：
	
	try Expr of
		Pattern -> Expr1
	catch
		Type:Exception -> Expr2
	after % this always gets executed
		Expr3
	end

	Expression可以包含多个表达式。当存在多个表达式的时候，of部分往往变得不太重要，这时候可以省略。变为类似这样的：
	try Expressions
	cath
		Exception:Reasion -> {caugth, Exception, Reason}
	end.	

	还有另外的处理结构：
		catch Expression或者
		case catch Expression of
			...
	
	
	
	
	
	
	
	

	
	




