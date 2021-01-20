clc; clear; close all;
% Matriz J Real que cumple con J^2 = I_4
J1 = [0 1 1 -sqrt(3);
     1 0 sqrt(3) -1;
     1 -sqrt(3) 0 1;
     sqrt(3) -1 1 0];

% Matriz J Real que cumple con J^2 = I_4     
J2 = [0 1 -sqrt(3) 1;
     1 0 -1 sqrt(3);
     sqrt(3) -1 0 1;
     1 -sqrt(3) 1 0];
     
% Matriz J Compleja que cumple con J^2 = I_4     
J3 = [0 -1 -1-i -1+i;
     1 0 -1+i 1+i;
     1+i 1-i 0 -1;
     1-i -1-i 1 0];

%Prueba     
R = J3^2