%Se realizan diferentes operaciones aritmeticas sobre la imagen
I=imread('mujer.jpg');
figure,subplot(5,2,1),subimage(I),title('Original'),subplot(5,2,2),imhist(I);
Isuma=I+50;
subplot(5,2,3),subimage(Isuma),title('Suma +50'), subplot(5,2,4),imhist(Isuma);
Iresta=I-50;
subplot(5,2,5),subimage(Iresta),title('Resta -50'), subplot(5,2,6),imhist(Iresta);
Ipro=I*1.3;
subplot(5,2,7),subimage(Ipro),title('Producto *1.3'), subplot(5,2,8),imhist(Ipro);
Idiv=I/2;
subplot(5,2,9),subimage(Idiv),title('Division /2'), subplot(5,2,10),imhist(Idiv);

%Se observa que al utilizar las operaciones de sumar y multiplicar, al
%aumentar los valores de forma general, se aumenta el brillo; sucediendo lo
%contrario con restar y dividir. Ademas, por ejemplo en el caso de la
%division, se observa cómo se estrecha el histograma repercutiendo en un
%empeoramiento del contraste.



%Utilizamos stretchlim para mejorar el contraste
stretchI=imadjust(I,stretchlim(I),[]);
subplot(2,2,1),subimage(I),title('Original'),subplot(2,2,2),imhist(I);
subplot(2,2,3),subimage(stretchI),title('Stretch'),subplot(2,2,4),imhist(stretchI);
%Se observa claramente una mejora del contraste, con un histograma mejor
%distribuido



%A continuación vamos a utilizar una función de transferencia de tipo gamma
%para intentar igualmente mejor el contraste
palfa = 3;
c=1;
Id=im2double(I);
%Obtenemos el minimo y maximo de la imagen
minimo = min(min(Id));
maximo = max(max(Id));
%Aplicamos la transformacion gamma
minimoGamma = c*(minimo.^palfa);
maximoGamma = c*(maximo.^palfa);

%Se aplica imadjust
imageGamma = imadjust(Id,[minimo maximo],[minimoGamma maximoGamma]);
%Se devuelve la imagen al rango 0-255
Itrun= im2uint8(imageGamma);

subplot(2,2,1),subimage(I),title('Original'),subplot(2,2,2),imhist(I);
subplot(2,2,3),subimage(Itrun),title('Gamma'),subplot(2,2,4),imhist(Itrun);
%Se observa un histograma mejor distribuido, lo cual se refleja en una
%imagen con mejor constraste




%Vamos ahora a aplicar otra funcion de transferencia
% [100 255]--> [0.3922 1]
imageAdjust = imadjust(I,[0.3922 1],[0 1]);
imageAdjust= im2uint8(imageAdjust);

subplot(2,2,1),subimage(I),title('Original'),subplot(2,2,2),imhist(I);
subplot(2,2,3),subimage(imageAdjust),title('Adjust'),subplot(2,2,4),imhist(imageAdjust);



%Por ultimo vamos a ecualizar la imagen con histeq
imageEq = histeq(I);

subplot(2,2,1),subimage(I),title('Original'),subplot(2,2,2),imhist(I);
subplot(2,2,3),subimage(imageEq),title('Equalized'),subplot(2,2,4),imhist(imageEq);
%Observamos una mejora muy notable del contraste de la imagen




