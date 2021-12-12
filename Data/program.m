clear all, clc, close all
%% Genero las tablas para el entrenamiento %% 
% Clases a estimar: garbanzo,lenteja,trigo
%Cargo los datos de cada clase
%En la ultima columna están las etiquetas de cada clase
load UNO  
load DOS  
load TRES
load CUATRO
load CINCO
load SEIS
load SIETE
load OCHO
load NUEVE
load DIEZ
load J
load Q
load K
 load CORAZON
 load DIAMANTE
 load TREBOL
 load ESPADA


%Genero la tabla con los datos de cada clase de manera aleatoria
Tdata=[T2;T3;T4;T5;T6;T7;T8;T9;T10;T11;T12;T13;T14;T1;T18;T19;T20];
[q,t]=size(Tdata);
ind=randperm(q,q);
for i=1:q
    Tdata(i,:)=Tdata(ind(i),:);
end
Tentrena=Tdata(1:round(q*70/100),:); %El 70% para el entrenamiento
Tvalida=Tdata(round(q*30/100)+1:end,:); %El 30% para la validacion 

%% ENTRENO LA RED
[trainedClassifierTODOS, validationAccuracy] = trainClassifierSVM(Tentrena);

%% Valido la red con los 30% de datos 
%trainedClassifier es la red entrenada
%ysal es la salida de la red cuando se le ingresa un nuevo dato


[a,b]=size(Tvalida);
yfit=[];
for i=1:a
    T=Tvalida(i,1:end-1); 
    ysal=predict(trainedClassifierTODOS, T{:,trainedClassifierTODOS.PredictorNames}); 
    yfit = [yfit; ysal];
end
res=[Tvalida(:,end),yfit];
test=categorical(Tvalida.name);
yt=categorical(yfit);
[cm,order]=confusionmat(test,yt);





% I=imread('3.jpg','jpg');
% 
% Igray=rgb2gray(I);
% 
% [M,N]= size(Igray); % Determina el tamaño de la imagen.
% Ibin = zeros(M,N); % Imagen modificada
% 
% 
% 
% AreaAmarilla=  find(I(:,:,1)>=80 & I(:,:,1)<=120 & I(:,:,2)>=80 &I(:,:,2)<=120 & I(:,:,3)<=60);%amarillo
% AreaAzul=  find(I(:,:,1)<=50 & I(:,:,2)<=80 & I(:,:,3)>=80 & I(:,:,3)<=150);%amarillo
%            
%            
% for x = 1:M
%     for y = 1:N
%         if Igray(x,y) <= 100  % Intensidades. Estaba  170.
%             Igray(x,y) = 0;
%             Ibin(x,y) = 0;
%             else
%             Ibin(x,y) = 255;
%         end
%     end
% end
% Ibin(AreaAmarilla)=255;
% Ibin(AreaAzul)=255;
% %  figure()
% %   imshow(Ibin)
% %             impixelinfo;
% 
% 
% % figure()
% %            imshow(Igray)
% %            impixelinfo;
% 
% test=imbinarize(Igray,0.39);             
% % figure()
% %            imshow(test)
% %            impixelinfo;  
%            
%         
%    
%   BW2 = imfill(Ibin,'holes');         
% %    figure()
% %             imshow(BW2)
% %            impixelinfo;          
%            
% [ob,nob] = bwlabel(BW2);        
% nob;
% minx=0;
% miny=0;
% maxx=0;
% maxy=0;
% for i=1:nob  
%     [xTemp,yTemp]=find(ob==nob);
%     minx=min(xTemp);
%     miny=min(yTemp);
%     maxx=max(xTemp);
%     maxy=max(yTemp);
%    
% end
% hx=maxx-minx;
% hy=maxy-miny;
% 
% nonIbin=255-Ibin;
% %  figure()
% %             imshow(nonIbin)
% %             impixelinfo;  
% [ob2,nob2] = bwlabel(nonIbin);     
% 
% 
% 
% nob2     
% tem = zeros(1,nob2);
% % Detección de regiones indeseadas por tamaño
% [r, c, n]= size(nonIbin);
% if nob2 > 0
%     for s = 1:nob2
%         tem(s) = length(ob2(ob2==s));  % Almacena el tamaño de cada region
%         if tem(s) < 100 || tem(s) > 350 % Menores a este valor son regiones indeseadas
%             
%             % Quitamos las regiones indeseadas
%             for i = 1:M
%                 for j = 1:N
%                     if ob2(i,j) == s
%                         nonIbin(i,j) = 0; % Ponemos a 0 las regiones indeseadas
%                     end
%                     if (i>minx+170)
%                     nonIbin(i,j) = 0;
%                     end
%                 end
%             end   
%         end
%     end
% end
% % 
% % figure()
% %            imshow(nonIbin)
% %            impixelinfo;  
% 
% b=medfilt2(nonIbin);
% figure()
%            imshow(b)
% 
% [Iobjeto,numobjeto] = bwlabel(b);
%  
% pos=cell(1,numobjeto); %imagen individual en tamaño de captura
% posIMGcolor=cell(1,numobjeto); %imagen de carta cortada ( solo la carta )
% posUbi=cell(1,numobjeto); %posicion de carta detectada
% imgEnderezada=cell(1,numobjeto); %imagen enderezada
% numValCarta=cell(1,numobjeto);
% imgAreaBusqueda=cell(1,numobjeto); %imagen de busqueda de numero
% posIMGNUM=cell(1,numobjeto); %Imagen recortada numero
% posIMGSim=cell(1,numobjeto); %Imagen recortada simbolo
% posIMREY=cell(1,numobjeto); %Imagen recortada cabeza rey
% areainfo=cell(1,numobjeto); %area info
% 
% 
%     for num=1:numobjeto
%         
%         [xTemp,yTemp]=find(Iobjeto==num);
%         % 
%         posUbi{num}=[xTemp,yTemp];
%         
%         
%        If=zeros(M,N); 
%        for x=1:M
%            for y=1:N
%                if Iobjeto(x,y)==num
%                   If(x,y)=255;    
%                end   
%            end    
%        end
%         pos{num}=If;
% 
%     end
% 
% 
% for i=1:numobjeto
%     x=posUbi{i}(:,1);
%     y=posUbi{i}(:,2);
%     im_prueba=I(min(x):max(x),min(y):max(y),:,:,:);
%     im_pruebaBN=b(min(x):max(x),min(y):max(y),:,:,:);
%     posIMGcolor{i}=im_prueba;
%     posIMGBN{i}=im_pruebaBN;
% %           figure()
% %           imshow(im_prueba)
% %          figure()
% %          imshow(im_pruebaBN)
% end
% 
% 
% %%
% figure()
% imshow(posIMGBN{5})
% %%
% mu1=[];
%    mu2=[];
%    mu3=[];
%    mu4=[];
%    mu5=[];
%    mu6=[];
%    mu7=[];
% name=[];
% area=[];
% excentricidad=[];
% filledarea=[];
% circularidad=[];
% perimetro=[];
% dEquiv=[];
% 
% s=regionprops(posIMGBN{5},'All');
% s1=mean([s.Area]);
% s2=mean([s.Eccentricity]);
% s3=mean([s.FilledArea]);
% s4=max([s.Circularity]);
% s5=mean([s.Perimeter]);
% s6=mean([s.EquivDiameter]);
% 
% 
% eta_mat = SI_Moment(posIMGcolor{5});
%     temp = Hu_Moments(eta_mat);
%    sol=[temp(1) temp(2) temp(3) temp(4) temp(5) temp(6) temp(7)];
%    mu1=[mu1; temp(1)];
%    mu2=[mu2; temp(2)];
%    mu3=[mu3; temp(3)];
%    mu4=[mu4; temp(4)];
%    mu5=[mu5; temp(5)];
%    mu6=[mu6; temp(6)];
%    mu7=[mu7; temp(7)];
%    area=[area;s1];
%     excentricidad=[excentricidad;s2];
%     filledarea=[filledarea;s3];
%     circularidad=[circularidad;s4];
%     perimetro=[perimetro;s5];
%     dEquiv=[dEquiv;s6];
% 
%  Ttest = table(mu1,mu2,mu3,mu4,mu5,mu6,mu7, area,excentricidad,filledarea,circularidad,perimetro,dEquiv);
%  
%     ysal=predict(trainedClassifier, Ttest{:,trainedClassifier.PredictorNames})






%Grafico la matriz de confusión
plotConfMat(cm,{'CINCO' 'CORAZON' 'CUATRO' 'DIAMANTE' 'DIEZ' 'DOS' 'ESPADA' 'NUEVE' 'OCHO' 'SEIS' 'SIETE' 'TREBOL' 'TRES' 'UNO' 'J' 'Q' 'K'})