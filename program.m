
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

% Last Modified by GUIDE v2.5 12-Nov-2021 13:59:56

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

global WBC_ID WBC_FORMAT indiceDiamante indiceEspada defaultPanel defaultFigure trainedClassifier trainedClassifierTODOS
defaultPanel = get(handles.uipanel1,'OuterPosition');
defaultFigure = get(handles.figure1,'OuterPosition');
%load TRAINED3
load MODELTRAINEDULTIMATE
%load TRAINEDSVM2
info=imaqhwinfo('winvideo');
WBC={'Seleccionar Video'};
WBC_ID = "0";
WBC_FORMAT=["0"; 'RGB24_1280x960';'YUY2_640x480'];
indiceDiamante = 1.456;
indiceEspada = 1.52;

upclogo=imread('UPC.jpg','jpg');
axes(handles.axes14)
imshow(upclogo)

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
posicion = get(handles.uipanel2,'Position');
if dispoEntrada ~= 1
    closepreview;
    vid=videoinput('winvideo',WBC_ID(dispoEntrada),WBC_FORMAT(dispoEntrada));
    set(handles.uipanel2,'Position',[posicion(1) posicion(2) posicion(3) 33.7 ])
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
    
posicion = get(handles.uipanel2,'Position');
set(handles.uipanel2,'Position',[posicion(1) posicion(2) posicion(3) 33.7 ])

I = getsnapshot(vid);
imwrite(I,'test1.jpg');
closepreview();
axes(handles.axes1)
imshow(I)




% --- Executes on button press in UploadFile.
function UploadFile_Callback(hObject, eventdata, handles)
% hObject    handle to UploadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=0;
[filename, pathname] = uigetfile( {'*.jpg;*.png', 'Archivo de imagen (*.jpg,*.png'}, 'Seleccione una imagen');
direccion=fullfile(pathname,filename);


if isequal(filename,0)
   disp('Cancelado por el usuario');
else
   disp(['Se ha abierto el archivo con exito: ', fullfile(pathname,filename)]);

    posicion = get(handles.uipanel2,'Position');
    set(handles.uipanel2,'Position',[posicion(1) posicion(2) posicion(3) 33.7 ])

   I=imread(direccion,'jpg');
   closepreview();
   axes(handles.axes1);
   imshow(I)
   
end


% --- Executes on button press in BotonProcesar.
function BotonProcesar_Callback(hObject, eventdata, handles)
% hObject    handle to BotonProcesar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I  index numobjeto trainedClassifier posIMGcolor posIMGBN trainedClassifierTODOS im_pruebaCortada

set(handles.uipanel2,'Visible','off')



Igray=rgb2gray(I);

[M,N]= size(Igray); % Determina el tamaño de la imagen.
Ibin = zeros(M,N); % Imagen modificada



AreaAmarilla=  find(I(:,:,1)>=80 & I(:,:,1)<=120 & I(:,:,2)>=80 &I(:,:,2)<=120 & I(:,:,3)<=60);%amarillo
AreaAzul=  find(I(:,:,1)<=50 & I(:,:,2)<=80 & I(:,:,3)>=80 & I(:,:,3)<=150);%amarillo
           
% figure();
% imshow(Igray);

for x = 1:M
    for y = 1:N
        if Igray(x,y) <= 100  % Intensidades. Estaba  170.
            Igray(x,y) = 0;
            Ibin(x,y) = 0;
            else
            Ibin(x,y) = 255;
        end
    end
end
Ibin(AreaAmarilla)=255;
Ibin(AreaAzul)=255;
%  figure()
%   imshow(Ibin)
%             impixelinfo;
% figure();
% imshow(Ibin);

% figure()
%            imshow(Igray)
%            impixelinfo;

test=imbinarize(Igray,0.39);             
% figure()
%            imshow(test)
%            impixelinfo;  
          
        
   
  BW2 = imfill(Ibin,'holes');         
%    figure()
%             imshow(BW2)
%            impixelinfo;          
           
[ob,nob] = bwlabel(BW2);        
nob;
minxIni=0;
minyIni=0;
maxxIni=0;
maxyIni=0;
for i=1:nob  
    [xTemp,yTemp]=find(ob==nob);
    minxIni=min(xTemp);
    minyIni=min(yTemp);
    maxxIni=max(xTemp);
    maxyIni=max(yTemp);
   
end
hx=maxxIni-minxIni;
hy=maxyIni-minyIni;

% figure();
% imshow(BW2); 


nonIbin=255-Ibin;
%   figure()
%              imshow(nonIbin)
%              impixelinfo;  
[ob2,nob2] = bwlabel(nonIbin);     

% figure();
% imshow(nonIbin); 

nob2     
tem = zeros(1,nob2);
% Detección de regiones indeseadas por tamaño
[r, c, n]= size(nonIbin);
if nob2 > 0
    for s = 1:nob2
        tem(s) = length(ob2(ob2==s));  % Almacena el tamaño de cada region
        if tem(s) < 100 || tem(s) > 350 % Menores a este valor son regiones indeseadas
            
            % Quitamos las regiones indeseadas
            for i = 1:M
                for j = 1:N
                    if ob2(i,j) == s
                        nonIbin(i,j) = 0; % Ponemos a 0 las regiones indeseadas
                    end
                     if (i>minxIni+200)
                     nonIbin(i,j) = 0;
                     end
                end
            end   
        end
    end
end
% 
%  figure()
%             imshow(nonIbin)
%             impixelinfo;  
c=medfilt2(nonIbin);
if(hy>hx) %horizontal
    temp=nonIbin;
    temp2 = I;
    I=imrotate(temp2,90);
   nonIbin = imrotate(temp,90);
   [M,N]= size(nonIbin);

end

b=medfilt2(nonIbin);
% figure()
%            imshow(b)

[Iobjeto,numobjeto] = bwlabel(b);
 
pos=cell(1,numobjeto); %imagen individual en tamaño de captura
posIMGcolor=cell(1,numobjeto); %imagen de carta cortada ( solo la carta )
posUbi=cell(1,numobjeto); %posicion de carta detectada
posIMGBN=cell(1,numobjeto); %imagen enderezada


    for num=1:numobjeto
        
        [xTemp,yTemp]=find(Iobjeto==num);
        % 
        posUbi{num}=[xTemp,yTemp];
        
        
       If=zeros(M,N); 
       for x=1:M
           for y=1:N
               if Iobjeto(x,y)==num
                  If(x,y)=255;    
               end   
           end    
       end
        pos{num}=If;

    end


for i=1:numobjeto
    x=posUbi{i}(:,1);
    y=posUbi{i}(:,2);
    im_prueba=I(min(x):max(x),min(y):max(y),:,:,:);
    im_pruebaBN=b(min(x):max(x),min(y):max(y),:,:,:);
    posIMGcolor{i}=im_prueba;
    posIMGBN{i}=im_pruebaBN;
%           figure()
%           imshow(im_prueba)
%          figure()
%          imshow(im_pruebaBN)
end




for i=1:2
mu1=[];
   mu2=[];
   mu3=[];
   mu4=[];
   mu5=[];
   mu6=[];
   mu7=[];
name=[];
area=[];
excentricidad=[];
filledarea=[];
circularidad=[];
perimetro=[];
dEquiv=[];

s=regionprops(posIMGBN{i},'All');
s1=mean([s.Area]);
s2=mean([s.Eccentricity]);
s3=mean([s.FilledArea]);
s4=max([s.Circularity]);
s5=mean([s.Perimeter]);
s6=mean([s.EquivDiameter]);


eta_mat = SI_Moment(posIMGcolor{i});
    temp = Hu_Moments(eta_mat);
   sol=[temp(1) temp(2) temp(3) temp(4) temp(5) temp(6) temp(7)];
   mu1=[mu1; temp(1)];
   mu2=[mu2; temp(2)];
   mu3=[mu3; temp(3)];
   mu4=[mu4; temp(4)];
   mu5=[mu5; temp(5)];
   mu6=[mu6; temp(6)];
   mu7=[mu7; temp(7)];
   area=[area;s1];
    excentricidad=[excentricidad;s2];
    filledarea=[filledarea;s3];
    circularidad=[circularidad;s4];
    perimetro=[perimetro;s5];
    dEquiv=[dEquiv;s6];

 Ttest = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv);
 

   %ysal{i}=predict(trainedClassifier, Ttest{:,trainedClassifier.PredictorNames})
    ysal{i}=predict(trainedClassifierTODOS, Ttest{:,trainedClassifierTODOS.PredictorNames});
end 
   
   
    %%



im_pruebaCortada=c(minxIni:maxxIni,minyIni:maxyIni,:,:,:);

axes(handles.axes2);
imshow(BW2)
   
axes(handles.axes3);
imshow(im_pruebaCortada)

 index = 1;
axes(handles.axes4);
imshow(posIMGcolor{index})
   
 index = index+1;
axes(handles.axes5);
imshow(posIMGcolor{index}) 
%msgbox(ysal);

%msgbox(strcat("Resultado: la carta es ", ysal{1}," de ", ysal{2} ));
% 

if ysal{1}=="TREBOL" || ysal{1}=="ESPADA" || ysal{2}=="TREBOL" || ysal{2}=="ESPADA"
    colorCarta="Negro";
elseif ysal{1}=="DIAMANTE" || ysal{1}=="CORAZON" || ysal{2}=="DIAMANTE" || ysal{2}=="CORAZON"
    colorCarta="Rojo";
end
   set(handles.text2,'String','Resultados : ');
 set(handles.text3,'String',strcat('Se detecto la carta : ')); 
 set(handles.text4,'String',strcat(ysal{1}," de ", ysal{2})); 
 set(handles.text5,'String',strcat('Color : ',colorCarta));   
    
 
     set(handles.pushbutton5,'Enable','off');
     set(handles.pushbutton6,'Enable','on');

%end


% --- Executes on button press in pushbutton5.
%CARTA ANTERIOR
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global index trainedClassifierTODOS posIMGBN posIMGcolor
 
index = 1;



        axes(handles.axes4);
        imshow(posIMGcolor{index})
        index = index+1;
        axes(handles.axes5);
        imshow(posIMGcolor{index})   

        for i=1:2
        mu1=[];
           mu2=[];
           mu3=[];
           mu4=[];
           mu5=[];
           mu6=[];
           mu7=[];
        name=[];
        area=[];
        excentricidad=[];
        filledarea=[];
        circularidad=[];
        perimetro=[];
        dEquiv=[];

        s=regionprops(posIMGBN{index+1-i},'All');
        s1=mean([s.Area]);
        s2=mean([s.Eccentricity]);
        s3=mean([s.FilledArea]);
        s4=max([s.Circularity]);
        s5=mean([s.Perimeter]);
        s6=mean([s.EquivDiameter]);


        eta_mat = SI_Moment(posIMGcolor{index+1-i});
            temp = Hu_Moments(eta_mat);
           sol=[temp(1) temp(2) temp(3) temp(4) temp(5) temp(6) temp(7)];
           mu1=[mu1; temp(1)];
           mu2=[mu2; temp(2)];
           mu3=[mu3; temp(3)];
           mu4=[mu4; temp(4)];
           mu5=[mu5; temp(5)];
           mu6=[mu6; temp(6)];
           mu7=[mu7; temp(7)];
           area=[area;s1];
            excentricidad=[excentricidad;s2];
            filledarea=[filledarea;s3];
            circularidad=[circularidad;s4];
            perimetro=[perimetro;s5];
            dEquiv=[dEquiv;s6];

         Ttest = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv);
        ysal{i}=predict(trainedClassifierTODOS, Ttest{:,trainedClassifierTODOS.PredictorNames});
        end 
        
       % msgbox(strcat("Resultado: la carta es ", ysal{2}," de ", ysal{1} ));
    
        if ysal{1}=="TREBOL" || ysal{1}=="ESPADA" || ysal{2}=="TREBOL" || ysal{2}=="ESPADA"
            colorCarta="Negro";
        elseif ysal{1}=="DIAMANTE" || ysal{1}=="CORAZON" || ysal{2}=="DIAMANTE" || ysal{2}=="CORAZON"
            colorCarta="Rojo";
        end
           set(handles.text2,'String','Resultados : ');
         set(handles.text3,'String',strcat('Se detecto la carta : ')); 
         set(handles.text4,'String',strcat(ysal{1}," de ", ysal{2})); 
         set(handles.text5,'String',strcat('Color : ',colorCarta));   

        set(handles.pushbutton6,'Enable','on');
        set(handles.pushbutton5,'Enable','off');
            
% 







% --- Executes on button press in pushbutton6.
%CARTA SIGUIENTE
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global index trainedClassifierTODOS numobjeto posIMGBN trainedClassifier posIMGcolor
index = index+1;
    set(handles.pushbutton5,'Enable','on');
%pushbutton12_Callback(hObject, eventdata, handles)
if (index<=numobjeto)



        axes(handles.axes4);
        imshow(posIMGcolor{index})
        index=index+1;
        axes(handles.axes5);
        imshow(posIMGcolor{index})   

        for i=1:2
        mu1=[];
           mu2=[];
           mu3=[];
           mu4=[];
           mu5=[];
           mu6=[];
           mu7=[];
        name=[];
        area=[];
        excentricidad=[];
        filledarea=[];
        circularidad=[];
        perimetro=[];
        dEquiv=[];

        s=regionprops(posIMGBN{index+1-i},'All');
        s1=mean([s.Area]);
        s2=mean([s.Eccentricity]);
        s3=mean([s.FilledArea]);
        s4=max([s.Circularity]);
        s5=mean([s.Perimeter]);
        s6=mean([s.EquivDiameter]);


        eta_mat = SI_Moment(posIMGcolor{index+1-i});
            temp = Hu_Moments(eta_mat);
           sol=[temp(1) temp(2) temp(3) temp(4) temp(5) temp(6) temp(7)];
           mu1=[mu1; temp(1)];
           mu2=[mu2; temp(2)];
           mu3=[mu3; temp(3)];
           mu4=[mu4; temp(4)];
           mu5=[mu5; temp(5)];
           mu6=[mu6; temp(6)];
           mu7=[mu7; temp(7)];
           area=[area;s1];
            excentricidad=[excentricidad;s2];
            filledarea=[filledarea;s3];
            circularidad=[circularidad;s4];
            perimetro=[perimetro;s5];
            dEquiv=[dEquiv;s6];

         Ttest = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv);
   ysal{i}=predict(trainedClassifierTODOS, Ttest{:,trainedClassifierTODOS.PredictorNames});
        end 
        
       % msgbox(strcat("Resultado: la carta es ", ysal{2}," de ", ysal{1} ));
    
        if ysal{1}=="TREBOL" || ysal{1}=="ESPADA" || ysal{2}=="TREBOL" || ysal{2}=="ESPADA"
            colorCarta="Negro";
        elseif ysal{1}=="DIAMANTE" || ysal{1}=="CORAZON" || ysal{2}=="DIAMANTE" || ysal{2}=="CORAZON"
            colorCarta="Rojo";
        end
           set(handles.text2,'String','Resultados : ');
         set(handles.text3,'String',strcat('Se detecto la carta : ')); 
         set(handles.text4,'String',strcat(ysal{1}," de ", ysal{2})); 
         set(handles.text5,'String',strcat('Color : ',colorCarta));   


            if ( index+1 >numobjeto)
                set(handles.pushbutton6,'Enable','off');
            end
    else

            set(handles.pushbutton6,'Enable','off');
            index = index-1;

end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global defaultFigure
set(handles.figure1,'OuterPosition',[defaultFigure(1) defaultFigure(2) 290 defaultFigure(4)]);

%set(handles.uipanel1,'OuterPosition',[2.8 0.923 205 59]);

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
if ( get(handles.radiobutton3,'Value')==1)
       set(handles.UploadFile,'Visible','off');
       set(handles.popupmenu1,'Visible','on');
       set(handles.pushbutton1,'Visible','on');
       set(handles.pushbutton2,'Visible','on');

   end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
   if ( get(handles.radiobutton4,'Value')==1)
       set(handles.UploadFile,'Visible','on');
       set(handles.popupmenu1,'Visible','off');
       set(handles.pushbutton1,'Visible','off');
       set(handles.pushbutton2,'Visible','off');
      
   end


% --- Executes during object creation, after setting all properties.
function uibuttongroup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%%ELEGIR TURNO
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I turnoJuego rondaJuego numobjeto posIMGBN posIMGcolor trainedClassifierTODOS
set(handles.uipanel2,'Visible','off')
set(handles.pushbutton5,'Enable','off')
set(handles.pushbutton6,'Enable','off')

BotonProcesar_Callback(hObject, eventdata, handles)

p=1;
numero=0;
for i=1:numobjeto
mu1=[];
   mu2=[];
   mu3=[];
   mu4=[];
   mu5=[];
   mu6=[];
   mu7=[];
name=[];
area=[];
excentricidad=[];
filledarea=[];
circularidad=[];
perimetro=[];
dEquiv=[];

s=regionprops(posIMGBN{i},'All');
s1=mean([s.Area]);
s2=mean([s.Eccentricity]);
s3=mean([s.FilledArea]);
s4=max([s.Circularity]);
s5=mean([s.Perimeter]);
s6=mean([s.EquivDiameter]);


eta_mat = SI_Moment(posIMGcolor{i});
    temp = Hu_Moments(eta_mat);
   sol=[temp(1) temp(2) temp(3) temp(4) temp(5) temp(6) temp(7)];
   mu1=[mu1; temp(1)];
   mu2=[mu2; temp(2)];
   mu3=[mu3; temp(3)];
   mu4=[mu4; temp(4)];
   mu5=[mu5; temp(5)];
   mu6=[mu6; temp(6)];
   mu7=[mu7; temp(7)];
   area=[area;s1];
    excentricidad=[excentricidad;s2];
    filledarea=[filledarea;s3];
    circularidad=[circularidad;s4];
    perimetro=[perimetro;s5];
    dEquiv=[dEquiv;s6];

 Ttest = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv);
 

   %ysal{i}=predict(trainedClassifier, Ttest{:,trainedClassifier.PredictorNames})
    prediccion=predict(trainedClassifierTODOS, Ttest{:,trainedClassifierTODOS.PredictorNames});


    ysal{i}=prediccion;

    switch (prediccion{1})
        case "UNO"
            numero=1;
        case "DOS"
            numero=2;
        case "TRES"
            numero=3;
        case "CUATRO"
            numero=4;
        case "CINCO"
            numero=5;
        case "SEIS"
            numero=6;
        case "SIETE"
            numero=7;
        case "OCHO"
            numero=8;
        case "NUEVE"
            numero=9;
        case "DIEZ"
            numero=10;            
    end
    if numero>0
        numSal(p)=numero;
        p=p+1;
        numero=0;
    end
    
end 
numSal
cartaUser=numSal(randi([1,length(numSal)]));
cartaPC=numSal(randi([1,length(numSal)]));




set(handles.text12,'String',strcat('Tu carta : ',num2str(cartaUser)));

%dado de la pc
pause(1)
dadoPC=randi([1,6]);
set(handles.text11,'String',strcat('carta de PC : ',num2str(cartaPC)));

if( cartaUser>=cartaPC)
    set(handles.text13,'String','Usuario comienza');
    set(handles.text10,'String',strcat("TURNO USUARIO COLOCA ",num2str(randi([2,4]))," CARTAS."));
    turnoJuego=1;   
    rondaJuego=1;
else
    set(handles.text13,'String','PC comienza');
    set(handles.text10,'String',strcat("TURNO PC COLOCA ",num2str(randi([2,4]))," CARTAS."));
    turnoJuego=0;
    rondaJuego=1;
end
set(handles.pushbutton8,'Enable', 'off');
set(handles.pushbutton9,'Enable','on');



% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I turnoJuego rondaJuego numobjeto posIMGBN posIMGcolor trainedClassifierTODOS im_pruebaCortada cartaUsuario cartaPC

%%PRECIONO BOTON PROCESAR
BotonProcesar_Callback(hObject, eventdata, handles)


numero=0;
p=1;
for i=1:numobjeto
mu1=[];
   mu2=[];
   mu3=[];
   mu4=[];
   mu5=[];
   mu6=[];
   mu7=[];
name=[];
area=[];
excentricidad=[];
filledarea=[];
circularidad=[];
perimetro=[];
dEquiv=[];

s=regionprops(posIMGBN{i},'All');
s1=mean([s.Area]);
s2=mean([s.Eccentricity]);
s3=mean([s.FilledArea]);
s4=max([s.Circularity]);
s5=mean([s.Perimeter]);
s6=mean([s.EquivDiameter]);


eta_mat = SI_Moment(posIMGcolor{i});
    temp = Hu_Moments(eta_mat);
   sol=[temp(1) temp(2) temp(3) temp(4) temp(5) temp(6) temp(7)];
   mu1=[mu1; temp(1)];
   mu2=[mu2; temp(2)];
   mu3=[mu3; temp(3)];
   mu4=[mu4; temp(4)];
   mu5=[mu5; temp(5)];
   mu6=[mu6; temp(6)];
   mu7=[mu7; temp(7)];
   area=[area;s1];
    excentricidad=[excentricidad;s2];
    filledarea=[filledarea;s3];
    circularidad=[circularidad;s4];
    perimetro=[perimetro;s5];
    dEquiv=[dEquiv;s6];

 Ttest = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv);
 

   %ysal{i}=predict(trainedClassifier, Ttest{:,trainedClassifier.PredictorNames})
    prediccion=predict(trainedClassifierTODOS, Ttest{:,trainedClassifierTODOS.PredictorNames});

    
    ysal{i}=prediccion;
    switch (prediccion{1})
        case "UNO"
            numero=1;
        case "DOS"
            numero=2;
        case "TRES"
            numero=3;
        case "CUATRO"
            numero=4;
        case "CINCO"
            numero=5;
        case "SEIS"
            numero=6;
        case "SIETE"
            numero=7;
        case "OCHO"
            numero=8;
        case "NUEVE"
            numero=9;
        case "DIEZ"
            numero=10;
    end
    if numero>0
        numSal(p)=numero;
        p=p+1;
        numero=0;
    end
    
end  
numSal
total=0;
if (turnoJuego==1)
    set(handles.axes6,'Visible','on');
    axes(handles.axes6);
    imshow(im_pruebaCortada) 
    rondaJuego=rondaJuego+1
    turnoJuego=0;
    set(handles.text10,'String', strcat("TURNO PC COLOCA ",num2str(randi([2,4]))," CARTAS."));
    for i=1:length(numSal)
        total=total+numSal(i);
    end
    cartaUsuario=total;
    set(handles.text24,'String', strcat("Tu carta : ",num2str(cartaUsuario)));
    if (rondaJuego>=3)
       if (cartaUsuario >= cartaPC)
           set(handles.text10,'String', '!GANA USUARIO!');
           set(handles.pushbutton8,'Enable', 'on');
           set(handles.pushbutton9,'Enable', 'off');
           else
           set(handles.text10,'String', '!GANA PC!');
           set(handles.pushbutton8,'Enable', 'on');
           set(handles.pushbutton9,'Enable', 'off');
       end
    end
    
elseif (turnoJuego==0)
    set(handles.axes7,'Visible','on');
    axes(handles.axes7);
    imshow(im_pruebaCortada) 
    rondaJuego=rondaJuego+1
    turnoJuego=1;
    for i=1:length(numSal)
        total=total+numSal(i);
    end
    cartaPC=total;
    set(handles.text25,'String', strcat("Carta PC : ",num2str(cartaPC)));
   set(handles.text10,'String', strcat("TURNO USUARIO COLOCA ",num2str(randi([2,4]))," CARTAS."));
    if (rondaJuego>=3)
       if (cartaUsuario >= cartaPC)
           set(handles.text10,'String', '!GANA PC!');
           set(handles.pushbutton8,'Enable', 'on');
           set(handles.pushbutton9,'Enable', 'off');
       else
           set(handles.text10,'String', '!GANA USUARIO!');
           set(handles.pushbutton8,'Enable', 'on');
           set(handles.pushbutton9,'Enable', 'off');
       end
    end
end




% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.axes6,'visible','off');
set(handles.axes7,'visible','off');
cla(handles.axes6);
cla(handles.axes7);
set(handles.pushbutton8,'Enable','on');
set(handles.pushbutton9,'Enable','off');
set(handles.text10,'String', '');
set(handles.text11,'String', '');
set(handles.text12,'String', '');
set(handles.text13,'String', '');
set(handles.text24,'String', '');
set(handles.text25,'String', '');



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global defaultPanel defaultFigure

set(handles.figure1,'OuterPosition',defaultFigure);
set(handles.axes6,'visible','off');
set(handles.axes7,'visible','off');
cla(handles.axes6);
cla(handles.axes7);
set(handles.pushbutton8,'Enable','on');
set(handles.pushbutton9,'Enable','off');
set(handles.text10,'String', '');
set(handles.text11,'String', '');
set(handles.text12,'String', '');
set(handles.text13,'String', '');
set(handles.text24,'String', '');
set(handles.text25,'String', '');
%set(handles.uipanel1,'OuterPosition',defaultPanel);



