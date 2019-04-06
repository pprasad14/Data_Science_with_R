# -*- coding: utf-8 -*-
"""
Created on Tue Feb  6 13:03:06 2018

@author: Prem Prasad
"""

def fib(n):
    if n<=1 :
        return n
    return fib(n-1) + fib(n-2)

while(int(input("Press 1 to continue, 0 to stop: "))):
    num = int(input("enter no of terms: "))
    if num>-1:
        print("fibonacci seq:  ")
        for i in range(0,(num)):
            print(fib(i), " ")
    else:
        print("fibonacci seq:  ")
        for i in range(0,(abs(num))):
            print(fib(i))
        