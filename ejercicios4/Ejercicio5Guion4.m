%Obtener sobre la imagen formas.png las esquinas usando el método de Harris. 
I = imread('formas.png');
%Aplicamos la detección de Harris
C = corner(I,'Harris');

imshow(I);
hold on;
plot(C(:,1),C(:,2),'r*');
%Se obtiene un gran resultado consiguiendo detectar las diferentes esquinas
%de las diferentes formas de la imagen, fallando en que algunas veces se
%detectan esquinas en los circulos, aunque esto se podría solventar con una
%mayor resolucion de la imagen.