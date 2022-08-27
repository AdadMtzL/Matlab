clc
close all
clear all
warning off all

disp('Clasificador por distancia euclidiana')

%Clasificador con distancia euclidiana

%declaracion de clases
c1 = [1 2 3 2 3; 2 2 4 7 9];
c2 = [3 4 7 8 9; 5 6 -1 2 3];
c3 = [10 10 11 12 13; 1 7 4 -2 9];
%vector desconocido
vectorx=input('Indique lac oordenada x del vector no clasificado ');
vectory=input('Indique la coordenada y del vector no clasificado ');
vector=[vectorx;vectory];

%calculo de las medias de cada clase
media1=mean(c1,2);
media2=mean(c2,2);
media3=mean(c3,2);

%graficación de las clases y el vector desconocido
 figure(1)
 plot(c1(1,:),c1(2,:),'ro','MarkerFaceColor','r','MarkerSize',10)
 grid on
 hold on
 plot(c2(1,:),c2(2,:),'b+','MarkerFaceColor','b','MarkerSize',10)
 plot(c3(1,:),c3(2,:),'k*','MarkerFaceColor','k','MarkerSize',10)
 plot(vector(1,:),vector(2,:),'g^','MarkerFaceColor','g','MarkerSize',10)
 legend('Clase 1','Clase 2','Clase 3','vector no clasificado');

%clasificación del vector
distancia1=norm(vector-media1);
distancia2=norm(vector-media2);
distancia3=norm(vector-media3);

%almacenamiento de las distancias
Distancias=[distancia1,distancia2,distancia3];

%deteminación de la distancia más corta
dint_min=min(min(Distancias));
clase=find(Distancias==dint_min);

%clasificación
fprintf('El vector desconocido pertenece a la clase %d \n',clase);