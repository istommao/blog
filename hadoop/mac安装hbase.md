# mac 安装 hbase



## 安装

`brew install hbase`

hbase文件安装在`/usr/local/Cellar/hbase`下面，文件名根据安装版本不同而不同. 比如我自己的安装目录为: `/usr/local/Cellar/hbase/1.2.6`

## 修改配置（可选）

### java home

```
cd /usr/local/Cellar/hbase/1.2.6
vim libexec/conf/hbase-env.sh
```

默认为:

```
# The java implementation to use.  Java 1.7+ required.
export JAVA_HOME="$(/usr/libexec/java_home)"
```

可以修改为你自己的 java 路径

### 存储路径

```
vim libexec/conf/hbase-site.xml
```

默认为:

```
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>file:///usr/local/var/hbase</value>
  </property>
  ...
```



## 启动&暂停

```
./bin/start-hbase.sh
```

### 验证是否安装成功

```
jps
```

出现HMaster说明安装运行成功。

### 启动HBase Shell

```
./bin/hbase shell
```

#### 停止HBase

```
./bin/stop-hbase.sh
```



## python 连接

启动 thrift server

`./bin/hbase thrift start`

安装 happybase: `pip install happybase`



连接：

```
import happybase
connection = happybase.Connection('127.0.0.1')
```

