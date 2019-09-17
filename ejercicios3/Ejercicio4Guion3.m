%Usa la función adapthisteq sobre la imagen mujer.jpg y analiza el resultado
I = imread('mujer.jpg');

Ieq = adapthisteq(I);
Ieq2 = adapthisteq(I,'clipLimit',0.005);
Ieq3 = adapthisteq(I,'clipLimit',0.1);
Ieq4 = adapthisteq(I,'clipLimit',0.3);
subplot(1,5,1),subimage(I),title('Original'), subplot(1,5,2),subimage(Ieq2),title('Image EQ 0.005');
subplot(1,5,3),subimage(Ieq),title('Image EQ 0.01'), subplot(1,5,4),subimage(Ieq3),title('Image EQ 0.1');
subplot(1,5,5),subimage(Ieq4),title('Image EQ 0.3');
%Observamos que es con un valor muy bajo de 'ClipLimit' cuando se consigue
%una gran mejora del contraste en la imagen