# linux 系统命令

## 修改密码

  sudo passwd root
  sudo passwd

## 查看系统

  uname -a
  lsb_release -a



## 创建/删除用户

* adduser: 会自动为创建的用户指定主目录、系统shell版本，会在创建时输入用户密码

  ```
  adduser alan
  ```


* useradd: 需要使用参数选项指定上述基本设置，如果不使用任何参数，则创建的用户无密码、无主目录、没有指定shell版本

  * -d：           指定用户的主目录
  * -m：          如果存在不再创建，但是此目录并不属于新创建用户；如果主目录不存在，则强制创建； -m和-d一块使用
  * -s：           指定用户登录时的shell版本
  * -M：           不创建主目录

  ```
  useradd  tt

  or:
  useradd  -d  "/home/tt"   -m   -s "/bin/bash"   tt

  # 为用户指定登录密码
  passwd tt
  ```

* userdel

  ```
  # 只删除用户
  userdel   用户名
  # 连同用户主目录一块删除
  userdel   -r   用户名
  ```

  ​





## end