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