%Función encargada de insertar una imagen en un fondo a partir de la fila y
%columna dada y el código del fondo: Verde --> 0 255 0
function imagen = chroma_key2(I,fondo,columna,fila,rojo,verde,azul)

%En función del color del chroma se calcula A
if rojo == 255
    A=0.5;
elseif verde == 255;
    A=0.5-0.3333;
else
    A=0.5-0.667;
end
  
  
imHSV=rgb2hsv(I);
aux=mod(imHSV(:,:,1)+A,1.0); 
color = 1-2*abs(aux-0.5);
imHSV(:,:,1)=color;
imHSV(:,:,2)=1;
imHSV(:,:,3)=1;

%En funcion de la componente de color de HSV se construye la mascara
mascara = imHSV(:,:,1);
%Umbral para que solo los pixeles correspondientes al color del chroma
%alcancen 1.
mascara = mascara + 0.05;

%Se obtiene la parte entera de la matriz, consiguiendo una mascara de 0 y 1
%donde 1 será aquellos pixeles del chroma
mascara = uint8(fix(mascara));
figure, imshow(mascara*255),title('Mascara');

[lenX,lenY] = size(mascara);

fondoBandaRoja = fondo(:,:,1);
fondoBandaVerde = fondo(:,:,2);
fondoBandaAzul = fondo(:,:,3);

%Se toman las areas correspondientes de la imagen de fondo del mismo tamaño
%que la mascara
areaRoja = fondoBandaRoja((fila+1):(lenX+fila),(columna+1):(lenY+columna));
areaVerde = fondoBandaVerde((fila+1):(lenX+fila),(columna+1):(lenY+columna));
areaAzul = fondoBandaAzul((fila+1):(lenX+fila),(columna+1):(lenY+columna));

%Se aplica la mascara eliminando de la imagen de fondo los píxeles que
%pasaran a ser del objeto del chroma
areaMaskRoja = areaRoja.*mascara;
areaMaskVerde = areaVerde.*mascara;
areaMaskAzul = areaAzul.*mascara;

figure,imshow(areaMaskRoja),title('Mascara sobre fondo');

imagenRojo = I(:,:,1);
imagenVerde = I(:,:,2);
imagenAzul = I(:,:,3);

%Se aplica la mascara invertida sobre el chroma de forma que ahora pase a 0
%todo el chroma de fondo, dejando a su valor normal el objeto que se quiere
%incluir
mascaraInvertida = mod((mascara+1),2);
imagenRojoMask = imagenRojo.*mascaraInvertida;
imagenVerdeMask = imagenVerde.*mascaraInvertida;
imagenAzulMask = imagenAzul.*mascaraInvertida;

%Ya se pueden sumar directamente las dos imagenes con las mascaras
%aplicadas
compuestaRojo = imagenRojoMask + areaMaskRoja;
compuestaVerde = imagenVerdeMask + areaMaskVerde;
compuestaAzul = imagenAzulMask + areaMaskAzul;

%Se actualiza en la imagen final las imagenes compuestas creadas
fondoBandaRoja((fila+1):(lenX+fila),(columna+1):(lenY+columna)) = compuestaRojo;
fondoBandaVerde((fila+1):(lenX+fila),(columna+1):(lenY+columna)) = compuestaVerde;
fondoBandaAzul((fila+1):(lenX+fila),(columna+1):(lenY+columna)) = compuestaAzul;

%Se recomponen las 3 bandas para obtener la imagen compuesta final
imagen = cat(3,fondoBandaRoja,fondoBandaVerde,fondoBandaAzul);
figure,imshow(imagen),title('Imagen compuesta');

end

