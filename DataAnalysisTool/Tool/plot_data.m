function plot_data(expData, plotParams)
%PLOT_DATA This function plots the data according to the parameters mentioned in params
%   expData     - structure that contains the data to be plotted
%   plotParams  - structure that contains the plotting options

% check plotting switch
if (~plotParams.plot) 
    disp('No plotting');
else
    %% check separate plotting switch
    if(plotParams.separatePlot)
        
        % bulding the plot_separate statement that will be executed
        if (isfield(expData,'Marker'))
            plot_separateString = 'plot_separate(expData,1,''';
        else
            plot_separateString = 'plot_separate(expData,0,''';
        end
        
        % extracting data headers to plot
        if(isempty(plotParams.separateData))
            headers = fieldnames(expData);  % if none mentioned, use all of the headers
            headers = headers(2:end);       % except Time :)
        else
            headers = plotParams.separateData;
        end
        
        % adding the headers to the plot_separate statement
        for i = 1:length(headers)
            if(i==length(headers))
                plot_separateString = strcat(plot_separateString,headers{i},''');');
            else
                plot_separateString = strcat(plot_separateString,headers{i},''',''');
            end
        end
        
        % executing the plot_separate statement
        eval(plot_separateString);
    end
    
    %% check multi plotting switch
    if(plotParams.multiPlot)
        
        % building the plot_multi statement that will be executed
        if (isfield(expData,'Marker'))
            plot_multiString = 'plot_multi(expData,1,''';
        else
            plot_multiString = 'plot_multi(expData,0,''';
        end
        
        
        % extracting data headers to plot
        if(isempty(plotParams.multiData)) % if none mentioned, use headers for separate plotting
            if(isempty(plotParams.separateData))
                headers = fieldnames(expData); % if no headers mentioned for separate plotting, use all of the headers
            else
                headers = plotParams.separateData;
            end
        else
            headers = plotParams.multiData;
        end
        
        % adding the headers to the plot_multi statement
        for i = 1:length(headers)
            if(i==length(headers))
                plot_multiString = strcat(plot_multiString,headers{i},''');');
            else
                plot_multiString = strcat(plot_multiString,headers{i},''',''');
            end
        end
        
        % executing the plot_multi statement
        eval(plot_multiString);
    end
    
    %% check sub plotting switch
    if(plotParams.subPlot)
        
        % building the plot_sub statement that will be executed
        if (isfield(expData,'Marker'))
            plot_subString = 'plot_sub(expData,1,''';
        else
            plot_subString = 'plot_sub(expData,0,''';
        end
        
        
        % extracting data headers to plot
        if(isempty(plotParams.subData)) % if none mentioned, use headers mentioned for multi plotting
            if(isempty(plotParams.multiData)) % if no headers mentioned for multi plotting, use headers mentioned for separate plotting
                if(isempty(plotParams.separateData)) % if no headers mentioned for separate plotting, use all of the headers
                    headers = fieldnames(expData);
                else
                    headers = plotParams.separateData;
                end
            else
                headers = plotParams.multiData;
            end
        else
            headers = plotParams.subData;
        end
        
        % adding the headers to the plot_sub statement
        for i = 1:length(headers)
            if(i==length(headers))
                plot_subString = strcat(plot_subString,headers{i},''');');
            else
                plot_subString = strcat(plot_subString,headers{i},''',''');
            end
        end
        
        % executing the plot_sub statement
        eval(plot_subString);
    end
    
end


end

