#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'zhuwei'

import time


def first_triangle_number_have_500_divisors():
    divs = 0
    sum = 0
    i = 1
    while True:
        sum += i
        for j in xrange(1, sum + 1):
            if sum % j == 0:
                divs += 1
                if divs > 500:
                    return sum
        divs = 0
        i += 1


if __name__ == '__main__':
    start = time.time()
    print first_triangle_number_have_500_divisors()
    elapsed = (time.time() - start)
    print "%s seconds" % elapsed
    print "hello"
