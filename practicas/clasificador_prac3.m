clc 
clear all
close all
warning off all
%generador de m clases con n elementos
no_clases=input('Indique la cantidad de clases \n');
elementos_clase=input('Indique la cantidad de elementos por clase \n');

%obtención del vector desconocido
desconocido_x=input('Indique la coordenada x del vector desconocido\n');
desconocido_y=input('Indique la coordenada y del vector desconocido\n');
vector=[desconocido_x ; desconocido_y];

%ploteo del vector desconocido
etiquetas_grupo=["vector-desconocido "];
plot(vector(1,:),vector(2,:),'kh','MarkerFaceColor','g','MarkerSize',15);
hold on
grid on
 
%variables auxiliares para el ploteo
figuras = ['o' '+' '*' '.' 'x' '_' '|' 's' 'd' '^' 'v' '<' '>' 'p' 'h'];
nf=1;
colores = ['r' 'g' 'b' 'c' 'm' 'y' 'k'];
nc=1;

%Determinación de la distancia por el usuario
tipo_distancia=0;
while (tipo_distancia >2 || tipo_distancia <1)
    tipo_distancia=input('Indique la distancia a calcular, 1.-Euclidiana, 2.-Mahalobis \n');
end

%generación de las clases aleatorias y su ploteo
for indice=1:1:no_clases
    fprintf("clase %d\n",indice);
    %obtención del centroide
    cenx=input('Indique la coordenada x del centroide de la clase \n');
    ceny=input('Indique la coordenada y del centroide de la clase \n');
    %obtención de las dispersion de la clase
    disp_x=input('Indique la dispersion en el eje x \n');
    disp_y=input('Indique la dispersion en el eje y \n');
    %generación de las clases
    clase_x=(randn(1,elementos_clase)+cenx)*disp_x;
    clase_y=(randn(1,elementos_clase)+ceny)*disp_y;
    clase=[clase_x;clase_y];
    %Calculo de distancias
    if(tipo_distancia == 1)
        %distancia euclidiana
        media=mean(clase,2);
        distancia_calculada=norm(vector-media);
        %Almacenamiento de la distancia minima y clase
        if(indice==1)
            distancia_minima=distancia_calculada;
            clase_pert=indice;
        else
            if(distancia_calculada<distancia_minima)
                distancia_minima=distancia_calculada;
                clase_pert=indice;
            end
        end
    else
        %distancia mahalobis
        media=mean(clase,2);
        matriz_covarianza=(clase-media)*transpose((clase-media));
        matriz_covarianza_inversa=inv(matriz_covarianza);
        diferenia_vector_clase=vector-media;
        diferenia_vector_clase_transpuesta=transpose(diferenia_vector_clase);
        distancia_calculada_mahalobis=diferenia_vector_clase_transpuesta*matriz_covarianza_inversa*diferenia_vector_clase;
        %Almacenamiento de la distancia minima y clase
        if(indice==1)
            distancia_minima=distancia_calculada_mahalobis;
            clase_pert=indice;
        else
            if(distancia_calculada_mahalobis<distancia_minima)
                distancia_minima=distancia_calculada_mahalobis;
                clase_pert=indice;
            end
        end
    end

    %sección que plotea de manera diferente cada clase
    %El limite de clases es 120 para que no genere un fallo al plotear
    if(nc>7)
        nc=1;
        nf=nf+1;
    else
        figs=[colores(nc) figuras(nf)];
        cl=[colores(nc)];
        plot(clase_x(1,:),clase_y(1,:),(figs(1,:)),'MarkerFaceColor',(cl(1,:)),'MarkerSize',5);
        nombre=string(" clase-"+indice);
        etiquetas_grupo=etiquetas_grupo.append(nombre);
        etiquetas_ind=split(etiquetas_grupo);
        legend(etiquetas_ind);
        nc=nc+1;
    end
end
fprintf("El vector pertenece a la clase %d\n",clase_pert);

%Practica 3: Pedir al usuario generar n clases con n representantes por clase %
%pedir la ubicación del vector desconocido.
%Ubicación (x,y) del centroide de cada clase%
%Dispersion (x,y) por cada clase%
% Menu interactivo que practica quere selecciona para determinar la distancia.
%
%