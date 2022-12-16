clc 
clear all
close all

%Código principal
%ruta1 = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/Alemania.jpg";
%ruta2 = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/belgica.jpeg";              
%ruta3 = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/colombia.png";                
%ruta4 = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/Holanda.jpeg";                
%ruta5 = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/Italia.jpeg";                
%ruta6 = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/Irlanda.jpeg";          
%ruta7 = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/luxemburgo.jpeg";
%ruta8 = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/qatar.png";

%Opciones();
%bandera = input('Indique la bandera a utilizar  ');
%no_pts=input('Indique la cantidad de puntos a colocar  ');
%umbral = input('Indique el umbral para clasificar los valores   ');

%Rt_band = ObtenerRuta(bandera);
%Image_bandera = imread(Rt_band);
%image(Image_bandera);
%hold on

%[puntos,info] = Generar_puntos(no_pts,bandera);
pts = [0,0;3,8;2,2;1,1;5,3;9,8;6,3;5,4;6,4;7,5];
n=10;
umbral=3;
%grupos = CrearGrupos(puntos,no_pts,umbral);
grupos = CrearGrupos(pts,n,umbral);


%--------------------------------------------------------------------------%
%%Funciones
function grupos_creados = CrearGrupos(puntos, cantidad,umbral)
    grupos =[];
    T = randi([1,10],1,1);
    

    %reestructuración
    j=1;
    for i = 1:1:cantidad
            %distancia = Det_Distancias(puntos(1,i),puntos(2,i),grupos(j))
            if i == 1
                %grupos{1} = [puntos(1,1),puntos(2,1)];
                grupos{j,1} = [puntos(1,1),puntos(1,2)];            
            else
                [grp_pert,distancia] = Det_Distancias(puntos(i,1),puntos(i,2),grupos,j);
                if distancia < umbral
                    longitud=size(grupos{grp_pert});
                    l = longitud(2)+1;
                    %grupos{longitud+1,j} =[puntos(1,i),puntos(2,i)];
                    grupos{grp_pert,l} =[puntos(i,1),puntos(i,2)];
                    longitud=size(grupos{grp_pert});
                    fprintf("Longitud del grupo %d es: %d\n",grp_pert,longitud(2));
                else
                    j = j+1;
                    %grupos{j} = [puntos(1,i),puntos(2,i)];
                    grupos{j,1} = [puntos(i,1),puntos(i,2)];
                end
            end
    end
   
    grupos_creados=grupos;
    %d(xi gj) = sqrt()
    
end

function [grp_pert,dist] = Det_Distancias(puntos_x,puntos_y,grupo,j)
%    med_pts = (puntos_x + puntos_y)/2;
    A=[puntos_x,puntos_y];
    for ind =1:1:j
        grp_ac=[grupo{ind,:},grupo{ind,:}];
        med = mean(grp_ac,2,'omitnan');
        temp = norm(A-med);
        if ind == 1
            dist = temp;
            grp_pert = ind;
        else
            if (temp < dist)
                dist=temp;
                grp_pert = ind;
            end
        end
    end
    
    %fprintf("Coordenada x; %d   Coordenada y: %d Media_grupo: %f  Distancia: %f  J: %d\n",puntos_x,puntos_y,med,dist,j);
end

function [puntos,info] = Generar_puntos(cantidad,value)
            ruta = ObtenerRuta(value);
            Imagen = imread(ruta);
            conv_coord_pix = imref2d(size(Imagen));            
            impixel(Imagen)
            figure(2);
            imshow(Imagen,conv_coord_pix);
            title('Imagen en coordenadas pixelares');
            if(value == 1) 
                %negro
                nx=randi([1,4160],1,cantidad);
                ny=randi([1,830],1,cantidad);                
                %rojo
                rx=randi([1,4160],1,cantidad);
                ry=randi([832,1664],1,cantidad);                
                %amarillo
                ax=randi([1,4160],1,cantidad);
                ay=randi([1665,2496],1,cantidad);
                d1=impixel(Imagen,nx(1,:),ny(1,:));
                d2=impixel(Imagen,rx(1,:),ry(1,:));
                d3=impixel(Imagen,ax(1,:),ay(1,:));
                grid on
                hold on
                plot(nx(1,:),ny(1,:),'ob','LineWidth',1,'MarkerSize',10);
                plot(rx(1,:),ry(1,:),'ok','LineWidth',1,'MarkerSize',10);
                plot(ax(1,:),ay(1,:),'og','LineWidth',1,'MarkerSize',10);
                legend('Negro','Rojo','Amarillo')
                title('GRAFICA DE 3 CLASES DE OBJETOS SOBRE UNA IMAGEN');                
                D=[d1,d2,d3];
                puntos = [nx,rx,ax;ny,ry,ay];
                info = D;
                    
            elseif(value == 2)            
                %negro
                nx=randi([1,1194],1,cantidad);
                ny=randi([1,2500],1,cantidad);                
                %rojo
                rx=randi([1195,2393],1,cantidad);
                ry=randi([1,2500],1,cantidad);                
                %amarillo
                ax=randi([2394,3586],1,cantidad);
                ay=randi([1,2500],1,cantidad);               
                d1=impixel(Imagen,nx(1,:),ny(1,:));
                d2=impixel(Imagen,rx(1,:),ry(1,:));
                d3=impixel(Imagen,ax(1,:),ay(1,:));
                grid on
                hold on
                plot(nx(1,:),ny(1,:),'*b','LineWidth',1,'MarkerSize',10);
                plot(rx(1,:),ry(1,:),'*k','LineWidth',1,'MarkerSize',10);
                plot(ax(1,:),ay(1,:),'*g','LineWidth',1,'MarkerSize',10);
                legend('Negro','Rojo','Amarillo')
                title('GRAFICA DE 3 CLASES DE OBJETOS SOBRE UNA IMAGEN');
                puntos = [nx,rx,ax;ny,ry,ay];
                D = [d1,d2,d3];
                info = D;

            elseif(value == 3)
                %amarillo
                amx=randi([1,766],1,cantidad);
                amy=randi([1,254],1,cantidad);                
                %azul
                ax=randi([1,766],1,cantidad);
                ay=randi([255,383],1,cantidad);                
                %rojo
                rx=randi([1,766],1,cantidad);
                ry=randi([384,511],1,cantidad);
                d1=impixel(Imagen,amx(1,:),amy(1,:));
                d2=impixel(Imagen,ax(1,:),ay(1,:));
                d3=impixel(Imagen,rx(1,:),ry(1,:));
                grid on
                hold on
                plot(amx(1,:),amy(1,:),'+b','LineWidth',1,'MarkerSize',10);
                plot(ax(1,:),ay(1,:),'+k','LineWidth',1,'MarkerSize',10);
                plot(rx(1,:),ry(1,:),'+g','LineWidth',1,'MarkerSize',10);
                legend('Amarillo','Azul','Rojo');
                title('GRAFICA DE 3 CLASES DE OBJETOS SOBRE UNA IMAGEN');
                puntos = [amx,ax,rx;amy,ay,ry];
                D = [d1,d2,d3];   
                info = D;

            elseif(value == 4)
                %rojo
                rx=randi([1,472],1,cantidad);
                ry=randi([1,82],1,cantidad);
                %blanco
                bx=randi([1,472],1,cantidad);
                by=randi([83,166],1,cantidad);
                %azul
                ax=randi([1,472],1,cantidad);
                ay=randi([167,249],1,cantidad);
                d1=impixel(Imagen,rx(1,:),ry(1,:));
                d2=impixel(Imagen,bx(1,:),by(1,:));
                d3=impixel(Imagen,ax(1,:),ay(1,:));
                grid on
                hold on
                plot(rx(1,:),ry(1,:),'ob','LineWidth',1,'MarkerSize',10);
                plot(bx(1,:),by(1,:),'ok','LineWidth',1,'MarkerSize',10);
                plot(ax(1,:),ay(1,:),'og','LineWidth',1,'MarkerSize',10);
                legend('Rojo','Blanco','Azul');
                title('GRAFICA DE 3 CLASES DE OBJETOS SOBRE UNA IMAGEN');
                puntos = [rx,bx,ax;ry,by,ay];
                D = [d1,d2,d3];
                info = D;
                
            elseif(value == 5)
                %verde
                vx=randi([1,1564],1,cantidad);
                vy=randi([1,3320],1,cantidad);
                %blanco
                bx=randi([1565,3336],1,cantidad);
                by=randi([1,3320],1,cantidad);
                %rojo
                rx=randi([3337,4992],1,cantidad);
                ry=randi([1,3320],1,cantidad);
                d1=impixel(Imagen,vx(1,:),vy(1,:));
                d2=impixel(Imagen,bx(1,:),by(1,:));
                d3=impixel(Imagen,rx(1,:),ry(1,:));
                grid on
                hold on
                plot(vx(1,:),vy(1,:),'*b','LineWidth',1,'MarkerSize',10);
                plot(bx(1,:),by(1,:),'*k','LineWidth',1,'MarkerSize',10);
                plot(rx(1,:),ry(1,:),'*g','LineWidth',1,'MarkerSize',10);
                legend('Verde','Blanco','Rojo');
                title('GRAFICA DE 3 CLASES DE OBJETOS SOBRE UNA IMAGEN');
                puntos = [vx,bx,rx;vy,by,ry];
                D = [d1,d2,d3];
                info = D;

            elseif(value == 6)
                %verde
                vx=randi([1,618],1,cantidad);
                vy=randi([1,1235],1,cantidad);
                %blanco
                bx=randi([619,1238],1,cantidad);
                by=randi([1,1235],1,cantidad);
                %naranja
                nx=randi([1239,1853],1,cantidad);
                ny=randi([1,1235],1,cantidad);
                d1=impixel(Imagen,vx(1,:),vy(1,:));
                d2=impixel(Imagen,bx(1,:),by(1,:));
                d3=impixel(Imagen,nx(1,:),ny(1,:));
                grid on
                hold on
                plot(vx(1,:),vy(1,:),'+b','LineWidth',1,'MarkerSize',10);
                plot(bx(1,:),by(1,:),'+k','LineWidth',1,'MarkerSize',10);
                plot(nx(1,:),ny(1,:),'+g','LineWidth',1,'MarkerSize',10);
                legend('Verde','Blanco','Naranja');
                title('GRAFICA DE 3 CLASES DE OBJETOS SOBRE UNA IMAGEN');
                puntos = [vx,bx,nx;vy,by,ny];
                D = [d1,d2,d3];
                info = D;

            elseif(value == 7)
                %rojo
                nx=randi([1,3836],1,cantidad);
                ny=randi([1,796],1,cantidad);
                %blanco
                bx=randi([1,3836],1,cantidad);
                by=randi([797,1596],1,cantidad);
                %azul
                ax=randi([1,3836],1,cantidad);
                ay=randi([1597,2396],1,cantidad);
                d1=impixel(Imagen,nx(1,:),ny(1,:));
                d2=impixel(Imagen,bx(1,:),by(1,:));
                d3=impixel(Imagen,ax(1,:),ay(1,:));
                grid on
                hold on
                plot(nx(1,:),ny(1,:),'ob','LineWidth',1,'MarkerSize',10);
                plot(bx(1,:),by(1,:),'ok','LineWidth',1,'MarkerSize',10);
                plot(ax(1,:),ay(1,:),'og','LineWidth',1,'MarkerSize',10);
                legend('Rojo','Blanco','Azul');
                title('GRAFICA DE 3 CLASES DE OBJETOS SOBRE UNA IMAGEN');
                puntos = [nx,bx,ax;ny,by,ay];
                D = [d1,d2,d3];
                info = D;

            elseif(value == 8)
                %blanco
                bx=randi([1,4160],1,cantidad);
                by=randi([797,1596],1,cantidad);
                %guinda
                gx=randi([1,4160],1,cantidad);
                gy=randi([1597,2396],1,cantidad);
                d1=impixel(Imagen,bx(1,:),by(1,:));
                d2=impixel(Imagen,gx(1,:),gy(1,:));
                grid on
                hold on
                plot(bx(1,:),by(1,:),'+b','LineWidth',1,'MarkerSize',10);
                plot(gx(1,:),gy(1,:),'+k','LineWidth',1,'MarkerSize',10);
                legend('Blanco','Guinda');
                title('GRAFICA DE 3 CLASES DE OBJETOS SOBRE UNA IMAGEN');
                puntos = [bx,gx;by,gy];     
                D = [d1,d2];
                info = D;
            end
            return

        end   

function ruta = ObtenerRuta(valor)
    if valor == 1
    ruta = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/Alemania.jpg";
    elseif valor == 2
    ruta = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/belgica.jpeg";              
    elseif valor == 3
    ruta = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/colombia.png";
    elseif valor == 4
    ruta = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/Holanda.jpeg";
    elseif valor == 5
    ruta = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/Italia.jpeg";
    elseif valor == 6
    ruta = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/Irlanda.jpeg";
    elseif valor == 7
    ruta = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/luxemburgo.jpeg";
    elseif valor == 8        
    ruta = "C:/Users/19286463/Desktop/Escom/semestre actual/pattern/github/Matlab/practicas/Práctica_8/imagenes/qatar.png";
    end
    return
end

function menu = Opciones()
    fprintf("1.-Bandera alemana \n2.- Bandera de Belgica\n3.- Bandera colombiana\n 4.-Bandera Holandesa\n5.-Bandera Italiana\n");
    fprintf("6.-Bandera Irlandesa \n7.- Bandera de Luxemburgo\n8.- Bandera Qatar\n");
    menu = 1;
end