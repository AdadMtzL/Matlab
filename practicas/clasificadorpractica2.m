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
c1 = [134 148 114 187 150 ; 77 116 116 103 72];
c2 = [133 87 65 32 99; 36 35 15 42 51];
c3 = [-34 -28 -64 -47 -70; -57 -16 -16 -43 -42];
c4 = [34 28 44 37 50; 186 165 135 92 171];
c5 = [134 128 160 137 100; -37 -16 -36 -63 -22];
c6 = [-110 -17 -54 -107 -50;47 96 56 93 22];
%vector no clasificado
vectorx=input('Indique la coordenada x del vector no clasificado ');
vectory=input('Indique la coordenada y del vector no clasificado ');
vector=[vectorx;vectory];

%calculo de medias
media1 = mean(c1,2);
media2 = mean(c2,2);
media3 = mean(c3,2);
media4=mean(c4,2);
media5=mean(c5,2);
media6=mean(c6,2);

%calculo de matrices
%---------------------------------clase 3----------------------------------
difvecmed1=vector-media1;%a1
transdifvecmed1=transpose(difvecmed1); %a2

mat1b=c1-media1;
b1=mat1b*transpose(mat1b);
matinvb1=inv(b1);

distancia1=transdifvecmed1*matinvb1*difvecmed1; % ya da la distancia corecta
%deberia ser 12.56

%---------------------------------clase 2----------------------------------
difvecmed2=vector-media2;%a1
transdifvecmed2=transpose(difvecmed2); %a2

mat2b=c2-media2;
b2=mat2b*transpose(mat2b);
matinvb2=inv(b2);

distancia2=transdifvecmed2*matinvb2*difvecmed2; % ya da la distancia corecta


%---------------------------------clase 3----------------------------------
difvecmed3=vector-media3;%a1
transdifvecmed3=transpose(difvecmed3); %a2

mat3b=c3-media3;
b3=mat3b*transpose(mat3b);
matinvb3=inv(b3);

distancia3=transdifvecmed3*matinvb3*difvecmed3; % ya da la distancia corecta

%---------------------------------clase 4----------------------------------
difvecmed4=vector-media4;%a1
transdifvecmed4=transpose(difvecmed4); %a2

mat4b=c4-media4;
b4=mat4b*transpose(mat4b);
matinvb4=inv(b4);

distancia4=transdifvecmed4*matinvb4*difvecmed4; % ya da la distancia corecta

%---------------------------------clase 5----------------------------------
difvecmed5=vector-media5;%a1
transdifvecmed5=transpose(difvecmed5); %a2

mat5b=c5-media5;
b5=mat5b*transpose(mat5b);
matinvb5=inv(b5);

distancia5=transdifvecmed5*matinvb5*difvecmed5; % ya da la distancia corecta

%---------------------------------clase 6----------------------------------
difvecmed6=vector-media6;%a1
transdifvecmed6=transpose(difvecmed6); %a2

mat6b=c6-media6;
b6=mat6b*transpose(mat6b);
matinvb6=inv(b6);

distancia6=transdifvecmed6*matinvb6*difvecmed6; % ya da la distancia corecta

%deteminación de la menor distancia
distancias=[distancia1 distancia2 distancia3 distancia4 distancia5 distancia6];

dist_min=min(min(distancias));

clase = find(distancias==dist_min);

fprintf('El vector pertenece a la clase %d\n',clase);

