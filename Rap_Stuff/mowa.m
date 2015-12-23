clear all;
close all;
[data,Fs] = audioread('LawnMower.mp3');

data = data(300000:800000,1)';

time = 0:1/Fs:length(data)*1/Fs;
fftdata = abs(fft(data));
fftdata = fftdata(1:(end/2));
plot(fftdata);

psdest = psd(spectrum.periodogram,data,'Fs',Fs,'NFFT',length(data));
I = psdest.Data;

dt = 1/Fs; % define a time increment (seconds per sample)
N = length(data);
Nyquist = 1/(2*dt); % Define Nyquist frequency
df = 1 / (N*dt); % Define the frequency increment
G = fftshift(fft(data)); % Convert "g" into frequency domain and shift to frequency range below
f = -Nyquist : df : Nyquist-df; % define frequency range for "G".
G_new = G.*(1j*2*pi*f);
data_new = abs(ifft(ifftshift(G_new)));

plot(data_new);

soundsc(data_new,Fs);


