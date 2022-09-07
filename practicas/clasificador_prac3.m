clc 
clear all
close all
warning off all
%intento de generar m clases con n elementos
m=input('Indique la cantidad de clases \n');
cn=input('Indique la cantidad de elementos por clase \n');

%obtención del ector desconocido
desconocido_x=input('Indique la coordenada x del vector desconocido\n');
desconocido_y=input('Indique la coordenada y del vector desconocido\n');
vector=[desconocido_x ; desconocido_y];

%ploteo del vector desconocido
plot(vector(1,:),vector(2,:),'kh','MarkerFaceColor','g','MarkerSize',15);
hold on
grid on
 
%variables auxiliares para el ploteo
figuras = ['o' '+' '*' '.' 'x' '_' '|' 's' 'd' '^' 'v' '<' '>' 'p' 'h'];
nf=1;
colores = ['r' 'g' 'b' 'c' 'm' 'y' 'k'];
nc=1;

%generación de las clases aleatorias y su ploteo
for indice=1:1:m
    fprintf("clase %d\n",indice);
    cenx=input('Indique la coordenada x del centroide de la clase \n');
    ceny=input('Indique la coordenada x del centroide de la clase \n');
    vx=randn(1,cn)+cenx;
    vy=randn(1,cn)+ceny;

    %sección que plotea de manera diferente cada clase, genera 50 etiquetas
    %El limite de clases es 120 para que no genere un fallo al plotear
    if(nc>7)
        nc=1;
        nf=nf+1;
    else
        figs=[colores(nc) figuras(nf)];
        cl=[colores(nc)];
        plot(vx(1,:),vy(1,:),(figs(1,:)),'MarkerFaceColor',(cl(1,:)),'MarkerSize',5);
        nombre="clase "+indice;
        nombre=nombre+ nombre;
        legend('vector desconocido',nombre);
        nc=nc+1;
    end
end

%Practica 3: Pedir al usuario generar n clases con n representantes por clase %
%pedir la ubicación del vector desconocido.
%Ubicación (x,y) del centroide de cada clase%
%Dispersion (x,y) por cada clase%
% Menu interactivo que practica quere selecciona para determinar la distancia.
%
%