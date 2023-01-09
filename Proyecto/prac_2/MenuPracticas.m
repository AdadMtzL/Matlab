clc 
close all 
clear all 
warning off all 
disp('Welcome to pattern recognition')

disp('Clasificador de maxima probabilidad')
%clases para el clasificador de maxima probabilidad
c1 = [134 148 114 120 150 ; 77 116 116 60 72];
c2 = [110 87 67 62 99; 36 35 15 45 51];
c3 = [34 40 64 47 70; 57 20 16 43 42];
c4 = [34 28 44 37 50; 120 165 135 92 171];
c5 = [138 128 100 125 115; 37 16 36 70 65];
c6 = [40 35 54 40 50;95 100 56 80 35];

%obtención del vector desconocido
vectorx=input('Indique lac coordenada x del vector no clasificado ');
vectory=input('Indique la coordenada y del vector no clasificado ');
vector=[vectorx;vectory];

%calculo de medias
media1=mean(c1,2);
media2=mean(c2,2);
media3=mean(c3,2);
media4=mean(c4,2);
media5=mean(c5,2);
media6=mean(c6,2);
%calculo de las matrices de varianza_covarianza
matriz_var_cov_clase_1=(c1-media1)*transpose(c1-media1);
matriz_var_cov_clase_2=(c2-media2)*transpose(c2-media2);
matriz_var_cov_clase_3=(c3-media3)*transpose(c3-media3);
matriz_var_cov_clase_4=(c4-media4)*transpose(c4-media4);
matriz_var_cov_clase_5=(c5-media5)*transpose(c5-media5);
matriz_var_cov_clase_6=(c6-media6)*transpose(c6-media6);

%calculo de la mat1
mat1_1=vector-media1;
mat1_2=vector-media2;
mat1_3=vector-media3;
mat1_4=vector-media4;
mat1_5=vector-media5;
mat1_6=vector-media6;

%calculo de la mat2
mat1_trans=transpose(mat1_1);
mat2_trans=transpose(mat1_2);
mat3_trans=transpose(mat1_3);
mat4_trans=transpose(mat1_4);
mat5_trans=transpose(mat1_5);
mat6_trans=transpose(mat1_6);

%calculo de distancias de mahalobis
dist1=mat1_trans*inv(matriz_var_cov_clase_1)*mat1_1;
dist2=mat2_trans*inv(matriz_var_cov_clase_2)*mat1_2;
dist3=mat3_trans*inv(matriz_var_cov_clase_3)*mat1_3;
dist4=mat4_trans*inv(matriz_var_cov_clase_4)*mat1_4;
dist5=mat5_trans*inv(matriz_var_cov_clase_5)*mat1_5;
dist6=mat6_trans*inv(matriz_var_cov_clase_6)*mat1_6;

%calculo de la parte superior de la fracción
sup1=exp(-0.5*(dist1));
sup2=exp(-0.5*(dist2));
sup3=exp(-0.5*(dist3));
sup4=exp(-0.5*(dist4));
sup5=exp(-0.5*(dist5));
sup6=exp(-0.5*(dist6));

%calculo de la parte inferior de la fracción
inf1=(2*pi)*det(matriz_var_cov_clase_1)^(0.5);
inf2=(2*pi)*det(matriz_var_cov_clase_2)^(0.5);
inf3=(2*pi)*det(matriz_var_cov_clase_3)^(0.5);
inf4=(2*pi)*det(matriz_var_cov_clase_4)^(0.5);
inf5=(2*pi)*det(matriz_var_cov_clase_5)^(0.5);
inf6=(2*pi)*det(matriz_var_cov_clase_6)^(0.5);

%calculo de las probabilidades
probabilidad_1=sup1/inf1;
probabilidad_2=sup2/inf2;
probabilidad_3=sup3/inf3;
probabilidad_4=sup4/inf4;
probabilidad_5=sup5/inf5;
probabilidad_6=sup6/inf6;

sumatoria_probabilidades = probabilidad_1+probabilidad_2+probabilidad_3+probabilidad_4+probabilidad_5+probabilidad_6;

probabilidad_total_1 = (probabilidad_1/sumatoria_probabilidades)*100;
probabilidad_total_2=(probabilidad_2/sumatoria_probabilidades)*100;
probabilidad_total_3=(probabilidad_3/sumatoria_probabilidades)*100;
probabilidad_total_4=(probabilidad_4/sumatoria_probabilidades)*100;
probabilidad_total_5=(probabilidad_5/sumatoria_probabilidades)*100;
probabilidad_total_6=(probabilidad_6/sumatoria_probabilidades)*100;

probabilidades=[probabilidad_total_1, probabilidad_total_2,probabilidad_total_3,probabilidad_total_4,probabilidad_total_5,probabilidad_total_6];

probabilida_maxima=max(max(probabilidades));

clase_pert=find(probabilidades == probabilida_maxima);

fprintf("El vector tiene una probabilidad del %f pertenecer a la clase %d\n",probabilida_maxima,clase_pert);

%graficación de las clases y el vector desconocido
 figure(1)
 plot(c1(1,:),c1(2,:),'ro','MarkerFaceColor','r','MarkerSize',10)
 grid on
 hold on
 plot(c2(1,:),c2(2,:),'b+','MarkerFaceColor','b','MarkerSize',10)
 plot(c3(1,:),c3(2,:),'k*','MarkerFaceColor','k','MarkerSize',10)
 plot(c4(1,:),c4(2,:),'c+','MarkerFaceColor','c','MarkerSize',10)
 plot(c5(1,:),c5(2,:),'gd','MarkerFaceColor','g','MarkerSize',10)
 plot(c6(1,:),c6(2,:),'mh','MarkerFaceColor','m','MarkerSize',10)
 plot(vector(1,:),vector(2,:),'y^','MarkerFaceColor','y','MarkerSize',5)
 legend('Clase 1','Clase 2','Clase 3','Clase 4','Clase 5','Clase 6','vector no clasificado');

