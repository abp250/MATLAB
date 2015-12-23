function plot_sub(expData, useMarker, varargin)
%PLOT_SUB This function make sub 2x1 subplots of data headers mentioned
%   expData     - structure that holds all of the data
%   useMarker   - flag to indicated whether or not to plot vertical lines
%                 at the marker locations
%   varargin    - the data headers to be plotted along with optional
%                 formatting parameters
%
%   Example of varargin: 'Pitch','r-','Roll','Yaw','go' 
%   This means that Pitch will be plotted in red solids, Roll with no
%   special formatting and Yaw in green circles.

% extracting the Time structure
time = expData.Time;
currHeaderIndex = 0;

% extract markerlocations, if any
markerLocations = [];
if(useMarker)
    if(~isfield(expData,'Marker'))
        error('Error! Attempting to plot markers without Marker field');
    else
        markerLocations = find(expData.Marker.data);
    end
end

% calculating number of headers
numOfHeaders = 0;
for i = 1:length(varargin)
    if(~isPlotCharString(varargin{i}))
        numOfHeaders = numOfHeaders + 1;
    end
end


counter = 1;
x = ceil(sqrt(length(varargin)));
y = x - floor((x ^ 2 - length(varargin))/x);
figure_handle = figure;

% building the plot statement to be executed
for i = 1:length(varargin)
    
    % continue to next argument if the current argument is a plot
    % formatting string
    if(isPlotCharString(varargin{i}))
        continue;
    end
    
    % keeping track of the number of headers
    currHeaderIndex = currHeaderIndex + 1;
    
    % adding header name to the plot statment
    plotString = strcat('plot(time.data,expData.',varargin{i},'.data');
    
    % adding the plot formatting string if it exists
    if(i ~= length(varargin))
        if(isPlotCharString(varargin{i+1}))
            plotString = strcat(plotString,',''',varargin{i+1},''');');
        else
            % use the plotting style parameters set for this header
            plotCharString = buildPlotCharString(eval(['expData.' varargin{i} '.params']));
            plotString = strcat(plotString,',''', plotCharString, ''');');
        end
    else
        % use the plotting parameters set for this header
        plotCharString = buildPlotCharString(eval(['expData.' varargin{i} '.params']));
        plotString = strcat(plotString,',''', plotCharString, ''');');
    end
    
    
    % going to next plot axes and incramenting counter.
    subplot(x,y,counter);
    counter = counter + 1;
    
    %% plotting data and making it look pretty
    eval(plotString);
    title(varargin{i});
    xlabel(['Time (' time.unit ')']);
    if(eval(['isempty(expData.' varargin{i} '.unit)']))
        yAxisLabel = varargin{i};
    else
        yAxisLabel = [varargin{i} ' (' eval(['expData.' varargin{i} '.unit']) ')'];
    end
    ylabel(yAxisLabel);
    xlim([0,time.data(end)]);
    grid ON;
    set(gca,'Color',eval(['expData.' varargin{i} '.params.backgnd']));
    % plotting markers, if any
    if(useMarker)
        l = numel(markerLocations);
        for i = 1:l
            hold on;
            xm = time.data(markerLocations(i));
            ym = get(gca,'YLim');
            plot([xm xm], ym, 'LineStyle', '--', 'Color',[0.7 0.7 0.7]);
            ym = ym(1)+(1/l)*i*(ym(2)-ym(1));
            text('String',strcat('M',num2str(i),'>'),'Position',[xm,ym],'HorizontalAlignment','right')
        end
    end
    
end

%linking all plot's X axis.
all_ha = findobj( figure_handle, 'type', 'axes', 'tag', '' );
linkaxes( all_ha, 'x' );

end