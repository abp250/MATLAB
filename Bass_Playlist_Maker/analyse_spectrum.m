close all
clear all
clc
new_files = [dir('*.flac'); dir('*.mp3');  dir('*.wav')]';
files = [];
if(exist('analysed_data.mat','file'))
    load('analysed_data.mat');
end
i = 1;
j = 1;
while j <= length(files)
    i = 1;
    found = 0;
    while i <= length(new_files)
       if(strcmp(files(j).name, new_files(i).name))
           new_files(i) = [];
           found = 1;
       else
          i = i+1;
       end
    end
    if(~found)
        files(j) = [];
    else
        j = j+1;
    end
end

%}
%
for i = 1:length(new_files)
   iplus1 = length(files)+1;
   filename = new_files(i).name
   %set(handles.text2,'string',filename);%for gui
   [y,fs1] = audioread(filename);
   fs = 1E4;
   y = resample(y,fs,fs1);
   dt = 1/fs;                     % seconds per sample
   StopTime = length(y)*dt;                  % seconds
   t = (0:dt:StopTime-dt)';
   N = size(t,1);
   %% Fourier Transform:
   X = fftshift(fft(y));
   len = round(length(X)/2);
   X = abs(X(len:end,1)+X(len:end,2))/N;
   %% Frequency specifications:
   dF = fs/N;                      % hertz
   f = [0:dF:fs/2]';           % hertz
   %% analyse data
   [Max,Index] = max(X);
   files(iplus1).name = new_files(i).name;
   files(iplus1).name = new_files(i).name;
   files(iplus1).DomFreq = f(Index);
   files(iplus1).bassScore = sum(X(1:find(f>=60,1)))/sum(X)*100;
   files(iplus1).info = audioinfo(filename);
end
fileID = fopen('BASS.m3u','w');
fprintf(fileID,'#EXTM3U\n');

for i = 1:length(files)
    bassScores(i) = files(i).bassScore;
end

[Sorted,Index] = sort(bassScores, 'descend');

for i = Index(find(Sorted>10))
    fprintf(fileID,'#EXTINF:%i, %s - %s\n',round(files(i).info.Duration), files(i).info.Artist, files(i).info.Title);
    fprintf(fileID,'%s\n',files(i).name);
end

fclose(fileID);
save('analysed_data.mat','files');
%set(handles.text2,'string','done :)');%for gui
%}

