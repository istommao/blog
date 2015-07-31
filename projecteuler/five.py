#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'zhuwei'

# 欧几里得
# gcd(a, b) = gcd(b, a%b), (a>b 且a mod b 不为0)
def gcd(num1, num2):
    if num1 < num2:
        num1, num2 = num2, num1
    if num1 % num2 == 0:
        return num2
    else:
        return gcd(num2, num1 % num2)

# 更相减损法
def gcd2(num1, num2):
    while num1 != num2:
        if num1 < num2:
            num1, num2 = num2, num1
        num1 -= num2
    return num1


if __name__ == '__main__':
    # print gcd(2, 9)
    # print gcd(3, 6)
    # print gcd2(2, 9)
    # print gcd2(3, 6)

    nn = 1
    for i in xrange(2, 21):
        nn = i * nn / gcd(i, nn)

    print nn

