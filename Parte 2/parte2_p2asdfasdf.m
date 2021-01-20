clc; clear; close all;
function F = matdft2(f,J,K)
  A = size(J,1);
  M = size(f,1)./A;
  N = size(f,2)./A;
  F = zeros(size(f));
  
  for u = 0:M-1
    for v = 0:N-1
      for m = 0:M-1
        for n = 0:N-1
          F(A*u+1:A*u+A, A*v+1:A*v+A) =  F(A*u+1:A*u+A, A*v+1:A*v+A)+  expm(-J.*2*pi.*m.*u./M) * f(A*m+1: A*m+A, A*n+1:A*n+A) * expm(-K.*2*pi.*n.*v./N);
        endfor
      endfor
    endfor
  endfor
endfunction

J = [0 1 1 -sqrt(3);
     1 0 sqrt(3) -1;
     1 -sqrt(3) 0 1;
     sqrt(3) -1 1 0];
K = eye(4);
A = imread('lena.jpg');
subplot(1,2,1)
imshow(A)
title('(a)')     
A = im2double(A);
B = matdft2(A, J, K);
B = fftshift(B)
B = rgb2gray(B);
imshow(log(B+1),[])