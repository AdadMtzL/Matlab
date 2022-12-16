clc 
clear all
close all
warning off all
%autores
%Martinez Luna Adad Marcel
%Campos Ocampo Johan
%chema
%Fecha: 02/11/22

%código principal
opc = 1;
%variables auxiliares para el ploteo
figuras = ['o' '+' '*' '.' 'x' '_' '|' 's' 'd' '^' 'v' '<' '>' 'p' 'h'];
nf=1;
colores = ['r' 'g' 'b' 'c' 'm' 'y' 'k'];
nc=1;
while (opc~=0)
    opc = menu();
    if opc == 1 %definir vector desconocido
        vector = definir_vector();
        tmp1=vector;
        opc = menu();
    elseif opc == 2 %creacion de clases
        cant_clases = input('Indique la cantidad de clases a crear ');
        elementos_clase = input('Indique los elementos por clase ');
        clases = crear_clases(cant_clases,elementos_clase);
        tmp2 = clases;
        opc = menu();
    elseif opc == 3 %ya funciona, hay que seleccionar 2 veces
        try
            fprintf("%f \n %f",tmp1(1,:),tmp1(2,:));
            opc = menu();
        catch
            fprintf("Error al imprimirlo\n");
            opc = menu();
        end
    elseif opc == 4 %ver clase en especifico
        try
            ncl = input('Indique la clase a ver --------> ');
            temp = [cell2mat(tmp2(1,ncl));cell2mat(tmp2(2,ncl))];
            fprintf("%f , %f \n",temp(1,:),temp(2,:));
            opc = menu();
        catch
            fprintf("Error al imprimir");
            opc = menu();
        end
    elseif opc == 5 %ver clases
        try
            for no = 1:1:cant_clases
                temp = [cell2mat(tmp2(1,no));cell2mat(tmp2(2,no))];
                fprintf("clase %d \n",no);
                fprintf("x: \n");
                fprintf("%f  ",temp(1,:));
                fprintf("\ny: \n");
                fprintf("%f  ",temp(2,:));
                fprintf("\n--------------------------------\n");
            end
            opc = menu();
        catch
            fprintf("No se ha podido acceder a la clase \n");
            opc = menu();
        end
    elseif opc == 6 %distancia euclidiana
        etiquetas_grupo=["vector-desconocido "];
        plot(vector(1,:),vector(2,:),'kh','MarkerFaceColor','g','MarkerSize',15);
        hold on
        grid on
        for elem = 1:1:cant_clases
            clas_ac=[cell2mat(tmp2(1,elem));cell2mat(tmp2(2,elem))];
            media=mean(clas_ac,2);
            distancia_calculada=norm(clas_ac-media);
            if(elem==1)
                distancia_minima=distancia_calculada;
                clase_pert=elem;
            else
                if(distancia_calculada<distancia_minima)
                    distancia_minima=distancia_calculada;
                    clase_pert=elem;
                end
            end
            %ploteo del vector desconocido
            if(nc>7)
                nc=1;
                nf=nf+1;
                figs=[colores(nc) figuras(nf)];
                plot(clas_ac(1,:),clas_ac(2,:),(figs(1,:)),'MarkerFaceColor',(cl(1,:)),'MarkerSize',5);
                nombre=string(" clase-"+elem);
                etiquetas_grupo=etiquetas_grupo.append(nombre);
                nc=nc+1;
            else
                figs=[colores(nc) figuras(nf)];
                cl=[colores(nc)];
                plot(clas_ac(1,:),clas_ac(2,:),(figs(1,:)),'MarkerFaceColor',(cl(1,:)),'MarkerSize',5);
                nombre=string(" clase-"+elem);
                etiquetas_grupo=etiquetas_grupo.append(nombre);
                etiquetas_ind=split(etiquetas_grupo);
                legend(etiquetas_ind);
                nc=nc+1;
            end
        end
        fprintf("El vector pertenece a la clase %d",clase_pert);
        opc = menu();
    elseif opc == 7 %distancia mahalahobis
        etiquetas_grupo=["vector-desconocido "];
        plot(vector(1,:),vector(2,:),'kh','MarkerFaceColor','g','MarkerSize',15);
        hold on
        grid on
        for elem = 1:1:cant_clases
            clas_ac=[cell2mat(tmp2(1,elem));cell2mat(tmp2(2,elem))];
            media=mean(clas_ac,2);
            matriz_covarianza=(clas_ac-media)*transpose((clas_ac-media));
            matriz_covarianza_inversa=inv(matriz_covarianza);
            diferenia_vector_clase=vector-media;
            diferenia_vector_clase_transpuesta=transpose(diferenia_vector_clase);
            distancia_calculada_mahalobis=diferenia_vector_clase_transpuesta*matriz_covarianza_inversa*diferenia_vector_clase;
            if(elem==1)
                distancia_minima=distancia_calculada_mahalobis;
                clase_pert=elem;
            else
                if(distancia_calculada_mahalobis<distancia_minima)
                    distancia_minima=distancia_calculada_mahalobis;
                    clase_pert=elem;
                end
            end
            %ploteo
            if(nc>7)
                nc=1;
                nf=nf+1;
                figs=[colores(nc) figuras(nf)];
                plot(clas_ac(1,:),clas_ac(2,:),(figs(1,:)),'MarkerFaceColor',(cl(1,:)),'MarkerSize',5);
                nombre=string(" clase-"+elem);
                etiquetas_grupo=etiquetas_grupo.append(nombre);
                nc=nc+1;
            else
                figs=[colores(nc) figuras(nf)];
                cl=[colores(nc)];
                plot(clas_ac(1,:),clas_ac(2,:),(figs(1,:)),'MarkerFaceColor',(cl(1,:)),'MarkerSize',5);
                nombre=string(" clase-"+elem);
                etiquetas_grupo=etiquetas_grupo.append(nombre);
                etiquetas_ind=split(etiquetas_grupo);
                legend(etiquetas_ind);
                nc=nc+1;
            end
        end
        fprintf("El vector pertenece a la clase %d",clase_pert);
        opc = menu();
    elseif opc == 8 %Maxima probabilidad
        etiquetas_grupo=["vector-desconocido "];
        plot(vector(1,:),vector(2,:),'kh','MarkerFaceColor','g','MarkerSize',15);
        hold on
        grid on
        sup={1,cant_clases};
        inf={1,cant_clases};
        probabilidades = {1,cant_clases};
        Probas = {1,cant_clases};
        distancias_calculadas_mahalahobis={1,cant_clases};
        sumatoria=0;

        for elem = 1:1:cant_clases
            clas_ac=[cell2mat(tmp2(1,elem));cell2mat(tmp2(2,elem))];
            media=mean(clas_ac,2);
            matriz_covarianza=(clas_ac-media)*transpose((clas_ac-media));
            matriz_covarianza_inversa=inv(matriz_covarianza);
            diferenia_vector_clase=vector-media;
            diferenia_vector_clase_transpuesta=transpose(diferenia_vector_clase);
            
            distancias_calculadas_mahalahobis{elem}=diferenia_vector_clase_transpuesta*matriz_covarianza_inversa*diferenia_vector_clase;
            
            sup{elem}=exp(-0.5*(distancias_calculadas_mahalahobis{elem}));
            inf{elem}=(2*pi)*det(matriz_covarianza)^(0.5);

            probabilidades{elem}=sup{elem}/inf{elem};

        end

        for elem = 1:1:cant_clases
            sumatoria = sumatoria+probabilidades{elem};
        end
        
        for elem = 1:1:cant_clases
            Probas{elem}=(probabilidades{elem}/sumatoria);
        end
        
        probas=cell2mat(Probas)
        Max_prob=max(max(probas));
        for ind =1:1:cant_clases
            if Max_prob==probas(ind)
                clase_pert=ind;
            end
        end

        fprintf("El vector tiene un %f de probabilidad de pertenecer a la clase %d",Max_prob,clase_pert);

        for elem = 1:1:cant_clases
            
            clas_ac=[cell2mat(tmp2(1,elem));cell2mat(tmp2(2,elem))];
            %ploteo
            if(nc>7)
                nc=1;
                nf=nf+1;
                figs=[colores(nc) figuras(nf)];
                plot(clas_ac(1,:),clas_ac(2,:),(figs(1,:)),'MarkerFaceColor',(cl(1,:)),'MarkerSize',5);
                nombre=string(" clase-"+elem);
                etiquetas_grupo=etiquetas_grupo.append(nombre);
                nc=nc+1;
            else
                figs=[colores(nc) figuras(nf)];
                cl=[colores(nc)];
                plot(clas_ac(1,:),clas_ac(2,:),(figs(1,:)),'MarkerFaceColor',(cl(1,:)),'MarkerSize',5);
                nombre=string(" clase-"+elem);
                etiquetas_grupo=etiquetas_grupo.append(nombre);
                etiquetas_ind=split(etiquetas_grupo);
                legend(etiquetas_ind);
                nc=nc+1;
            end
        end
        opc = menu();
    elseif opc == 0
        fprintf("Hasta luego\n");
        break
    elseif opc > 8 || opc<0 
        opc = menu();
    end
end
%funciones, deben de ir abajo del código principal

%Memu de opciones
function m = menu()
    fprintf("\nBienvenido a la práctica 4 de pattern recognition \n");
    fprintf("Las operaciones disponibles son las siguientes: \n");
    fprintf("0.- salir\n1.- Definir el vector desconocido\n2.-Definir clases\n");
    fprintf("3.- ver el vector a clasificar\n4.-Ver clase\n5.-Ver las clases\n");
    fprintf("6.-Distancia euclidiana\n7.- Distancia mahalahobis\n8.-maxima probabilidad\n-------------------------\n");
    m = input('Indique otra operación a realizar  ----->  ');
end

%Función que crea las calses en un cell array
function clases = crear_clases(cant_clases,elementos_clase)
    dispersiones = obt_disps(cant_clases);
    centroides = obt_cent(cant_clases);

    clase_x = {1,cant_clases};
    clase_y = {1,cant_clases};
    disp_array=cell2mat(dispersiones);
    cent_array=cell2mat(centroides);
    for i = 1:1:cant_clases
        dx = disp_array(1,i);
        dy = disp_array(2,i);
        cx = cent_array(1,i);
        cy = cent_array(2,i);
        vx=[(randn(1,elementos_clase)+cx)*dx];
        vy=[(randn(1,elementos_clase)+cy)*dy];
        clase_x{i}=vx;
        clase_y{i}=vy;
    end
    clases = [clase_x;clase_y]; 
    % se retorna como cell array, para que sea más facil su impresion con
    % el formato temp = [cell2mat(clase(1,i));cell2array(clase(1,i))]
    % donde i es el número de clase
    return
end

%Función que permite definir las ccordenadas del vector desconocido
function vector = definir_vector()
    fprintf("Definición del vector desconocido \n");
    desconocido_x=input('Indique la coordenada x del vector desconocido\n');
    desconocido_y=input('Indique la coordenada y del vector desconocido\n');
    vector=[desconocido_x ; desconocido_y];
    return
end

%Función que permite definir las dispersiones de las clases
function dispersiones = obt_disps(cant_clases)
    fprintf("Definición de las dispersiones de clase \n");
    dispx = {1,cant_clases};
    dispy = {1,cant_clases};
    for i = 1:1:cant_clases
        fprintf("clase %d \n",i);
        dispx{i}=input('Indique la dispersion en el eje x \n');
        dispy{i}=input('Indique la dispersion en el eje y \n');
        fprintf("_____________________________________________\n");
    end
    dispersiones=[dispx;dispy];
    return
end

%Función que permite definir los centroides de las clases
function centroides = obt_cent(cant_clases)
    fprintf('Definición de los centroides de las clases \n');
    cent_x = {1,cant_clases};
   cent_y = {1,cant_clases};
    for i = 1:1:cant_clases
        fprintf("clase %d \n",i);
        cent_x{i}=input('Indique el centroide en el eje x \n');
        cent_y{i}=input('Indique el centroide en el eje y \n');
        fprintf("_____________________________________________\n");
    end
    centroides=[cent_x;cent_y];
    return
end