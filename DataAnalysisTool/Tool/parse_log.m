function [loggedData] = parse_log(filename, params, expData)
%parse_log This independent function parses the data stored in the file and
%returns a structure containing the data
%   filename    - this is the complete path of the file with the filename
%   params      - this is the params structure which holds the analysis
%                 configuration options

% Check if file exists
if (~exist(filename,'file'))
    error(strcat(filename, ' does not exist'));
end

% Open file
FileID = fopen(filename, 'r');

% Gets the first line of the file
string = fgetl(FileID);

% Test first line, if not formatted correctly, reject
if(size(regexp(string, '^#')) == 0)
    error(strcat(filename, ' is not properly formatted, and does not contain "#" headers'));
end

% Loop through header lines
while( regexp(string, '^#') == 1 )
    
    %Print out string and move on
    disp(string)
    old = string;
    string = fgetl(FileID);
    
end

% Two possibilities for the next two lines:
%   1) line of headers
%   2) line of units
foundHeaders = 0;
foundUnits = 0;

% Checking current line's type:
identifier = string(1);

if (regexp(identifier,'%'))
    foundHeaders = 1;
    % this is a line of headers; extract headers:
    headers = strsplit(string);
    headers{1} = strrep(headers{1},'%', '');
    numOfHeaders = length(headers);
else
    if (regexp(identifier,'&'))
        foundUnits = 1;
        % this is a line of units; extract units:
        units = strsplit(string);
        units{1} = strrep(units{1},'&','');
    else
         error(strcat(filename, ' is not properly formatted, contains undefined line identifier.'));
    end
end

% Obtaining the next line
string = fgetl(FileID); 
identifier = string(1);

if(foundHeaders)
    if(regexp(identifier,'&'))
        foundUnits = 1;
        % this is a line of units; extract units:
        units = strsplit(string);
        units{1} = strrep(units{1},'&','');
    else
        error(strcat(filename, ' is not properly formatted, contains or undefined/excessive line identifiers.'));
    end
else
    if(foundUnits)
        if(regexp(identifier,'%'))
            % this is a line of headers; extract headers:
            headers = strsplit(string);
            headers{1} = strrep(headers{1},'%', '');
            numOfHeaders = length(headers);
        end
    else
        error('Should never be able to get here');
    end
end

% sanity check and clean up
if(numOfHeaders ~= length(units))
    error(strcat(filename, ' is not properly formatted, contains unmatched number of units and headers'));
end
clear foundHeaders foundUnits;

% Get all data into a single matrix called "log"
log = [];
line = zeros(1,numOfHeaders);
while ~feof(FileID)
    line = textscan(FileID, '%f', numOfHeaders);
    line = transpose(cell2mat(line));
    log = [log;line];
end

% Converting the log matrix into a expData structure.
for i = 1:numOfHeaders
    
    eval(['loggedData.' headers{i} '.data = log(:,i);']);           % adding data
    eval(['loggedData.' headers{i} '.unit = cell2mat(units(i));']);           % adding unit
    eval(['loggedData.' headers{i} '.params.plot = 0;']);           % adding params.plot
    eval(['loggedData.' headers{i} '.params.style = ''-'';']);      % adding params.style
    eval(['loggedData.' headers{i} '.params.color = ''b'';']);      % adding params.color
    eval(['loggedData.' headers{i} '.params.marker = ''none'';']);      % adding params.marker
    eval(['loggedData.' headers{i} '.params.backgnd = [1 1 1];']);  % adding params.backgnd
    
end

% data types are set
if( exist('params', 'var') && exist( 'expData','var'))
    
    % setting the value of <header-name>.params.plot value
    if((params.plotting.plot == 1) && isempty(setdiff(headers,expData.datafields)))
        
        if(params.plotting.subPlot == 1)
            if(isempty(params.plotting.subData))
                if(isempty(params.plotting.multiData))
                    if(isempty(params.plotting.separateData))
                        for i = 1:numOfHeaders
                            eval(['loggedData.' headers{i} '.params.plot = 1;']);
                        end
                    else
                        for i = 1:length(params.plotting.separateData)
                            eval(['loggedData.' params.plotting.separateData{i} '.params.plot = 1;']);
                        end
                    end
                    
                else
                    for i = 1:length(params.plotting.multiData)
                        eval(['loggedData.' params.plotting.multiData{i} '.params.plot = 1;']);
                    end
                end
            else
                for i = 1:length(params.plotting.subData)
                    eval(['loggedData.' params.plotting.subData{i} '.params.plot = 1;']);
                end
            end
        end
        
        if(params.plotting.multiPlot == 1)
            if(isempty(params.plotting.multiData))
                if(isempty(params.plotting.separateData))
                    for i = 1:numOfHeaders
                        eval(['loggedData.' headers{i} '.params.plot = 1;']);
                    end
                else
                    for i = 1:length(params.plotting.separateData)
                        eval(['loggedData.' params.plotting.separateData{i} '.params.plot = 1;']);
                    end
                end
            else
                for i = 1:length(params.plotting.multiData)
                    eval(['loggedData.' params.plotting.multiData{i} '.params.plot = 1;']);
                end
            end
        end
        
        if(params.plotting.separatePlot == 1)
            if(isempty(params.plotting.separateData))
                for i = 1:numOfHeaders
                    eval(['loggedData.' headers{i} '.params.plot = 1;']);
                end
            else
                for i = 1:length(params.plotting.separateData)
                    eval(['loggedData.' params.plotting.separateData{i} '.params.plot = 1;']);
                end
            end
        end
        
        
    else
        % nothing really needed to do here since the default value of
        % <header-name>.params.plot is 0
    end 
    
    % setting the following values to those set in DataAnalysis.m
    % 1) <header-name>.params.style
    % 2) <header-name>.params.color
    % 3) <header-name>.params.marker
    % 4) <header-name>.params.backgnd
    for i = 1:numOfHeaders
        
        eval(['loggedData.' headers{i} '.params.style = params.plotting.style;']);
        eval(['loggedData.' headers{i} '.params.color = params.plotting.color;']);
        eval(['loggedData.' headers{i} '.params.marker = params.plotting.marker;']);
        eval(['loggedData.' headers{i} '.params.backgnd = params.plotting.backgnd;']);
        
    end
end

% converting time to relative time
loggedData.Time.data = loggedData.Time.data - loggedData.Time.data(1);

% this is to parse the Marker field, if it exists
if (isfield(loggedData,'Marker'))
    
    c = zeros(numel(loggedData.Marker.data),1);
    
    for i = 2: numel(loggedData.Marker.data)
         if (loggedData.Marker.data(i)>loggedData.Marker.data(i-1))
             c(i) = loggedData.Marker.data(i);
         end
    end
    
    loggedData.Marker.data = c;
     
end

% if expData was sent in as a variable, then update the plotting parameters
% of loggedData to be the same as that in the existing data structure
if (exist('expData','var'))
    if(isempty(setdiff(headers,expData.datafields)))
    for i = 1:numOfHeaders
        
        eval(['loggedData.' headers{i} '.params.style = expData.' headers{i} '.params.style;']);
        eval(['loggedData.' headers{i} '.params.color = expData.' headers{i} '.params.color;']);
        eval(['loggedData.' headers{i} '.params.marker = expData.' headers{i} '.params.marker;']);
        eval(['loggedData.' headers{i} '.params.backgnd = expData.' headers{i} '.params.backgnd;']);
        
    end
    end
end

end

