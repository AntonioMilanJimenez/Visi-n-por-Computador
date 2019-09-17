%Coge una imagen en color y utiliza imadjust o histeq para mejorar el contraste
I = imread('danza.ppm');
imhsv = rgb2hsv(I);

%Obtenemos las bandas rgb
rojo = I(:,:,1);
verde = I(:,:,2);
azul = I(:,:,3);

%Obtenemos las bandas hsv
h = imhsv(:,:,1);
s = imhsv(:,:,2);
v = imhsv(:,:,3);

%Ecualizamos cada banda por separado
rojoeq = histeq(rojo);
azuleq = histeq(azul);
verdeeq = histeq(verde);

imageeq = cat(3,rojoeq,verdeeq,azuleq);

subplot(1,5,1),subimage(I),title('Original'),subplot(1,5,2),subimage(rojoeq),title('Rojo EQ');
subplot(1,5,3),subimage(verdeeq),title('Verde EQ'),subplot(1,5,4),subimage(azuleq),title('Azul EQ');
subplot(1,5,5),subimage(imageeq),title('Image EQ');
%Directamente, encontramos el problema de aplicar la ecualizacion sobre las
%bandas RGB. Al intentar distribuir los histogramas, se estan alterando los
%colores de la imagen.


%Para solventar esto y poder hacer un buen ecualizado sobre una imagen en
%color, se debe trabajar sobre el formato HSV, pudiendo ecualizar las otras
%bandas si alterar la banda H respectiva al color.

seq = histeq(s);
veq = histeq(v);

imageeq = cat(3,h,seq,veq);
imageeq = hsv2rgb(imageeq);

subplot(1,2,1),subimage(I),title('Original'), subplot(1,2,2),subimage(imageeq),title('Image EQ');
%Se muestra que se ha conseguido ecualizar la imagen si alterar el color.



