function plotCharStr = buildPlotCharString(plotParams)
%buildPlotCharString builds a character string for plotting using the
%plotParams input structure
%   plotParams : structure that contains the plotting style parameters.
%       fields of plotParams:
%           plotParams.plot
%           plotParams.style
%           plotParams.color
%           plotParams.marker
%           plotParams.backgnd
%           

% keeps track of the index in the string
i = 1;
plotCharStr = '';
% color
if(~isempty(plotParams.color))
    plotCharStr = strcat(plotCharStr,plotParams.color);
end

% marker
if(~isempty(plotParams.marker))
    if(~strcmp(plotParams.marker,'none'))
        plotCharStr = strcat(plotCharStr,plotParams.marker);
    end
end

% style
if(~isempty(plotParams.style))
    plotCharStr = strcat(plotCharStr,plotParams.style);
end

% sanity check for the string
if(~isPlotCharString(plotCharStr))
    error('Wrong plot style formatting options, please use allowed values only');
end

end

