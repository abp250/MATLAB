close all;clear all;
files = {'a.flac'}
s = [20, 21];
figure_handle = figure;
for i = 1:length(files);
audioinfo(files{i})
[Y{i}, fs{i}] = audioread(files{i});
start{i} = find(Y{i} > .1 ,1,'first');
Y{i} = Y{i}(start{i}:length(Y{i}),:);
T{i} = 1/fs{i}:1/fs{i}:(length(Y{i})/fs{i});
T{i} = transpose(T{i});
T{i}(start{i})
Ys{i} = Y{i}(T{i} > s(1) & T{i} < s(2),:);
Ts{i} = T{i}(T{i} > s(1) & T{i} < s(2),:);
subplot(length(files),1,i); 
plot(Ts{i},Ys{i});  
end
all_ha = findobj( figure_handle, 'type', 'axes', 'tag', '' );
linkaxes( all_ha, 'x' );