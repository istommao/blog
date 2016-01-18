# eunit

## 操作

新建一个test目录，在目录中，新建测试文件，文件名以`_test`结尾，比如`abc_test.erl`, 在文件中导入：

	-include_lib("eunit/include/eunit.hrl").
	
然后编写单元测试，可以将所有的单元测试汇总到函数`test()`中，也可以对每个单元测试的函数的名字也`_test`结束，这样erlang会自动帮你export出这些函数并执行，不需要自己去export。比如：

	length_test() -> ?assert(length([1,2,3]) =:= 3).
	
这样就可以直接编译该文件(不需要export，在编译的时候erlang会自动为你导出test函数)，然后执行单测了：

	# erlc abc_test.erl
	# erl
	> eunit:test(abc)
	或者：
	> abc_test:length_test().
	
其中： 

1. erlc 是编译命令，erlc *.erl表示编译当前目录下所有erlang源文件； 
2. eunit:test(Module) 执行某个module的单元测试 

如果按照app的路径存放的话：
	
	├── Makefile
	├── doc
	├── ebin
	├── priv
	├── src
	└── test

在编译时，其指令为：

	-o 参数用来指定编译后的字节码存放目录（这里是ebin） 
	-pa参数用来指定执行文件（.beam）目录 
	
makefile中增加类似如下的设置：

	test/$(PROJECT).app: src/*.erl src/module/*.erl test/*.erl
		@mkdir -p test/
		erlc -v $(ERLC_OPTS) -DTEST -o test/ -pa test/ $?

	eunit: compile-test
		erl -noshell $(PA) -pa test -eval "case eunit:test([$(TEST_MODULES),$(MODULES),$(CF_MODULES)], [verbose]) of 'ok' -> init:stop(); _ -> init:stop(1) end."

	
具体makefile的模板，可参考开源软件`kazoo`的各个`app`的[makefile](https://github.com/zhuwei05/blog/blob/master/erlang/erlang%E7%9A%84makefile%E6%A8%A1%E6%9D%BF.md)

如此设置后，通过执行：

	make test

即可完成编译和执行相应的单测。

## 参考

* [Erlang单元测试](http://diaocow.iteye.com/blog/1753416)
* <http://www.erlang.org/doc/man/eunit.html>
			
	
		
			