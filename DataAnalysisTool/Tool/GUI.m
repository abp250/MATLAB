function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 03-Jul-2015 10:11:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% MATLAB auto-generated comments ---------------------------
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

handles.filepath = hObject;
handles.filepath = mfilename('fullpath');
handles.filepath = strrep(handles.filepath, 'GUI', '');
addpath(handles.filepath);
cd(handles.filepath);
if (~exist(handles.filepath,'file'))
     error(strcat(handles.filepath, ' does not exist'))
end

if(~isfield(handles, 'axes'))
    %I did this to make looping through all the axes, toggle buttons and radio buttons MUCH simpler
    for i = 1:12 
        eval(['handles.axes{' num2str(i) '} = handles.axes' num2str(i) ';']);
        eval(['handles = rmfield(handles,''axes' num2str(i) ''');']);
        eval(['handles.togglebuttons{' num2str(i) '} = handles.togglebutton' num2str(i) ';']);
        eval(['handles = rmfield(handles,''togglebutton' num2str(i) ''');']);
        eval(['handles.radiobutton{' num2str(i) '} = handles.radiobutton' num2str(i) ';']);
        eval(['handles = rmfield(handles,''radiobutton' num2str(i) ''');']);
    end    
    %just to be consistent i did the same for the option radiobuttons
    for i = 13:16
        eval(['handles.radiobutton{' num2str(i) '} = handles.radiobutton' num2str(i) ';']);
        eval(['handles = rmfield(handles,''radiobutton' num2str(i) ''');']);
    end   
end
handles.main = hObject;
handles.main = struct();

if(evalin('base','exist(''main'')'))
    handles.main = importData(hObject, eventdata, handles);
    handles = loadOptions(hObject, eventdata, handles);
    previewPlot(hObject, eventdata, handles);
    if(~isfield(handles.main.params.file,'pathName'))
        handles.main.params.file.name = '';
        handles.main.params.file.path = handles.filepath;
        handles.main.params.file.pathName = handles.filepath;
    end
else
    handles.main.params.file.name = '';
    handles.main.params.file.path = handles.filepath;
    handles.main.params.file.pathName = handles.filepath;
end
cd(handles.main.params.file.path);
load_listbox(hObject, eventdata, handles)
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% DO NOT MODIFY UNLESS YOU KNOW WHAT YOUR DOING
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close figure1.
%     Close function
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% executes when the GUI is closed either by command from matlab terminal or
% with the operating system x on the top right of the GUI.
% MATLAB auto-generated comments ---------------------------
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
cd(handles.filepath);
% Hint: delete(hObject) closes the figure
delete(hObject);

% --- Executes when selected object is changed in uipanel1
%     Modification of 'edit plotting options' selection
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% contains radiobuttons that control plot customizations customizations. 
% this runs every time any radio button selection labeled "edit plotting options" is
% changed
if(isfield(handles.main,'expData'))
previewPlot(hObject, eventdata, handles)
end

% --- Executes when selected object is changed in uipanel3.
%     Modification of Figure Options radio buttons or checkboxes
function uipanel3_SelectionChangeFcn(hObject, eventdata, handles)
% contains plotting options variables, selecting anything will require
% replotting for previewing to be consistent with resulting plots
% MATLAB auto-generated comments ---------------------------
% hObject    handle to the selected object in uipanel3 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

handles.main.params.plotting.separatePlot = 0;           % to generate separate plots
handles.main.params.plotting.multiPlot = 0;              % to super impose multiple quantities on the same plot
handles.main.params.plotting.subPlot = 0; 

switch get(get(handles.uipanel3,'SelectedObject'),'Tag')
case 'radiobutton14',  handles.main.params.plotting.separatePlot = 1;
case 'radiobutton15',  handles.main.params.plotting.subPlot = 1; 
case 'radiobutton16',  handles.main.params.plotting.multiPlot = 1;
    otherwise
        error('You must select a radio button to indicate what field''s options you are changing.')
end
exportData(hObject, eventdata, handles);
previewPlot(hObject, eventdata, handles);
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
%     Plot Data
function pushbutton2_Callback(hObject, eventdata, handles)
% this clears all figures and passes data structure on to plot_data
% function for plotting
% MATLAB auto-generated comments ---------------------------
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles.main = importData(hObject, eventdata, handles);

if(handles.main.params.plotting.clearFigs)   %executes if the 'clear figs' option is set to 1.
    set(handles.figure1, 'HandleVisibility', 'off');
    close all;
    set(handles.figure1, 'HandleVisibility', 'on');
end

plot_data(handles.main.expData, handles.main.params.plotting);

guidata(hObject,handles);

% --- Executes on button press in pushbutton3.
%     Apply Options
function pushbutton3_Callback(hObject, eventdata, handles)
% applies selected options to radio button selected data field and stores
% data in the structure.
% MATLAB auto-generated comments ---------------------------
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
switch get(get(handles.uipanel1,'SelectedObject'),'Tag')
case 'radiobutton1',  i = 2;
case 'radiobutton2',  i = 3;
case 'radiobutton3',  i = 4;
case 'radiobutton4',  i = 5;
case 'radiobutton5',  i = 6;
case 'radiobutton6',  i = 7;
case 'radiobutton7',  i = 8;
case 'radiobutton8',  i = 9;
case 'radiobutton9',  i = 10;
case 'radiobutton10',  i = 11;
case 'radiobutton11',  i = 12;
case 'radiobutton12',  i = 13;   
case 'radiobutton13',  i = 1;
    otherwise
        error('You must select a radio button to indicate what field''s options you are changing before pressing this button.')
end

color = get(handles.listbox1,'String');
color = color(get(handles.listbox1,'Value'));
style = get(handles.listbox2,'String');
style = style(get(handles.listbox2,'Value'));
marker = get(handles.listbox3,'String');
marker = marker{get(handles.listbox3,'Value')};
bg = get(handles.listbox4,'String');
bg = bg(get(handles.listbox4,'Value'));
handles.main.expData.params{i}.color = color;
handles.main.expData.params{i}.style = cell2mat(style);
handles.main.expData.params{i}.marker = marker;
handles.main.expData.params{i}.backgnd = bg;
exportData(hObject, eventdata, handles);
previewPlot(hObject, eventdata, handles);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);

% --- Executes on button press in pushbutton4.
%     Refresh File Browser Listbox
function pushbutton4_Callback(hObject, eventdata, handles)
% refreshes browser listbox(5).
% allows a one-click refresh.
% MATLAB auto-generated comments ---------------------------
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  isdir(handles.main.params.file.pathName)
        cd (handles.main.params.file.pathName);
        handles.main.params.file.path = cd;
        handles.main.params.file.pathName = cd;
        addpath(cd);
        load_listbox(hObject, eventdata, handles);
        cd handles.main.params.file.path;
end

% --- Executes on selection change in listbox5.
%     File Browser Listbox
function listbox5_Callback(hObject, eventdata, handles)
% This is a directory browser that allows user to easily navigate to the
% logfile without having to click through a popup browser. It also stays in
% the directory of the current log for ease of use.
% MATLAB auto-generated comments ---------------------------
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5
handles = guidata(hObject);
get(handles.figure1,'SelectionType');
if strcmp(get(handles.figure1,'SelectionType'),'open')
    index_selected = get(handles.listbox5,'Value');
    file_list = get(handles.listbox5,'String');
    [path, handles.main.params.file.name, ext] = fileparts(file_list{index_selected});
    handles.main.params.file.name = strcat(handles.main.params.file.name,ext);
    handles.main.params.file.pathName = strcat(handles.main.params.file.path,'\', handles.main.params.file.name);
    if  isdir(handles.main.params.file.pathName)
        cd (handles.main.params.file.pathName);
        handles.main.params.file.path = cd;
        handles.main.params.file.pathName = cd;
        addpath(cd);
        load_listbox(hObject, eventdata, handles);
    else
        cd(handles.main.params.file.path);
        switch ext
            case '.txt'
            
                if(isfield(handles.main.params,'plotting'))
                    if(isfield(handles.main,'expData'))
                        handles.main.expData = parse_log(handles.main.params.file.pathName,handles.main.params,handles.main.expData);
                    else
                        handles.main.expData = parse_log(handles.main.params.file.pathName,handles.main.params);
                    end
                else
                    handles.main.params = set_params(hObject, eventdata, handles);
                    handles.main.expData = parse_log(handles.main.params.file.pathName,handles.main.params);
                end
                handles.main = generateGuiData(hObject, eventdata, handles);
                exportData(hObject, eventdata, handles);
                handles.main = importData(hObject, eventdata, handles);
                handles = updateOptions(hObject, eventdata, handles);
                handles = loadOptions(hObject, eventdata, handles);
                set(handles.text5,'string',strcat('Current Log:	', handles.main.params.file.pathName));
                previewPlot(hObject, eventdata, handles);
                                
            case '.mat'
                handles.main = importData(hObject, eventdata, handles);
                handles = updateOptions(hObject, eventdata, handles);
                handles = loadOptions(hObject, eventdata, handles);
                set(handles.text5,'string',strcat('Current Log:', handles.main.params.file.pathName));
                previewPlot(hObject, eventdata, handles);
                
            otherwise
            try
                open(handles.main.params.file.pathName,handles.main.params);
            catch ex
                errordlg(ex.getReport('basic'),'File Type Error','modal');
            end
            
        end
    end
end

guidata(hObject,handles);


%% Extra Functions
% Used by above

% --- Plots all current fields stored in main on the GUI preview plot axes
function previewPlot(hObject, eventdata, handles)
% I decided to make this seperate function becuase plots need to be updated
% at various stages in the program.
if(~isnan(handles.main.expData.Time.data))
    if(strcmp(get(get(handles.uipanel1,'SelectedObject'),'Tag'), 'radiobutton13'))  % This is checked so that the preview plots are using the same plotting options for all fields. These options are stored in the "Time" header because the time variable is never plotted by itself.
        whitebg(handles.main.expData.params{1}.backgnd);
        for i = 1:length(handles.main.expData.data)-1
                if(~isnan(handles.main.expData.data{i}(1,1)) && i<=length(handles.axes))
                    plot(handles.axes{i},handles.main.expData.data{1},handles.main.expData.data{i+1},buildPlotCharString(handles.main.expData.params{1}));
                    set(handles.axes{i},'Color',handles.main.expData.params{1}.backgnd);
                    set(handles.togglebuttons{i},'string',handles.main.expData.datafields{i+1},'enable','on');
                    grid(handles.axes{i}, 'on');
                    xlabel(handles.axes{i},strcat(handles.main.expData.datafields{1},'(', handles.main.expData.unit{1},')'));
                    ylabel(handles.axes{i},handles.main.expData.unit{i+1});
                    if(isfield(handles.main.expData,'Marker') && handles.main.params.plotting.useMarkers) % plotting markers consumes a lot of time which is why i added this option. Here is where it checks for that option to be on.
                        marks = find(handles.main.expData.Marker.data);
                        for j = 1:length(marks)
                            line([handles.main.expData.data{1}(marks(j)) handles.main.expData.data{1}(marks(j))], get(handles.axes{i},'YLim'),'Color','red','Parent',handles.axes{i})
                        end
                        
                    end
                end
        end
    else
        whitebg('white');
        for i = 1:length(handles.main.expData.data)-1
            if(~isnan(handles.main.expData.data{i}(1,1)) && (i<=length(handles.axes)))
                plot(handles.axes{i},handles.main.expData.data{1},handles.main.expData.data{i+1},'LineStyle',handles.main.expData.params{i+1}.style,'Marker',handles.main.expData.params{i+1}.marker,'Color',handles.main.expData.params{i+1}.color);
                if(~handles.main.params.plotting.multiPlot)
                    set(handles.axes{i},'Color',handles.main.expData.params{i+1}.backgnd);
                end
                set(handles.togglebuttons{i},'string',handles.main.expData.datafields{i+1},'enable','on');
                grid(handles.axes{i}, 'on');
                xlabel(handles.axes{i},strcat(handles.main.expData.datafields{1},'(', handles.main.expData.unit{1},')'));
                ylabel(handles.axes{i},handles.main.expData.unit{i+1});
                if(isfield(handles.main.expData,'Marker')&&handles.main.params.plotting.useMarkers)
                        marks = find(handles.main.expData.Marker.data);
                        for j = 1:length(marks)
                            line([handles.main.expData.data{1}(marks(j)) handles.main.expData.data{1}(marks(j))], get(handles.axes{i},'YLim'),'Color','red','Parent',handles.axes{i})
                        end
                        
                end
            end
        end
    end
    for i = length(handles.main.expData.data):length(handles.axes)
                plot(handles.axes{i},0,0);
                set(handles.axes{i},'Color','white');
                grid(handles.axes{i}, 'off');
                set(handles.togglebuttons{i},'string','no data','enable','off');
                set(handles.togglebuttons{i},'value',0);
                handles.main.params.plotting.toPlot{i} = [];
    end
    setbgcolor(hObject, eventdata, handles);
end
guidata(hObject, handles);

% --- Imports data from the workspace variable main.
function main = importData(hObject, eventdata, handles)
% I decided to make this seperate function becuase plots need to be updated
% at various stages in the program.
main = evalin('base' , 'main');
handles.main = main;
handles.main = generateGuiData(hObject, eventdata, handles);

if(~isfield(handles.main.params,'plotting'))
    handles.main.params = set_params(hObject, eventdata, handles);
end
if(~isfield(handles.main.params.plotting,'separatePlot'))
    handles.main.params.plotting.separatePlot = 1;           % to generate separate plots
end
if(~isfield(handles.main.params.plotting,'multiPlot'))
    handles.main.params.plotting.multiPlot = 0;              % to super impose multiple quantities on the same plot
end
if(~isfield(handles.main.params.plotting,'subPlot'))
    handles.main.params.plotting.subPlot = 0;           % to generate sub plots for multiple quantities
end
if(~isfield(handles.main.params.plotting,'clearFigs'))
    handles.main.params.plotting.clearFigs = 1;
end
if(~isfield(handles.main.params.plotting,'useMarkers'))
    handles.main.params.plotting.useMarkers = 1;
end
main = handles.main;
guidata(hObject, handles);

% --- Copies data fields and names from main.expData into cells
function main = generateGuiData(hObject, eventdata, handles)
% This makes it easier to manipulate data and loop through many fields for
% use in the GUI callbacks.
% My format:
%   all of these fields are stored in handles.main.expData can not be
%   stored in handles because this is a non-GUI function and it will be
%   deleted after the function ends.
%	names of the headers corresponding to the i'th data is stored in datafields{i}
%	data corresponding to the i'th datafield is stored in data{i}
%   units of corresponding i'th datafield is stored in unit{i}
%   parameters corresponding to the i'th datafield is stored in params{i}


handles.main.expData.datafields = fieldnames(handles.main.expData)';
n = length(handles.main.expData.datafields);
m = 1;
for i = 1:n
    if(~strcmp(handles.main.expData.datafields{i},'Marker'))
        eval(['handles.main.expData.data{m} = handles.main.expData.', handles.main.expData.datafields{i}, '.data;']); %% Data re-stored in cells for ease of use by GUI code.
        eval(['handles.main.expData.unit{m} = handles.main.expData.', handles.main.expData.datafields{i}, '.unit;']); %% Units also put into cells for ease of use
        eval(['handles.main.expData.params{m} = handles.main.expData.', handles.main.expData.datafields{i}, '.params;']); 
    else
        handles.main.expData.datafields{i} = []; %% deletes Marker from the datafields cell array so that it won't be plotted
        m = m-1; %% the pain in the butt required to add markers...
    end
    m = m+1;
end
handles.main.expData.datafields = handles.main.expData.datafields(~cellfun('isempty',handles.main.expData.datafields));  %% clears the empty cell created by removing marker. This is so plotting is easier later
main = handles.main;
guidata(hObject, handles);

% --- Exports data back to the MATLAB environment workspace
function exportData(hObject, eventdata, handles)
% this function exports the data to the workspace structure main
% it also changes the format back to it's original by removing the GUI data
% will update the structure to the settings that have been changed by the GUI
for i = 1:length(handles.main.expData.datafields)
    eval(['handles.main.expData.', handles.main.expData.datafields{i}, '.data = handles.main.expData.data{find(strcmp(handles.main.expData.datafields,handles.main.expData.datafields{i}))};']); 
    eval(['handles.main.expData.', handles.main.expData.datafields{i}, '.unit = handles.main.expData.unit{find(strcmp(handles.main.expData.datafields,handles.main.expData.datafields{i}))};']); %%
    eval(['handles.main.expData.', handles.main.expData.datafields{i}, '.params = handles.main.expData.params{find(strcmp(handles.main.expData.datafields,handles.main.expData.datafields{i}))};']);
end
handles.main.expData = rmfield(handles.main.expData, 'datafields');
handles.main.expData = rmfield(handles.main.expData, 'data');
handles.main.expData = rmfield(handles.main.expData, 'unit');
handles.main.expData = rmfield(handles.main.expData, 'params');

assignin('base', 'main', handles.main);

% --- Sets the background color of everything.
function setbgcolor(hObject, eventdata, handles)
% this changes all backgorund color of text fields and radio buttons etc.
% because if you don't there will be a white square when the figure changes
% background color.
% if any new things are added, just copy and paste one of these set
% functions and replace the name of the object with the one added.
bgcolor = get(handles.figure1,'color');
set(handles.uipanel1,'BackgroundColor', bgcolor);
set(handles.uipanel2,'BackgroundColor', bgcolor);
set(handles.uipanel3,'BackgroundColor', bgcolor);
for i = 1:16
    set(handles.radiobutton{i},'BackgroundColor', bgcolor);
end

for i = 1:5 %loop through text boxes 1 to 5
    eval(['set(handles.text', num2str(i) , ',''BackgroundColor'', bgcolor);'])
end
set(handles.checkbox1,'BackgroundColor', bgcolor);
set(handles.checkbox3,'BackgroundColor', bgcolor);
guidata(hObject, handles);

% --- Updates the browser listbox
function load_listbox(hObject, eventdata, handles)
% this updates the browser listbox to whatever directory is selected.
dir_struct = dir(cd);
[sorted_names,sorted_index] = sortrows({dir_struct.name}');
handles.file_names = sorted_names;
handles.is_dir = [dir_struct.isdir];
handles.sorted_index = sorted_index;
guidata(handles.figure1,handles)
set(handles.listbox5,'String',handles.file_names,'Value',1)
set(handles.text5,'string',strcat('Current Log:', handles.main.params.file.pathName))
cd(handles.filepath);
guidata(hObject, handles);

% --- Sets default parameters
function params = set_params(hObject, eventdata, handles)
handles.main.params.plotting.plot = 1;               % switch to choose plotting
handles.main.params.plotting.separatePlot = 1;           % to generate separate plots
handles.main.params.plotting.multiPlot = 0;              % to super impose multiple quantities on the same plot
handles.main.params.plotting.subPlot = 0;           % to generate sub plots for multiple quantities
handles.main.params.plotting.clearFigs = 1;
handles.main.params.plotting.useMarkers = 1;
handles.main.params.plotting.separateData = {};     % column numbers to plot on separate figures
handles.main.params.plotting.toPlot = {};
                                                        % if empty & plot = 1, all the columns will be plotted                                               
handles.main.params.plotting.multiData = {};         % if empty but switch is on, use separateData values
handles.main.params.plotting.subData = {};      % if empty but switch is on, use multiData values
handles.main.params.plotting.color = 'k'; % one character for color of the plotting line
handles.main.params.plotting.marker = 'none'; % one character for the maker of the plotting line
handles.main.params.plotting.style = '-'; % one character for the style of the plotting line
handles.main.params.plotting.backgnd = 'w'; % rgb array for background color of the plot
params = handles.main.params;

% --- Changes all GUI objects to be consistent with current options
function handles = loadOptions(hObject, eventdata, handles)
% this is for a situation where a user opens the GUI when there have been
% options already set. This function will set the GUI objects so that it
% appears as if those options are already set. If this is not done, the
% options may be changed.
handles = guidata(hObject);
set(handles.radiobutton{14},'Value',0)
set(handles.radiobutton{15},'Value',0)
set(handles.radiobutton{16},'Value',0)
if(handles.main.params.plotting.separatePlot)
    set(handles.radiobutton{14},'Value',1)
else if(handles.main.params.plotting.subPlot)
        set(handles.radiobutton{15},'Value',1)
    else if(handles.main.params.plotting.multiPlot)
            set(handles.radiobutton{16},'Value',1)
        else
            set(handles.radiobutton{14},'Value',1);
            handles.main.params.plotting.separatePlot = 1;
        end
    end
end

if(handles.main.params.plotting.clearFigs)      %updates the GUI with data stored to keep consistent
    set(handles.checkbox1,'Value',1)
else
    set(handles.checkbox1,'Value',0)
end

if(handles.main.params.plotting.useMarkers)
    set(handles.checkbox3,'Value',1)
else
    set(handles.checkbox3,'Value',0)
end

for n = 1:length(handles.main.expData.datafields)
    if(n<=length(handles.togglebuttons))
        set(handles.togglebuttons{n}, 'Value', 0);
    end
end
if(isfield(handles.main.params.plotting,'toPlot'))
    for m = 1:length(handles.main.params.plotting.toPlot)
        for n = 2:length(handles.main.expData.datafields)
            if(strcmp(handles.main.expData.datafields{n},handles.main.params.plotting.toPlot{m}) && (n <= length(handles.togglebuttons)))
                set(handles.togglebuttons{n-1}, 'Value', 1);
            end
        end
    end
end
exportData(hObject, eventdata, handles);
guidata(hObject, handles);

% --- Checks all options
function handles = updateOptions(hObject, eventdata, handles)
% Made this to remove a lot of bulk from the togglebutton callbacks as well
% as radiobuttons.

handles = guidata(hObject);

if(get(handles.checkbox1,'Value'))
    handles.main.params.plotting.clearFigs = 1;
else
    handles.main.params.plotting.clearFigs = 0;
end

if(get(handles.checkbox3,'Value'))
    handles.main.params.plotting.useMarkers = 1;
else
    handles.main.params.plotting.useMarkers = 0;
end

handles.main.params.plotting.toPlot = {};
for i = 1:length(handles.main.expData.datafields)-1
    if(i<=length(handles.axes))
        button_state = get(handles.togglebuttons{i},'Value');
    end
    if button_state == 1
        handles.main.params.plotting.toPlot = {handles.main.params.plotting.toPlot{:}, handles.main.expData.datafields{i+1}};
    else
        handles.main.params.plotting.toPlot(strcmp(handles.main.expData.datafields{i+1},handles.main.params.plotting.toPlot)) = [];
    end
end
handles.main.params.plotting.toPlot = handles.main.params.plotting.toPlot(~cellfun('isempty',handles.main.params.plotting.toPlot));

if(handles.main.params.plotting.separatePlot)
    handles.main.params.plotting.separateData = handles.main.params.plotting.toPlot;
end
if(handles.main.params.plotting.multiPlot)
    handles.main.params.plotting.multiData = handles.main.params.plotting.toPlot; 
end
if(handles.main.params.plotting.subPlot)
    handles.main.params.plotting.subData = handles.main.params.plotting.toPlot;
end
guidata(hObject, handles);

uipanel3_SelectionChangeFcn(hObject, eventdata, handles);

exportData(hObject, eventdata, handles);

guidata(hObject, handles);


%% bulky functions (repetative)
%--- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
%% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
%--- Executes on button press in checkbox2.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
%--- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton6.
function togglebutton6_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton7.
function togglebutton7_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton8.
function togglebutton8_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)clc
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton9.
function togglebutton9_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton7.
function togglebutton10_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton8.
function togglebutton11_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)clc
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);
% --- Executes on button press in togglebutton9.
function togglebutton12_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles = updateOptions(hObject, eventdata, handles);
guidata(hObject,handles);