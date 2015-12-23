close all
clear all
f=192000;
l = 2;
fbegin = 20;
fend = 40;
t = linspace(0,1,f);
t = t';
y = [chirp(t,fbegin,l,fend),zeros(length(t),1)];
y = [y;[zeros(length(t),1),chirp(t,fend,l,fbegin)]];


l = .5;
t=linspace(0,1,f);
t = t';
fhold = 20;
for i = 1:10
    y = [y;[chirp(t,i*fhold,l,i*fhold),zeros(length(t),1)]];
end
for i = 10:1
    y = [y;[zeros(length(t),1),chirp(t,i*fhold,l,i*fhold)]];
end


t=linspace(0,1,f);
t = t';
for i = 1:3
    x = 20+10*pi*sin(i*pi*t);
    y = [y;[zeros(length(t),1),sin(t.*x*2*pi)]];
    y = [y;[sin(t.*x*2*pi),zeros(length(t),1)]];
end



l = 5;
t=linspace(0,l,f*l);
t = t';
pwm = pwm(f,1,.2,l);
pwm = pwm';
sig = sin(t*20)+sin(t*34)+.2*sin(t*2000)+.2*sin(t*500);
sig = sig/3;
y = [y;[zeros(length(t),1),pwm.*sig]];
y = [y;[pwm.*sig,zeros(length(t),1)]];

clear pwm;
pwm = pwm(f,5,0.2,l);
pwm = pwm';
%sig = sin(t*34)+sin(t*2000)+sin(t*500);
%sig = sig/3;
y = [y;[zeros(length(t),1),pwm.*sig]];
y = [y;[pwm.*sig,zeros(length(t),1)]];


clear pwm;
pwm = pwm(f,10,0.1,l);
pwm = pwm';
%sig = sin(t*20)+sin(t*34)+.2*sin(t*2000)+.2*sin(t*500);
%sig = sig/3;

y = [y;[zeros(length(t),1),pwm.*sig]];
y = [y;[pwm.*sig,zeros(length(t),1)]];

y = [y;[chirp(t,fbegin,l,fend)+chirp(t,fend,l,fbegin),zeros(length(t),1)]/2];
y = [y;[zeros(length(t),1),chirp(t,fbegin,l,fend)+chirp(t,fend,l,fbegin)]/2];


l = 5;
t = linspace(0,l,f*l)';

for i = 0:3
    y = [y;[(chirp(t,20+180*rand(1),l,20+180*rand(1))+chirp(t,20+180*rand(1),l,20+180*rand(1))),(chirp(t,20+180*rand(1),l,20+180*rand(1))+chirp(t,20+180*rand(1),l,20+180*rand(1)))]/2];
end

y = y;
spectrogram(y(:,1)); % Display the spectrogram
soundsc(y,f);
plot(y);

audiowrite('basstest.flac',y,f);
