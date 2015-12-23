clc
clear all
close all
load('data4.mat')
X = data.res.Reading;
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

X = data.readings(1);
X1 = data.cap.readings(2);
X2 = data.capReading3;
Y = data.cap.real;
cap = X(1):-1:30000;

modelfun = @(b,x)(b(1)+b(2)./(b(3)*x+b(4)));

beta0 = [0;6000;.001;1];

t = modelfun(beta0,cap);

opts = statset('nlinfit');
opts = statset('MaxIter',100000);
opts.RobustWgtFun = 'bisquare';

for i = 1:4
b(i) = nlinfit(X(i),Y,modelfun,beta0);
end

y = modelfun(b,cap);
y1 = modelfun(b1,cap);
y2 = modelfun(b2,cap);
z =  polyval(p,cap);

figure
plot(X,Y,'.');
hold on
plot(X1,Y,'.');
hold on
plot(X2,Y,'.');
hold on
plot(cap,[y;y1;y2]);

X = data.cap2Reading;
X1 = data.cap2Reading2;
X2 = data.cap2Reading3;
cap = X(1):-1:30000;

modelfun = @(b,x)(b(1)+b(2)./(b(3)*x+b(4)));

beta0 = [0;6000;.001;1];

t = modelfun(beta0,cap);

opts = statset('nlinfit');
opts = statset('MaxIter',100000);
opts.RobustWgtFun = 'bisquare';

c = nlinfit(X,Y,modelfun,beta0);
c1 = nlinfit(X1,Y,modelfun,c);
c2 = nlinfit(X2,Y,modelfun,c1);
p = polyfit(X,Y,po);

y = modelfun(c,cap);
y1 = modelfun(c1,cap);
y2 = modelfun(c2,cap);
z =  polyval(p,cap);

figure
plot(X,Y,'.');
hold on
plot(X1,Y,'.');
hold on
plot(X2,Y,'.');
hold on
plot(cap,[y;y1;y2]);

X = data.cap3Reading;
X1 = data.cap3Reading2;
X2 = data.cap3Reading3;
cap = X(1):-1:30000;

modelfun = @(b,x)(b(1)+b(2)./(b(3)*x+b(4)));

beta0 = [0;6000;.001;1];

t = modelfun(beta0,cap);

opts = statset('nlinfit');
opts = statset('MaxIter',100000);
opts.RobustWgtFun = 'bisquare';

d = nlinfit(X,Y,modelfun,beta0);
d1 = nlinfit(X1,Y,modelfun,d);
d2 = nlinfit(X2,Y,modelfun,d1);
p = polyfit(X,Y,po);

y = modelfun(d,cap);
y1 = modelfun(d1,cap);
y2 = modelfun(d2,cap);
z =  polyval(p,cap);

figure
plot(X,Y,'.');
hold on
plot(X1,Y,'.');
hold on
plot(X2,Y,'.');
hold on
plot(cap,[y;y1;y2]);

bs = [b,b1,b2]/680000
cs = [c,c1,c2]/1500000
ds = [d,d1,d2]/3300000

betas500hz = [b*680000,c*1500000,d*3300000]
betas1000hz = [b1*680000,c1*1500000,d1*3300000]
betas2000hz = [b2*680000,c2*1500000,d2*3300000]




