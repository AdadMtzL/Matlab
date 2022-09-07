clc 
clear all
close all
warning off all
%intento de generar m clases con n elementos
m=input('Indique la cantidad de clases \n');
cn=input('Indique la cantidad de elementos por clase \n');

for indice=1:1:m
    disp('clase');
    disp(indice);
    %cenx=input('Indique la coordenada x del centroide de la clase \n');
    %ceny=input('Indique la coordenada x del centroide de la clase \n');
    vx=randn(1,cn)+indice/2;
    vy=randn(1,cn)+indice/2;
    if(indice == 1)
        plot(vx(1,:),vy(1,:),'ro','MarkerFaceColor','r','MarkerSize',5);
        hold on
        grid on
    elseif(indice == 2)
        plot(vx(1,:),vy(1,:),'go','MarkerFaceColor','g','MarkerSize',5);
    elseif(indice == 3)
        plot(vx(1,:),vy(1,:),'bo','MarkerFaceColor','b','MarkerSize',5);
    elseif(indice == 4)
        plot(vx(1,:),vy(1,:),'co','MarkerFaceColor','c','MarkerSize',5);
    elseif(indice == 5)
        plot(vx(1,:),vy(1,:),'mo','MarkerFaceColor','m','MarkerSize',5);
    elseif(indice == 6)
        plot(vx(1,:),vy(1,:),'yo','MarkerFaceColor','y','MarkerSize',5);
    elseif(indice == 7)
        plot(vx(1,:),vy(1,:),'ko','MarkerFaceColor','k','MarkerSize',5);
    elseif(indice == 8)
        plot(vx(1,:),vy(1,:),'r+','MarkerFaceColor','r','MarkerSize',5);
    elseif(indice == 9)
        plot(vx(1,:),vy(1,:),'g+','MarkerFaceColor','g','MarkerSize',5);
    elseif(indice == 10)
        plot(vx(1,:),vy(1,:),'b+','MarkerFaceColor','b','MarkerSize',5);
    elseif(indice == 11)
        plot(vx(1,:),vy(1,:),'c+','MarkerFaceColor','c','MarkerSize',5);
    elseif(indice == 12)
        plot(vx(1,:),vy(1,:),'m+','MarkerFaceColor','m','MarkerSize',5);
    elseif(indice == 13)
        plot(vx(1,:),vy(1,:),'y+','MarkerFaceColor','y','MarkerSize',5);
    elseif(indice == 14)
        plot(vx(1,:),vy(1,:),'k+','MarkerFaceColor','k','MarkerSize',5);        
    elseif(indice == 15)
        plot(vx(1,:),vy(1,:),'r*','MarkerFaceColor','r','MarkerSize',5);
    elseif(indice == 16)
        plot(vx(1,:),vy(1,:),'g*','MarkerFaceColor','g','MarkerSize',5);
    elseif(indice == 17)
        plot(vx(1,:),vy(1,:),'b*','MarkerFaceColor','b','MarkerSize',5);
    elseif(indice == 18)
        plot(vx(1,:),vy(1,:),'c*','MarkerFaceColor','c','MarkerSize',5);
    elseif(indice == 19)
        plot(vx(1,:),vy(1,:),'m*','MarkerFaceColor','m','MarkerSize',5);
    elseif(indice == 20)
        plot(vx(1,:),vy(1,:),'y*','MarkerFaceColor','y','MarkerSize',5);
    elseif(indice == 21)
        plot(vx(1,:),vy(1,:),'k*','MarkerFaceColor','k','MarkerSize',5);
    elseif(indice == 22)
        plot(vx(1,:),vy(1,:),'r.','MarkerFaceColor','r','MarkerSize',5);
    elseif(indice == 23)
        plot(vx(1,:),vy(1,:),'g.','MarkerFaceColor','g','MarkerSize',5);
    elseif(indice == 24)
        plot(vx(1,:),vy(1,:),'b.','MarkerFaceColor','b','MarkerSize',5);
    elseif(indice == 25)
        plot(vx(1,:),vy(1,:),'c.','MarkerFaceColor','c','MarkerSize',5);
    elseif(indice == 26)
        plot(vx(1,:),vy(1,:),'m.','MarkerFaceColor','m','MarkerSize',5);
    elseif(indice == 28)
        plot(vx(1,:),vy(1,:),'y.','MarkerFaceColor','y','MarkerSize',5);
    elseif(indice == 29)
        plot(vx(1,:),vy(1,:),'k.','MarkerFaceColor','k','MarkerSize',5);        
    elseif(indice == 30)
        plot(vx(1,:),vy(1,:),'rx','MarkerFaceColor','r','MarkerSize',5);
    elseif(indice == 31)
        plot(vx(1,:),vy(1,:),'gx','MarkerFaceColor','g','MarkerSize',5);
    elseif(indice == 32)
        plot(vx(1,:),vy(1,:),'bx','MarkerFaceColor','b','MarkerSize',5);
    elseif(indice == 33)
        plot(vx(1,:),vy(1,:),'cx','MarkerFaceColor','c','MarkerSize',5);
    elseif(indice == 34)
        plot(vx(1,:),vy(1,:),'mx','MarkerFaceColor','m','MarkerSize',5);
    elseif(indice == 35)
        plot(vx(1,:),vy(1,:),'yx','MarkerFaceColor','y','MarkerSize',5);
    elseif(indice == 36)
        plot(vx(1,:),vy(1,:),'kx','MarkerFaceColor','k','MarkerSize',5);     
    elseif(indice == 37)
        plot(vx(1,:),vy(1,:),'r_','MarkerFaceColor','r','MarkerSize',5);
    elseif(indice == 38)
        plot(vx(1,:),vy(1,:),'g_','MarkerFaceColor','g','MarkerSize',5);
    elseif(indice == 39)
        plot(vx(1,:),vy(1,:),'b_','MarkerFaceColor','b','MarkerSize',5);
    elseif(indice == 40)
        plot(vx(1,:),vy(1,:),'c_','MarkerFaceColor','c','MarkerSize',5);
    elseif(indice == 41)
        plot(vx(1,:),vy(1,:),'m_','MarkerFaceColor','m','MarkerSize',5);
    elseif(indice == 42)
        plot(vx(1,:),vy(1,:),'y_','MarkerFaceColor','y','MarkerSize',5);
    elseif(indice == 43)
        plot(vx(1,:),vy(1,:),'k_','MarkerFaceColor','k','MarkerSize',5);        
    end
end

%Practica 3: Pedir al usuario generar n clases con n representantes por clase %
%pedir la ubicación del vector desconocido.
%Ubicación (x,y) del centroide de cada clase%
%Dispersion (x,y) por cada clase%
% Menu interactivo que practica quere selecciona para determinar la distancia.
%
%