title: rebar使用
date: 2016-03-11 11:55:55
tags:
-rebar

# rebar使用

解决方法：
http://www.metabrew.com/article/erlang-rebar-tutorial-generating-releases-upgrades

安装rebar
git clone https://github.com/basho/rebar.git
cd rebar && make
拷贝生成的rebar文件到对应需要rebar的目录，或者将其作为全局命令拷贝到/usr/local/bin目录
     
编写rebar.config

执行编译
     rebar compile

如果有依赖，需要先执行:
     rebar get-deps
