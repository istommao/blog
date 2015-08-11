#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'zhuwei'


def get_strings(strs):
    return strs.replace(" ", "%20")

if __name__ == '__main__':
    with open("temp.txt", 'rb+') as f:
        for line in f:
            print "line: %s" % get_strings(line).rstrip()