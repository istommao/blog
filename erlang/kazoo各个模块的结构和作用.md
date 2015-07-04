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

##ecallmgr
---

	ecallmgr_fs_sup ---worker---> ecallmgr_fs_nodes:管理fs节点的添加删除，
       		        ---worker---> ecallmgr_fs_channels:记录fs的channel信息，并将其信息存储在ets里
       		        ---worker---> ecallmgr_fs_conferences:记录conference信息，并将其信息存储在ets里
       		        ---sup---> ecallmgr_fs_pinger_sup
       		        ---sup---> 动态添加ecallmgr_fs_node_sup
       		        
       		        
    ecallmgr_fs_pinger_sup ---worker---> 动态添加ecallmgr_fs_pinger
    ecallmgr_fs_node_sup ---worker---> 启动其他以ecallmgr_fs开头的模块         


---



