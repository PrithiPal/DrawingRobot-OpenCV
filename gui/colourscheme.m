function varargout = colourscheme(varargin)
% COLOURSCHEME MATLAB code for colourscheme.fig
%      COLOURSCHEME, by itself, creates a new COLOURSCHEME or raises the existing
%      singleton*.
%
%      H = COLOURSCHEME returns the handle to a new COLOURSCHEME or the handle to
%      the existing singleton*.
%
%      COLOURSCHEME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLOURSCHEME.M with the given input arguments.
%
%      COLOURSCHEME('Property','Value',...) creates a new COLOURSCHEME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before colourscheme_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to colourscheme_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help colourscheme

% Last Modified by GUIDE v2.5 17-Nov-2017 05:33:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @colourscheme_OpeningFcn, ...
                   'gui_OutputFcn',  @colourscheme_OutputFcn, ...
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


% --- Executes just before colourscheme is made visible.
function colourscheme_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to colourscheme (see VARARGIN)

% Choose default command line output for colourscheme
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes colourscheme wait for user response (see UIRESUME)
% uiwait(handles.figure1);
Img = imread('image.jpg');
axes(handles.axes1);
set(handles.axes1, 'Visible', 'on');
imshow(Img);
% --- Outputs from this function are returned to the command line.
function varargout = colourscheme_OutputFcn(hObject, eventdata, handles) 
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
run('print.m')
close('colourscheme')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n = csvread('data/n.csv');

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
    subplot(3,n,i+2*n),imshow(show_color_matrix) ;
   
    % PRINTING RGB COLOR TO FILE
    csvwrite('regions/region_color.csv',lab2rgb(LAB_MATRIX,'OutputType','uint8'));
    
end



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% comparing distances and finding optimal pen for color selection
set(handles.pushbutton1, 'Enable', 'on');
if get(handles.radiobutton2, 'value') == 1
    ORIG_FILENAME = 'image.jpg';
    PEN_DATA = csvread('color_index_csv.csv'); % 47 vcolo
    NORM_PEN_DATA = PEN_DATA./255;
    NORM_PEN_DATA = NORM_PEN_DATA(:,2:4);
    LAB_PEN_DATA = rgb2hsv(NORM_PEN_DATA);

    REGION_DATA = csvread('regions/region_color.csv');
    NORM_REGION_DATA = REGION_DATA./255;
    LAB_REGION_DATA = rgb2hsv(NORM_REGION_DATA);

    % distance vector for each region; min(d) gives best color resembelance

    d = zeros([1, size(PEN_DATA,1)]);  % for HSV Euclidean distance


    % matrix with optimal pen values.

    optimal = zeros([1 size(REGION_DATA,1)]); % for HSV Euclidean distance


    for  A = (1:size(REGION_DATA,1))
        d = zeros([1, size(PEN_DATA,1)]);
        region_color = LAB_REGION_DATA(A,:);
        %region_color
        for j=(1:size(PEN_DATA,1))

            pen_color = LAB_PEN_DATA(j,:);
            %pen_color
            val = color_distance(region_color,pen_color);

            d(1,j) = color_distance(region_color,pen_color);
            %d(1,j)

        end

        [M1,I1]= min(d(:));

        % This logic stops from picking same pen for multiple regions. We want
        % unique pen color for all region average colors.

        if ~ismember(I1,optimal(1,:))
            optimal(A) = I1;
        else %
            d(I1)=[];
            [M1,I1] = min(d(:));
            optimal(A) = I1;
        end




    end;
    figure;
n = csvread('data/n.csv');


    region_filename = strcat(strcat('regions/region_1.bmp'));
    x = imread(region_filename);
    SUM_MAT = zeros([size(x,1) size(x,2) 3]);


    for i=(1:n)
        region_filename = strcat(strcat('regions/region_',int2str(i)),'.bmp');
        x = imread(region_filename);
        euclid_color = PEN_DATA(optimal(i),2:4);

        orig_color = REGION_DATA(i,:);

        color_patch_euclid = ones([size(x,1) size(x,2) 3]);

        color_patch_orig = ones([size(x,1) size(x,2) 3]);

        color_patch_euclid(:,:,1) = euclid_color(1,1)./255;
        color_patch_euclid(:,:,2) = euclid_color(1,2)./255;
        color_patch_euclid(:,:,3) = euclid_color(1,3)./255;
        color_patch_overlap = color_patch_euclid;


        color_patch_orig(:,:,1) = orig_color(1,1)./255;
        color_patch_orig(:,:,2) = orig_color(1,2)./255;
        color_patch_orig(:,:,3) = orig_color(1,3)./255;


        subplot(3,n,i),imshow(color_patch_orig), title(strcat('Averaged Color',int2str(i))); % shows original region
        subplot(3,n,n+i),imshow(color_patch_euclid), title(strcat('Matched Color',int2str(i)));; % shows 



        r = color_patch_overlap(:,:,1);
        g = color_patch_overlap(:,:,2);
        b = color_patch_overlap(:,:,3);

        r(x==0)=0;
        g(x==0)=0;   

        b(x==0)=0;

        color_patch_overlap(:,:,1) = r;
        color_patch_overlap(:,:,2) = g;
        color_patch_overlap(:,:,3) = b;

        subplot(3,n,2*n+i),imshow(color_patch_overlap),title(strcat('Matched Region',int2str(i))); % show region with averaged color to all pixels

        SUM_MAT = imadd(SUM_MAT,color_patch_overlap);
       % subplot(4,n,3*n+i),imshow(SUM_MAT);
        imwrite(color_patch_overlap,strcat('color_regions/region_',int2str(i),'.bmp'))
end
%figure;
ORIG_SCALED_IMAGE = scale_image(imread(ORIG_FILENAME));
%subplot(1,2,1),imshow(ORIG_SCALED_IMAGE);
%subplot(1,2,2),imshow(SUM_MAT) 
axes(handles.axes2)
imshow(SUM_MAT)
imwrite(SUM_MAT, 'Final_preview.bmp')
    
   
else
n = csvread('data/n.csv');
    region_filename = strcat(strcat('color_regions/region_1.bmp'));
    x = imread(region_filename);
    SUM_MAT = x;
    SUM_MAT(:) = 0;
    figure;
   for i=(1:n)

        color_filename = strcat(strcat('color_regions/region_',int2str(i)),'.bmp');
        color_patch_overlap = imread(color_filename);
        subplot(1,n,i),imshow(color_patch_overlap), title(strcat('Customized Region',int2str(i))); % shows original region

        SUM_MAT = imadd(SUM_MAT,color_patch_overlap);

        imwrite(SUM_MAT, 'Final_preview.bmp')

   end 
           axes(handles.axes2)
        imshow(SUM_MAT)
end


% --- Executes on key press with focus on radiobutton2 and none of its controls.
function radiobutton2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        run('manual_color.m')


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
if get(handles.radiobutton2, 'value') == 0
    set(handles.pushbutton4, 'Enable', 'on');
else
    set(handles.pushbutton4, 'Enable', 'off');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('customize.m')
close(colourscheme)
