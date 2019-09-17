%Compara el resultado que producen el filtrado gaussiano y el filtro de mediana sobre las imágenes 
%disney_r1.png ... disney_r5.png.
Id1 = imread('disney_r1.png');
Id2 = imread('disney_r2.png');
Id3 = imread('disney_r3.png');
Id4 = imread('disney_r4.png');
Id5 = imread('disney_r5.png');

%Aplicamos un filtrado Gaussiano
gauss = fspecial('gaussian',[5 5]);
Id1_G = imfilter(Id1,gauss);
Id2_G = imfilter(Id2,gauss);
Id3_G = imfilter(Id3,gauss);
Id4_G = imfilter(Id4,gauss);
Id5_G = imfilter(Id5,gauss);

%Aplicamos un filtro de medianas
Id1_M = medfilt2(Id1,[5 5]);
Id2_M = medfilt2(Id2,[5 5]);
Id3_M = medfilt2(Id3,[5 5]);
Id4_M = medfilt2(Id4,[5 5]);
Id5_M = medfilt2(Id5,[5 5]);


subplot(3,5,1),imshow(Id1),title('Original 1'),subplot(3,5,2),imshow(Id2),title('Original 2');
subplot(3,5,3),imshow(Id3),title('Original 3'),subplot(3,5,4),imshow(Id4),title('Original 4');
subplot(3,5,5),imshow(Id5),title('Original 5'),subplot(3,5,6),imshow(Id1_G),title('Gaussian 1');
subplot(3,5,7),imshow(Id2_G),title('Gaussian 2'),subplot(3,5,8),imshow(Id3_G),title('Gaussian 3')
subplot(3,5,9),imshow(Id4_G),title('Gaussian 4'),subplot(3,5,10),imshow(Id5_G),title('Gaussian 5');
subplot(3,5,11),imshow(Id1_M),title('Median 1'),subplot(3,5,12),imshow(Id2_M),title('Median 2');
subplot(3,5,13),imshow(Id3_M),title('Median 3'),subplot(3,5,14),imshow(Id4_M),title('Median 4');
subplot(3,5,15),imshow(Id5_M),title('Median 5');

%Para el ruido 'sal y pimienta' que presentan las imágenes originales, se
%muestra que el filtrado de Medianas funciona mucho mejor para eliminarlo
%que el filtrado de Gaussiano. Para los 3 primeras imágenes se consiguen
%resultados muy buenos, y para las 2 ultimas, si bien se elimina el ruido,
%es cierto que se 'emborronan' más las imágenes.