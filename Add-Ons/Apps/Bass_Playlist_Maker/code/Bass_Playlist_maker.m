function varargout = Bass_Playlist_maker(varargin)
% BASS_PLAYLIST_MAKER MATLAB code for Bass_Playlist_maker.fig
%      BASS_PLAYLIST_MAKER, by itself, creates a new BASS_PLAYLIST_MAKER or raises the existing
%      singleton*.
%
%      H = BASS_PLAYLIST_MAKER returns the handle to a new BASS_PLAYLIST_MAKER or the handle to
%      the existing singleton*.
%
%      BASS_PLAYLIST_MAKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASS_PLAYLIST_MAKER.M with the given input arguments.
%
%      BASS_PLAYLIST_MAKER('Property','Value',...) creates a new BASS_PLAYLIST_MAKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Bass_Playlist_maker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Bass_Playlist_maker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Bass_Playlist_maker

% Last Modified by GUIDE v2.5 14-Nov-2015 23:32:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Bass_Playlist_maker_OpeningFcn, ...
                   'gui_OutputFcn',  @Bass_Playlist_maker_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Bass_Playlist_maker is made visible.
function Bass_Playlist_maker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Bass_Playlist_maker (see VARARGIN)

% Choose default command line output for Bass_Playlist_maker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Bass_Playlist_maker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Bass_Playlist_maker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
new_files = [dir('*.flac'); dir('*.mp3');  dir('*.wav')]';
files = [];
load('analysed_data.mat');
i = 1;
j = 1;
while j <= length(files)
    i = 1;
    while i <= length(new_files)
       if(strcmp(files(j).name, new_files(i).name))
           new_files(i) = [];
       else
          i = i+1; 
       end
    end
   j = j+1;
end

%}
%
for i = 1:length(new_files)
   iplus1 = length(files)+1;
   filename = new_files(i).name;
   set(handles.text2,'string',filename);
   [y,fs1] = audioread(filename);
   fs = 1E4;
   y = resample(y,fs,fs1);
   dt = 1/fs;                     % seconds per sample
   StopTime = length(y)*dt;                  % seconds
   t = (0:dt:StopTime-dt)';
   N = size(t,1);
   %% Fourier Transform:
   X = fftshift(fft(y));
   len = round(length(X)/2);
   X = abs(X(len:end,1)+X(len:end,2))/N;
   %% Frequency specifications:
   dF = fs/N;                      % hertz
   f = [0:dF:fs/2]';           % hertz
   %% analyse data
   [Max,Index] = max(X);
   files(iplus1).name = new_files(i).name;
   files(iplus1).name = new_files(i).name;
   files(iplus1).DomFreq = f(Index);
   files(iplus1).bassScore = sum(X(1:find(f>=60,1)))/sum(X)*100;
   files(iplus1).info = audioinfo(filename);
end
fileID = fopen('BASS.m3u','w');
fprintf(fileID,'#EXTM3U\n');

for i = 1:length(files)
    bassScores(i) = files(i).bassScore;
end

[Sorted,Index] = sort(bassScores, 'descend');

for i = Index(find(Sorted>10))
    fprintf(fileID,'#EXTINF:%i, %s - %s\n',round(files(i).info.Duration), files(i).info.Artist, files(i).info.Title);
    fprintf(fileID,'%s\n',files(i).name);
end

fclose(fileID);
save('analysed_data.mat','files')
set(handles.text2,'string','done :)');

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
