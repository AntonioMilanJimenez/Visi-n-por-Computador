%Función encargada del cálculo de HOG
function hog = calcularHOG(I)

%Construcción de las máscaras
mascaraV = [-1 0 1];
mascaraH = [-1;0;1];

%Se aplican las máscaras
gx = imfilter(I, mascaraV);
gy = imfilter(I, mascaraH);

%Se calculan las matrices de magnitudes y orientaciones para cada pixel de
%la imagen
magnitud = sqrt(double(power(gx,2)+power(gy,2)));
orientacion = rad2deg(atand(double(gy)./double(gx))) + 90;


[sizeF sizeC] = size(I);

filas = fix(sizeF/8);
columnas = fix(sizeC/8);

celulas = zeros(filas,columnas,9);

for i=1:filas
    for j=1:columnas
        %Se toman los píxeles correspondientes a la celula
        pixeles = I((i*8-7):i*8,(j*8-7):j*8);
        %Se calcula el histograma correspondiente
        histograma = calcularHistograma(pixeles,i,j,magnitud,orientacion);
        celulas(i,j,:) = histograma;
    end
end


filasBloque = filas-1;
columnasBloque = columnas-1;

bloques = zeros(filasBloque,columnasBloque,36);

for i=1:filasBloque
    for j=1:columnasBloque
        %Se toman los histogramas de las celulas que componen el bloque
        hist1 = celulas(i,j,:);
        hist2 = celulas(i,j+1,:);
        hist3 = celulas(i+1,j,:);
        hist4 = celulas(i+1,j+1,:);
        
        hist1 = transpose(hist1(:));
        hist2 = transpose(hist2(:));
        hist3 = transpose(hist3(:));
        hist4 = transpose(hist4(:));
        
        %Se concatenan los histogramas
        bloqueHistograma = hist1;
        bloqueHistograma = cat(2,bloqueHistograma,hist2);
        bloqueHistograma = cat(2,bloqueHistograma,hist3);
        bloqueHistograma = cat(2,bloqueHistograma,hist4);
        
        %Se normaliza el bloque
        bloqueHistograma = bloqueHistograma/sqrt(power(norm(bloqueHistograma),2)+0.01);
        
        bloques(i,j,:) = bloqueHistograma;
        
    end
end


hog = [];

%Se concatenan los arrays de los bloques
for i=1:filasBloque
    for j=1:columnasBloque
        bloque = bloques(i,j,:);
        bloque = transpose(bloque(:));
        hog = cat(2,hog,bloque);
    end
end

%Se normaliza el HOG
hog = hog/sqrt(power(norm(hog),2)+0.01);

%Se evita que valores superiores tomen demasiada relevancia
hog(hog>0.2) = 0.2;

end

    
    