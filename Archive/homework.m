clear all
close all
clc
format rat;
B = [-6, 2, 4; -4, 1, 2; -12, 3, 7]
B = B'
Bp = [-12, -2, 4; 8, 1, -2; 16, 2, -3]
Bp = Bp'
x = [2;3;1]

BpB = [Bp,B]

Pinv = rref(BpB)
Pinv = Pinv(:,4:6)

BBp = [B,Bp];
P = rref(BBp);
P = P(:,4:6)

P = inv(Pinv)

P*Pinv

xB = P*x
