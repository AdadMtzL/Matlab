clc 
clear all
close all
warning off all

%Este programa genera clases con n elementos aleatorios

%generación de n elementos por clase
n=100000;
c1x=randn(1,n)+3;
c1y=randn(1,n)+3;

c2x=randn(1,n)-2; %+-n indica el centroide de los puntos aleatorios
c2y=randn(1,n)-2;

c3=[randn(1,n)+8;randn(1,n)+8];
plot(c1x(1,:),c1y(1,:),'ro','MarkerFaceColor','r','MarkerSize',5);
hold on
grid on
plot(c2x(1,:),c2y(1,:),'g*','MarkerFaceColor','g','MarkerSize',5);
plot(c3(1,:),c3(2,:),'b+','MarkerFaceColor','b','MarkerSize',5);

legend('clase1','clase2','clase3');