

H = 10^(23/20)/(1+s/(40*pi*10^6)+s^2/(40*pi*10^6)^2)

zer = zero(H)
pol = pole(H)

S = stepinfo(H,'SettlingTimeThreshold',.01)