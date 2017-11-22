function varargout = print(varargin)
% PRINT MATLAB code for print.fig
%      PRINT, by itself, creates a new PRINT or raises the existing
%      singleton*.
%
%      H = PRINT returns the handle to a new PRINT or the handle to
%      the existing singleton*.
%
%      PRINT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRINT.M with the given input arguments.
%
%      PRINT('Property','Value',...) creates a new PRINT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before print_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to print_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help print

% Last Modified by GUIDE v2.5 17-Nov-2017 04:49:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @print_OpeningFcn, ...
                   'gui_OutputFcn',  @print_OutputFcn, ...
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


% --- Executes just before print is made visible.
function print_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to print (see VARARGIN)

% Choose default command line output for print
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes print wait for user response (see UIRESUME)
% uiwait(handles.figure1);
I = imread('Final_preview.bmp');
axes(handles.axes1);
imshow(I);

% --- Outputs from this function are returned to the command line.
function varargout = print_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('colourscheme.m')
close(print)


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton1, 'Enable', 'on');
% this function prints the matrix which robot reads into txt files.
n = csvread('data/n.csv');


for i=(1:n) 
    IMAGE_FILENAME = strcat('regions/region_',int2str(i),'.bmp');
    I = imread(IMAGE_FILENAME);
    OUTPUT_FILENAME = strcat('region_text_files/region_text_',int2str(i),'.txt');
    print_two_dim_matrix(I,OUTPUT_FILENAME); 
end


input1 = strcat('region_text_files/',get(handles.edit1, 'string'), '.txt');  %%input number one or name of first txt file
input2 = strcat('region_text_files/',get(handles.edit2, 'string'), '.txt');  %%input number two or name of second txt file

file_readip = fopen(input1,'r');
i =0;
tline = fgetl(file_readip);
x_max = tline;
tline = fgetl(file_readip);
y_max = tline;
while(ischar(tline))
    i=i+1;
    tline = fgetl(file_readip);
    A{i} = tline;
end
fclose(file_readip);
file_readip2 = fopen(input2,'r');
i = 0;
tline2 = fgets(file_readip2);
x2 = tline2;
tline2 = fgets(file_readip2);
y2 = tline2;
while(ischar(tline2))
    i=i+1;
    tline2 = fgets(file_readip2);
    D{i} = tline2;
end
fclose(file_readip2);
y = length(A);
n =y-125;
j=n;
k=1;
while(n<y)
    C{k}=A{n};
    n=n+1;
    k=k+1;
end
n=1;
while(n<j)
    B{n}=D{n};
    n=n+1;
end
file_read2 = fopen('CODE.ino','r');
p=1;
tline1 = fgets(file_read2);
E{p} = tline1;
while(p<511)
  p=p+1;
  tline1 = fgets(file_read2);
  E{p}=tline1;
end
fclose(file_read2);
y1 = length(E);

file_write = fopen('src\MAIN_V2.ino','w');
fprintf(file_write,'%s\n','//======================================//');
fprintf(file_write,'%s\n','//               XFOX                   //');
fprintf(file_write,'%s\n','//               XFOX                   //');
fprintf(file_write,'%s\n','//======================================//');
fprintf(file_write,'%s\n','');
fprintf(file_write,'%s\n','#include <Arduino.h>');
fprintf(file_write,'%s\n','#include <Servo.h>');
fprintf(file_write,'%s\n','#include <avr/eeprom.h>');
fprintf(file_write,'%s\n','#include <PGMWrap.h>');
fprintf(file_write,'%s\n','');
fprintf(file_write,'%s','const uint8_p arr1[][');
fprintf(file_write,'%s',x_max);
fprintf(file_write,'%s\n','] PROGMEM =');
fprintf(file_write,'%s\n','{');
j =1;
u = length(B);
while(j<=u)
    fprintf(file_write,'%s',B{j});
    j=j+1;
end
fprintf(file_write,'%s\n','};');
fprintf(file_write,'%s\n','');
fprintf(file_write,'%s','const uint8_p arr2[][');
fprintf(file_write,'%s',x_max);
fprintf(file_write,'%s\n','] PROGMEM =');
fprintf(file_write,'%s\n','{');
 j = 1;
 u = length(C);
while(j<=u)
    fprintf(file_write,'%s\n',C{j});
    j=j+1;
end
fprintf(file_write,'%s\n','};');
fprintf(file_write,'%s\n','');
fprintf(file_write,'%s\n','//Variables//');
fprintf(file_write,'%s','int x_max = ');
fprintf(file_write,'%s',x_max);
fprintf(file_write,'%s\n','; // max valve in x');
fprintf(file_write,'%s','int y_max = ');
fprintf(file_write,'%s',y_max);
fprintf(file_write,'%s\n','; // paper max valve in y');
fprintf(file_write,'%s\n','');
j = 1;
while(j<y1)
    fprintf(file_write,'%s',E{j});
    j=j+1;
end

dos('platformio run');
dos('platformio run -t upload');
