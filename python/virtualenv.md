# Virtualenv



## virtualenvwrapper

[virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/install.html)

```
pip install virtualenvwrapper
```

zsh: `~/.zshrc`

```
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source $HOME/Library/Python/2.7/bin/virtualenvwrapper.sh
```



创建环境:

```
mkvirtualenv -p python3.6 pytorch-py3
```



## ipython

zsh: `~/.zshrc` (ipython >= 1.0)

```
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
```





## end