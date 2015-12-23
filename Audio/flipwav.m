function [temp] = flipwav( filename )
[y,fs] = wavread(filename);
x = flipud(y);
flipname = fliplr(filename);
wavwrite(x,fs,flipname);
end

