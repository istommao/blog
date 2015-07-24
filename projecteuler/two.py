#!/usr/bin/env python
__author__ = 'zhuwei'


def fib1(n):
    x, y = 0, 1
    while n:
        x, y, n = y, x+y, n-1
    return x

fib = lambda n, x=0, y = 1: x if n == 0 else fib(n-1, y, x+y)


def helper(upper_bound):
    total = 0
    i = 0
    while fib(i) < upper_bound:
        if fib(i) % 2 == 0:
            total += fib(i)
        i += 1

    return total

if __name__ == '__main__':
    print fib(1)
    print fib(0)
    print fib(10)
    print helper(4000000)
