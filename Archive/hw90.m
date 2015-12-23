close all
clear all
clc
format rat

A = [0	2	0;1	-1	0;0	0	-2]

B = eye(3)

Bp = [[-1;1;0], [2;1;0], [0;0;1]]



N = [Bp,B]

N = rref(N)

Pinv = [N(:,4),N(:,5),N(:,6)]

P = inv(Pinv)

Ap = Pinv*A*P

Vbp = [4,-5]'

Vb = P*Vbp

TVB = A*Vb