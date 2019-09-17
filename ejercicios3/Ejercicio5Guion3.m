%Por ultimo vamos a aplicar diferentes técnicas de mejora de constraste
%sobre la imagen 'paisaje.jpg'

I = imread('paisaje.jpg');

I = rgb2hsv(I);
h = I(:,:,1);
s = I(:,:,2);
v = I(:,:,3);
I = hsv2rgb(I);

%Stretchlim
Istretch = imadjust(v,stretchlim(v),[]);
Istretch = cat(3,h,s,Istretch);
Istretch = hsv2rgb(Istretch);

%Histeq
Ieq = histeq(v);
Ieq = cat(3,h,s,Ieq);
Ieq = hsv2rgb(Ieq);

%Adapthisteq
Iadapt = adapthisteq(v,'clipLimit',0.005);
Iadapt = cat(3,h,s,Iadapt);
Iadapt = hsv2rgb(Iadapt);

subplot(1,4,1),subimage(I),title('Original'), subplot(1,4,2),subimage(Istretch),title('stretchlim');
subplot(1,4,3),subimage(Ieq),title('histeq'), subplot(1,4,4),subimage(Iadapt),title('adapthisteq 0.005');
%Aunque para todas las diferentes técnicas se consigue una mejora del
%contraste, con 'histeq' se consigue un resultado bastante bueno.