clear all
close all
X = [0 0 0 0 0 1 1 1 1 1 2 2 2 2 3 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4]; % the input data
fig=figure; hax=axes; 
plot(X)

hold on

Xd = diff(X);  % differentiating it and putting a 1 where it changes

plot(Xd)

M = find(Xd') %finding the indices of 1s 



hold on 
plot(1:length(X),X) 
SP=1; %your point goes here 
for i = 1:length(M)
    line([M(i) M(i)], get(hax,'YLim'),'Color','red')
end
