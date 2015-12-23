close all
clear all
dt = 1E-3;
t = dt:dt:5;
Fs = 1/dt;
x = 2+sin(2*pi*60*t);
x = detrend(x,0);
xdft = fft(x);
freq = 0:Fs/length(x):Fs/2;
xdft = xdft(1:length(x)/2+1);
plot(freq,abs(xdft));
[~,I] = max(abs(xdft));
fprintf('Maximum occurs at %d Hz.\n',freq(I));