%En este ejercicio se va a realizar una composicion de transferencia con una
%transformacion gamma.

I = imread('campo.ppm');

Ihsv = rgb2hsv(I);
h = Ihsv(:,:,1);
s = Ihsv(:,:,2);
v = Ihsv(:,:,3);

palfa = 0.75;
c=1;
%Cambiamos de rango
%110 --> 0.4314
%190 --> 0.7451

%Aplicamos la transformacion gamma
minimoGamma = c*(0.4314.^palfa);
maximoGamma = c*(0.7451.^palfa);

%Se aplica imadjust sobre la banda v para no alterar el color
imageGammaV = imadjust(v,[0.4314 0.7451],[minimoGamma maximoGamma]);

imageGamma = cat(3,h,s,imageGammaV);
imageGamma = hsv2rgb(imageGamma);
subplot(1,2,1),subimage(I),title('Original'), subplot(1,2,2),subimage(imageGamma),title('Image Gamma');