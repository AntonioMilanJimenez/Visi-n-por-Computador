%Explica como se ha ocultado la imagen de las vacas en el castillo y como se ha recuperado.
castillo1 = imread('castillo.pgm');
castillo2 = imread('Castillo_oculto2bits.pgm');

diferencia = castillo1 - castillo2;

figure,imshow(diferencia*80);
%Mostrando la diferencia entre las dos imagenes del castillo se puede
%apreciar que hay algo oculto.

%Una idea simple de cómo está oculta la imagen de las vacas en la segunda
%imagen es simplemente si el valor del pixel es par o impar. Con esta idea,
%se considera 1 si el pixel es impar, 0 si es par y viceversa.

castilloImpares = mod(castillo2,2);
castilloPares = 1 - castilloImpares;

subplot(1,2,1),imshow(castilloPares*255),title('Pixeles pares'),subplot(1,2,2),imshow(castilloImpares*255),title('Pixeles impares');

%Efectivamente, se aprecian ya las figuras de las vacas. Sin embargo, dado
%que la imagen que se espera conseguir está en el rango [0 128 255], al
%tener 3 posibles valores, realizar módulo 2 no es suficiente pues sólo se
%pueden conseguir 2 opciones de valores (0 o 1).

%Probamos entonces ahora con módulo 4 para tener así 4 posibles salidas
%(0 1 2 3).


castilloMod4 = mod(castillo2,4);
max(max(castilloMod4))
imagenMod4 = castilloMod4*128;
%El máximo de esta imagen es 2, por lo que multiplicando por 128 se
%conseguirá que la imagen se muestre en el rango [0 128 255]
figure,imshow(imagenMod4),title('Modulo 4');
%Ahora sí se ha conseguido la imagen objetivo.

%Para conseguir la imagen del rango [0 255] bastará con que los valores de
%128 se convierta a 0 también.
castilloMod4 = castilloMod4/2;
%Con "fix" se obtiene solo la parte entera
castilloMod4 = fix(castilloMod4);
castilloMod4 = castilloMod4*255;

%Visualizamos ya las imagenes conseguidas junto con las imagenes objetivo

vacas1 = imread('vacas.pgm');
vacas2 = imread('recuperada_castillo.pgm');

subplot(2,2,1),imshow(vacas2),title('Objetivo [0 255]'),subplot(2,2,2),imshow(castilloMod4),title('Modulo 4 [0 255]');
subplot(2,2,3),imshow(vacas1),title('Objetivo [0 128 255]'),subplot(2,2,4),imshow(imagenMod4),title('Modulo 4 [0 128 255]');


%Por lo tanto, es una forma interesante de ocultar una imagen en otra al
%trabajar únicamente con módulo 4, de forma que sólo se alteren los 2 bits
%menos significativos y no se apreciable el cambio a simple vista.

%Sobre cómo se puede ocultar la imagen:

%Primero se obtiene la matriz de módulo 4 de la imagen que ocultará a la
%otra imagen
originalMod4 = mod(castillo1,4);
%Se resta la matriz obtenida a la imagen original para conseguir que todos
%los valores sean múltiplos de 4
originalMod4 = castillo1-originalMod4;

%Sobre esta matriz, se puede sumar ya directamente la imagen de la vaca en
%el rango [0 1 2]. De forma que cuando sobre la imagen modificada resultante del
%castillo se vuelva a realiza módulo 4, se obtenga nuevamente la imagen de
%las vacas. Como mucho se modifica en 3 valores cada pixel, algo
%inapreciable a simple vista.
vacas = mod(castillo2,4);
castilloModificada = originalMod4 + vacas;
castilloMod4 = mod(castilloModificada,4);

%Se visualiza la imagen del castillo en la que se acaban de ocultar las
%vacas junto con la imagen de las vacas que se puede extraer de ella.
subplot(1,2,1),imshow(castilloModificada),title('Castillo Modificado'),subplot(1,2,2),imshow(castilloMod4*128),title('Vacas ocultas');


