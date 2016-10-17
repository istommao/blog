title: supervisord使用
date: 2016-10-11 19:44:00
tags:
- python
- supervisor

# supervisord使用

## 环境

* centos6.5 `lsb_release -a`
* python2.7, 源码安装，路径：/opt/python27

### supervisor安装

	/opt/python27/pip install supervisor
	
	
### 配置文件

	/opt/python27/bin/echo_supervisord_conf > /etc/supervisord.conf	
	
参照生成的配置文件，在最后添加如下代码：假设要启动两个脚本：`start_server.sh`(该脚本启动web服务)和`start_celery.sh `(该脚本启动celery)

```
[program:app1_server]
command=/opt/apps/app1/scripts/start_server.sh
numprocs=1
user=zhuwei
autostart=true
autorestart=unexpected
	
[program:app1_celery]
command=/opt/apps/app1/scripts/start_celery.sh --loglevel=info
numprocs=1
user= zhuwei
autostart=true
autorestart=unexpected
	
redirect_stderr=true
stdout_logfile=/tmp/app1_celery.log
	
```

start_server.sh

```

#!/usr/bin/env sh
set -e

cd $(dirname $0)
cd ../src
mkdir -p ../log

# scripts/start_server.sh
exec ../env/bin/python app.py $*
```

start_celery.sh

```
#!/usr/bin/env sh
set -e

cd $(dirname $0)
cd ../src

# scripts/start_celery.sh [--loglevel=debug]
exec ../env/bin/celery --app=tasks.jira worker $*

```


### 启动

	/opt/python27/bin/supervisord -c /etc/supervisord.conf
	ps aux | grep supervisord

### 启动程序

使用supervisor启动程序

	 /opt/python27/bin/supervisorctl

	supervisor> status
	app1_celery                    RUNNING   pid 10315, uptime 19 days, 23:53:59
	app1_server                    RUNNING   pid 10322, uptime 19 days, 23:53:52
	supervisor> help
	    
	supervisor> restart app1_celery
	app1_celery: stopped
	app1_celery: started
	supervisor> restart app1_server
	app1_server: stopped
	app1_server: started
	supervisor> status

	

### supervisor自启动脚本(centos)

注意修改python、supervisor和配置文件路径：

```
supervisorctl=/opt/python27/bin/supervisorctl
supervisord=${SUPERVISORD-/opt/python27/bin/supervisord}
prog=supervisord
pidfile=${PIDFILE-/var/run/supervisord.pid}
lockfile=${LOCKFILE-/var/lock/subsys/supervisord}
STOP_TIMEOUT=${STOP_TIMEOUT-60}
OPTIONS="${OPTIONS--c /etc/supervisord.conf}"
RETVAL=0
```

详细：

```
#!/bin/bash
#
# supervisord   Startup script for the Supervisor process control system
#
# Author:       Mike McGrath <mmcgrath@redhat.com> (based off yumupdatesd)
#               Jason Koppe <jkoppe@indeed.com> adjusted to read sysconfig,
#                   use supervisord tools to start/stop, conditionally wait
#                   for child processes to shutdown, and startup later
#               Erwan Queffelec <erwan.queffelec@gmail.com>
#                   make script LSB-compliant
#
# chkconfig:    345 83 04
# description: Supervisor is a client/server system that allows \
#   its users to monitor and control a number of processes on \
#   UNIX-like operating systems.
# processname: supervisord
# config: /etc/supervisord.conf
# config: /etc/sysconfig/supervisord
# pidfile: /var/run/supervisord.pid
#
### BEGIN INIT INFO
# Provides: supervisord
# Required-Start: $all
# Required-Stop: $all
# Short-Description: start and stop Supervisor process control system
# Description: Supervisor is a client/server system that allows
#   its users to monitor and control a number of processes on
#   UNIX-like operating systems.
### END INIT INFO

# Source function library
. /etc/rc.d/init.d/functions

# Source system settings
if [ -f /etc/sysconfig/supervisord ]; then
    . /etc/sysconfig/supervisord
fi

# Path to the supervisorctl script, server binary,
# and short-form for messages.
supervisorctl=/opt/python27/bin/supervisorctl
supervisord=${SUPERVISORD-/opt/python27/bin/supervisord}
prog=supervisord
pidfile=${PIDFILE-/var/run/supervisord.pid}
lockfile=${LOCKFILE-/var/lock/subsys/supervisord}
STOP_TIMEOUT=${STOP_TIMEOUT-60}
OPTIONS="${OPTIONS--c /etc/supervisord.conf}"
RETVAL=0

start() {
    echo -n $"Starting $prog: "
    daemon --pidfile=${pidfile} $supervisord $OPTIONS
    RETVAL=$?
    echo
    if [ $RETVAL -eq 0 ]; then
        touch ${lockfile}
        $supervisorctl $OPTIONS status
    fi
    return $RETVAL
}

stop() {
    echo -n $"Stopping $prog: "
    killproc -p ${pidfile} -d ${STOP_TIMEOUT} $supervisord
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && rm -rf ${lockfile} ${pidfile}
}

reload() {
    echo -n $"Reloading $prog: "
    LSB=1 killproc -p $pidfile $supervisord -HUP
    RETVAL=$?
    echo
    if [ $RETVAL -eq 7 ]; then
        failure $"$prog reload"
    else
        $supervisorctl $OPTIONS status
    fi
}

restart() {
    stop
    start
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status -p ${pidfile} $supervisord
        RETVAL=$?
        [ $RETVAL -eq 0 ] && $supervisorctl $OPTIONS status
        ;;
    restart)
        restart
        ;;
    condrestart|try-restart)
        if status -p ${pidfile} $supervisord >&/dev/null; then
          stop
          start
        fi
        ;;
    force-reload|reload)
        reload
        ;;
    *)
        echo $"Usage: $prog {start|stop|restart|condrestart|try-restart|force-reload|reload}"
        RETVAL=2
esac

exit $RETVAL
```



