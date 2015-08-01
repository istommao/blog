#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'zhuwei'


def sum_square_difference(N):
    result = 0
    for i in xrange(1, N + 1):
        for j in xrange(i + 1, N + 1):
            result += i * j

    return 2 * result


if __name__ == '__main__':

    print sum_square_difference(100)

