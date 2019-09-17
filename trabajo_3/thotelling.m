%En este ejercicio se pide al alumno que desarrolle el fichero thotelling.m para aplicar la 
%transformada a un conjunto de imágenes satélite de la ciudad de Adra. Establecer el error 
%cometido cuando se usa:

    %Solamente la primera imagen correspondiente al primer autovalor
    %Solamente las dos primeras imágenes correspondientes al primer y segundo autovalor
    %...
    %Todos las imágenes.

%Mostrar una gráfica que muestre el error cometido cuando se usan las diferentes imágenes obtenidas.

img1 = imread('banda1.tif');
img2 = imread('banda2.tif');
img3 = imread('banda3.tif');
img4 = imread('banda4.tif');
img5 = imread('banda5.tif');
img6 = imread('banda6.tif');

soloColumna1 = transpose(reshape(img1,1,[]));
soloColumna2 = transpose(reshape(img2,1,[]));
soloColumna3 = transpose(reshape(img3,1,[]));
soloColumna4 = transpose(reshape(img4,1,[]));
soloColumna5 = transpose(reshape(img5,1,[]));
soloColumna6 = transpose(reshape(img6,1,[]));

matrizConjunta = [soloColumna1,soloColumna2,soloColumna3,soloColumna4,soloColumna5,soloColumna6];

%Se calcula la matriz de covarianza
matrizCovarianza = cov(double(matrizConjunta));

%Se calculan los autovectores y los autovalores
[A,D] = eig(matrizCovarianza);

A = transpose(fliplr(A));
D = fliplr(transpose(fliplr(D)));

[sizey sizex] = size(matrizConjunta);

%Se calcula el nuevo primer pixel a partir de la media del pixel y la
%matriz A
pixel = double(matrizConjunta(1,:));
pixel = pixel - mean(pixel);
pixel = transpose(A*transpose(pixel));

y = pixel;

%Se repite el proceso para el resto de pixeles
for i = 2:sizey
   pixel = double(matrizConjunta(i,:));
   pixel = pixel - mean(pixel);
   pixel = transpose(A*transpose(pixel));
   y = cat(2,y,pixel); 
end

%Se formatea la matriz para poder obtener ya las nuevas imagenes
y = reshape(y',sizex,[]);
y = transpose(y);

y1 = y(:,1);
[sizey sizex] = size(img1);
y1 = reshape(y1,[sizey sizex]);

y2 = y(:,2);
[sizey sizex] = size(img2);
y2 = reshape(y2,[sizey sizex]);

y3 = y(:,3);
[sizey sizex] = size(img3);
y3 = reshape(y3,[sizey sizex]);

y4 = y(:,4);
[sizey sizex] = size(img4);
y4 = reshape(y4,[sizey sizex]);

y5 = y(:,5);
[sizey sizex] = size(img5);
y5 = reshape(y5,[sizey sizex]);

y6 = y(:,6);
[sizey sizex] = size(img6);
y6 = reshape(y6,[sizey sizex]);


subplot(2,3,1),imshow(y1,[]),title('Y1'),subplot(2,3,2),imshow(y2,[]),title('Y2');
subplot(2,3,3),imshow(y3,[]),title('Y3'),subplot(2,3,4),imshow(y4,[]),title('Y4');
subplot(2,3,5),imshow(y5,[]),title('Y5'),subplot(2,3,6),imshow(y6,[]),title('Y6');


%Calculo del error
diagonal = diag(D);
sumaD = sum(diagonal);

%Se calculan los diferentes errores en funcion de las imágenes que se
%incluyen
error = sumaD - diagonal(1);

for i = 2:6
   e = sumaD - sum(diagonal(1:i));
   error = cat(2,error,e);
end

imagenes = [1 2 3 4 5 6];
figure,plot(imagenes,error),title('Error cometido para los diferentes grupos de imagenes Y');
%Se observa el decrecimiento del error al ir considerando más imágenes
%hasta llegar a un error de 0. 

%Es interesante cómo el decrecimiento es cada vez más lento al ir incluyendo 
%más imágenes (error inicial de 3960). Esto se debe a que son las primeras imágenes
%las que más "energía" tienen por lo que no hay grandes diferencias al incluir o no 
%las últimas imágenes ya que son las menos relevantes.