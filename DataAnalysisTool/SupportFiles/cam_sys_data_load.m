function [] = cam_sys_data_load( varargin )
%cam_sys_data_load(...)
%
% USE: 
%
% Produces a structure containing the time data, x axis position, y axis
% position, z axis position, roll Euler angle, pitch Euler angle, and yaw
% Euler angle for each CSV file produced by Optitrack Tracking Tools 
% contained in a given directory. 
%
% SYNTAX: 
%   
% cam_sys_data_load( path )
%  
% Optional Inputs: 
%
%   path is a string containing the name of the directory containing the 
%   CSV files to be read in. If this argument is not included, the user
%   will be prompted to choose a director through a GUI menu. 
%
% Outputs: 
%
%   One or more instances of a structure containing vectors for time, 
%   position and orientation. For an output structure called data: 
%       data.t (time stamp vector)
%       data.x (x axis position vector)
%       data.y (y axis position vector) 
%       data.z (z axis position vector)
%       data.phi (roll Euler angle vector)
%       data.theta (pitch Euler angle vector)
%       data.psi (yaw Euler angle vector) 
%
%       ***The structure names will generally be the same as the CSV file
%       names, unless the file name is not a valid MATLAB variable name in
%       which case it will be renamed data#, where # will be the index
%       where the file would appear in the result of a dir or ls command. 
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
%
%

if isempty(varargin)
    path = uigetdir('.','Choose a directory containing the Optitrack CSV files you want to load.');
else
    path = varargin{end}; 
end

files = dir(path);

fileIndex = find(~[files.isdir]);

for k = 1:length(fileIndex)
    fileName = files(fileIndex(k)).name;
    
    if strcmpi('.csv',fileName(end-3:end))
        if isvarname(fileName(1:end-4)) 
            assignin('base',fileName(1:end-4),cam_sys_data_read([path,'\',fileName])); 
        else
            assignin('base',['data',num2str(k)],cam_sys_data_read([path,'\',fileName])); 
            disp([fileName(1:end-4),' has been renamed data',num2str(k),...
            ' in order to be a valid MATLAB variable name.']); 
        end
    else
        disp([fileName,' not loaded since it is not a CSV file.']); 
    end
end

end

