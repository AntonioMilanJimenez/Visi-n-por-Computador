%Utiliza la correlación para buscar formas en una imagen.
%Detección de letras en texto
texto = imread('texto.png');
letraO = imread('letra_o.png');
letraI = imread('letra_i.png');
%Se ajusta el tamaño
letraO=im2bw(imresize(letraO,0.9),0.5);
letraI=im2bw(imresize(letraI,0.9),0.5);
%Se crea el elemento estructural
sO = strel('arbitrary',letraO);
sI = strel('arbitrary',letraI);
%Se aplica la apertura
openO = imopen(texto,sO);
openI = imopen(texto,sI);
imshow(texto);
figure,subplot(1,2,1),imshow(openO),title('Letra o'),subplot(1,2,2),imshow(openI),title('Letra i');


%Detección de formas
formas = imread('formas.png');
estrella = imread('estrella.png');
ovalo = imread('ovalo.png');
%Se ajusta el tamaño
estrella=im2bw(imresize(estrella,0.9),0.5);
ovalo=im2bw(imresize(ovalo,0.9),0.5);
%Se crea el elemento estructural
sEstrella = strel('arbitrary',estrella);
sOvalo = strel('arbitrary',ovalo);
%Se aplica la apertura
openEstrella = imopen(formas,sEstrella);
openOvalo = imopen(formas,sOvalo);
imshow(formas);
figure,subplot(1,2,1),imshow(openEstrella),title('Estrellas'),subplot(1,2,2),imshow(openOvalo),title('Ovalos');

