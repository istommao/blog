#1.简介
pycurl是curl的一个python版本。默认的安装python后，并没有安装pycurl，需要自己去安装。网上找到pycurl源码包，解压后运行：python setup.py install即可。

#2.pycurl的使用说明
pycurl的使用主要是一些参数的设定。

```
1. c.setopt(pycurl.URL,myurl)  
    设定链接的地址
2. c.setopt(pycurl.HTTPHEADER,['Content-Type: application/json','Content-Length: '+str(len(remove_str))])
    设置http的包头信息。注意.长度的字符传是用于put或者post等方法传参数的。
3. c.setopt(pycurl.CUSTOMREQUEST,"DELETE")
    设置封装方法.有put.post.get.delete等多种方法
4. c.setopt(pycurl.POSTFIELDS,remove_str)
    设置psot过去的数据.注意是一个字典样式的字符串
5. c.setopt(pycurl.WRITEFUNCTION,b.write)
   c.setopt(pycurl.FOLLOWLOCATION, 1)
    设置写的回调.所有输出都定向到b.write中。
6. c.setopt(pycurl.MAXDEDIRS,5)
    设置重定向次数
7. c.setopt(pycurl.CONNECTTIMEOUT,60)
   c.setopt(pycurl.TIMEOUT,600)
    设置链接超时.设置下载超时
8. c.setopt(pycurl.USERAGENT,"xxxx")
    设置代理浏览器
9. c.setopt(pycurl.HEADER,1)
    开启包头输出
   c.setopt(pycurl.HEADERFUNCTION,header_str.write)
    将包头输出到header_str.write流中
10. c.perform()
     执行curl命令
11. print b.getvalue()打印消息
12.  print c.getinfo(c.HTTP_CODE)   //答应返回值
     print c.getinfo(c.CONTENT_TYPE)  //打印文本类型
     print c.getinfo(c.EFFECTIVE_URL)  //打印重定向URL
```
#3.pycurl封装HTTP的GET和POST方法
```
def pycurl_get_data(curl_obj, url, header):
    buf = StringIO.StringIO()
    curl_obj.setopt(pycurl.WRITEFUNCTION, buf.write)
 
    curl_obj.setopt(pycurl.URL, url)
    curl_obj.setopt(pycurl.HTTPHEADER, header)
 
    curl_obj.perform()
 
    json_data = buf.getvalue()
    buf.close()
    return json.loads(json_data)
    
def pycurl_post_data(curl_obj, url, header, data):
    buf = StringIO.StringIO()
    curl_obj.setopt(pycurl.WRITEFUNCTION, buf.write)
 
    curl_obj.setopt(pycurl.POSTFIELDS, data)
    curl_obj.setopt(pycurl.URL, url)
    curl_obj.setopt(pycurl.HTTPHEADER, header)
 
    curl_obj.perform()
 
    json_data = buf.getvalue()
    buf.close()
    return json.loads(json_data)
``` 
