clear all
close all
V = [1.5473    3.1903    4.2564    4.7504    5.2595    5.9200    7.3970    8.0530    9.4930   10.133  11.734  12.524   13.100   13.751   14.914]
D = 1:15
LSB = 15/2^4
I = LSB:LSB:15*LSB

P = polyfit(1:15,V,1);
P = P(2):P(1):15*P(1)

plot(V)
hold on
plot(I+1,'r')
plot(P+1,'black')
set(gca,'XTick',0:15)

ERR = (V-I)/LSB
figure
plot(ERR)

OFFSET = I(1)-P(1) %Ideal - linear best fit

figure
plot(I,'r')
hold on
plot(P+OFFSET,'black')
set(gca,'XTick',0:15)

GAINERROR = I(15)-P(15)-OFFSET

p = polyfit(1:15,V,5);
f = polyval(p,1:.1:15);

figure
plot(f,1:.1:15)
hold on
plot(V,D)

for i=1:14
    BinWid(i) =  V(i+1)-V(i);
end
BinWid

