clear all
close all

FS = 4E9;
T = 1/FS;

F = [1E5,1E6,1E7,1E8];

for i = T:T:.0001
  Y(round(i*FS)) = cos(i*F(ceil(i*40000))*(2*pi));
end
audiowrite('output2.wav',Y, FS);