clc 
close all

X = data.reading;                                                           %cutoff resistance data from arduino
Y = data.cap;                                                               %actual capacitance connected to sensor for corresponding readings
po = 1;
cut = X(1):-1:X(end);                                                       %cutoff resistance linearized data to plot our function

modelfun = @(b,x)(b(1)+b(2)./(b(3)*x+b(4)));                                %model function used to calculate input capacitance.

beta0 = [0;-1E17;-1E8;1E13];                                                % this must be close to the correct function or it will diverge

opts = statset('nlinfit');                                                  %settings for nlinfit
opts = statset('MaxIter',100000);                                           %settings for nlinfit
opts.RobustWgtFun = 'bisquare';                                             %settings for nlinfit

b = nlinfit(X,Y,modelfun,beta0);                                            %calculates the beta values b starting at beta0 to find best nonlinear fit line to go from X through the "modelfun" function to get Y.

y = modelfun(b,cut);                                                        %calculates the expected output curve based on beta values b
figure
plot(X,Y,'o');
xlabel('cutoff resistance (ohms)');
hold on;
plot(cut,y);
ylabel('capacitance (picoFarads)');