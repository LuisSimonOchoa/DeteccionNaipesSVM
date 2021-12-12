function varargout = program(varargin)
% PROGRAM MATLAB code for program.fig
%      PROGRAM, by itself, creates a new PROGRAM or raises the existing
%      singleton*.
%
%      H = PROGRAM returns the handle to a new PROGRAM or the handle to
%      the existing singleton*.
%
%      PROGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAM.M with the given input arguments.
%
%      PROGRAM('Property','Value',...) creates a new PROGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before program_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to program_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help program

% Last Modified by GUIDE v2.5 09-Nov-2021 23:08:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @program_OpeningFcn, ...
                   'gui_OutputFcn',  @program_OutputFcn, ...
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


% --- Executes just before program is made visible.
function program_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to program (see VARARGIN)

% Choose default command line output for program
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes program wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global WBC_ID WBC_FORMAT

info=imaqhwinfo('winvideo');
WBC={'Seleccionar Video'};
WBC_ID = "0";
WBC_FORMAT=["0"; 'RGB24_1280x960';'MJPG_640x480'];


for i=1:length(info.DeviceIDs)
    temp = imaqhwinfo('winvideo',i);
    WBC = [WBC; temp.DeviceName];
end
for i=1:length(info.DeviceIDs)
    temp = imaqhwinfo('winvideo',i);
    WBC_ID = [WBC_ID; temp.DeviceID];
end
set(handles.popupmenu1,'String',WBC)

% --- Outputs from this function are returned to the command line.
function varargout = program_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global WBC_ID WBC_FORMAT vid
dispoEntrada = get(handles.popupmenu1,"value");
handles.output = hObject;
axes(handles.axes1);
sizevid={[0 0];[1280 960]; [640 480]};
if dispoEntrada ~= 1
    closepreview;
    vid=videoinput('winvideo',WBC_ID(dispoEntrada),WBC_FORMAT(dispoEntrada));
    
    hImage=image(zeros(sizevid{dispoEntrada}(2),sizevid{dispoEntrada}(1),3));
    preview(vid,hImage);
    guidata(hObject, handles);

end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid I
%cd 'data'
 a = dir('*.jpg');
 n = numel(a);

I = getsnapshot(vid);
%imwrite(I, 'test2.jpg');


% Igray=rgb2gray(I);
% 
% pout_imadjust = imadjust(Igray);
% 
% BW = 255*imbinarize(pout_imadjust);
% %ip=find(I(1:)==1);
% 
% [M,N,P]= size(BW);          %Se extraen dimensiones de la imegen
% Z=zeros(M,N);

% I=imrotate(I,-90);
% 
% 
% amount = 1.75; % a rather significant saturation/chroma alteration
% A = imtweak(I,'hsv',[0 amount 1]);
% 
% 
% 
% imshow(uint8(A));
% 
% impixelinfo;
 imwrite(I, string(n)+'.jpg');
% 
% cd ..

%ocr(I)



% %ip=find(I(:,:,1)>250 | I(:,:,2)>100 | I(:,:,3)>250);
% %Z(ip)=255; 
% axes(handles.axes2)
% 
% [M,N]=size(BW);  % determina el tamaño de la imagen.
% 
% [Iobjeto,numobjeto] = bwlabel(BW);
% 
% 
% 
% imshow(uint8(BW));
% imwrite(BW, 'test.jpg');
% impixelinfo;
