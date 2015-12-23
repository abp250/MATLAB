clc
clear all
close all
load('data.mat')
X = data.resReading;
Y = data.resReal;
po = 10;
res = X(1):1:X(end);


modelfun = @(b,x)(b(1)+b(2)./(b(3)*x+b(4)));

beta0 = [1000000;170000000000;1;1];
t = modelfun(beta0,res);

opts = statset('nlinfit');
opts = statset('MaxIter',1000);
opts.RobustWgtFun = 'bisquare';

b = nlinfit(X,Y,modelfun,beta0);
p = polyfit(X,Y,po);

y = modelfun(b,res);
z =  polyval(p,res);
figure
plot(X,Y,'.');
hold on
plot(res,y);


%{
po = {'constant', '(x-y)^-1'};
p = polyfitn(X,Y,po);
z = polyvaln(p,res)';


figure
plot(X,Y,'.');
hold on
plot(res,z);





X = data.reading2;
Y = data.resis2;
b2 = nlinfit(X,Y,modelfun,beta0);
p2 = polyfit(X,Y,po);
res = X(1):1:X(end);
y = modelfun(b2,res);
z =  polyval(p2,res);
figure
plot(X,Y,'.');
hold on
plot(res,y);


X = data.reading3;
Y = data.resis3;
b3 = nlinfit(X,Y,modelfun,beta0);
p3 = polyfit(X,Y,po);
res = X(1):1:X(end);
y = modelfun(b3,res);
z =  polyval(p3,res);
figure
plot(X,Y,'.');
hold on
plot(res,z);


b2
p3


% figure;
% p = polyfit(X,Y,50);
% 
% plot(res,polyval(p,res),'-r')
% hold on
% plot(X,Y);
% 


%}
