function varargout = project_ofdm_gui(varargin)
%#function conversion ofdm_mod_gui ofdm_demod_gui
% PROJECT_OFDM_GUI M-file for project_ofdm_gui.fig
%      PROJECT_OFDM_GUI, by itself, creates a new PROJECT_OFDM_GUI or raises the existing
%      singleton*.
%
%      H = PROJECT_OFDM_GUI returns the handle to a new PROJECT_OFDM_GUI or the handle to
%      the existing singleton*.
%
%      PROJECT_OFDM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT_OFDM_GUI.M with the given input arguments.
%
%      PROJECT_OFDM_GUI('Property','Value',...) creates a new PROJECT_OFDM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before project_ofdm_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to project_ofdm_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help project_ofdm_gui

% Last Modified by GUIDE v2.5 26-Dec-2012 15:00:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @project_ofdm_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @project_ofdm_gui_OutputFcn, ...
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


% --- Executes just before project_ofdm_gui is made visible.
function project_ofdm_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to project_ofdm_gui (see VARARGIN)

% Choose default command line output for project_ofdm_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes project_ofdm_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = project_ofdm_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double


% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global result_plot;
global modulated_data;
input_file=get(handles.filename,'String');
[no_use filename ext]=fileparts(input_file);
if isempty(ext)
    errordlg('Field must not kept empty for file extension','Error Mandetory_Field','modal');
elseif ext=='.bmp'
    data=imread(input_file);
elseif ext=='.wav'
    data=wavread(input_file);
    data=uint8(data);
else
    errordlg('Extension Must be .bmp/.wav','U have entered wrong input','modal');
end
Main_function_gui;
axes(handles.axes1);
plot(reshape(modulated_data,1,size(modulated_data,1)...
    *size(modulated_data,2)),'o');
axis([-2.0 2.0 -2.0 2.0]);
title('Qpsk plot for baseband');
axes(handles.axes2);
plot(freq_axis,real(ofdm_data),'k');
title('Orthogonal Carriers')
axes(handles.axes3);
plot(reshape(result_plot,1,...
    size(result_plot,1)*size(result_plot,2)),'o');
title('Corrupted Qpsk');
axes(handles.axes4);
plot(freq_axis,real(BaseBand_data),'k');
title('Corrupted OFDM Symbols');