pkg load image

function I = f_inp(A, M, bounds, its)
  Ar = A(:,:,1);
  Ag = A(:,:,2);
  Ab = A(:,:,3);
  for i = 1:its
    
    Cr = conv2(Ar, M, 'same');
    Cg = conv2(Ag, M, 'same');
    Cb = conv2(Ab, M, 'same');
    Ar(bounds) = Cr(bounds);
    Ag(bounds) = Cg(bounds);
    Ab(bounds) = Cb(bounds);
  endfor
  I(:,:,1) = Ar;
  I(:,:,2) = Ag;
  I(:,:,3) = Ab;
endfunction 

clear; clc;

#Cargar imagenes
A = imread("fondo_verde.jpg");
B = imread("playa.jpg");

#Obtener imagen binaria a partir de canal verde
Edge =(A(:,:,2)<243);

#Distribuir imagenes en canales
Br = B(:,:,1);
Bg = B(:,:,2);
Bb = B(:,:,3);
Ar = A(:,:,1);
Ag = A(:,:,2);
Ab = A(:,:,3);

#Obtener bordes
EdgeStrel = strel('diamond',2);
EdgeErode = imerode(Edge,EdgeStrel);
Edge = Edge&~EdgeErode;

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

#impainting
a = 0.073235;
b = 0.176765;
M =  [a b a; 
      b 0 b; 
      a b a];
its=100;
I = f_inp(A+B, M, Edge, its);

imshow(I)


