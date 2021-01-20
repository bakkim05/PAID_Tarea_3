clc; clear; close all;

pkg load image

function mat = FA(r, g,b )
  mat = [ 0 -r -g -b;
          r 0 -b g;
          g b 0 -r;
          b -g r 0];
end

function E = matE(p,q,r)
  J = [0 1 1 -sqrt(3);
     1 0 sqrt(3) -1;
     1 -sqrt(3) 0 1;
     sqrt(3) -1 1 0];
  
  E = expm(-J.*(2*pi*p*q/r));
end

function F =dft_2d()
  

A = imread('lena.jpg');
A = im2double(A);
subplot(1,2,1)
imshow(A)
title('(a)')


[m, n, c] = size(A)
A1 = arrayfun(@FA, A(:,:,1), A(:,:,2), A(:,:,3),"UniformOutput", false);
F = 
size(B1)