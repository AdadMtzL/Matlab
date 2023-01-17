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
usuario = input("Indique quien esta haciendo uso del software en este monento \n1.-Johan\n2.-Adad\n3.-Chema\n");
if usuario ==1
    nombre = "C:\Users\Johan\Documents\GitHub\Matlab\Proyecto\Bases Sossa\IMAG";
elseif usuario ==2
    nombre = "C:\Users\19286463\Desktop\Escom\semestre actual\pattern\github\Matlab\Proyecto\Imagenes\IMG";
elseif usuario ==3
    %nombre = "C:\Users\Johan\Documents\GitHub\Matlab\Proyecto\Bases Sossa\IMAG";
end
%nombreInicialArchivo = "IMAG";
nombreInicialArchivo = "IMG";
extension = ".bmp";
totalImagenes = 60;
fprintf("Generacion no indexada \n");
info = extract_car(nombreInicialArchivo,extension,totalImagenes,nombre);
fprintf("Creacion de clases \n");
[clase,x,y,z] = crear_clases(info);
fprintf("Generacion de la indexada \n");
index_info = inx(clase);
%ruta_imagen = "C:\Users\19286463\Desktop\Escom\semestre actual\pattern\github\Matlab\Proyecto\Bases Sossa\IMAG115.bmp";
%ruta_imagen = "C:\Users\19286463\Desktop\Escom\semestre actual\pattern\github\Matlab\Proyecto\Imagenes\IMG036.bmp";
%ecd(clase,ruta_imagen);
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
    for i = 1:1:contador-1
        if i<10
            numero = "00";
        elseif i<99
            numero = "0";
        else
            numero = "";
        end
        imagen = imread(imagenes(i));
        imagen = im2gray(imagen);
        imagen = imbinarize(imagen);
        imagen = bwareaopen(imagen,30);
        imagen = imfill(imagen,'holes');
        stats = regionprops(imagen,"Perimeter","Area","Centroid","Circularity","ConvexArea");
        for j =1 :1: length(stats)
            nombre = "obj";
            objetosGuardados = objetosGuardados + 1;
            nombre = strcat(nombre,num2str(j),nombreInicialArchivo,numero,num2str(i),extension);
            nombreObjeto(objetosGuardados,1) = nombre;
            perimetro(objetosGuardados,1) = stats(j).Perimeter;
            area(objetosGuardados,1) = stats(j).Area;
            circularidad(objetosGuardados,1) = stats(j).Circularity;
            convexArea(objetosGuardados,1) = stats(j).ConvexArea;
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
        contador_obj = contador_obj+14;
        repeticiones = repeticiones +1;
    end
    
    x= clase_x;
    y = clase_y;
    z= clase_z;
    cls = cell(5,3);
    for ind = 1:1:4
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

    

%----------Función para euclidiana----------------%
function Euclidean = ecd(clase,ruta_imagen)
    cls_pert = 0;
    objetosGuardados = 0;
    imagen = imread(ruta_imagen);
    imagen = imbinarize(imagen);
    imagen = bwareaopen(imagen,30);
    imagen = imfill(imagen,'holes');
    imshow(imagen);
    stats = regionprops(imagen,"Area","Centroid","Circularity","ConvexArea");

    datos = split(ruta_imagen,'\');
    nombre = split(datos(length(datos)),'.');
    nombreInicialArchivo = nombre(1);
    extension = nombre(2);
    numero = "";
    %length(stats)
    for j = 1:1:length(stats)
        nombre = "obj";
        objetosGuardados = objetosGuardados + 1;
        nombre = strcat(nombre,num2str(j),nombreInicialArchivo,numero,extension);
        nombreObjeto(objetosGuardados,1) = nombre;
        area(objetosGuardados,1) = stats(j).Area;
        circularidad(objetosGuardados,1) = stats(j).Circularity;
        convexArea(objetosGuardados,1) = stats(j).ConvexArea;
        X_desc = stats(j).Area;
        Y_desc = stats(j).Circularity;
        Z_desc = stats(j).ConvexArea;
        for ind = 1:1:5
            temp = [cell2mat(clase(ind,1));cell2mat(clase(ind,2));cell2mat(clase(ind,3))];
            mean_x = mean(temp(1,:));
            mean_y = mean(temp(2,:));
            mean_z = mean(temp(3,:));
            Difx=mean_x - X_desc;
            Dify=mean_y - Y_desc;
            Difz=mean_z - Z_desc;
            pdifx=Difx*Difx;
            pdify=Dify*Dify;
            pdifz=Difz*Difz;
            dist_calc = sqrt(pdifx+pdify+pdifz);
            if (ind ==1)
                dist_min = dist_calc;
                cls_pert = ind;
            else
                if(dist_calc<dist_min)
                    dist_min=dist_calc;
                    cls_pert = ind;
                end
            end
        end
        if cls_pert == 1
            nombre_clase = "Rondana";
        elseif cls_pert == 2
            nombre_clase = "Tornilllo";
        elseif cls_pert == 3
            nombre_clase = "Alcayata";
        elseif cls_pert == 4
            nombre_clase = "Armella";
        elseif cls_pert == 5
            nombre_clase = "Cola de pato";
        end
        try
            fprintf("El objeto "+nombreObjeto(j,1));
            fprintf(" tiene una distancia de "+dist_calc);
            texto = strcat(" y pertenece a la clase ",nombre_clase);
            fprintf(texto);
            fprintf("\n");
            stats_1 = regionprops(imagen,"Perimeter","Area","Centroid","BoundingBox","Circularity",'Extrema',"ConvexArea");
            for i =1:1:length(stats)
                ttmmp = stats_1(i).BoundingBox;
                rectangle("Position",[ttmmp(1),ttmmp(2),ttmmp(3),ttmmp(4)],"EdgeColor","r","LineWidth",2);
                text(stats(i).Centroid(1),stats(i).Centroid(2),strcat(num2str(i)),"Color","g");
            end
        catch exception
            
        end
    end
end


%---------Función para obtener la base indexada cambiar a 5 en le for---%
function Datos_indexados = inx(clase)
    try 
        delete("tablaIndexada.xlsx");
    catch   exception
        
    end
    Data_carac = cell(5,4);
    Data_carac{1,1} = "Nombre";
    Data_carac{1,2} = "Area";
    Data_carac{1,3} = "Circularidad";
    Data_carac{1,4} = "Area convexa";
    nombre = ["Rondana","Tornillo","Alcayata","Armella","Cola de pato"];
    %for no_clase = 1:1:5
    for no_clase = 1:1:4
        temp = [cell2mat(clase(no_clase,1));cell2mat(clase(no_clase,2));cell2mat(clase(no_clase,3))];
        Area = mean(temp(1,:));
        Circularidad = mean(temp(2,:));
        ConvexArea = mean(temp(3,:));
        nombre_cls = nombre(no_clase);
        Data_carac{no_clase+1,1} = nombre_cls;
        Data_carac{no_clase+1,2} = Area;
        Data_carac{no_clase+1,3} = Circularidad;
        Data_carac{no_clase+1,4} = ConvexArea;
    end
    %Data_carac
    Datos_indexados = Data_carac;
    Datos_indexados_tabla = table(Data_carac);
    %Datos_indexados
    %Esta escribiendo Data_Carac_1,Data_Carac_2,Data_Carac_3,Data_Carac_4
    %no se como corregirlo
    writetable(Datos_indexados_tabla,'tablaIndexada.xlsx',"AutoFitWidth",true);
end
