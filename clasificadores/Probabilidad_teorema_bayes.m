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
mat1_trans=transpose(mat1_1);
mat2_trans=transpose(mat1_2);
mat3_trans=transpose(mat1_3);

%calculo de distancias de mahalobis
dist1=mat1_trans*inv(matriz_var_cov_clase_1)*mat1_1
dist2=mat2_trans*inv(matriz_var_cov_clase_2)*mat1_2;
dist3=mat3_trans*inv(matriz_var_cov_clase_3)*mat1_3;

%calculo de la parte superior de la fracción
sup1=exp(-0.5*(dist1));
sup2=exp(-0.5*(dist2));
sup3=exp(-0.5*(dist3));

%calculo de la parte inferior de la fracción
inf1=(2*pi)*det(matriz_var_cov_clase_1)^(0.5);
inf2=(2*pi)*det(matriz_var_cov_clase_2)^(0.5);
inf3=(2*pi)*det(matriz_var_cov_clase_3)^(0.5);

%calculo de las probabilidades
probabilidad_1=sup1/inf1;
probabilidad_2=sup2/inf2;
probabilidad_3=sup3/inf3;

sumatoria_probabilidades = probabilidad_1+probabilidad_2+probabilidad_3;

probabilidad_total_1 = (probabilidad_1/sumatoria_probabilidades)*100;
probabilidad_total_2=(probabilidad_2/sumatoria_probabilidades)*100;
probabilidad_total_3=(probabilidad_3/sumatoria_probabilidades)*100;

probabilidades=[probabilidad_total_1, probabilidad_total_2,probabilidad_total_3];

probabilida_maxima=max(max(probabilidades));

clase_pert=find(probabilidades == probabilida_maxima);

