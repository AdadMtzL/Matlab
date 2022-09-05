clc 
close all 
clear all 
warning off all 
disp('Welcome to pattern recognition')
%   Esto determina un porcentaje de similitud ante otras clases
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

%declaración de clases y el vector desconocido
c1 = [1 2 3 2 3; 2 2 4 7 9];
c2 = [3 4 7 8 9; 5 6 -1 2 3];
c3 = [10 10 11 12 13; 1 7 4 -2 9];
vector=[7;5];

%calculo de medias
media1=mean(c1,2);
media2=mean(c2,2);
media3=mean(c3,2);

%calculo de las matrices de varianza_covarianza
matriz_var_cov_clase_1=(c1-media1)*transpose(c1-media1);
matriz_var_cov_clase_2=(c2-media2)*transpose(c2-media2);
matriz_var_cov_clase_3=(c3-media3)*transpose(c3-media3);

%calculo de la mat1
mat1_1=vector-media1;
mat1_2=vector-media2;
mat1_3=vector-media3;

%calculo de la mat2
mat2_1=transpose(mat1_1);
mat2_2=transpose(mat1_2);
mat2_3=transpose(mat1_3);

%calculo de distancias de mahalobis
dist1=mat2_1*inv(matriz_var_cov_clase_1)*mat1_1;
dist2=mat2_2*inv(matriz_var_cov_clase_2)*mat1_2;
dist3=mat2_3*inv(matriz_var_cov_clase_3)*mat1_3;

%calculo de la parte superior de la fracción
sup1=exp(-(dist1)/2);
sup2=exp(-(dist2)/2);
sup3=exp(-(dist3)/2);

%calculo de la parte inferior de la fracción
inf1=(2*pi)^(2/2)*det(inv(matriz_var_cov_clase_1))^(1/2);
inf2=(2*pi)^(2/2)*det(inv(matriz_var_cov_clase_2))^(1/2);
inf3=(2*pi)^(2/2)*det(inv(matriz_var_cov_clase_3))^(1/2);

%calculo de las probabilidades
probabilidad_1=sup1/inf1;
probabilidad_2=sup2/inf2;
probabilidad_3=sup3/inf3;

probabilidad_total_1=(probabilidad_1/probabilidad_2+probabilidad_3)*100;
probabilidad_total_2=(probabilidad_2/probabilidad_1+probabilidad_3)*100;
probabilidad_total_3=(probabilidad_3/probabilidad_2+probabilidad_1)*100;
