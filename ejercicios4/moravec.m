%% EJERCICIO: Programar el detector de esquinas de Moravec

%I = checkerboard(100,4,4);
I = imread('formas.png');

%Se crean las mascaras h, v, diag1 y diag2
mascaraH = [1 -1];
mascaraV = [-1; 1];
mascaraDiag1 = [0 1;-1 0];
mascaraDiag2 = [1 0;0 -1];

%Se aplican las mascaras creadas sobre la imagen
h = imfilter(double(I), mascaraH);
v = imfilter(double(I), mascaraV);
diag1 = imfilter(double(I), mascaraDiag1);
diag2 = imfilter(double(I), mascaraDiag2);

%Se aplica la mascara 3x3
mascara = fspecial('average',3)*9;
hh = imfilter(abs(h), mascara);
vv = imfilter(abs(v), mascara);
d1 = imfilter(abs(diag1), mascara);
d2 = imfilter(abs(diag2), mascara);

[sizeY sizeX] = size(hh);

c=zeros(sizeY,sizeX);

%Se toma el mínimo valor de las 4 matrices
for i=1:sizeY
    for j=1:sizeX
        c(i,j) = min([hh(i,j) vv(i,j) d1(i,j) d2(i,j)]);
    end
end


%Se eliminan aquellos puntos que no sean maximos en su entorno
for i = 2:(sizeY-1)
    for j = 2:(sizeX-1)
        aux = c((i-1:i+1),(j-1:j+1));
        aux = max(max(aux));
        if(aux ~= c(i,j))
            c(i,j) = 0;
        end
    end
end

%Así, en la imagen c quedarian representadas las esquinas detectadas
figure,imshow(c),title('Esquinas (Moravec)');
