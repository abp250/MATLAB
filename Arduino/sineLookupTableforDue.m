close all
clear all


len = 1000;
t = 0:len;
sine = sin(t*2*pi/len);
sine = sine*4095/2;
sine = sine+2048;
sine = round(sine,0);

sine(find(sine<0)) = 0;
sine(find(sine>4095)) = 4095;

mi = min(sine)
ma = max(sine)
d = diff(sine);
mid = min(d)
mad = max(d)


plot(t,sine,'.');