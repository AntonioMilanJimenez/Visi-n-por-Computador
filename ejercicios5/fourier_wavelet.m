%Parte 1 Fourier --> Ejercicio 1
%Mostrar las componentes frecuenciales que entran en un disco de centro u,v y radio r. 
%Visualizar diferentes discos cambiando el centro y radio.

%Se crea una imagen vacia
tamX = 256;
tamY = 256;
[columnsInImage rowsInImage] = meshgrid(1:tamX, 1:tamY);
%Sobre la imagen se crea un disco de centro (128,128) y radio 100
centerX = 128;
centerY = 128;
radius = 100;
circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2 <= radius.^2;

Id=im2double(circlePixels); %% pasamos a double la imagen
ft=fft2(Id); %obtenemos la transformada de fourier
ft_shift =fftshift(ft); %desplazado el 00 al centro u+N/2, v+M/2

flog=(log(1+abs(ft_shift)));
freal1 = real(ft_shift);
fimg1 = imag(ft_shift);
logmod1 = log(1+abs(ft_shift));
fase1 = (angle(ft_shift));


centerX = 180;
centerY = 80;
radius = 90;
circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2 <= radius.^2;

Id=im2double(circlePixels); %% pasamos a double la imagen
ft=fft2(Id); %obtenemos la transformada de fourier
ft_shift =fftshift(ft); %desplazado el 00 al centro u+N/2, v+M/2

flog=(log(1+abs(ft_shift)));
freal2 = real(ft_shift);
fimg2 = imag(ft_shift);
logmod2 = log(1+abs(ft_shift));
fase2 = (angle(ft_shift));


centerX = 200;
centerY = 40;
radius = 120;
circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2 <= radius.^2;

Id=im2double(circlePixels); %% pasamos a double la imagen
ft=fft2(Id); %obtenemos la transformada de fourier
ft_shift =fftshift(ft); %desplazado el 00 al centro u+N/2, v+M/2

flog=(log(1+abs(ft_shift)));
freal3 = real(ft_shift);
fimg3 = imag(ft_shift);
logmod3 = log(1+abs(ft_shift));
fase3 = (angle(ft_shift));


centerX = 20;
centerY = 170;
radius = 50;
circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2 <= radius.^2;

Id=im2double(circlePixels); %% pasamos a double la imagen
ft=fft2(Id); %obtenemos la transformada de fourier
ft_shift =fftshift(ft); %desplazado el 00 al centro u+N/2, v+M/2

flog=(log(1+abs(ft_shift)));
freal4 = real(ft_shift);
fimg4 = imag(ft_shift);
logmod4 = log(1+abs(ft_shift));
fase4 = (angle(ft_shift));

figure, subplot(4,4,1),imshow(freal1,[]), title ('Real (128,128,100)'),subplot(4,4,2),imshow(fimg1,[]),title('Imaginaria (128,128,100)'),subplot(4,4,3), imshow(logmod1,[]),title('Log Modulo (128,128,100)');
subplot(4,4,4), imshow(fase1), title('Fase (128,128,100)');
subplot(4,4,5),imshow(freal2,[]), title ('Real (180,80,90)'),subplot(4,4,6),imshow(fimg2,[]),title('Imaginaria (180,80,90)'),subplot(4,4,7), imshow(logmod2,[]),title('Log Modulo (180,80,90)');
subplot(4,4,8), imshow(fase2), title('Fase (180,80,90)');
subplot(4,4,9),imshow(freal3,[]), title ('Real (200,40,120)'),subplot(4,4,10),imshow(fimg3,[]),title('Imaginaria (200,40,120)'),subplot(4,4,11), imshow(logmod3,[]),title('Log Modulo (200,40,120)');
subplot(4,4,12), imshow(fase3), title('Fase (200,40,120)');
subplot(4,4,13),imshow(freal4,[]), title ('Real (20,170,50)'),subplot(4,4,14),imshow(fimg4,[]),title('Imaginaria (20,170,50)'),subplot(4,4,15), imshow(logmod4,[]),title('Log Modulo (20,170,50)');
subplot(4,4,16), imshow(fase4), title('Fase (20,170,50)');


%-----------------------------------------------------------------------------------------------------
%Parte 1 Fourier --> Ejercicio 2
%Eliminación de ruido. Sobre la imagen cameraman insertar ruido gaussiano y mirar qué componentes 
%frecuenciales habría que eliminar para reducir el mayor ruido posible.
I = imread('cameraman.tif');
Inoise = imnoise(I,'gaussian');

figure,subplot(1,2,1),imshow(I),title('Original'),subplot(1,2,2),imshow(Inoise),title('Ruido Gaussiano');


Id=im2double(Inoise); %% pasamos a double la imagen
ft=fft2(Id); %obtenemos la transformada de fourier
ft_shift =fftshift(ft); %desplazado el 00 al centro u+N/2, v+M/2

fase = angle(ft_shift);
flog=(log(1+abs(ft_shift)));
freal = real(ft_shift);
fimg = imag(ft_shift);

figure, subplot(2,2,1),imshow(freal,[]), title ('Real'),subplot(2,2,2),imshow(fimg,[]),title('Imaginaria'),...
    subplot(2,2,3), imshow(flog,[]),title('Log Modulo'),...
    subplot(2,2,4), imshow(fase), title('Fase')


%Al haber incluido ruido en la imagen, ahora se presentan en ésta
%variaciones ŕapidas en los niveles de gris, representadas por las
%frecuencias altas.

%Para poder entonces eliminar el ruido es necesario eliminar o atenuar
%estas frecuencias altas, para lo cual se tiene que realizar un filtrado de
%paso bajo:

%Se construye la matriz de distancias
mi=size(I,1)/2;
mj=size(I,2)/2;
x=1:size(I,2);
y=1:size(I,1);
[Y, X]=meshgrid(y-mi,x-mj);
dist = hypot(X,Y);


%Se crea el filtro de paso bajo
%Se escoge un radio intermedio para eliminar ruido sin que se pierda
%demasiado detalle
radius = 70;
H=zeros(size(I,1),size(I,2));

ind=ind2sub(size(H), find(dist<=radius));
H(ind)=1;
Hd=fftshift(double(H));

%CONVOLUCION CON EL FILTRO IDEAL EN EL DOMINIO DE FOURIER
DFT_filt=Hd.*ft;
Ifiltrada=real(ifft2(DFT_filt));

figure,subplot(2,2,1),imshow(I),title('Original'),subplot(2,2,2),imshow(Inoise),title('Ruido Gaussiano');
subplot(2,2,3),imshow(log(1+abs(fftshift(DFT_filt))),[]),title('Filtro Paso Bajo'),subplot(2,2,4),imshow(Ifiltrada),title('Imagen filtrada');

%Así, se consigue atenuar el ruido introducido sin que se pierda demasiado
%detalle en la imagen. Si se quisiese disminuir más el ruido, se escogería
%un filtro con un radio más pequeño aunque implicaría una pérdida mayor de
%los detalles de la imagen. De igual forma, si se quisiese más detalle, se
%incrementaria el radio del filtro aunque como consecuencia no se
%eliminaría tanto ruido.






%Parte 2 Wavelet
%Realizar sobre la imagen barbara una descomposición wavelet usando bior3.7 con tres niveles. 
%Fijado un porcentaje , por ejemplo 10 %, que  indican el porcentaje de coeficientes que nos 
%quedamos de entre todos los coeficientes wavelets de la descomposición. Estos coeficientes son 
%los que tiene mayor magnitud.  Variar el porcentaje y obtener una gráfica en la que en el eje X 
%tenemos razón de compresión y en el eje Y el valor de PSNR.

I = imread('barbara.png');
figure,imshow(I,[]),title('Original');


%Porcentaje de coeficientes a seleccionar por su magnitud
porcentaje = 10;

%Descomposición a 3 niveles
[C,S] = wavedec2(I,3,'bior3.7');

%Dado que se va a trabajar con magnitudes, se obtienen los valores
%absolutos. Se escoge como umbral el valor correspondiente al porcentaje escogido
aux = sort(abs(C),'descend');
[size1 size2] = size(aux);


C10 = C;
porcentaje = 100/porcentaje;
tam = fix(size2/porcentaje);
umbral = aux(tam);

%Si no superan el umbral se establecen a 0
C10(C10<umbral) = 0;

%Reconstruccion
I10 = waverec2(C10,S,'bior3.7');



porcentaje = 5;
C5 = C;
porcentaje = 100/porcentaje;
tam = fix(size2/porcentaje);
umbral = aux(tam);
C5(C5<umbral) = 0;
%Reconstruccion
I5 = waverec2(C5,S,'bior3.7');



porcentaje = 20;
C20 = C;
porcentaje = 100/porcentaje;
tam = fix(size2/porcentaje);
umbral = aux(tam);
C20(C20<umbral) = 0;
%Reconstruccion
I20 = waverec2(C20,S,'bior3.7');



porcentaje = 50;
C50 = C;
porcentaje = 100/porcentaje;
tam = fix(size2/porcentaje);
umbral = aux(tam);
C50(C50<umbral) = 0;
%Reconstruccion
I50 = waverec2(C50,S,'bior3.7');



porcentaje = 80;
C80 = C;
porcentaje = 100/porcentaje;
tam = fix(size2/porcentaje);
umbral = aux(tam);
C80(C80<umbral) = 0;
%Reconstruccion
I80 = waverec2(C80,S,'bior3.7');




porcentaje = 99;
C99 = C;
porcentaje = 100/porcentaje;
tam = fix(size2/porcentaje);
umbral = aux(tam);
C99(C99<umbral) = 0;
%Reconstruccion
I99 = waverec2(C99,S,'bior3.7');




figure,subplot(2,3,1),imshow(I5,[]),title('Reconstruccion 5%'),subplot(2,3,2),imshow(I10,[]),title('Reconstruccion 10%');
subplot(2,3,3),imshow(I20,[]),title('Reconstruccion 20%'),subplot(2,3,4),imshow(I50,[]),title('Reconstruccion 50%');
subplot(2,3,5),imshow(I80,[]),title('Reconstruccion 80%'),subplot(2,3,6),imshow(I99,[]),title('Reconstruccion 99%');

%Se observa que ya tan solo con un porcentaje bajo de comprensión ya se consigue
%reconstruir notablemente bien la imagen a excepción de los pequeños detalles.
%Así, se demuestra que escogiendo sólo la información más relevante, es
%suficiente para recuperar bastante bien una imagen.



%Calculo de PSNR
[psnr5, mse5, maxerr5, l2rat5] = measerr(I,I5);
[psnr10, mse10, maxerr10, l2rat10] = measerr(I,I10);
[psnr20, mse20, maxerr20, l2rat20] = measerr(I,I20);
[psnr50, mse50, maxerr50, l2rat50] = measerr(I,I50);
[psnr80, mse80, maxerr80, l2rat80] = measerr(I,I80);
[psnr99, mse99, maxerr99, l2rat99] = measerr(I,I99);


aX = [5 10 20 50 80 99];
aY = [psnr5 psnr10 psnr20 psnr50 psnr80 psnr99];
figure,plot(aX,aY),title('Porcentaje vs PSNR');
%Observamos que conforme aumenta el ratio de comprensión, aumenta
%también PSNR (Peak Signal-to-Noise Ratio). Sin embargo, ya con una
%comprensión del 20% se obtiene un resultado muy similar al 99% por lo que
%se consigue una buena comprensión al tener que usar mucha menos
%información.

aY = [mse5 mse10 mse20 mse50 mse80 mse99];
figure,plot(aX,aY),title('Porcentaje vs MSE');
%Respecto al MSE (Mean-squared error), observamos que al aumentar el ratio
%de comprension, disminuye cada vez menos el error por lo comentado
%anteriormente.