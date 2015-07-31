#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'zhuwei'

"""
Problem 4
A palindromic number reads the same both ways.

The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

Find the largest palindrome made from the product of two 3-digit numbers.

"""


def is_palindrome2(num):
    # str_num = str(num)
    str_num = "%d" % num
    str_len = len(str_num)
    for i in xrange(0, str_len / 2):
        if str_num[i] != str_num[str_len - 1 - i]:
            return False
    return True


def is_palindrome(num):
    if num < 0:
        return False
    divisor = 1
    while num / divisor >= 10:
        divisor *= 10   # 获取num的有几位，比如999对应divisor为100
    while num != 0:
        left = num / divisor
        right = num % 10
        if left != right:
            return False
        num = (num % divisor) / 10  # 去除最高位和最低位,divisor对应缩小100倍
        divisor /= 100
    return True


def max_three_digit_product_palindrome():
    max_answer = 1
    for i in xrange(999, 99, -1):
        for j in xrange(999, 99, -1):
            if is_palindrome2(i * j):
                if i * j > max_answer:
                    max_answer = i * j
    return max_answer


if __name__ == '__main__':

    print max_three_digit_product_palindrome()
