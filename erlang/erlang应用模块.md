#Erlang应用模块
=====
#行为模式gen_fsm
=========


#应用application
=====

##OTP应用的目录结构
主要需要目录就是ebin，src，其他有doc、priv、include等

* src
包含Erlang源代码

* ebin
包含Erlang目标代码—— beam 文件。 .app 文件也放在这里。

* priv
用于应用专属文件。例如，C执行程序就放在这里。应该使用函数 code:priv_dir/1 来访问这个目录。

* include
用于包含文件。

##应用元数据src/appname.app
该文件的作用在于让系统获悉应该如何启动和停止应用，还可用于指定应用的依赖项。

基本格式：

```
{application, ch_app,
 [{description, "Channel allocator"},
  {vsn, "1"},
  {modules, [ch_app, ch_sup, ch3]},
  {registered, [ch3]},
  {applications, [kernel, stdlib, sasl]},
  {mod, {ch_app,[]}}
 ]}.

```

三元组中第二个元素是应用名称所对应的原子。

* description
简短描述，字符串。默认为 “”。

* vsn
版本号，字符串。默认为”“。

* modules
由该应用引入的所有模块。当生成启动脚本和tar文件时，将用到这个列表。一个模块必须被定义于且仅于一个应用。默认为[]。

* registered
应用中所有注册进程的名称。 systools 使用这个列表来探测在应用之间是否有名称冲突。默认为 []。

* applications
所有在此应用之前必须启动的应用。 systools 使用该列表来生成正确的启动脚本。默认为 []，但是注意任何应用都要至少依赖于 kernel 和 stdlib 。

* mod
告诉OTP系统应该如何启动应用。该参数的值是一个元组，起内容为一个模块名和一些可选的启动参数。该模块必须实现application行为模式，应用的启动就是从这个模块的start函数开始的。





##创建一个application行为模式
创建一个application模块，负责应用的启动。一般命名为:appname_app。主要就是实现启动和暂停。

e.g.

```
-module(ch_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    ch_sup:start_link().

stop(_State) ->
    ok.
```



##总结
建立一个OTP应用需要完成3件事：

* 遵循标准目录结构
* 添加用于存放应用元数据.app文件
* 创建一个application行为模式的实现模块，负责启动应用


# 创建监督者appname_sup

e.g.

```
-define(WORKER(I), {I, {I, 'start_link', []}, 'permanent', 5000, 'worker', [I]}).   
-define(CHILDREN, [?WORKER(?appname)]).

start_link() ->
    supervisor:start_link({'local', ?MODULE}, ?MODULE, []).

-spec init([]) -> sup_init_ret().
init([]) ->
    RestartStrategy = 'one_for_one',
    MaxRestarts = 5,
    MaxSecondsBetweenRestarts = 10,

    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
    {'ok', {SupFlags, ?CHILDREN}}.
    

```


监督者模块主要完成的工作：

1. 启动监督者：supervisor:start_link
2. 指明如何启动监督者及策略：

```
-define(WORKER(I), {I, {I, 'start_link', []}, 'permanent', 5000, 'worker', [I]}).


```
3. 返回监督规范：{'ok', {SupFlags, ?CHILDREN}}.


**监督者策略**：

`重启策略`

* one_for_one: 如果一个子进程终止了，仅该进程被重启。
* one_for_all: 如果一个子进程终止了，那么所有其他的子进程都被终止然后，所有的子进程都被重启，包括原来被终止的那个。

`子进程规范`

子进程规范是一个用于描述受监督者管理的进程的元组。子进程规范由6个元素组成：

* Id 是督程内部用于标识子进程规范的名称。
* StartFunc 定义了用于启动子进程的很难书调用。它是一个模块.函数.参数的元组，与 apply(M, F, A) 用的一样。
* Restart 定义了一个被终止的子进程要在何时被重启：
    1. permanent 子进程总会被重启。
    2. temporary 子进程从不会被重启。    
    3. transient 子进程只有当其被异常终止时才会被重启，即，退出理由不是 normal 。
* Shutdown 定义了一个子进程应如何被终止。
    1. brutal_kill 表示子进程应使用 exit(Child, kill) 进行无条件终止。    
    2. 一个整数超时值表示督程先通过调用 exit(Child, shutdown) 告诉子进程要终止了，然后等待其返回退出信号。如果在  指定的事件内没有接受到任何退出信号，那么使用 exit(Child, kill) 无条件终止子进程。    
    3. 如果子进程是另外一个督程，那么应该设置为 infinity 以给予子树足够的时间关闭。
* Type 指定子进程是督程还是佣程。
* Modules 应该为只有一个元素的列表 [Module]，其中 Module 是回调模块的名称，如果子进程是督程、gen_server或者gen_fsm。如果子进程是一个gen_event，那么 Modules 应为 dynamic 。 在升级和降级过程中发布处理器将用到这个信息.


#Example：在kazoo中添加自己的模块

##按照应用建立文件夹ebin、src

##编写模块的程序

##添加src下的appname.app.src文件
该文件会根据makefile，生成ebin下的appname.app文件。

```
{application, my_gen_fsm,
 [
  {description, "my gen fsm"},
  {vsn, "1"},
  {registered, []},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, {my_gen_fsm_app, []}},
  {env, []}
 ]}.

```

##编辑makefile
根据kazoo每个模块的makefile稍作修改即可。



##添加OTP行为模式application模块
```
my_gen_fsm_app.erl
start(_Type, _Args) ->
    my_gen_fsm_sup:start_link().

stop(_State) ->
    my_gen_fsm:stop().
```

##添加监督者sup模块
```
my_gen_fsm_sup.erl

-define(WORKER(I), {I, {I, 'start_link', []}, 'permanent', 5000, 'worker', [I]}).

-define(CHILDREN, [?WORKER('my_gen_fsm')
                  ]).

start_link() ->
    supervisor:start_link({'local', ?MODULE}, ?MODULE, []).


init([]) ->
    RestartStrategy = 'one_for_one',
    MaxRestarts = 5,
    MaxSecondsBetweenRestarts = 10,

    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
    
    {'ok', {SupFlags, ?CHILDREN}}.
```






