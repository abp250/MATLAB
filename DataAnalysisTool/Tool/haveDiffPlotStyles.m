function y = haveDiffPlotStyles(data,headers)
%   haveDiffPlotStyles checks to see if the headers in the data structure
%   have different plotting parameters
%
%   This function ONLY compares the color, marker and style fields of the
%   params structure.

% initialize to true
y = 1;

% return 1 if only one
if(length(headers) == 1)
    y = 1;
    return
end

% obtaining the plotting params structure from each header
j = 0;
for i = 1:length(headers)
    
    entity = headers{i};
    headerPlotParams(i) = eval(['data.' entity '.params']);

end

% check if there are more than two defaults
numOfDefaults = 0;
for i = 1:length(headerPlotParams)
    if(isDefaultPlotCharString(headerPlotParams(i)))
        numOfDefaults = numOfDefaults + 1;
        if(numOfDefaults >= 2)
            y = 0;
            return
        end
    else
    end
end

% checking for equality between the plotting parameters
colorEqual = 0;
markerEqual = 0;
styleEqual = 0;
for i = 1:length(headerPlotParams)
    for j = 1:length(headerPlotParams)
       if(i == j)
           continue;
       else
           if(strcmp(headerPlotParams(i).color, headerPlotParams(j).color) == 1)
               colorEqual = 1;
           end
           if(strcmp(headerPlotParams(i).marker, headerPlotParams(j).marker) == 1)
               markerEqual = 1;
           end
           if(strcmp(headerPlotParams(i).marker, headerPlotParams(j).marker) == 1)
               styleEqual = 1;
           end
           
           if(colorEqual && markerEqual && styleEqual)
               y = 0;
               return;
           end
           colorEqual = 0;
           markerEqual = 0;
           styleEqual = 0;
       end 
    end
end

end

