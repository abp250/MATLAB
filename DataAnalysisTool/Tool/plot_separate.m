function plot_separate(expData, useMarker, varargin)
%PLOT_SEPARATE This function plots separate plots for the data-headers
%passed to the function
%   expData     - structure that contains all the data
%   useMarker   - flag to indicated whether or not to plot vertical lines
%                 at the marker locations
%   varargin    - the headers of the data to be plotted
%
%   Example of varargin: 'Pitch','r-','Roll','Yaw','go' 
%   This means that Pitch will be plotted in red solids, Roll with default 
%   formatting and Yaw in green circles.

time = expData.Time; % extracting time structure
markerLocations = [];

% extract markerlocations, if any
if(useMarker)
    if(~isfield(expData,'Marker'))
        error('Error! Attempting to plot markers without Marker field');
    else
        markerLocations = find(expData.Marker.data);
    end
end

% bulding the plot statement that will be executed
for i = 1:length(varargin)
    
    dataHeader = varargin{i};
    
    % continue to next iteration if current argument is a plotting character string
    if(isPlotCharString(dataHeader))
        continue;
    end
    
    % adding the header to the plot statment to be executed
    plotString = strcat('plot(time.data,expData.',dataHeader,'.data');
    
    % adding plot formatting string, if it exists
    if(i ~= length(varargin))
        if(isPlotCharString(varargin{i+1}))
            plotString = strcat(plotString,',''',varargin{i+1},''');');
        else
            % use the plotting parameters set for this header
            plotCharString = buildPlotCharString(eval(['expData.' dataHeader '.params']));
            plotString = strcat(plotString,',''', plotCharString, ''');');
        end
    else
        % use the plotting parameters set for this header
        plotCharString = buildPlotCharString(eval(['expData.' dataHeader '.params']));
        plotString = strcat(plotString,',''', plotCharString, ''');');
    end
    
    % plotting data and making it look good
    figure;
    whitebg(gcf,eval(['expData.' dataHeader '.params.backgnd']));   % setting background
    eval(plotString);   % plotting
    title(dataHeader);  % setting title
    xlabel(['Time (' time.unit ')']);   % setting the x-axis label
    if(eval(['isempty(expData.' dataHeader '.unit)']))
        yAxisLabel = dataHeader;
    else
        yAxisLabel = [dataHeader ' (' eval(['expData.' dataHeader '.unit']) ')'];
    end
    ylabel(yAxisLabel); % setting y-axis label
    xlim([0, time.data(end)]); % setting x-axis limits
    grid ON;    % setting grid lines on the graph
    % adding markers
    for i = 1:numel(markerLocations)
        hold on;
        plot([time.data(markerLocations(i)) time.data(markerLocations(i))], ylim, 'LineStyle', '--', 'Color',[0.7 0.7 0.7]);
        text(time.data(markerLocations(i)),(min(ylim)+max(ylim))/2, num2str(i));
    end
    
end

end

