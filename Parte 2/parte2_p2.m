clc; clear; close all;

pkg load image

function mat = FA(pix)
  r = pix(1);
  g = pix(2);
  b = pix(3);
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


function F = DFT_2D(A)
  [m, n, c] = size(A)
  F = zeros(m,n);
   for u = 1:m
     for v=1:n
      L =[]
      for r = 0:m-1
        for s = 0:n-1
           L= [L matE(r,u,m)*FA(A(r+1, s+1,:))*matE(s,v,n))];
        end
      end
      F(u,v) = norm(1/sqrt(m*n)*sum(L))
    end
  end
end

A = imread('lena.jpg');
A = A(1:10,1:10,:);
subplot(1,2,1)
imshow(A)
title('(a)')

A = im2double(A);
tic;
B = DFT_2D(A);
toc;
B1 = fftshift(B);
B = im2uint8(B);
subplot(1,2,2)
imshow(log(1+B), [])
title('(b)')