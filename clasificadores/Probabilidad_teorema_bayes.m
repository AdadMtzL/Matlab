clc 
close all 
clear all 
warning off all 
disp('Welcome to pattern recognition')
%
%
%               e^{-1(Distancia mahalobi)/2}
%p(vec/clase)=------------------------------------------------------------
%            (2pi)^{n/2}*[determinante(matriz_varianza_covarianza)]^{1/2}
%
%distancia de mahalobis = (vector - media_clase)^T *Matriz_inversa_covarianza_clase(x-media_clase)*(vector - media_clase)
%                                  ^                               ^                                 ^
%                                  |                               |                                 |
%                                 mat2                           mat_inv_cov                        mat1


%                          matriz_covarianza_clase=(clase-media_clase)*(clase-media_clase)^T

%notas importantes : ^T indica la matriz transpuesta

c1 = [1 2 3 2 3; 2 2 4 7 9];
c2 = [3 4 7 8 9; 5 6 -1 2 3];
c3 = [10 10 11 12 13; 1 7 4 -2 9];