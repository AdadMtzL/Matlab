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

res = 1700;

nombreInicialArchivo = "IMG";
extension = ".bmp";
totalImagenes = 55  ;
fprintf("Generacion no indexada \n");
info = extract_car(nombreInicialArchivo,extension,totalImagenes,nombre,res);
fprintf("Creacion de clases \n");
[clase,x,y,z] = crear_clases(info);
fprintf("Generacion de la indexada \n");
index_info = inx(clase);
ruta_contenedora = [];
rutas_validas =1;
clase_buscada = opc();
for ind = 1:1:55
    if ind < 10
        texto = "C:\Users\19286463\Desktop\Escom\semestre actual\pattern\github\Matlab\Proyecto\Imagenes\IMG00";
        ruta_imagen = strcat(texto,int2str(ind),".bmp");
    else
        texto = "C:\Users\19286463\Desktop\Escom\semestre actual\pattern\github\Matlab\Proyecto\Imagenes\IMG0";
        ruta_imagen = strcat(texto,int2str(ind),".bmp");
    end
    val = ecd(clase,ruta_imagen,clase_buscada,res);
    if val == 1
       ruta_contenedora{rutas_validas} = ruta_imagen;
       rutas_validas = rutas_validas + 1;
    end
    continuar = input('¿Siguiente imagen?  ');
end
for img =1:1:length(ruta_contenedora) 
        imshow(ruta_contenedora{img});
        continuar = input('¿Siguiente imagen?  ');
end


%%Funciones--------------------------------------------------------------------%%
%---------Funcuión para la extracción de la información-------%
function info = extract_car(nombreInicialArchivo,extension,totalImagenes,nombre,res)
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
        imagen = imresize(imagen,[res,res]);
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

    clase_x = {1,15};
    clase_y = {1,15};
    clase_z = {1,15};
    
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
    rep_2 = 6;
    while rep_2 ~= 16
        for cont = contador_obj:1:contador_obj+9
            vx{no_ind} = info(cont,2);
            no_ind = no_ind+1;
        end
        no_ind = 1;
        for cont = contador_obj:1:contador_obj+9
            vy{no_ind} = info(cont,3);
            no_ind = no_ind+1;
        end
        no_ind = 1;
        for cont = contador_obj:1:contador_obj+9
            vz{no_ind} = info(cont,4);
            no_ind = no_ind+1;
        end
        no_ind = 1;
        clase_x{rep_2}=vx;
        clase_y{rep_2}=vy;
        clase_z{rep_2}=vz;
        contador_obj = contador_obj+9;
        rep_2 = rep_2 +1;
    end
    x= clase_x;
    y = clase_y;
    z= clase_z;
    cls = cell(15,3);
    for ind = 1:1:15
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

%----------Función para euclidiana----------------%
function Euclidean = ecd(clase,ruta_imagen,clase_buscada,res)
    cls_pert =[];
    objetosGuardados = 0;
    imagen = imread(ruta_imagen);
    imagen = im2gray(imagen);
    imagen = imresize(imagen,[res,res]);
    imagen = imbinarize(imagen);
    imagen = bwareaopen(imagen,30);
    imagen = imfill(imagen,'holes');
    %imshow(imagen);
    stats = regionprops(imagen,"Area","Centroid","Circularity","ConvexArea");

    datos = split(ruta_imagen,'\');
    nombre = split(datos(length(datos)),'.');
    nombreInicialArchivo = nombre(1);
    extension = nombre(2);
    numero = "";
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
        cls_pert(j) = det_clase(clase,X_desc,Y_desc,Z_desc);
        try
            imagen = imread(ruta_imagen);
            imagen = im2gray(imagen);
            imagen = imresize(imagen,[res,res]);
            imshow(imagen)
            cls_pert(j)
            if cls_pert(j) ==  clase_buscada
               Euclidean =1;
            else
               Euclidean =0;
            end
        catch exception
            
        end
    end
end

%Funcion de apoyo
function cls_pert = det_clase(clase,X,Y,Z)
    for ind =1:1:15
        temp = [cell2mat(clase(ind,1));cell2mat(clase(ind,2));cell2mat(clase(ind,3))];
        mean_x = mean(temp(1,:));
        mean_y = mean(temp(2,:));
        mean_z = mean(temp(3,:));
        Difx=mean_x - X;
        Dify=mean_y - Y;
        Difz=mean_z - Z;
        pdifx=Difx*Difx;
        pdify=Dify*Dify;
        pdifz=Difz*Difz;
        dist_calc = sqrt(pdifx+pdify+pdifz);
        if ind ==1
            dist_min = dist_calc;
            cls = ind;
        else
            if (dist_calc<dist_min)
                dist_min=dist_calc;
                cls = ind;
            end
        end
    end
    %cls
    cls_pert = cls;
end

%---------Función para obtener la base indexada cambiar---%
function Datos_indexados = inx(clase)
    try 
        delete("tablaIndexada.xlsx");
    catch   exception
        
    end
    Data_carac = cell(15,4);
    Data_carac{1,1} = "Nombre";
    Data_carac{1,2} = "Area";
    Data_carac{1,3} = "Circularidad";
    Data_carac{1,4} = "Area convexa";
    nombre = ["Rondana","Tornillo","Alcayata","Armella","Cola de pato","Rondana y tornillo","Rondana y alcayata","Rondana y cola de pato", "Rondana y Armella","Tornillo y alcayata","Tornillo y armella","Tornillo y cola de pato","Alcayata y armella","Alcayata y cola de pato","Armella y cola de pato"];
    for no_clase = 1:1:15
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

function menu =opc()
    nombre = ["Rondana","Tornillo","Alcayata","Armella","Cola de pato","Rondana y tornillo","Rondana y alcayata","Rondana y cola de pato", "Rondana y Armella","Tornillo y alcayata","Tornillo y armella","Tornillo y cola de pato","Alcayata y armella","Alcayata y cola de pato","Armella y cola de pato"];
    fprintf("Indique la clase para buscar imagenes \n");
    for nombre_clase =1:1:length(nombre)
        texto = strcat(int2str(nombre_clase),".- ",nombre(nombre_clase));
        fprintf(texto+"\n");
    end
    menu = input('Que clase desea buscar   ');
end
