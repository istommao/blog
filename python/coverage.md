title: coverage
date: 2017-01-09 10:09:00
tags:
- coverage

# coverage

install:

	pip install coverage
		
run:

	coverage run my_program.py arg1 arg2
	或 pytest/tox
	py.test --cov={toxinidir}/appdir -sx tests
	
report:

	coverage report
	
html

	coverage html -d covhtml
	
combine

	coverage combine


examples:

	# interested in coverage for the dexml module,
	# and we don't care about coverage within the tests themselves
	coverage report --include="*dexml*" --omit="*test*"
	
	# Output winds up in the "htmlcov" directory
	coverage html --include="*dexml*" --omit="*test*"
	
	
## tox

```

[tox]
envlist = py25,py26,py27,py32
 
[testenv]
deps= nose
      coverage
commands = coverage erase
           coverage run {envbindir}/nosetests
           coverage report --include=*dexml* --omit=*test*
 
[testenv:py32]
deps=
commands = python setup.py test
```


## reference

* [Testing better with coverage and tox](https://www.rfk.id.au/blog/entry/testing-better-coverage-tox/)	