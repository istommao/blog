#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'zhuwei'

import math


def is_prime(numbers):
    if numbers <= 1:
        return False
    sqrt_number = int(math.sqrt(numbers)) + 1
    for i in xrange(2, sqrt_number):
        if numbers % i == 0:
            return False

    return True


def max_prime_factor(numbers):
    sqrt_n = int(math.sqrt(numbers))
    max_factor = 1
    for i in xrange(2, sqrt_n):
        if numbers % i == 0:
            if i > max_factor:
                max_factor = i
            numbers /= i
    return max_factor

if __name__ == '__main__':
    # number = 13195
    number = 600851475143
    print "max prime factor %s" % max_prime_factor(number)