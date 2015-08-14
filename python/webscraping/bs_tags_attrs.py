#!/usr/bin/env python
__author__ = 'zhuwei'

from urllib import urlopen
from bs4 import BeautifulSoup

if __name__ == '__main__':
    html = urlopen("http://www.salttiger.com/")
    bsObj = BeautifulSoup(html, "html.parser")

    # bsObj.findAll(tagName, tagAttributes)
    nameList = bsObj.findAll("a", {"rel": "bookmark"})

    for name in nameList:
        print(name.get_text())