clear all
close all
clc
format rat;
v = [-1;7;2]
u = [2,1,5;
1,-2,0;
-3,2,-4]
u = transpose(u)
syms c1 c2 c3 real
c = [c1;c2;c3]

ui = inv(u)

c = u* v