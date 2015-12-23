clc
clear all
close all
load('data4.mat')
X = data.resReading;
Y = data.resReal;
po = 2;
res = X(1):1:X(end);

modelfun = @(b,x)(b(1)+b(2)./(b(3)*x+b(4)));

beta0 = [-500366.698145372;-1.90397015730411e+20;390689798.674469;-355663638130372];


opts = statset('nlinfit');
opts = statset('MaxIter',100000);
opts.RobustWgtFun = 'bisquare';

a = nlinfit(X,Y,modelfun,beta0);
p = polyfit(X,Y,po);

y = modelfun(a,res);
z =  polyval(p,res);
figure
plot(X,Y,'.');
hold on
plot(res,y);

X = data.capReading;
X1 = data.capReading2;
X2 = data.capReading3;
Y = data.capReal;
cap = 300000:-1:30000;

modelfun = @(b,x)(b(1)+b(2)./(b(3).*x+b(4)));

beta0 = [0;6000;.001;1];

t = modelfun(beta0,cap);

opts = statset('nlinfit');
opts = statset('MaxIter',100000);
opts.RobustWgtFun = 'bisquare';

b = nlinfit(data.cap.readings.res1500000,Y,modelfun,beta0);

y = modelfun(b,cap);
z =  polyval(p,cap);

figure
plot(data.cap.readings.c1500000,Y,'.');
hold on
plot(cap,y);