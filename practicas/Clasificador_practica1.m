clc
close all
clear all
warning off all
%autores
%Martinez Luna Adad Marcel
%Campos Ocampo Johan
%Fecha: 27/08/22
disp('Clasificador por distancia euclidiana con 6 clases')

%Clasificador con distancia euclidiana

%declaracion de clases
c1 = [134 148 114 187 150 ; 77 116 116 103 72];
c2 = [133 87 65 32 99; 36 35 15 42 51];
c3 = [-34 -28 -64 -47 -70; -57 -16 -16 -43 -42];
c4 = [34 28 44 37 50; 186 165 135 92 171];
c5 = [134 128 160 137 100; -37 -16 -36 -63 -22];
c6 = [-110 -17 -54 -107 -50;47 96 56 93 22];
limsupy=500;
limsupx=500;
liminfx=-500;
liminfy=-500;
%vector desconocido
vectorx=input('Indique lac coordenada x del vector no clasificado ');
vectory=input('Indique la coordenada y del vector no clasificado ');
vector=[vectorx;vectory];

%calculo de las medias de cada clase
media1=mean(c1,2);
media2=mean(c2,2);
media3=mean(c3,2);
media4=mean(c4,2);
media5=mean(c5,2);
media6=mean(c6,2);

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

%clasificación del vector
distancia1=norm(vector-media1);
distancia2=norm(vector-media2);
distancia3=norm(vector-media3);
distancia4=norm(vector-media4);
distancia5=norm(vector-media5);
distancia6=norm(vector-media6);

%almacenamiento de las distancias
Distancias=[distancia1,distancia2,distancia3,distancia4,distancia5,distancia6];

%comprobación de los limites
 if vectorx > limsupx
    fprintf('Vector fuera de los limites, no se puede clasificar\n');
    elseif vectorx < liminfx
        fprintf('Vector fuera de los limites, no se puede clasificar\n');
        elseif vectory > limsupy
            fprintf('Vector fuera de los limites, no se puede clasificar\n');
            elseif vectory < liminfy
                fprintf('Vector fuera de los limites, no se puede clasificar\n');
                else
                    %deteminación de la distancia más corta
                    dint_min=min(min(Distancias));
                    clase=find(Distancias==dint_min);

                    %clasificación
                    fprintf('El vector desconocido pertenece a la clase %d \n',clase);
                end
   
