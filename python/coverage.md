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

