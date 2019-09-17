%Función encargada del cálculos de las características y etiquetas de un
%conjunto de imagenes dado el tamaño de imagenes positivas y el
%multiplicador del número de imagenes negativas (*50)
function [X_pos,y_pos,X_neg,y_neg] = calcularCaracteristicas(tamPos,multiploNeg)

%Se seleccionan aleatoriamente los indices de las imagenes
selectAleatorio = randperm(900);
seleccionados = selectAleatorio(1:tamPos);

%Matriz de caracteristicas
X_pos = zeros(tamPos,12420);

for i=1:tamPos
    %Se toma la direccion de la imagen
    select = seleccionados(i);
    if(select<10)
        img = cat(2,'data/pedestrians128x64/per0000',cat(2,int2str(select),'.ppm'));
    elseif(select<100)
        img = cat(2,'data/pedestrians128x64/per000',cat(2,int2str(select),'.ppm'));
    else
        img = cat(2,'data/pedestrians128x64/per00',cat(2,int2str(select),'.ppm'));
    end
    
    %Se carga la imagen
    I = imread(img);
    
    %Se calcula el HOG de la imagen
    hog = calcularHOG(I);
    X_pos(i,:) = hog;
    
end

%Se construyen las etiquetas positivas
y_pos = ones(1,tamPos);


%Direccion de las imagenes negativas
imgsNeg = dir('data/pedestrians_neg');
imgsNeg = imgsNeg(3:52);

%Se repiten las imagenes negativos el numero de veces indicado
imgsNeg = repmat(imgsNeg,multiploNeg);
tamNeg = 50*multiploNeg;

%Matriz de caracteristicas
X_neg = zeros(tamNeg,12420);

for i=1:tamNeg
   %Se toma el nombre de la imagen 
   img = imgsNeg(i).name;
   img = cat(2,'data/pedestrians_neg/',img);
   %Se lee la imagen
   I=imread(img);
   
   %Se ajusta su tamaño
   I = imresize(I, [512 512]);
   
   %Se escoge aleatoriamente una subarea de la imagen de 128x64
   lim = 512-128;
   randF = randi([1 lim],1,1);
   
   lim = 512-64;
   randC = randi([1 lim],1,1);
   
   I = I(randF:randF+127,randC:randC+63,:);
   
   %Se calcula el HOG para la imagen
   hog = calcularHOG(I);
   X_neg(i,:) = hog;
    
end

%Se construyen las etiquetas negativas
y_neg = zeros(1,tamNeg) -1;



end