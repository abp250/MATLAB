clear all
close all
clc
format rat
A =[2	1	0;
0	2	1;
0	2	-1;
1	1	1;
1	1	-1]

B = [1;
    0;
1;
-1;
0]
syms x

inv(A'*A)*(A'*B)


A = [1,-1;
    1,1;
    1,3]
B = [1;-2;-3]


inv(A'*A)*(A'*B)