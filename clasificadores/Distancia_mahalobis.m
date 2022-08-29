clc
close all
clear all
warning off all
%autor: Martinez Luna Adad Marcel

%distancia de mahalobis = (vector - media_clase)^T *Matriz_inversa_covarianza_clase(x-media_clase)*(vector - media_clase)
%                                  ^                               ^                                 ^
%                                  |                               |                                 |
%                                  a2                              b                                 a1


%                          matriz_covarianza_clase=(clase-media_clase)*(clase-media_clase)^T

%notas importantes : ^T indica la matriz transpuesta

%declaración de clases
c1 = [1 2 3 2 3; 2 2 4 7 9];
c2 = [3 4 7 8 9; 5 6 -1 2 3];
c3 = [10 10 11 12 13; 1 7 4 -2 9];
%vector no clasificado
vector=[7; 5];

%calculo de medias
m1 = mean(c1,2);
m2 = mean(c2,2);
m3 = mean(c3,2);

%calculo de matrices
%---------------------------------clase 3----------------------------------
difvecmed1=vector-m1;%a1
transdifvecmed1=transpose(difvecmed1); %a2

mat1b=c1-m1;
b1=mat1b*transpose(mat1b);
matinvb1=inv(b1);

distancia1=transdifvecmed1*matinvb1*difvecmed1; % ya da la distancia corecta
%deberia ser 12.56

%---------------------------------clase 2----------------------------------
difvecmed2=vector-m2;%a1
transdifvecmed2=transpose(difvecmed2); %a2

mat2b=c2-m2;
b2=mat2b*transpose(mat2b);
matinvb2=inv(b2);

distancia2=transdifvecmed2*matinvb2*difvecmed2; % ya da la distancia corecta
%deberia ser 0.3833
%---------------------------------clase 3----------------------------------
difvecmed3=vector-m3;%a1
transdifvecmed3=transpose(difvecmed3); %a2

mat3b=c3-m3;
b3=mat3b*transpose(mat3b);
matinvb3=inv(b3);

distancia3=transdifvecmed3*matinvb3*difvecmed3; % ya da la distancia corecta
%deberia ser 2.7830

%deteminación de la menor distancia
distancias=[distancia1 distancia2 distancia3];

dist_min=min(min(distancias));

clase = find(distancias==dist_min);

fprintf('El vector pertenece a la clase %d\n',clase);

