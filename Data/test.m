clc; clear all; close all;
I=imread('test.jpg','jpg');



%% Reconocimiento de fichas en general
% Convertimos la imagen a escala de grises


%pos=find(I(:,:,1)>=150 & I(:,:,2)>=150 & I(:,:,3)>=50 & I(:,:,3)<=180);


%I2=I;
%I2(pos)=60;

Igray=rgb2gray(I);

% Binarizamos la intensidad de la imagen para facilitar el reconocimiento
[M,N]= size(Igray); % Determina el tamaño de la imagen.
Ibin = zeros(M,N); % Imagen modificada
for x = 1:M
    for y = 1:N
        if Igray(x,y) <= 170 % Intensidades. Estaba  170.
            Ibin(x,y) = 0;
        else
            Ibin(x,y) = 255;
        end
    end
end

pout_imadjust = imadjust(Ibin);

BW = 255*imbinarize(Igray,0.5);

figure()
imshow(BW)

figure()
imshow(255-BW)


% Primera matriz de etiquetado (Para detectar regiones pequeñas indeseadas)
[ob,nob] = bwlabel(Ibin);

tem = zeros(1,nob);
% Detección de regiones indeseadas por tamaño
if nob > 0
    for s = 1:nob
        tem(s) = length(ob(ob==s));  % Almacena el tamaño de cada region
        if tem(s) < 1500 % Menores a este valor son regiones indeseadas
            % Quitamos las regiones indeseadas
            for i = 1:M
                for j = 1:N
                    if ob(i,j) == s
                        Ibin(i,j) = 0; % Ponemos a 0 las regiones indeseadas
                    end
                end
            end
        end
    end
end


% Segunda matriz de etiquetado (Para detectar todas las fichas)
[Iobjeto,numobjeto] = bwlabel(Ibin);

pos=cell(1,numobjeto);
posIMGcolor=cell(1,numobjeto);
posUbi=cell(1,numobjeto);


objeto=2;
if numobjeto>0 && objeto<=numobjeto && objeto>0
    for num=1:numobjeto
        
        [xTemp,yTemp]=find(Iobjeto==num);
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
       figure()
       imshow(uint8(If));
       
    end
end

for i=1:numobjeto
    x=posUbi{i}(:,1);
    y=posUbi{i}(:,2);
    im_prueba=I(min(x):max(x),min(y):max(y),:,:,:);
    posIMGcolor{i}=im_prueba;
    figure()
    imshow(uint8(im_prueba));
end





