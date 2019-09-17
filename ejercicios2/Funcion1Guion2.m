%Cargar una imagen RGB y convertirla a HSV. Para ello implementa una función que reciba como entrada 
%la imagen en formato RGB y que muestre una ventana con la imagen y los histogramas de sus tres 
%componentes HSV.
function Funcion1Guion2(imagenRGB)

imRGB = imread(imagenRGB);
imhsv = rgb2hsv(imRGB);
im1= imhsv(:,:,1);
im2= imhsv(:,:,2);
im3= imhsv(:,:,3);

mapahsv=hsv(256);
figure;
subplot(1,4,1), subimage(imRGB),title('Imagen');
subplot(1,4,2),imhist(im2uint8(im1),mapahsv), title('Color');
subplot(1,4,3),imhist(im2uint8(im2)), title('Saturacion');
subplot(1,4,4),imhist(im2uint8(im3)), title('Brillo');
end



