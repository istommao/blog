#kazoo节点使用erlang的appmon/observer


1. 在本地，启动erlang节点，任意命名节点名位aaa

		erl -name aaa
	
2. 在本地，设置要监控节点的cookie。首先查找到监控节点的cookie，比如为xyz。
	
		erlang:set_cookie(node(), 'xyz').
		
3. 在kazoo节点（服务器），获取终端节点的名字

		执行
		/opt/kazoo/scripts/conn-to-apps.sh
		输入：nodes().
		
	
4. 在本地，启动appmon或observer
 		
 		先测试ping，参数为步骤3获得的结果
 		
		net_adm:ping('whistle_con_abcd@xxx').
	
		appmon:start(). 或
		observer:start().
		
		
	
	

	