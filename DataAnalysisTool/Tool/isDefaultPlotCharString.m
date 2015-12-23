function y = isDefaultPlotCharString(plotParams)
%isDefaultPlotCharString Compares the input plotParams structure to the
%default plotting format:
%       color   b
%       marker  (none)
%       style   -
%   Return 1 if it is the default plotting style. Returns 0 otherwise

defaultColor = 0;
defaultMarker = 0;
defaultStyle = 0;

% checking plotting color
if(plotParams.color == 'b' || isempty(plotParams.color))
    defaultColor = 1;
end

% checking plotting marker
if(isempty(plotParams.marker))
    defaultMarker = 1;
end

% checking plotting style
if(plotParams.style == '-' || isempty(plotParams.style))
    defaultStyle = 1;
end

% final check
if(defaultColor && defaultMarker && defaultStyle)
    y = 1;
else
    y = 0;
end

end

