title: python profiling
date: 2016-12-27 09:52:00
tags:
- python
- profiling

# python profiling

安装:

	$ pip install ipython
	$ pip install line-profiler
	$ pip install psutil
	$ pip install memory_profiler

* `%time` & `%timeit`: See how long a script takes to run (one time, or averaged over a bunch of runs).
* `%prun`: See how long it took each function in a script to run.
* `%lprun`: See how long it took each line in a function to run.
* `%mprun` & `%memit`: See how much memory a script uses (line-by-line, or averaged over a bunch of runs).


## Profiling a Werkzeug (flask) app

<http://www.alexandrejoseph.com/blog/2015-12-17-profiling-werkzeug-flask-app.html>

```python
from werkzeug.contrib.profiler import ProfilerMiddleware
from myapp import app  # This is your Flask app
app.wsgi_app = ProfilerMiddleware(app.wsgi_app)
app.run(debug=True)    # Standard run call
```



## timeit

* <https://docs.python.org/3.0/library/timeit.html>

命令行运行：

```
>>> import timeit
>>> s = """\
... try:
...     str.__bool__
... except AttributeError:
...     pass
... """
>>> t = timeit.Timer(stmt=s)
>>> print("%.2f usec/pass" % (1000000 * t.timeit(number=100000)/100000))
17.09 usec/pass
```

命令行运行模块命令:

```
t  = timeit.Timer("func({'d': 'd'})", 'from xxx import func')
```




## profile



基础

```
# iPython
import cProfile
cProfile.run('re.compile("foo|bar")')
cProfile.run('re.compile("foo|bar")', 'stats_info')

p = cProfile.Profile()
p.runcall(re.compile, "foo|bar")
p.print_stats('cumulative')

```

使用 pstats

```
import pstats

s = pstats.Stats(p)
s = s.sort_stats('cumtime')

s.print_stats(30)
s.print_callees(20)
s.print_callees('func_name')
```



使用命令行

```
# Command line interface
python -m cProfile -o stats_info built-in-profiler/test.py
import pstats
p = pstats.Stats('stats_info')
p.sort_stats('cumtime')
p.print_stats() 
```

