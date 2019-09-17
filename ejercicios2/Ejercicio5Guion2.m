%Crea una animación en la que, dada una imagen, se pueda ver como van ciclando los colores. Para ello, 
%cada fotograma se obtendrá sumando un pequeño incremento a la componente H del fotograma anterior. 
I=imread('praga1.jpg');

y=rgb2hsv((I));
z=y;
for i=1:255
    disp(i)
    %Se incrementa la componente H de z en funcion del valor anterior
    z(:,:,1)=mod(y(:,:,1)+i/255.0,0.99);
    peli(i)=im2frame((hsv2rgb(z)));
end
movie(peli);