close all
clear all
clc
s = serial('COM3');
fopen(s)
fprintf(s,'*IDN?')
for i = 1:1000
D(i) = fscanf(s);
end
fclose(s)