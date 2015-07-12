#kazoo各个模块的结构和作用
====

##acdc
----
作用：处理座席和队列的事件，并统计座席和队列的一些状态信息


----

##blackhole
-----
作用：通过websocket（socketio和cowboy）可以订阅一些事件，在kazoo产生这些事件时，可以将消息经过websocket发给客户端。

-----

##Camper
----
作用：监听<<"delegate">>, <<"job">>

---

##cccp（calling card callback platform）
---
电话卡回拨平台？将自己的呼叫CID隐藏，使用代理的CID（比如office里的号码）。将长途电话费用转嫁给公司号码

作用：处理电话卡打电话的事件，监听各种call_event和CHANNEL_ANSWER,CHANNEL_DESTROY等事件

方式：通过启动两个监听：cccp_platform_listener(call_event)，cccp_callback_listener(CHANNEL_DESTROY和CHANNEL_ANSWER)

---

##callflow
====
	callflow_sup:
		worker-->cf_shared_listener
		worker-->cf_listener
		sup-->cf_event_handler_sup
		sup-->cf_exe_sup
		
	1.cf_shared_listener
	监听presence和notification事件，调用cf_util模块作为responder.
	
	2.cf_listener
	监听dialplan的route_req和route_win事件，调用cf_route_req和cf_route_win模块作为responder
	
	cf_route_req:收到route_req请求，去DB查找对应user和accountid的callflow	
	
	3.
	


====

##ecallmgr
---

	ecallmgr_sup: 
		worker-->wh_nodes
		worker-->ecallmgr_init
		sup   -->ecallmgr_auxiliary_sup
		sup   -->ecallmgr_call_sup
					
	1.
	ecallmgr_init: 获取ecallmgr的cookie和log的等级
	
	2.
	ecallmgr_auxiliary_sup: 开启3个缓存，启动工作进程ecallmgr_registrar，以及督促ecallmgr_originate_sup
		ecallmgr_registrar: 监听reg_query（从ets表里查询注册信息）、reg_success（注册成功，写入到ets表里）和reg_flush（清除ets表信息）事件，也提供直接显示ets表信息的接口
		ecallmgr_originate_sup: 动态启动每个子进程ecallmgr_originate
		ecallmgr_originate: 监听dialplan和call_event事件
	
	3.ecallmgr_call_sup:动态添加ecallmgr_call_event_sup和ecallmgr_call_control_sup
		sup --> ecallmgr_call_event_sup
		sup --> ecallmgr_call_control_sup
	3.1 ecallmgr_call_event_sup
		worker --> ecallmgr_call_events
		
		ecallmgr_call_events:接收FS发送的call events，并将其发送到call event队列里。
		
	3.2 ecallmgr_call_control_sup
		worker --> ecallmgr_call_control
		
		ecallmgr_call_control: 接收AMQP消息，将其JSON格式转为proplist，然后将这些call commands添加到命令队列CmdQ里，逐个执行。
		
		
	
	4.
	ecallmgr_fs_sup 
		worker---> ecallmgr_fs_nodes:管理fs节点的添加删除，
		worker---> ecallmgr_fs_channels:记录fs的channel信息，并将其信息存储在ets里
		worker---> ecallmgr_fs_conferences:记录conference信息，并将其信息存储在ets里
		sup---> ecallmgr_fs_pinger_sup
		sup---> 动态添加ecallmgr_fs_node_sup
		
       		        
    	4.1   		        
    	ecallmgr_fs_pinger_sup ---worker---> 动态添加ecallmgr_fs_pinger
    	ecallmgr_fs_pinger: 监控节点状态，周期性去检测
    
    	4.2
    	ecallmgr_fs_node_sup 
    		worker---> 启动其他以ecallmgr_fs开头的模块
    		sup---> ecallmgr_fs_event_stream_sup：动态创建ecallmgr_fs_event_stream
    		
    	
    	4.2.1
    	ecallmgr_fs_authn: 查找FS的目录
    	ecallmgr_fs_authz: 认证请求         
		ecallmgr_fs_bridge: 建立FS的bridge
		ecallmgr_fs_channel: 处理channel的请求，转成FS的XML，并从FS获取结果
		ecallmgr_fs_channels: 监听查询channel和channel统计的消息，并记录到ets里
		ecallmgr_fs_command: 
		ecallmgr_fs_conference: 监听会议的command，执行并发送执行结果到MQ
		ecallmgr_fs_conferences: 监听查询conference的信息，并记录到ets里
		ecallmgr_fs_config: 给FS发送配置命令
		ecallmgr_fs_msg: 接收和处理通知事件的请求，比如MWI更新等
		ecallmgr_fs_node: 管理FS的节点和资源
		ecallmgr_fs_nodes: 
		ecallmgr_fs_notify: 接收和处理通知事件的请求，
		ecallmgr_fs_resource: 处理orginate的请求，启动ecallmgr_originate_sup
		
		ecallmgr_originate_sup：动态创建子进程ecallmgr_originate
		ecallmgr_originate：监听<<"dialplan">>, <<"originate_execute">>和<<"call_event">>, <<"*">>,并调用freeswtich相关函数执行，把结果发到MQ
		ecallmgr_fs_route：接收和处理route（dialplan）请求（调用freeswitch:bind）。回去调用ecallmgr_call_sup:start_event_process和ecallmgr_call_sup:start_control_process
		ecallmgr_fs_xml：为不同的FS响应产生对应的XML
		ecallmgr_registrar：监听注册成功和查询事件
		  
		
		
					
		
	5. wh_nodes:存储节点信息到ets表中
---



