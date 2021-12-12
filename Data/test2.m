clc;close all; clear all;
all_files = dir;
all_dir = all_files([all_files(:).isdir]);
num_dir = numel(all_dir)



% re1=[];
% re2=[];
% re3=[];
% re4=[];
%all_dir.name
for h=3:num_dir
cd(all_dir(h).name)
a = dir('*.jpg');
z = numel(a)
disp( pwd)
disp('...')

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



for p=1:z
    close all;
hu_arr=[];

%    %%
 A=imread(a(p).name);

%      [M]=feature_vec(double(A));
c=rgb2gray(A);
d=255*imbinarize(c); 
b=medfilt2(255-d);
% figure()
% imshow(b)
% pause(0.5)

s=regionprops(b,'All');
s1=mean([s.Area]);
s2=mean([s.Eccentricity]);
s3=mean([s.FilledArea]);
s4=max([s.Circularity]);
s5=mean([s.Perimeter]);
s6=mean([s.EquivDiameter]);

% x=mean([s.Orientation])
% result=(abs(x)-90*sign(abs(x)))
% J = imrotate(A,result);
% figure()
% imshow(b);
% impixelinfo
% figure()
% imshow(J);
%ocr(b, 'TextLayout', 'line', 'CharacterSet', '0123456789')   

  temporal=0;
    eta_mat = SI_Moment(A);
    temp = Hu_Moments(eta_mat);
   sol=[temp(1) temp(2) temp(3) temp(4) temp(5) temp(6) temp(7)];
   mu1=[mu1; temp(1)];
   mu2=[mu2; temp(2)];
   mu3=[mu3; temp(3)];
   mu4=[mu4; temp(4)];
   mu5=[mu5; temp(5)];
   mu6=[mu6; temp(6)];
   mu7=[mu7; temp(7)];
   name=[name;string(all_dir(h).name)];
   area=[area;s1];
    excentricidad=[excentricidad;s2];
    filledarea=[filledarea;s3];
    circularidad=[circularidad;s4];
    perimetro=[perimetro;s5];
    dEquiv=[dEquiv;s6];
% 
% s = regionprops(I,'all');
% temparea=s.Area;
% tempcentroide=s.FilledArea;
% tempexcentricidad=s.Eccentricity;
% tempconvArea=s.ConvexArea;
% tempcircularidad=s.Circularity;
% tempeuNum=s.EulerNumber;
% tempsol=s.Solidity;
% tempetiqueta="uno";
% etiqueta=[etiqueta, "uno"];
% 
% if(isempty(tempexcentricidad))
%     excentricidad(p)=0;
% else
%     excentricidad(p)=tempexcentricidad;
% end
% 
% if(isempty(tempconvArea))
%     convArea(p)=0;
% else
%     convArea(p)=tempconvArea;
% end
% if(isempty(tempcircularidad))
%     circularidad(p)=0;
% else
%     circularidad(p)=tempcircularidad;
% end
% if(isempty(tempeuNum))
%     euNum(p)=0;
% else
%     euNum(p)=tempeuNum;
% end
% if(isempty(tempsol))
%     sol(p)=0;
% else
%     sol(p)=tempsol;
% end
% 
% area(p)=temparea;
% centroide(p)=tempcentroide;






% Igray=rgb2gray(I);
% 
% 
% [M,N]= size(Igray); % Determina el tamaño de la imagen.
% Ibin = zeros(M,N); % Imagen modificada
% disp(p)
% disp("Procesado")
end
 cd ..
disp(h)
switch(h)
    case 3
        T1 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T1')
    case 4
        T2 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T2')
    case 5
        T3 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T3')
    case 6
        T4 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T4')
    case 7
        T5 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T5')
    case 8
        T6 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T6')
    case 9
        T7 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T7')
    case 10
        T8 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T8')
    case 11
        T9 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T9')
    case 12
        T10 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T10')
    case 13
        T11 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T11')
    case 14
        T12 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T12')
    case 15
        T13 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
        save(strcat(all_dir(h).name,'.mat'), 'T13')
    case 16
        T14 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
         save(strcat(all_dir(h).name,'.mat'), 'T14')
%     case 17
%         T15 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
%         save(strcat(all_dir(h).name,'.mat'), 'T15')
%     case 18
%         T16 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
%         save(strcat(all_dir(h).name,'.mat'), 'T16')
%     case 19
%         T17 = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
%         save(strcat(all_dir(h).name,'.mat'), 'T17')

end

 end
%%
 %T = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv,name)
%  area=area';
%  centroide=centroide';
%  excentricidad=excentricidad';
%  convArea=convArea';
%  circularidad=circularidad';
%  sol=sol';
%  euNum=euNum';
%  etiqueta=etiqueta';
%  patients = table(area,centroide,excentricidad,convArea,circularidad,sol,euNum,etiqueta);
%   
%  
%  patients