#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'zhuwei'

import math


def is_prime(n):
    if n <= 1:
        return False
    sqrt_n = int(math.sqrt(n)) + 1
    for x in xrange(2, sqrt_n):
        if n % x == 0:
            return False
    return True


if __name__ == '__main__':
    n = 0
    i = 2
    while n != 10001:
        if is_prime(i):
            n += 1
        i += 1
    print i-1

