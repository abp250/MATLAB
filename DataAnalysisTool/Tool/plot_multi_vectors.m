function plot_multi_vectors(xval, varargin)
%PLOT_MULTI_VECTORS This function plots multiple vectors on the same plot.
%The vectors are plotted against time.
%   xval        - the vector to be plotted against
%   varargin    - the vectors to be plotted (with optional formatting)

vectorNames = cell(length(varargin),1);
numOfVectors = 0;

for i = 1:length(varargin)
    
    dataHeader = varargin{i};
    
    if(isPlotCharString(dataHeader))
        continue;
    end
    
    % track the number of vectors to be used for legend creation
    numOfVectors = numOfVectors + 1;
    vectorNames{numOfVectors} = inputname(i+1);
    
    % plotting the individual vectors (with formatting)
    if(i ~= length(varargin))
        if(isPlotCharString(varargin{i+1}))
            plot(xval,dataHeader,varargin{i+1});
        else
            plot(xval,dataHeader);
        end
    else
        plot(xval,dataHeader);
    end
    
    % hold the plot for the next vectors
    if (numOfVectors == 1)
        hold all;
    end
    
end

grid ON;
xlabel(inputname(1));
xlim([0,xval(length(xval))]);

% constructing statement for inserting the legend
legendString = ['legend('''];
for i = 1:numOfVectors
    if(i == numOfVectors)
        legendString = strcat(legendString,vectorNames{i,1},''',''Location'',''NorthWest'');');
    else
        legendString = strcat(legendString,vectorNames{i,1},''',''');
    end
end
eval(legendString);

end

