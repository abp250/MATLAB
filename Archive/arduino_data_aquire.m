% Works but at low freq (25 Hz) and not for long (too much data)
clear all;
s1 = serial('COM3');                            %define serial port
s1.BaudRate=115200;                               %define baud rate
     
%open serial port
fopen(s1);
clear data;
i=0;
figure(1);
hold on;
while(1)
        i=i+1;
        data = fscanf(s1); %read sensor
        data = str2num(data);
        plot(i,data,'o','markersize',3);
        drawnow;
end
% close the serial port!
fclose(s1);


% delete all ports 
%delete(instrfindall)