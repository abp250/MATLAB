function data = cam_sys_data_read(filename)
%cam_sys_data_read(...)
%
% USE: 
%
% Produces a structure containing the time data, x axis position, y axis
% position, z axis position, roll Euler angle, pitch Euler angle, and yaw
% Euler angle from a CSV file produced by Optitrack Tracking Tools. 
%
% SYNTAX: 
%   
% data = cam_sys_data_read(filename)
%  
% Inputs: 
%
%   filename is a string containing the name of the CSV file to be read in
%
% Outputs: 
%
%   data is a structure containing vectors for time, position and
%   orientation: 
%       data.t (time stamp)
%       data.x (x axis position)
%       data.y (y axis position) 
%       data.z (z axis position)
%       data.phi (roll Euler angle *(as reported by Tracking Tools)) 
%       data.theta (pitch Euler angle *(as reported by Tracking Tools)) 
%       data.psi (yaw Euler angle *(as reported by Tracking Tools)) 
%       data.qx = 1st quaternion component  
%       data.qy = 1st quaternion component
%       data.qz = 1st quaternion component
%       data.qw = 1st quaternion component
%
%       *The Euler Angles reported by Tracking Tools may be incorrect
%       depending on the setup of the axes. As of 3-14-13, they are
%       incorrect since the axes are set up to provide the correct
%       information for the VRPN decoding of the MicroCART base station
%       software, which assumes a Yaw-Pitch-Roll sequence of rotations.
%       The quaternions can be used to obtain the correct Euler angles if
%       the rotation sequence is known. 
%  
%
% AUTHOR(s): 
%
%   Matt Rich 
%   Graduate Student 
%   Electrical and Computer Engineering Department
%   Iowa State University 
%   m87rich@iastate.edu
%
% LAST MODIFIED: 
%   
%   13-Mar-2012 (Matt Rich) : initial creation
%   14-Mar-2013 (Matt Rich) : added quaternion extraction 
%
%

[num,txt,raw] = xlsread(filename);

data.t = raw(45:end,3); data.t = [data.t{1:2:end}]; 

data.x = raw(45:end,6); data.x = [data.x{1:2:end}];
data.y = raw(45:end,7); data.y = [data.y{1:2:end}];
data.z = raw(45:end,8); data.z = [data.z{1:2:end}];

data.psi = raw(45:end,13); data.psi = [data.psi{1:2:end}]; 
data.theta = raw(45:end,14); data.theta = [data.theta{1:2:end}]; 
data.phi = raw(45:end,15); data.phi = [data.phi{1:2:end}]; 

data.qx = raw(45:end,9); data.qx = [data.qx{1:2:end}];
data.qy = raw(45:end,10); data.qy = [data.qy{1:2:end}];
data.qz = raw(45:end,11); data.qz = [data.qz{1:2:end}];
data.qw = raw(45:end,12); data.qw = [data.qw{1:2:end}];

end
