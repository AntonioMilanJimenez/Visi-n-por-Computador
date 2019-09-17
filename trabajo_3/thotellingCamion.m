img1 = imread('a.jpg');
img2 = imread('b.jpg');
img3 = imread('c.jpg');
img4 = imread('d.jpg');
img5 = imread('e.jpg');

img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
img3 = rgb2gray(img3);
img4 = rgb2gray(img4);
img5 = rgb2gray(img5);

soloColumna1 = transpose(reshape(img1,1,[]));
soloColumna2 = transpose(reshape(img2,1,[]));
soloColumna3 = transpose(reshape(img3,1,[]));
soloColumna4 = transpose(reshape(img4,1,[]));
soloColumna5 = transpose(reshape(img5,1,[]));

matrizConjunta = [soloColumna1,soloColumna2,soloColumna3,soloColumna4,soloColumna5];

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


subplot(2,3,1),imshow(y1,[]),title('Y1'),subplot(2,3,2),imshow(y2,[]),title('Y2');
subplot(2,3,3),imshow(y3,[]),title('Y3'),subplot(2,3,4),imshow(y4,[]),title('Y4');
subplot(2,3,5),imshow(y5,[]),title('Y5');

