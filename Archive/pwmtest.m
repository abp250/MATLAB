

clear all;
close all;
F2 = 10;
F1 = 10;
A = 1;
t = 0:0.001:1;
c = A.*sawtooth(2*pi*F1*t);
%sawtooth
subplot(3,1,1);
plot(t,c)
xlabel('time');
ylabel('amplitude');
title('carrier sawtooth wave');
grid on;
subplot(3,1,2);
plot(t,m);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal');
grid on;
n = length(c);
for i=1:n
    if(m(i)>c(i))
        pwm(i) = 1;
    else
        pwm(i) = 0;
    end
end
subplot(3,1,3);
plot(t,pwm);
title('plot of pwm');
axis([0,1,0,2]);