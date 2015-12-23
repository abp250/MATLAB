clc
clear all
close all
load('data5.mat')
po = 2;
data.res.res = data.res.reading(1):1:data.res.reading(end);

modelfun = @(b,x)(b(1)+b(2)./(b(3)*x+b(4)));

beta0 = [-500366.698145372;-1.90397015730411e+20;390689798.674469;-355663638130372];

opts = statset('nlinfit');
opts = statset('MaxIter',100000);
opts.RobustWgtFun = 'bisquare';
%beta0 = [0;0;-1;0];
data.res.beta = nlinfit(data.res.reading,data.res.real,modelfun,beta0);

data.res.fit = modelfun(data.res.beta,data.res.res);

figure
plot(data.res.reading,data.res.real,'.');
hold on
plot(data.res.res,data.res.fit);

data.cap.cap = 300000:-1:30000;

modelfun = @(b,x)(b(1)+b(2)./(b(3)*x+b(4)));
beta0 = [0;0;1;0];

for i = 1:3
    figure
    for n = 1:4
        hold on
        plot(data.cap.reading{i}(:,n),data.cap.real,'.');
        data.cap.beta{i,n} = nlinfit(data.cap.reading{i}(:,n),data.cap.real,modelfun,beta0);
        data.cap.fit{i,n} = modelfun(data.cap.beta{i,n},data.cap.cap);
        hold on
        plot(data.cap.cap,data.cap.fit{i,n});
    end
end

for n = 1:4
    figure
    for i = 1:3
        hold on
        plot(data.cap.reading{i}(:,n),data.cap.real,'.');
        hold on
        plot(data.cap.cap,data.cap.fit{i,n});
    end
end
a = [[-1890.47493817724;299788127.157783;0.883079284545861;6014.85709852501],[-1338.90746146266;287055750.525000;0.937019121923819;3160.51080603656],[-1038.89005262761;274156365.994695;0.979388373742781;140.717130844127]]

for i = 1:4
%%a(i) =  data.cap.beta{i,3}
figure
plot(data.cap.reses',a(i,:),'o');
data.cap.bb{i} = nlinfit(data.cap.reses',a(i,:),modelfun,beta0);
hold on
y = modelfun(data.cap.bb{i},data.res.real);
plot(data.res.real,y)
end


