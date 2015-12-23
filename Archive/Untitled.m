clear all
clc
format rat
syms x

B = [sqrt(5)*(x^2-1);
    sqrt(5)*(x^2+x+2)]
dot(B(1,:),B(2,:))
W = zeros(size(B))
U = zeros(size(B))

for i = 1:length(B)
    W(i,:) = B(i,:)
    for j = 1:i-1
        W(i,:) = W(i,:) - dot(B(i,:),W(j,:))/dot(W(j,:),W(j,:))*W(j,:)
    end
    U(i,:) = W(i,:)/norm(W(i,:))
end

[Q,R]=gschmidt(B)
