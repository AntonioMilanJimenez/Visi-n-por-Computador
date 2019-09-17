%Haz otra función que, de forma análoga, muestre los histogramas de las componentes RGB. Esta vez 
%no hay que mostrar ningún mapa de color específico para ninguna de ellas.
function Funcion2Guion2(imagenHSV)

imRGB = hsv2rgb(imagenHSV);
im1= imRGB(:,:,1);
im2= imRGB(:,:,2);
im3= imRGB(:,:,3);

figure;
subplot(1,4,1), subimage(imRGB),title('Imagen');
subplot(1,4,2),imhist(im2uint8(im1)), title('Rojo');
subplot(1,4,3),imhist(im2uint8(im2)), title('Verde');
subplot(1,4,4),imhist(im2uint8(im3)), title('Azul');
end
