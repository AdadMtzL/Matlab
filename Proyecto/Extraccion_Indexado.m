clc %Limpia la pantalla
clear all %limpia todas las variables
close all %cierra todo
warning off all %evita llamadas de atención
%Identificar distinciones entre objetos

%Notas: 
%Nombre de objeto: ob+Numero+NombreImagenConExtensión
%
%constantes
%-------Cambiar ruta absoluta
try %rutas johan
    %nombre = "C:\Users\Johan\Documents\GitHub\Matlab\Proyecto\Bases Sossa\IMAG";
    nombre = "C:\Users\19286463\Desktop\Escom\semestre actual\pattern\github\Matlab\Proyecto\Bases Sossa\IMAG";
    %nombre = "C:\Users\Johan\Documents\GitHub\Matlab\Proyecto\Bases Sossa\IMAG";
catch except
    print(except)
end
nombreInicialArchivo = "IMAG";
extension = ".BMP";
totalImagenes = 120;
info = extract_car(nombreInicialArchivo,extension,totalImagenes,nombre);
[clase,x,y,z] = crear_clases(info);


%A = [1,4,7,8;4,2,3,5];
%mean(A,2)


%%Funciones--------------------------------------------------------------------%%
%---------Funcuión para la extracción de la información-------%
function info = extract_car(nombreInicialArchivo,extension,totalImagenes,nombre)
    %Arreglo de caracteristicas
    numero = "";
    imagenes = [""];
    nombreObjeto = [""];
    perimetro = [];
    area = [];
    circularidad = [];
    convexArea = [];
    %Lectura de las imagenes
    contador = 1;
    for i=1:+1:totalImagenes
        %Este if es porque los los archivos del 99 al 104 no existen.
        if ~(i<105 && i>98)
            if i<10
                numero = "00";
            elseif i<100
                numero = "0";
            else
                numero = "";
            end
            texto = strcat(nombre,numero,num2str(i),extension);
            imagenes(contador) = texto;
            contador = contador + 1;
        end
    end
    
    %Guardamos cada caracteristica en un arreglo con nombre y numero de objeto
    objetosGuardados = 0;
    for i = 1: +1:contador-1
        if i<10
            numero = "00";
        elseif i<99
            numero = "0";
        else
            numero = "";
        end
        imagen = imread(imagenes(i));
        if i>98 
            i = i+6; 
        end
        imagen = imbinarize(imagen);
        imagen = bwareaopen(imagen,30);
        imagen = imfill(imagen,'holes');
        stats = regionprops(imagen,"Perimeter","Area","Centroid","Circularity","ConvexArea");
        for j =1 : length(stats)
            nombre = "obj";
            objetosGuardados = objetosGuardados + 1;
            nombre = strcat(nombre,num2str(j),nombreInicialArchivo,numero,num2str(i),extension);
            nombreObjeto(objetosGuardados,1) = nombre;
            perimetro(objetosGuardados,1) = stats(j).Perimeter;
            area(objetosGuardados,1) = stats(j).Area;
            circularidad(objetosGuardados,1) = stats(j).Circularity;
            convexArea(objetosGuardados,1) = stats(j).ConvexArea;
        end
        if i>98 
            i = i-6; 
        end
    end
    %Escritura de los valores en tabla (Solo para muestra, no es necesaria la extraccion de los datos)
    T = table(nombreObjeto,perimetro,area,circularidad,convexArea);
    
    %Detección de la existencia de un conjunto de datos previo
    try 
        delete("tablaNoIndexada.xlsx");
    catch   exception
        
    end
    writetable(T,'tablaNoIndexada.xlsx',"AutoFitWidth",true);
    %----------Visualizacion de tabla, quitar comentario para desplegar-------------
    %Area de datos B2:E686
    %B1 -> Perimtetro
    %C1 -> Area
    %D1 -> Circularidad
    %E1 -> ConvexArea
    %type tablaNoIndexada.xlsx;
    
    %formas de obtener la info
    %info = readmatrix('tablaNoIndexada.xlsx','Range','B2:E686');
    info = [perimetro,area,circularidad,convexArea];
    return
end

%---------Función para la creación de clases------%
function [clase,x,y,z] = crear_clases(info)

    clase_x = {1,5};
    clase_y = {1,5};
    clase_z = {1,5};
    
    %creacion de clases
    contador_obj = 1;
    no_ind = 1;
    repeticiones = 1;
    while repeticiones ~= 6
        for cont = contador_obj:1:contador_obj+14
            vx{no_ind} = info(cont,2);
            no_ind = no_ind+1;
        end
        no_ind = 1;
        for cont = contador_obj:1:contador_obj+14
            vy{no_ind} = info(cont,3);
            no_ind = no_ind+1;
        end
        no_ind = 1;
        for cont = contador_obj:1:contador_obj+14
            vz{no_ind} = info(cont,4);
            no_ind = no_ind+1;
        end
        no_ind = 1;
        clase_x{repeticiones}=vx;
        clase_y{repeticiones}=vy;
        clase_z{repeticiones}=vz;
        contador_obj = contador_obj+15;
        repeticiones = repeticiones +1;
    end
    
    x= clase_x;;
    y = clase_y;
    z= clase_z;
    cls = cell(5,3);
    for ind = 1:1:5
        conv_x = cell2mat(x{ind});
        conv_y = cell2mat(y{ind});
        conv_z = cell2mat(z{ind});
        cls{ind,1}=conv_x;
        cls{ind,2}=conv_y;
        cls{ind,3}=conv_z;
    end
    clase= cls;
    return
end

%----------Funcion para metodo probabilístico-----%
function probabilidad_clase = prob(clases,info)
%nota importante, para entrenamiento(clases de objetos) tenemos 15 de cada
%clase (sumatoria de 1 a 5), por ende los objetos on los 1 a 15
%clase 1 1-15
%clase 2 16-30
%clase 3 31-45
%clase 4 46-60
%clase 5 61-75
%Estructura info cruda: perimetro,area,circularidad,convexarea
% se retorna como cell array, para que sea más facil su impresion con
% el formato temp = [cell2mat(clase(1,i));cell2mat(clase(1,i));cell2mat(clase(1,i))]
%clasificación
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



end
    temp = [cell2mat(clase(1,1));cell2mat(clase(2,1));cell2mat(clase(3,1))];
    mean_x = mean(temp(1,:));
    mean_y = mean(temp(2,:));
    mean_z = mean(temp(3,:));
    media = [mean_x;mean_y;mean_z]


%----------Función para perceptron----------------%
function Euclidean = ecd()
    %d = sqrt((xi-xd)^2 + (yi - yd)^2 + (zi - yd)^2)
    %xi,yi,zi media clase -> mean(clase(dim,:))
    %mean_x = mean(temp(1,:))
    %mean_y = mean(temp(2,:))
    %mean_z = mean(temp(3,:))
    %media = [mean_x;mean_y;mean_z];
    dist_calc =100000000;
    cls_pert = 0;
    for ind = 1:1:5
        temp = [cell2mat(clase(1,1));cell2mat(clase(2,1));cell2mat(clase(3,1))];
        mean_x = mean(temp(1,:));
        mean_y = mean(temp(2,:));
        mean_z = mean(temp(3,:));
%        media = [mean_x;mean_y;mean_z]
        dist_calc = sqrt(pow2(mean_x - X_desc)+pow2(mean_y - Y_desc)+pow2(mean_z - Z_desc));
        if dist_calc > dist_temp
            dist_calc = dist_temp;
            cls_pert = ind;
        end
    end
    

end


