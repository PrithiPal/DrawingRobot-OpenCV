function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
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
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 17-Nov-2017 03:41:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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

 
% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
welcome_text = ' ';
image_processing_text = ''
set(handles.text2, 'String', welcome_text);
set(handles.text6, 'String', image_processing_text);

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

global cam;
global SNAPSHOT_SIGNAL;
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close all;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.pushbutton5, 'Enable', 'off')
    set(handles.pushbutton6, 'Enable', 'off')
    set(handles.pushbutton7, 'Enable', 'off')
    set(handles.checkbox1, 'Enable', 'off')
    if get(handles.checkbox1, 'Value') == 1
        set(handles.text7, 'String', 'Do you want to print with default settings?')
    elseif get(handles.checkbox1, 'Value') == 0
        set(handles.text7, 'String', 'Do you want to print with customized settings?')
    end
    set(handles.uipanel4, 'Visible', 'on')

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel2, 'Visible', 'on');
    set(handles.uipanel3, 'Visible', 'off');

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
    if get(handles.checkbox1, 'Value') == 1
        set(handles.pushbutton7, 'Enable', 'off');
    elseif get(handles.checkbox1, 'Value') == 0
        set(handles.pushbutton7, 'Enable', 'on');
    end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    run('customize.m')

    close(gui)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel2, 'Visible', 'off');
    set(handles.uipanel3, 'Visible', 'on');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
    [handles.file,orig_filepath] = uigetfile({'*.bmp;*.jpg;*.tif;*.png;*.gif','All Image Files'});
    Img = imread(handles.file);

    if handles.file ~= 0
        imwrite(Img, 'image.jpg')
        set(handles.text4, 'Visible', 'on');
        set(handles.text4, 'String', handles.file);
        set(handles.pushbutton2, 'Enable', 'on');
        axes(handles.axes1);
        set(handles.axes1, 'Visible', 'on');
        imshow(Img)
    end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel2, 'Visible', 'off');
    set(handles.uipanel1, 'Visible', 'on');

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel2, 'Visible', 'on');
    set(handles.uipanel1, 'Visible', 'off');
    for l = 1:6
        if exist(strcat('Lab_', int2str(l), '.jpg'))
            delete (strcat('Lab_', int2str(l), '.jpg'));
        end
    end
    for in = 1:6
        if exist(strcat('Intensity_', int2str(in), '.jpg'))
            delete (strcat('Intensity_', int2str(in), '.jpg'));
        end
    end
    for i = 1:6
        if exist(strcat('manual_segment_', int2str(i), '.jpg'))
            delete (strcat('manual_segment_', int2str(i), '.jpg'));
        end
    end
    for f=1:30
        if exist(strcat('Final_', int2str(f), '.jpg'))
            delete (strcat('Final_', int2str(f), '.jpg'));
        else
            break
        end
    end
    if exist('image_preprocessed.jpg')
            delete 'image_preprocessed.jpg'
    end
    if exist('Manual_to_process.jpg')
            delete 'Manual_to_process.jpg'
    end
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel4, 'Visible', 'off');
    set(handles.uipanel3, 'Visible', 'off');
    set(handles.uipanel5, 'Visible', 'on');
    if get(handles.checkbox1, 'Value') == 1
        set(handles.text7, 'String', 'Do you want to print with default settings?')
    elseif get(handles.checkbox1, 'Value') == 0
        for i=1:20
            if exist(strcat('Final_', int2str(i), '.jpg'))
                data(:,:,:,i) = imread(strcat('Final_', int2str(i), '.jpg'));
            else
                break
            end
        end
    end
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.pushbutton5, 'Enable', 'on')
    set(handles.pushbutton6, 'Enable', 'on')
    set(handles.checkbox1, 'Enable', 'on')
    if get(handles.checkbox1, 'Value') == 0
        set(handles.pushbutton7, 'Enable', 'on')
    end
    set(handles.uipanel4, 'Visible', 'off');

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    n = 6

    figure;

    ORIG = imread('image.jpg');
    ORIG_SCALED = scale_image(ORIG);
    LAB_MATRIX = zeros([n 3]);


for i=(1:n)

    I = imread(strcat(strcat('regions/region_',int2str(i)),'.bmp'));
    % REGION BW IMAGES
    subplot(3,n,i),imshow(I);
    
    J = ORIG_SCALED;
    
    
    R = J(:,:,1);
    G = J(:,:,2);
    B = J(:,:,3);
    
    R(I~=1)=0;
    G(I~=1)=0;
    B(I~=1)=0;

    J(:,:,1) = R;
    J(:,:,2) = G;
    J(:,:,3) = B;
    
    % REGION COLORED IMAGES
    subplot(3,n,i+n),imshow(J);
    
    avg_colored_lab = average_color(J);
    
    L = avg_colored_lab(1);
    a = avg_colored_lab(2);
    b = avg_colored_lab(3);
    
    color_matrix = ones([size(J,1) size(J,2) 3]);
    
    color_matrix(:,:,1) = L;
    color_matrix(:,:,2) = a;
    color_matrix(:,:,3) = b;
    
    
    LAB_MATRIX(i,1) = L;
    LAB_MATRIX(i,2) = a;
    LAB_MATRIX(i,3) = b;
    
    
    show_color_matrix = lab2rgb(color_matrix);
    % SHOW AVERAGED COLOR
    subplot(3,n,i+2*n),imshow(show_color_matrix), ;
   
    % PRINTING RGB COLOR TO FILE
    csvwrite('regions/region_color.csv',lab2rgb(LAB_MATRIX,'OutputType','uint8'));
    
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% this program takes snapshot at creates a image.
% this program takes snapshot at creates a image.
set(handles.pushbutton15, 'Enable', 'on')
OUTPUT_FILENAME = 'image.jpg';
WEBCAM_NAME = 'Logitech HD Webcam C510';
cam = webcam(WEBCAM_NAME);
SNAPSHOT_SIGNAL=0;

for idx=1:10000 
    frame = snapshot(cam);
    imshow(frame);
    if get(handles.text17, 'value')==1
        set(handles.pushbutton2, 'Enable', 'on');
        clear('cam');
        imshow(frame)
        imwrite(frame,OUTPUT_FILENAME); 
        closepreview();
        break;
    end
end



% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text17, 'value', 1);
