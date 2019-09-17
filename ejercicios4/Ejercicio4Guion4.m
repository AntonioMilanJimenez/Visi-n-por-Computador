%Analizar la imagen distorsion1.jpg y aplicar diferentes técnicas para mejorarla (eliminación del ruido).
%En concreto, prueba con suavizados gaussianos y con el filtro 'motion' de Matlab. ¿Se te ocurre 
%alguna otra técnica que mejore sensiblemente la calidad de la imagen respecto de los filtrados 
%propuestos? 
I = imread('distorsion1.jpg');

%Se divide la imagen en las bandas hsv para poder realizar el filtro de
%Medianas sin alterar el color
Ihsv = rgb2hsv(I);
h = Ihsv(:,:,1);
s = Ihsv(:,:,2);
v = Ihsv(:,:,3);

%Se construyen los filtros correspondientes de Gauss y Motion
gauss5 = fspecial('gaussian',[5 5]);
gauss7 = fspecial('gaussian',[7 7]);
motion5 = fspecial('motion',5);
motion7 = fspecial('motion',7);

%Se aplican los filtros
Ig5 = imfilter(I,gauss5);
Ig7 = imfilter(I,gauss7);
Im5 = imfilter(I,motion5);
Im7 = imfilter(I,motion7);

%Se aplica tambien el filtro de Medianas sobre la banda v para no alterar
%el color de la imagen
IMedian7 = medfilt2(v,[7 7]);
IMedian7 = cat(3,h,s,IMedian7);
IMedian7 = hsv2rgb(IMedian7);

subplot(2,3,1),imshow(I),title('Original'),subplot(2,3,2),imshow(Ig5),title('Gaussian 5x5');
subplot(2,3,3),imshow(Ig7),title('Gaussian 7x7'),subplot(2,3,4),imshow(Im5),title('Motion 5x5');
subplot(2,3,5),imshow(Im7),title('Motion 7x7'),subplot(2,3,6),imshow(IMedian7),title('Medianas 7x7');
%Observamos que el filtro Gaussiano no funciona bien pues realmente no
%llega a eliminar el ruido. Con el filtro 'Motion' se consiguen mejores
%resultados, se elimina el ruido aunque quizás se 'emborrona' demasiado la
%imagen. Con el  filtrado de Medianas parece obternerse los mejores
%resultados pues se elimina igualmente el ruido de la imagen pero sin que
%pierda tanta calidad la imagen.