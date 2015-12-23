function [ sig ] = pwm( Fs, fPWM, duty , len )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if(duty > 1 || duty < 0)
    error('duty cycle must be a value between 1 and 0');
end
t = 0:1/Fs:len; 
t = linspace(0,len,Fs*len); 
c = .5+ .5*sawtooth(2*pi*fPWM*t);
n = length(c);
for i=1:n
    if(c(i)<duty)
        sig(i) = 1;
    else
        sig(i) = 0;
    end
end
end

