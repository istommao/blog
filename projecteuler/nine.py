#!/usr/bin/env python
# -*- coding: utf-8 -*-
__author__ = 'zhuwei'


def special_pythagorean_triplet(all_sum):
    # a, b, = 0, 0
    for a in xrange(0, all_sum / 3 + 1):
        for b in xrange(a+1, all_sum / 2 + 1):
            c = all_sum - a - b
            if a < b < c:
                if a*a + b * b == c*c:
                    print a, b, c
                    return a*b*c
    return None


if __name__ == '__main__':

    print special_pythagorean_triplet(1000)
