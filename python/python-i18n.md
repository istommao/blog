# python-i18n

参考资料:

* [python i18n实现](http://www.jianshu.com/p/f139697dbe7a)
* [Internationalization (i18n) of Python Application by GNU gettext Tools](https://siongui.github.io/2016/01/14/python-i18n-py-application-by-gnu-gettext/)
* [Run-time language switch of web.py](http://webpy.org/cookbook/runtime-language-switch)
* [babel](http://babel.pocoo.org/en/latest/index.html)
* [flask-babel](https://pythonhosted.org/Flask-Babel/)

类比：

pybabel extract --- xgettext : .pot
pybabel init -- msginit : lang.po
pybabel compile --- msgfmt : domain.mo
pybabel update -- msgmerge

	1. 提取需要转换的字符串: pybabel extract src/ -o mm.pot
	2. 修改: mm.pot
	3. 生成对应语言的 *.po: pybabel init -i mm.pot -l zh -d i18n
	4: 生成对应的 *.mo: pybabel compile -i i18n/zh/LC_MESSAGES/messages.po -d i18n -l zh

实现:

* <https://github.com/zhuwei05/py-demo/blob/master/i18n/i18n_demo.py>


## 时区问题

* [pytz](http://tech.glowing.com/cn/dealing-with-timezone-in-python/)


## locale 列表 和 时区

* [locale list](https://gist.github.com/jacobbubu/1836273)
* [time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

