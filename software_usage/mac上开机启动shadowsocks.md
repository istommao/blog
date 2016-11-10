title: mac上开机启动shadowsocks
date: 2016-11-10 09:58:00
tags:
- mac
- shadowsocks

# mac上开机启动shadowsocks

打开终端：`cd ~/Library/LaunchAgents`

编写脚本，保存为`~/Library/LaunchAgentsshadowsocks.plist`

```
<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
        "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>Label</key>
        <string>shadowsocks</string>
        <key>ProgramArguments</key>
        <array>
        <string>/Applications/ShadowsocksX.app/Contents/MacOS/ShadowsocksX</string>
        <string>-startup</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
    </plist>
```

加载脚本：

	launchctl load ~/Library/LaunchAgents/shadowsocks.plist
	
如果想要停止服务：

	launchctl unload ~/Library/LaunchAgents/shadowsocks.plist


## 参考

* [如何让SHADOWSOCKS在MAC上自动启动](http://www.wuliaole.com/post/how_to_setup_automatic_load_for_shadowsocks_on_mac/)


