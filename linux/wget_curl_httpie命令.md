title: wget_curl_httpie命令
date: 2017-07-05 16:21:00
tags:
- wget
- curl
- httpie

# wget_curl_httpie命令

## 代理

* `wget -e "http_proxy=porxyhost:port" www.baidu.com`
* `curl -x proxyhost:port www.baidu.com `
* `curl --socks5 125.119.175.48:8909 http://example.com/`

如果需要用户名密码，格式

`curl -x "http://user:pwd@host:port" www.baidu.com`

在Linux的命令行底下，一般的程序都是使用 `http_proxy` 和`https_proxy` 这两个环境变量来获得代理设置的

