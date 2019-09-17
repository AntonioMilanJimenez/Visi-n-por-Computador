%%Ejercicio 2
%Descomponer una imagen RGB en sus tres componentes de color (rosa.jpg).
%%%Cargamos la imagen rosa.jpg
ImagenRosa = imread('rosa.jpg')
whos ImagenRosa
%%%Dada sus dimensiones, obteniendo 3 matrices diferentes sabemos que se
%%%trata de una imagen a color

%%
%%------------------------------- Parte 1 ------------------------------------------------------
%%%Obtenemos por separado esas 3 matrices que se corresponden a las 3
%%%componentes de color
imRed = ImagenRosa(:,:,1);
imGreen = ImagenRosa(:,:,2);
imBlue = ImagenRosa(:,:,3)

%%%Visualizamos las 3 componentes junto con la imagen original
figure, subplot(1,4,1),imshow(ImagenRosa),title('color'),subplot(1,4,2),imshow(imRed),title ('Roja'), ...
    subplot(1,4,3),imshow(imGreen),title ('Verde'),subplot(1,4,4),imshow(imBlue),title ('Azul')


%%Observamos que en la imágenes de las bandas de colores, aparecen tonos de
%%grises más cercanos al blanco correspondiendose a aquellas regiones de la
%%imagen original con más componente de rojo (igualmente sucede con las
%%bandas de Verde y Azul).

%%Esto se debe a que en esas regiones los valores eran más altos para esa
%%banda, cercanos a 255, y al llevarlos por separado a un tono de grises,
%%éstos se van hacia el blanco.

%%Tambien podemos observar que colores que son una mezcla 'equitativa' de
%%dos bandas, como el amarillo (Rojo y Verde), aparecen en tonos blancos
%%tanto para la banda roja como para la verde.


%%
%%------------------------------- Parte 2 --------------------------------------------------------
%%A continuación vamos a anular la banda roja
%%Para ello, bastará con sustituir su actual banda roja por una del mismo
%%tamaño con todos los valores a 0, haciendo que se pierda totalmente la
%%componente roja

%%%Creamos la matriz de ceros
tamY = size(imRed,1)
tamX = size(imRed,2)
rojoAnulado = zeros(tamY,tamX)

%%%Reconstruimos la matriz con esta nueva banda
sinRojo = cat(3,rojoAnulado,imGreen,imBlue)

%%%Visualizamos la imagen original y la nueva imagen sin rojo
figure, subplot(1,2,1), imtool(ImagenRosa),title 'original',subplot(1,2,2),imtool(sinRojo), title('Sin Rojo')

%%Al haber eliminado el rojo encontramos dos diferencias principales. 

%%La primera es que aquellas partes de la flor que eran totalmente rojos se
%%han convertido ahora en negro al no tener ya ningún color para esa parte.

%%La segunda diferencia es que todas esas partes de la flor cuyo color era
%%alguna mezcla con el rojo, se han convertido totalmente en la otra banda
%%con la que se mezclaban. Por ejemplo, el morado (Azul y Rojo), ahora
%%tiene un tono totalmente azul o el amarillo que anteriormente se
%%comentaba es ahora únicamente un tono de verde.



%%
%%------------------------------- Parte 3 -----------------------------------------------------------
%%Por último se realizarán otro tipo de modificaciones sobre las bandas de
%%color para la imagen sintetica.jpg

%%%Cargamos la imagen
sintetica = imread('sintetica.jpg')
whos sintetica
imshow(sintetica)

%%
%%%Se convierte la banda roja a su nivel maximo
imRed = sintetica(:,:,1);
imGreen = sintetica(:,:,2);
imBlue = sintetica(:,:,3)

%%%Se crea una matriz del mismo tamaño con todos los valores en 255
tamY = size(imRed,1)
tamX = size(imRed,2)
rojoMaximo = ones(tamY,tamX)*255

imRojoMaximo = cat(3,rojoMaximo,imGreen,imBlue)


%%%Se intercambian las bandas verde y azul
imIntercambiadas = cat(3,imRed,imBlue,imGreen)

%%%En la banda azul se realiza un desplazamiento de 50 pixeles en ambas
%%%dimensiones
azulDesplazado = circshift(imBlue,[50 50])
imAzulDesplazado = cat(3,imRed,imGreen,azulDesplazado)

%%%Se invierte la banda verde de izquierda a derecha
verdeInvertido = fliplr(imGreen)
imVerdeInvertido = cat(3,imRed,verdeInvertido, imBlue)


%%%Se visualizan ya todas las imagenes
figure, subplot(1,5,1),imshow(sintetica),title('Original'),subplot(1,5,2),imshow(imRojoMaximo),title ('Rojo Maximo'), ...
    subplot(1,5,3),imshow(imIntercambiadas),title ('Verde-Azul Intercambiadas'),subplot(1,5,4),imshow(imAzulDesplazado),title ('Azul desplazado (50)'),subplot(1,5,5),imshow(imVerdeInvertido),title('Verde invertido LR')
