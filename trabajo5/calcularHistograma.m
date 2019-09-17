%Funcion encargada del cálculo de l histograma de una celula
function histograma = calcularHistograma(pixeles,fila,columna,magnitudes,orientaciones)

%Limites de los bins o contenedores
bins = [10 30 50 70 90 110 130 150 170];

histograma = zeros(1,9);

for i=1:8
    for j=1:8
        %Se toma el pixel
        pixel = pixeles(i,j);
        %Se estima su posición real en la imagen
        ipixel = i+(fila-1)*8;
        jpixel = j+(columna-1)*8;
        %Se obtiene su orientacion y magnitud
        orientacion = orientaciones(ipixel,jpixel);
        magnitud = magnitudes(ipixel,jpixel);
        
        binAnterior = 0;
        bin = 0;
        
        %Se calculan los dos contenedores a los que perteneceria
        if(orientacion > 170 || orientacion<=10)
            binAnterior = 9; %170
            bin = 1; %10    
        else
            localizados = orientacion<=bins;
            bin = find(localizados,1,'first');
            binAnterior = bin-1;
        end
        
        limBin = bins(bin);
        limBinAnterior = bins(binAnterior);
        
        %Se calcula el valor correspondiente en funcion de su pertenencia a
        %ambos contenedores
        valorBinAnterior = magnitud*(limBin-orientacion)/(limBin-limBinAnterior);
        valorBin = magnitud*(orientacion-limBinAnterior)/(limBin-limBinAnterior);
        
        %Se actualiza el valor del histograma para ambos bins
        histograma(bin) = histograma(bin) + valorBin;
        histograma(binAnterior) = histograma(binAnterior) + valorBinAnterior;        
    end
end




end