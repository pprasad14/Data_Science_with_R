# -*- coding: utf-8 -*-
"""
Created on Tue Feb  6 11:03:18 2018

@author: Prem Prasad
"""

def calc(x, y, z):
    if y=='+' or y=='plus':
        print("sum is: %s " % (x+z))
    elif y=='-' or y=='minus':
        print("difference is: %s" % (x-z))
    elif y=='*' or y=='into' or y=='multiply':
        print("product is: %s" % (x*z))
    elif y=='/' or y=='divided':
        print("division is : %s" % (x/z)) if z!=0 else print("divide by zero error")

start = 1
while(start):        
    exp = input("Enter the expression with spaces:"+
            "\nfor words: use 'plus' for +, \n'minus' for -, \n'into' or 'multiply' for *, \nand 'divided' for / \n")
    print("your expression is : " + exp)
    exp_split = exp.split(" ")
    calc(int(exp_split[0]),exp_split[1],int(exp_split[2]))
    start = input("continue? 1 for yes, 0 for no: ")