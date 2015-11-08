#Python运行系统命令

可以使用os模块的system或popen执行系统命令。

	import os
	
	def running_system_cmd(command):
	    # os.system(command)
	    return os.popen(command).read()