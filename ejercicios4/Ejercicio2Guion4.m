%¿Cómo se puede mejorar la calidad de las imágenes distorsion2.jpg, rostro1.png y rostro2.png? 
I = imread('distorsion2.jpg');
Ir1 = imread('rostro1.png');
Ir2 = imread('rostro2.png');

imshow(I);
%Observando la primera imagen, para aumentar la calidad se podría aplicar
%el filtro 'unsharp' para realzar los detalles

filtroU5 = fspecial('unsharp',0.05);
filtroU15 = fspecial('unsharp',0.15);
filtroU25 = fspecial('unsharp',0.25);
filtroU40 = fspecial('unsharp',0.4);

resultadoU5 = imfilter(I,filtroU5,'replicate');
resultadoU15 = imfilter(I,filtroU15,'replicate');
resultadoU25 = imfilter(I,filtroU25,'replicate');
resultadoU40 = imfilter(I,filtroU40,'replicate');

subplot(2,3,1),imshow(I),title('Original'),subplot(2,3,2),imshow(resultadoU5),title('Filtrado U 0.05');
subplot(2,3,3),imshow(resultadoU15),title('Filtrado U 0.15'),subplot(2,3,4),imshow(resultadoU25),title('Filtrado U 0.25');
subplot(2,3,5),imshow(resultadoU40),title('Filtrado U 0.4');
%Con este filtrado unsharp se consigue realzar los detalles de la imagen,
%sobretodo con filtrados 0.05 y 0.15



imshow(Ir1);
%Para esta nueva imagen, podría ser nuevamente una buena idea intentar
%realzar los detalles pues se encuentra algo borrosa

resultadoU5 = imfilter(Ir1,filtroU5,'replicate');
resultadoU15 = imfilter(Ir1,filtroU15,'replicate');
resultadoU25 = imfilter(Ir1,filtroU25,'replicate');

subplot(2,2,1),imshow(Ir1),title('Original'),subplot(2,2,2),imshow(resultadoU5),title('Filtrado U 0.05');
subplot(2,2,3),imshow(resultadoU15),title('Filtrado U 0.15'),subplot(2,2,4),imshow(resultadoU25),title('Filtrado U 0.25');
%Se consigue una mejora clara al emplear este realzamiento de detalles



imshow(Ir2);
%Para esta imagen que presenta un ruido de tipo 'sal y pimienta', parece
%una buena idea utilizar un filtrado de Medianas

Ir2_M3 = medfilt2(Ir2,[3 3]);
Ir2_M5 = medfilt2(Ir2,[5 5]);
Ir2_M7 = medfilt2(Ir2,[7 7]);

subplot(2,2,1),imshow(Ir2),title('Original'),subplot(2,2,2),imshow(Ir2_M3),title('Medianas 3x3');
subplot(2,2,3),imshow(Ir2_M5),title('Medianas 5x5'),subplot(2,2,4),imshow(Ir2_M7),title('Medianas 7x7');
%Así, con este filtrado, se ha conseguido eliminar el ruido de la imagen
