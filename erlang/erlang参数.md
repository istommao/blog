title: erlang参数
date: 2016-03-28 12:27:30
tags:
- erlang
- env
- emfile
- ulimit

# erlang参数
---

进行性能测试，可能遇到的端口号不够或文件描述符不够的情况：

	+P 200000   // erlang最大进程数
	-env ERL_MAX_PORTS 4096   // erlang最大端口号
	
参看erlang虚拟机的信息：

	erlang:system_info(process_limit).
	erlang:system_info(check_io).
	erlang:length(erlang:ports()).	
	
系统参数ulimit：/etc/security/limits.conf

	* soft nproc 65535
	* hard nproc 65535
	* soft nofile 65535
	* hard nofile 65535

## 参考

* [erl](http://erlang.org/doc/man/erl.html)
* [Performance Tuning](https://www.ejabberd.im/tuning)	
* [gen_tcp接受链接时enfile的问题分析及解决](http://blog.yufeng.info/archives/1851)