%%Ejercicio 1
%Probar los distintos visualizadores de que disponemos en Matlab (imshow, imtool, imagesc).
%%
%%Cargamos la imagen disney.png
ImagenDisney = imread('disney.png')

%%Conocemos algunas caracteristicas de la imagen
whos ImagenDisney


%%
%%------------------------------- Parte 1 -------------------------------------------------
%%Visualizacion con imshow
imshow(ImagenDisney)

%%
%%%Visualizacion con imtool
imtool(ImagenDisney)

%%
%%%Visualizacion con imagesc, observando que no se utilizan las dimensiones
%%%originales de la imagen
imagesc(ImagenDisney)

%%%Se establece la paleta de colores de grises para poder visualizarla con los
%%%colores correctos
colormap('gray'), imagesc(ImagenDisney)



%%
%%------------------------------- Parte 2 -------------------------------------------------
%%A continuación se convierte a double la imagen con 'double'
disneyDouble = double(ImagenDisney)
whos disneyDouble
%%Su rango sigue siendo el mismo [0,255] pero ahora cada dato ocupa un
%%'double', ocupando más Bytes la imagen

%%
%%%Visualizacion con imshow (es necesario indicarle '[]' pues de lo contrario trabajará en el rango [0,1])
imshow(disneyDouble,[])

%%
%%%Visualizacion con imtool
imtool(disneyDouble,[])

%%
%%%Visualizacion con imagesc(disneyDouble)
imagesc(disneyDouble)

%%%Se establece la paleta de grises
colormap('gray'),imagesc(disneyDouble)



%%
%%------------------------------- Parte 3 -------------------------------------------------
%%Ahora se realiza la conversion a double con im2double:
disneyImDouble = im2double(ImagenDisney)
whos disneyImDouble
%%Ahora sí se ha realizado la conversión al rango [0,1] para cada uno de
%%los datos

%%
%%%Visualizando con imshow
imshow(disneyImDouble)
%%%Ya no es necesario indicar '[]'

%%
%%%Visualizando con imtool
imtool(disneyImDouble)

%%
%%%Visualizando con imagesc
imagesc(disneyImDouble)
colormap('gray'),imagesc(disneyImDouble)

%%Por lo tanto, es importante tener en cuenta qué conversión se está
%%realizando pues, aunque se cambie el tipo de dato, no quiere decir que
%%haya una conversión implicita en los valores de los datos
