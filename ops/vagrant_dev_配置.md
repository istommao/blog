# vagrant dev 配置

基于 [ubuntu-14.04-amd64.box]( https://github.com/kraksoft/vagrant-box-ubuntu/releases/download/14.04/ubuntu-14.04-amd64.box)

* 设置 `root` 密码为: root
* 配置阿里源

  ```
  sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak #备份
  sudo vim /etc/apt/sources.list #修改
  sudo apt-get update #更新列表
  ```

  ```
  deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
  deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
  deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
  deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
  deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
  deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
  deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
  deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
  deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
  deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
  ```

* 安装 vim: `sudo apt-get install -y vim`
* 安装 python 配置

  安装 pip:

  ```
  sudo apt-get install -y freetds-dev
  sudo apt-get install -y python-pip
  sudo apt-get install -y python-dev​
  sudo apt-get install python3-dev  # for python3.x installs
  ```

  配置 pip 源:

  	mkdir -p ~/.pip
  	vim ~/.pip/pip.conf

  ```
  [global]
  index-url = http://mirrors.aliyun.com/pypi/simple/

  [install]
  trusted-host=mirrors.aliyun.com
  ```

* 打包

  ```
  vagrant halt
  vagrant package --output dev-python.box
  ```

* 在项目中使用

  ```
  cd /path/to/project
  vagrant box add project-name /path/to/dev-python.box
  vagrant init project-name
  ```

  修改 Vagrantfile：

  ```
    # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "private_network", ip: "172.16.1.111"
  config.ssh.insert_key = false
  ```