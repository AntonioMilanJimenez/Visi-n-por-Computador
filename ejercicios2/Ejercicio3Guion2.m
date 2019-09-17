%Implementa alguna modificación sobre la componente H de la imagen. Por ejemplo, suma un valor 
%constante a dicho componente y visualiza la imagen resultante. 
imMarilyn = imread('Warhol_Marilyn_1967_OnBlueGround.jpg');
imhsv = rgb2hsv(imMarilyn);
im1= imhsv(:,:,1);
im2= imhsv(:,:,2);
im3= imhsv(:,:,3);

%%Sobre la componente H se suma una constante
im1 = im1 + 0.1;
imMasColor = cat(3,im1,im2,im3);
%%Se devuelve a su formato rgb
imMasColor = hsv2rgb(imMasColor);


figure, subplot(1,2,1), imtool(imMarilyn),title 'Original',subplot(1,2,2),imtool(imMasColor), title('Mas color')
%%Al aumentar el tono, el color de la imagen "se mueve" de angulo (0.1 --> 36º) en el
%%"cono" del modelo HSV. Así, el azul celeste se mueve hacia un azul oscuro
%%mientras que el naranja se mueve hacia el amarillo. 