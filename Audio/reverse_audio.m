close all;clear all;
f = ls;

for i = 1:size(f)
    x{i} = strrep(f(i,:), ' ', '');
    a = strsplit(x{i},'.');
    
    if(strcmp(a(length(a)),'flac'))
    files{i} = a(1,1);
    end
end

for i = 1:length(files);
audioinfo(files{i})
[Y{i}, fs{i}] = audioread(files{i});
Y{i} = flipud(Y{i});
a = strsplit(files{i},'.');
audiowrite(strcat(fliplr(a{1}),'.flac'),Y{i},fs{i});
end
