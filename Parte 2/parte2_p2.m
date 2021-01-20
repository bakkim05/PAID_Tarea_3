clc; clear; close all;

function F = matdft2(f)
  
  f = cell2mat(f);
  
  J = [0 1 1 -sqrt(3);
     1 0 sqrt(3) -1;
     1 -sqrt(3) 0 1;
     sqrt(3) -1 1 0];
     K =J;
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
    u
  endfor
endfunction
     
A = imread('lena.jpg');
subplot(1,2,1)
imshow(A)
title('(a)')     
A = im2double(A);

function mat = FA(r, g,b )
  
  mat = [ 0 -r -g -b;
          r 0 -b g;
          g b 0 -r;
          b -g r 0];
end

A1 = arrayfun(@FA, A(:,:,1), A(:,:,2), A(:,:,3),"UniformOutput", false);

s = 50
B = matdft2(A1(1:s,1:s));

C = zeros(50,50);
C1 = zeros(s,s);

for x = 0:s-1
  for y =0:s-1
    C1(x+1,y+1) = norm(B(4*x +1: 4*x+4, 4*y +1: 4*y+4));
  end
end
subplot(1,2,2)
imshow(C1)