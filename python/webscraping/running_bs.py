#!/usr/bin/env python
# -*- coding: utf-8 -*-

import bs4
from urllib import urlopen
# from bs4 import BeautifulSoup

__author__ = 'zhuwei'


html = urlopen("http://www.qq.com/")
bsObj = bs4.BeautifulSoup(html.read(), "html.parser")
print(bsObj.h1)
