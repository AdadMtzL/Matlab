clc %Limpia la pantalla
clear all %limpia todas las variables
close all %cierra todo
warning off all %evita llamadas de atención
%Identificar distinciones entre objetos

%Notas: 
%Nombre de objeto: ob+Numero+NombreImagenConExtensión
%
%variables
imagenes = [""];
%-------Cambiar ruta absoluta
nombre = "C:\Users\Johan\Documents\GitHub\Matlab\Proyecto\Bases Sossa\IMAG";
nombreInicialArchivo = "IMAG";
extension = ".BMP";
numero = "";
totalImagenes = 120;


%Arreglo de caracteristicas
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
writetable(T,'tablaNoIndexada.txt');
%----------Visualizacion de tabla, quitar comentario para desplegar-------------
%type tablaNoIndexada.txt;

