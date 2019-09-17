
videoFile = 'data/dedo_hr.mp4';

%Se obtiene la se�al utilizando �nicamente la banda roja
[yRojo, vRojo] = acquire(videoFile);

process(yRojo,30);

%As�, se observa un 'Hearth Rate' entre 50 y 60, un pulso dentro de lo
%normal para una persona.

%A continuaci�n se obtiene la se�al pero utlizando las 3 bandas RGB,
%trabajando con las componentes principales de las 3 bandas y sus medias.
[yRGB, vRGB] = acquireRGB(videoFile);

process(yRGB,30);
%Se observa nuevamente que la se�al se encuentra siempre entre 50 y 60.

%Calculando el mse entre las dos se�ales
error=immse(yRojo,yRGB)
%Se obtiene un error de 9182.9


