# pyenv



## install

```
brew install pyenv
brew install pyenv-virtualenv
```

自动补全: `.bashrc` 或者 `.bash_profile`

```
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

## 命令

```
# 本机安装 Python 版本
pyenv versions

# 查看可安装版本
pyenv install -l 

# 安装和卸载 python
pyenv install 2.7.12
pyenv uninstall 2.7.12

所有命令
pyenv commands
```

```
# 切换python默认版本
$ pyenv global 2.7.3  # 设置全局的 Python 版本，通过将版本号写入 ~/.pyenv/version 文件的方式。

$ pyenv local 2.7.3 # 设置 Python 本地版本，通过将版本号写入当前目录下的 .python-version 文件的方式。通过这种方式设置的 Python 版本优先级较 global 高。

$ pyenv shell 2.7.3 # 设置面向 shell 的 Python 版本，通过设置当前 shell 的 PYENV_VERSION 环境变量的方式。这个版本的优先级比 local 和 global 都要高。–unset 参数可以用于取消当前 shell 设定的版本。
$ pyenv shell --unset

$ pyenv rehash  # 创建垫片路径（为所有已安装的可执行文件创建 shims，如：~/.pyenv/versions/*/bin/*，因此，每当你增删了 Python 版本或带有可执行文件的包（如 pip）以后，都应该执行一次本命令）
```

## pyenv-virtualenv

```
创建虚拟环境: pyenv virtualenv 版本号 虚拟环境名
环境的真实目录位于 ~/.pyenv/versions/
$ pyenv virtualenv 2.7.10 env-2.7.10

列出当前虚拟环境
pyenv virtualenvs
pyenv activate env-name  # 激活虚拟环境
pyenv deactivate #退出虚拟环境，回到系统环境

删除虚拟环境
pyenv uninstall my-virtual-env
rm -rf ~/.pyenv/versions/env-name  # 或者删除其真实目录
```

example

```
创建虚拟环境--pyenv virtualenv 版本号 虚拟环境名。
$ pyenv virtualenv 3.5.1 venv-3.5.1

创建项目

$ mkdir myproject
$ cd myproject
# 指定项目的环境: pyenv local 虚拟环境名
$ pyenv local venv-3.5.1

```



