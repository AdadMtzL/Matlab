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
nombre = "C:\Users\Johan\Documents\GitHub\Matlab\Proyecto\Bases Sossa\IMAG";
extension = ".BMP";
numero = "";
totalImagenes = 120;


%Arreglo de caracteristicas
nombreObjeto = [];
perimetro = [];
area = [];
centroide = [];
circularidad = [];
convexArea = [];

%Lectura de las imagenes
contador = 1;
for i=1:+1:totalImagenes
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

for j = 1: +1:totalImagenes
nombre = "obj";
imagen = imread(imagenes(j));
imagen = imbinarize(imagen);
imagen = bwareaopen(imagen,30);
stats = regionprops(imagen,"Perimeter","Area","Centroid","Circularity",'Extrema',"ConvexArea");
    for i =1 : length(stats)
        
    end
end
