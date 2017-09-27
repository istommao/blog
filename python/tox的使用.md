title: tox的使用
date: 2016-11-25 22:07:00
tags:
- tox
- python

# tox的使用
====

## 题外话

python 中有些很好的工作来规范整个项目的开发，而其中使用较多的就是使用 `tox` 、 `flake8` 、 `pytest` 。

tox 管理 virtualenv 环境，可在一个 python 项目中定义多个版本的 python 环境，从而检查项目源代码的兼容性。flake8 进行源代码检查，根据 pep8 检查源代码是否符合规范（也可使用 pylint ，pylint 较严格）。 pytest 进行单元测试，或者通过 pytest 的插件 pytest-cov 同时进行代码覆盖率测试。


## What is Tox?

> Tox is a generic virtualenv management and test command line tool you can use for:
>
> * checking your package installs correctly with different Python versions and interpreters
> * running your tests in each of the environments, configuring your test tool of choice
> * acting as a frontend to Continuous Integration servers, greatly reducing boilerplate and merging CI and shell-based testing.


安装: `pip install tox`


## 在项目中使用

在项目中加入 `tox.ini` :

    [tox]
    envlist = py26,py27
    [testenv]
    deps=pytest       # install pytest in the venvs
    commands=py.test  # or 'nosetests' or ...

### 实例

    [tox]
    envlist = py27
    skipsdist = True
    
    [testenv]
    deps =
        -rrequirements.txt
        -rdev-requirements.txt
    commands = coverage erase
               py.test --cov={toxinidir}/projectname --cov={toxinidir}/commands -sx tests

#### 解读

* tox: 指定全局配置

    * envlist: csv格式。指定 virtualenv 的 python 版本。默认支持的 [python版本](https://tox.readthedocs.io/en/latest/example/basic.html#a-simple-tox-ini-default-environments)
    * skipsdist: 跳过打包操作： `python setup.py install`。此时的办法是使用 `python setup.py develop` 方
      式来进行源码安装。tox 为此提供了便利的参数 `skipsdist` 和 `usedevelop`

* testenv: virtualenv 测试的共享(默认)配置。因此可以指定专属的 testenv。比如在配置中增加: `[testenv:NAME]`

    * deps: 需要的依赖。MULTI-LINE-LIST 格式。
    * commands: ARGVLIST 格式。指定需要执行的命令
    * {toxinidir}: tox 的全局变量，tox.ini 所在的目录。其他 [全局变量](https://tox.readthedocs.io/en/latest/config.html#globally-available-substitutions)
    * coverage erase: 使用 [coverage 测试工具](http://coverage.readthedocs.io/en/coverage-4.2/index.html)。清除之前的 coverage 测试数据
    * py.test --cov: py.test 的测试覆盖率. -sx: 指定输出结果，遇到错误指定停止

* testenv还可以设置[其他](https://tox.readthedocs.io/en/latest/config.html#virtualenv-test-environment-settings)

    * install_command: ARGV 格式。可以指定安装依赖的工具和命令。这样就可以自定义安装依赖的方式。比如可以指定安装源：`install_command = pip install -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com {opts} {packages}`
    * setenv: MULTI-LINE-LIST 格式。可以设置 `NAME=VALUE` 环境变量
    * passenv: SPACE-SEPARATED-GLOBNAMES 格式。可以指定一些系统的环境变量
    * whitelist_externals: 默认情况下，在 virtualenv 中不能使用外部安装的命令，这本来是为了命令环境的
      隔离，但有些情况下，可能需要使用外部命令。例如，在对代码对格式检查时，不想要在每个 virtualenv 中都安装一遍 flake8，只需调用外部环境中唯一的一份 flake8 即可。



#### 指定pip安装源

```
[testenv]
install_command = pip install -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com --extra-index-url https://anthor-source/simple {opts} {packages}
```





#### 设置代码检查

    [testenv:pep8]
    usedevelop = False
    deps =
    whitelist_externals = flake8
    commands = flake8 myproj
               flake8 tests
               
    [flake8]
    exclude = env,venv,.venv,.git,.tox,dist,doc,__pycache__
    ignore = E24,E226,E501
    max-complexity = 10


### coverage

* [coverage](coverage.md) 

    
## 参考

* [tox](https://github.com/tox-dev/tox)
* [tox basic usage](https://tox.readthedocs.io/en/latest/example/basic.html)
* [tox configuration](https://tox.readthedocs.io/en/latest/config.html)
* [使用 tox flake8 pytest 规范 python 项目](http://www.cnblogs.com/fengyc/p/5803798.html)
* [Configuring Flake8](http://flake8.pycqa.org/en/latest/user/configuration.html)