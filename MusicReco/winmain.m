function varargout = winmain(varargin)
% WINMAIN MATLAB code for winmain.fig
%      WINMAIN, by itself, creates a new WINMAIN or raises the existing
%      singleton*.
%
%      H = WINMAIN returns the handle to a new WINMAIN or the handle to
%      the existing singleton*.
%
%      WINMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINMAIN.M with the given input arguments.
%
%      WINMAIN('Property','Value',...) creates a new WINMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before winmain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to winmain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help winmain

% Last Modified by GUIDE v2.5 17-Nov-2015 09:18:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @winmain_OpeningFcn, ...
                   'gui_OutputFcn',  @winmain_OutputFcn, ...
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

lab=[];
coff=[];
model=[];
% End initialization code - DO NOT EDIT


% --- Executes just before winmain is made visible.
function winmain_OpeningFcn(hObject, eventdata, handles, varargin)
axis(handles.axes1);
a=imread('img\\question.jpg');
imshow(a);

filename='train\\001.wav';
filelabl=1;
namelist=[];
labllist=[];
while(exist(filename)==2)
    namelist=[namelist;filename];
    filename=sprintf('train\\\\%03d.wav',filelabl+1);
    labllist=[labllist;filelabl];
    filelabl=filelabl+1;
end

global lab;
global coff;
global model;

[lab,coff,model]=addtrain(namelist,labllist);

set(gcf,'Name','音乐之声');
set(handles.pushbutton2,'Visible','off');
set(handles.pushbutton2,'Enable','off');
set(handles.pushbutton3,'Enable','on');
set(handles.pushbutton4,'Enable','off');
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to winmain (see VARARGIN)

% Choose default command line output for winmain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes winmain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = winmain_OutputFcn(hObject, eventdata, handles)     
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

filename='train\\001.wav';
filelabl=1;
namelist=[];
labllist=[];
while(exist(filename)==2)
    namelist=[namelist;filename];
    filename=sprintf('train\\\\%03d.wav',filelabl+1);
    labllist=[labllist;filelabl];
    filelabl=filelabl+1;
end

global lab;
global coff;
global model;

[lab,coff,model]=addtrain(namelist,labllist);

set(handles.pushbutton2,'Enable','on');
set(handles.pushbutton2,'Visible','off');
set(handles.pushbutton3,'Enable','on');
set(handles.pushbutton4,'Enable','off');
set(handles.text1,'String','训练成功，请选择一个要预测的wav文件！');
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

global target_coff;
global target_lab;
predfile=uigetfile('.wav');
predfile=['predict\\',predfile];
target_coff=extractfeatures(predfile);
target_coff=target_coff';
[sx,sy]=size(target_coff);
target_lab=zeros(sx,1);
target_lab(:,1)=1;
lab=0;
str=sprintf('已选择文件：%s！请进行预测！',predfile);
set(handles.text1,'String',str);

set(handles.pushbutton2,'Enable','off');
set(handles.pushbutton3,'Enable','off');
set(handles.pushbutton4,'Enable','on');

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global lab;
global coff;
global model;
global target_coff;
global target_lab

predlabl=svmpredict(target_lab,target_coff,model);
predtarg=mode(predlabl)
imgfile=sprintf('img\\\\%03d.jpg',predtarg);
axis(handles.axes1);
a=imread(imgfile);
imshow(a);    
str=sprintf('对应乐器见图！',predtarg);
set(handles.text1,'String',str);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
