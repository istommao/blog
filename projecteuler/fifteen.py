#!/usr/bin/env
# -*- coding: utf-8 -*-

__author__ = 'zhuwei'


def total_path(x, y):
    if x == 0 or y == 0:
        return 1
    else:
        return total_path(x-1, y) + total_path(x, y-1)


if __name__ == '__main__':

    print total_path(6, 6)

    print 'hello'