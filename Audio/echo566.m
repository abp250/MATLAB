clear all
close all
clc

[data,Fs] = audioread('air-horn-club-sample_1.mp3');
numecho = 5;
delay  = .2;
h = [[1,1]; zeros(delay*Fs,2)];
for i = 0:(numecho+1)
    h =  [h ; [1,1]; zeros(round(rand(1)*delay*Fs),2)];
end
hrand  = h;

h = [[1,1]; zeros(delay*Fs,2)];
for i = 0:(numecho+1)
    h =  [h ; [1,1]; zeros(round(i/numecho*delay*Fs),2)];
end

datae = [conv(data(:,1),h(:,1)),conv(data(:,2),h(:,2))];
%datae(2) = conv(data(:,2),h(:,2));

sound(datae,Fs);
audiowrite('output.wav',datae,Fs);