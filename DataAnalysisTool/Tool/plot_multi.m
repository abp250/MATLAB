function plot_multi(expData, useMarker, varargin)
%PLOT_MULTI This function is used to plot multiple headers on the same plot 
%   expData - structure that stores all of the data
%   useMarker   - flag to indicated whether or not to plot vertical lines
%                 at the marker locations
%   varargin - the header names and corresponding plotting parameters
%
%   Example of varargin: 'Pitch','r-','Roll','Yaw','go' 
%   This means that Pitch will be plotted in red solids, Roll with no
%   special formatting and Yaw in green circles.

% calculating number of headers
numOfHeaders = 0;
headers = {};
for i = 1:length(varargin)
    if(~isPlotCharString(varargin{i}))
        numOfHeaders = numOfHeaders + 1;
        headers{numOfHeaders} = varargin{i};
    end
end

% checking to see validity of varargin
if (length(varargin) > (numOfHeaders*2))
    error('Too many arguments entered');
end

% if the plotting style params for each header are different, diffPlotStyles = 1
diffPlotStyles = haveDiffPlotStyles(expData,headers);

% extracting time structure
time = expData.Time;

% extract markerlocations, if any
markerLocations = [];
if(useMarker)
    if(~isfield(expData,'Marker'))
        error('Error! Attempting to plot markers without Marker field');
    else
        markerLocations = find(expData.Marker.data);
    end
end

% initiliazing final plot statement to be executed
plotString = ['plot(time.data,expData.'];

% building the plot statement to be executed
for i = 1:length(varargin)
    entity = varargin{i};
    
    plotString = strcat(plotString,entity);
        
    if (i~=length(varargin))
        % adding plot style character string
        if (isPlotCharString(entity))
            % entity is a plot character string here
            plotString = strcat(plotString,''',time.data,expData.');
        else
            % entity is a header here
            
            plotString = strcat(plotString,'.data,');
            
            % extracting next entity 
            nextEntity = varargin{i+1};
            
            % checking to see if next entity is a plot character string
            if (isPlotCharString(nextEntity))
                % if yes, add the required inverted commas
                plotString = strcat(plotString,'''');
            else
                % if not, add the plot character string from header's params
                if(diffPlotStyles)
                    % if the headers have different plotting style params
                    if(isDefaultPlotCharString(eval(['expData.' entity '.params'])))
                        % if the plotting params are default, don't bother
                        plotString = strcat(plotString,'time.data,expData.');
                    else
                        % else, construct a plot char string and append
                        plotCharString = buildPlotCharString(eval(['expData.' entity '.params']));
                        plotString = strcat(plotString,'''');
                        plotString = strcat(plotString,plotCharString);
                        plotString = strcat(plotString,''',');
                        plotString = strcat(plotString,'time.data,expData.');
                    end
                else
                    % if two or more headers have the same plotting style
                    % params, don't construct their plot char strings  
                    plotString = strcat(plotString,'time.data,expData.');                    
                end
            end
            
        end
    else
        % this is the last entity in the varargin cell array
        
        if(isPlotCharString(entity))
             % if a plot character string, add the ending inverted comma
            plotString = strcat(plotString,''');');
        else
            % if not, add the header's data to the plotString
            plotString = strcat(plotString,'.data');
            % and also add the plot character string from its params
            if(diffPlotStyles)
                 % if the headers have different plotting style params
                if (isDefaultPlotCharString(eval(['expData.' entity '.params'])))
                    % if the plotting params are default, don't worry
                    plotString = strcat(plotString,');');
                else
                    % else, construct a plot char string and append
                    plotCharString = buildPlotCharString(eval(['expData.' entity '.params']));
                    plotString = strcat(plotString,',''');
                    plotString = strcat(plotString,plotCharString);
                    plotString = strcat(plotString,''');');
                end
            else
                % if two or more headers have the same plotting style
                % params, don't construct their plot char strings  
                plotString = strcat(plotString,');');
            end
        end
    end
   
end

%% plotting stuff
figure;                 % opening a new figure
whitebg(gcf,[1 1 1]);   % making sure the background is set to white
eval(plotString);       % plotting
grid ON;                % plotting grid lines
xlim([0,time.data(end)]); % setting x-axis limits
xlabel(['Time (' time.unit ')']);       % setting x-axis label

%constructing yAxisLabel
yAxisLabel = [];
for i = 1:numOfHeaders
    if i == numOfHeaders
        yAxisLabel = strcat(yAxisLabel,headers{i});
        if(eval(['isempty(expData.' headers{1} '.unit)']))
            break;
        else
            yAxisLabel = strcat(yAxisLabel,'(', eval(['expData.' headers{1} '.unit']),')');
        end
    else
        yAxisLabel = strcat(yAxisLabel,headers{i},',');
    end
end

ylabel(yAxisLabel);

% constructing statement for inserting the legend
legendString = ['legend('''];
for i = 1:numOfHeaders
    if(i == numOfHeaders)
        legendString = strcat(legendString,headers{i},''',''Location'',''NorthWest'');');
    else
        legendString = strcat(legendString,headers{i},''',''');
    end
end

eval(legendString);

% plotting markers, if any
for i = 1:numel(markerLocations)
    hold on;
    plot([time.data(markerLocations(i)) time.data(markerLocations(i))], ylim, 'LineStyle', '--', 'Color',[0.7 0.7 0.7]);
    text(time.data(markerLocations(i)),(min(ylim)+max(ylim))/2, num2str(i));
end
    
end

