#!/usr/bin/env python
__author__ = 'zhuwei'

from urllib import urlopen
from bs4 import BeautifulSoup

if __name__ == '__main__':
    html = urlopen("http://www.pythonscraping.com/pages/page3.html")
    bsObj = BeautifulSoup(html, "html.parser")

    print "children:"
    for child in bsObj.find("table",{"id":"giftList"}).children:
        print(child)

    print "sibling:"
    for sibling in bsObj.find("table",{"id":"giftList"}).tr.next_siblings:
        print(sibling)