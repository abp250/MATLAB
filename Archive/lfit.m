clc
clear all
close all
load('data3.mat')
X = [1,2,3,4,5,6,7];
Y = [1,8,32,64,128,256,1024];
po = 1;
div = X(1):1:X(end);

modelfun = @(b,x)(b(1)./(-x+b(2)));

beta0 = [-1;-1];

t = modelfun(beta0,div);

opts = statset('nlinfit');
opts = statset('MaxIter',100000);
opts.RobustWgtFun = 'bisquare';

b = nlinfit(X,Y,modelfun,beta0);
p = polyfit(X,Y,po);

y = modelfun(b,div);
z =  polyval(p,div);
figure
plot(X,Y,'.');
hold on
plot(div,y);
