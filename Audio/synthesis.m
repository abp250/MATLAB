clear all;
close all;
[data,Fs] = audioread('LawnMower.mp3');



data = data(400000:700000,1)';

plot(data);
psdest = psd(spectrum.periodogram,data,'Fs',Fs,'NFFT',length(data));

I = psdest.Data;
figure;
plot(I);
I(I<.002) = 0;

t = 0:1/Fs:10;


x = abs(ifft(I));
soundsc(x,Fs);