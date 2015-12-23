close all
clear all
clc
format rat
syms a b
A = [a -b;b a]
v = [12;5]
u = [13;0]

[a,b] = solve(A*v==u,[a,b])

clear all

A = [1,-1,0,2;0,2,1,1;1,2,0,1;3,-1,1,0]

v = [-1,0,0,0;0,1,0,0;0,0,3,0;0,0,0,4]

u = A*v

u = sum((A*v)')
