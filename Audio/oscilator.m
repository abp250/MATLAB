C = .047E-6  %uf
R1 = 10000;
R2 = 1000;

duty = 100*(R1+R2)/(R1+2*R2)
f = 1/(.69*C*(R1+2*R2))