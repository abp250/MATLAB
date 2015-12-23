function y = isPlotCharString(str)
% isPlotCharString sees if the str is composed of characeters that are used
% in making up a plot formatting string.
%   str - string to check

if (length(str) <= 4)
    
    % if the input string is empty, it is a valid plot formatting character
    % string
    if(length(str) == 0)
        y = 1;
        return
    end
    
    % list of possible characters allowed in the string
    plotTypeChars = ['bgrcmykw.ox+*sdv^<>ph-:.'];
    
    for i = 1:length(str)
        if (ismember(str(i),plotTypeChars))
            y = 1;
            continue
        else
            y = 0;
            break;
        end
    end
    
else
    y = 0;
end

end