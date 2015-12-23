%% ANALYSIS CONFIGURATION OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modify your analysis configuration options here

% FNAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if you know the name of the log file that you want to parse, set the it
% here only if it is in the working directory. Otherwise, you may leave it
% blank. You will be able to choose the file to parse through an explorer
% window.
%
fname = '';  

% PLOTTING SWITCHES - set them to 0 or 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
plot            = 1;    % to choose plotting
separatePlot    = 1;    % to generate separatePlots
multiPlot       = 1;    % to generate multiPlot
subPlot         = 1;    % to generate subPlots
clearFigs       = 0;    % to close all the plots (needed only by the GUI)

% DATA TO PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SEPARATEDATA 
% write names of the data headers that you want to plot using
% seperatePlots. If this is empty but "plot" switch is 1, all the columns
% will be plotted using seperatePlots.
%
separateData = {'Pitch', 'Roll'};
                                                
% MULTIDATA
% write names of the data headers that you want to plot using multiPlots.
% If this is empty but "plot" switch is 1, the data headers in separateData
% will be plotted using multiPlots.
%
multiData = {}; 

% SUBDATA
% write names of the data headers that you want to plot using subPlots.
% If this is empty but "plot" switch is 1, the data headers in multiData
% will be plotted using subPlots.
%
subData = {};

% COLOR FOR PLOTTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
color       = 'r';      % one character for color of the plotting line
marker      = '';       % one character for the marker of the plotting line
style       = ':';      % one character for the style of the plotting line
backgnd     = [1 1 1];  % rgb array for background color of the plot


%% DO NOT MODIFY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fpath = '';
if(isempty(fname))
    [fname, fpath] = uigetfile('.txt','Select log file');
end

% storing file options in the structure
params.file.name = fname;               % file name only
params.file.path = fpath;               % file path only
params.file.pathName = [fpath fname];   % file path with file name


% storing plotting parameters in the structure
params.plotting.plot = plot;               
params.plotting.separatePlot = separatePlot;           
params.plotting.multiPlot = multiPlot;              
params.plotting.subPlot = subPlot;
params.plotting.clearFigs = clearFigs;

% storing plotting data in the structure
params.plotting.separateData = separateData;                
params.plotting.multiData = multiData;         
params.plotting.subData = subData;

% storing colors for plotting in the struture
params.plotting.color = color; 
params.plotting.marker = marker; 
params.plotting.style = style; 
params.plotting.backgnd = backgnd;

% saving params into a file
%save params params;

% DO NOT MODIFY - END
%% parsing the log file specified %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% parse the log and instantiate the data structure, expData
%
expData = parse_log(params.file.pathName, params); 

%save expData expData;

%% plotting routines %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the data accoriding to the plotting parameters set
%
plot_data(expData, params.plotting);

%% creating the main structure to be stored in the workspace %%%%%%%%%%%%%
%
main.params     = params;
main.expData    = expData;
clearvars -except main;
save main main;