#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'zhuwei'

import math


def is_prime(number):
    if number < 2:
        return False
    sqrt_number = int(math.sqrt(number))
    for i in xrange(2, sqrt_number + 1):
        if number % i == 0:
            return False
    return True


def sum_prime(upper_bound):
    sum_result = 0
    for i in xrange(2, upper_bound + 1):
        if is_prime(i):
            sum_result += i

    return sum_result

if __name__ == '__main__':
    print sum_prime(2000000)
