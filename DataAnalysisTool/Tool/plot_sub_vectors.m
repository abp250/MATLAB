function plot_sub_vectors(xval,varargin)
%PLOT_SUB_VECTORS This function plots 2x1 sub plots for the vectors
%passed to the function. The vectors are plotted against time.
%   xval        - the vector to be plotted against
%   varargin    - the vectors to be plotted (with optional formatting)

numOfVectors = 0;

for i = 1:length(varargin)
    
    % continue to the next iteration if the current argument is a plot
    % formatting string
    if(isPlotCharString(varargin{i}))
        continue;
    end
    
    % keeping track of the number of vectors to check for creation of new
    % figures
    numOfVectors = numOfVectors + 1;
    
    % creating new figure, if needed, and choosing the right axes
    if(mod(numOfVectors,2) == 1)
        figure;
        if(~(i == length(varargin)))
            subplot(2,1,1);
        end
    else
        subplot(2,1,2);
    end
    
    % plotting the vector
    if(i ~= length(varargin))
        if(isPlotCharString(varargin{i+1}))
            plot(xval,varargin{i},varargin{i+1});
        else
            plot(xval,varargin{i});
        end
    else
        plot(xval,varargin{i});
    end
    
    % labelling the plot
    title(inputname(i+1));
    xlabel(inputname(1));
    ylabel(inputname(i+1));
    xlim([0,xval(length(xval))]);
    grid ON;
    
end

end

