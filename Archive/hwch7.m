clc

format rat

A = [1,-3/2;1/2,-1]

syms Lam

Lameye = Lam * eye(2)

Lam = solve(det(A-Lameye) == [0;0])


rref(A - 1/2*eye(2))

rref(A + 1/2*eye(2))
