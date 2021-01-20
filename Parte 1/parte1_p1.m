pkg load image

clear; clc;

#Cargar imagenes
A = imread("fondo_verde.jpg");
B = imread("playa.jpg");

#Distribuir imagenes en canales
Br = B(:,:,1);
Bg = B(:,:,2);
Bb = B(:,:,3);
Ar = A(:,:,1);
Ag = A(:,:,2);
Ab = A(:,:,3);

#Umbrales altos y bajos
Thh=230;
Thl = 60;

#Limpiar color negro en canales
Ar(Ar<33)=0;
Ab(Ab<33)=0;

#Sustituir canales en la imagen
A(:,:,1)=Ar;
A(:,:,3)=Ab; 
#Obtener indices donde solo verde existe
inx = (A(:,:,2) > Thh) & (A(:,:,1) <= Thl) & (A(:,:,3) <= Thl);
#verde -> negro
Ag(inx)=0;

#remplazar en imagen
A(:,:,2)=Ag;

#extraer color del fondo
Br(~inx)=0;
Bg(~inx)=0;
Bb(~inx)=0;

#reconstruir fondo
B(:,:,1)=Br;
B(:,:,2)=Bg;
B(:,:,3)=Bb;

imshow(A+B)