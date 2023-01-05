clc %Limpia la pantalla
clear all %limpia todas las variables
close all %cierra todo
warning off all %evita llamadas de atención
%Parte 1,2.- características del objeto

%variables
LlaveAllen = 0;
Arandela = 0;
Tuerca = 0;
Armella = 0;
ColaDePato = 0;

imagen = imread("Bases Sossa\IMAG067.BMP");
figure(1)
imshow(imagen);
imagen = imbinarize(imagen);
figure(2)
imagen = bwareaopen(imagen,30);
imagen = imfill(imagen,'holes');
imshow(imagen);
stats = regionprops(imagen,"Perimeter","Area","Centroid","BoundingBox","Circularity","ConvexArea");
hold on
for i =1 : length(stats)
    x = stats(i).BoundingBox;
    rectangle("Position",[x(1),x(2),x(3),x(4)],"EdgeColor","r","LineWidth",2);
    text(stats(i).Centroid(1),stats(i).Centroid(2),num2str(i),"Color","g");
    valor = buscarElemento(stats(i).Circularity,stats(i).Area,stats(i).ConvexArea);
    if valor == "LlaveAllen"
        LlaveAllen = LlaveAllen +1;
    elseif valor == "Arandela"
        Arandela = Arandela +1;
    elseif valor == "Armella"
        Armella = Armella + 1;
    elseif valor == "ColaDePato"
        ColaDePato = ColaDePato + 1 ;
    elseif valor == "Tuerca"
        Tuerca = Tuerca + 1 ;
    end
end

function resultado = buscarElemento(circularidad,area,convexArea)
            resultado = "no";
            if circularidad >.9
                resultado = "Arandela";
            elseif circularidad<.45 && area > 450 && convexArea<1400
                resultado = "Armella";
            elseif area>1000
                resultado = "ColaDePato";
            elseif circularidad<.45 && circularidad>.14 && area < 450
                resultado = "Tuerca";
            elseif circularidad<.2 && area < 500 && convexArea>1310
                resultado = "LlaveAllen";
            end
        end