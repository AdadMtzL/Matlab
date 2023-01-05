clc %Limpia la pantalla
clear all %limpia todas las variables
close all %cierra todo
warning off all %evita llamadas de atención
%Identificar distinciones entre objetos

%variables
imagenes = [""];
nombre = "Bases Sossa\IMAG";
extension = ".BMP";
numero = "";

contador = 1;
for i=1:+1:120
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

nombre = input('Dime el nombre del elemento a analizar\n','s');
condicion = false;
while ~condicion
    [primerasCaracteristicas, imagenAvance] = primeraFase(imagenes);
    [caso, circ, area, convex] = segundaFase(imagenes, primerasCaracteristicas, imagenAvance, nombre);
    switch(caso)
        case 1
            disp(strcat(nombre," se identifica con circularidad entre: ",num2str(circ(1)),", ",num2str(circ(2))));
        case 2
            disp(strcat(nombre," se identifica con circularidad entre: ",num2str(circ(1)),", ",num2str(circ(2))," y area entre: ",num2str(area(1)),", ",num2str(area(2))));
        case 3
            disp(strcat(nombre," se identifica con circularidad entre: ",num2str(circ(1)),", ",num2str(circ(2)),", area entre: ",num2str(area(1)),", ",num2str(area(2))," y ConvexArea entre:",num2str(convex(1)),", ",num2str(convex(2))));
        case 4
            disp(strcat(nombre," se identifica con circularidad entre: ",num2str(circ(1)),", ",num2str(circ(2)),", area entre: ",num2str(area(1)),", ",num2str(area(2))," y ConvexArea entre:",num2str(convex(1)),", ",num2str(convex(2))));
    end
    condicion = true;
end
function [resultado, contador] = primeraFase(imagenes)
    condicion = false;
    contador = 1;
    while ~condicion
        imagen = imread(imagenes(contador));
        imagen = imbinarize(imagen);
        figure(1)
        imagen = bwareaopen(imagen,30);
        imagen = imfill(imagen,'holes');
        imshow(imagen);
        stats = regionprops(imagen,"Perimeter","Area","Centroid","BoundingBox","Circularity",'Extrema',"ConvexArea");
        for i =1 : length(stats)
            x = stats(i).BoundingBox;
            rectangle("Position",[x(1),x(2),x(3),x(4)],"EdgeColor","r","LineWidth",2);
            text(stats(i).Centroid(1),stats(i).Centroid(2),num2str(i),"Color","g");
        end
        numero = input('Señale el elemento que desea analizar (solo uno)\n');
        if numero ~= 0
            resultado = stats(numero);
            condicion = true;
        end
        contador = contador + 1;
    end
end
function [caso, circ, area, convex] = segundaFase(imagenes, elemento, imagenAvance, nombre)
    condicion = false;
    contador = 1;
    avance = 15;
    variable = 1;
    caso = 0;
    [circ, area, convex] = rangoElementosInit(elemento);
    numerosUtilizados = [0];
    while ~condicion
        repetido = true;
        while repetido
            rng;
            r = randi([imagenAvance+1 114],1,1);
            if ~ismember(numerosUtilizados, r)
                numerosUtilizados(contador) = r;
                contador = contador + 1;
                repetido = false;
            end
        end
        imagen = imread(imagenes(contador));
        imagen = imbinarize(imagen);
        figure(1)
        imagen = bwareaopen(imagen,30);
        imagen = imfill(imagen,'holes');
        imshow(imagen);
        stats = regionprops(imagen,"Perimeter","Area","Centroid","BoundingBox","Circularity",'Extrema',"ConvexArea");
        valido = "N";
        for i =1 : length(stats)
            x = stats(i).BoundingBox;
            rectangle("Position",[x(1),x(2),x(3),x(4)],"EdgeColor","r","LineWidth",2);
            text(stats(i).Centroid(1),stats(i).Centroid(2),num2str(i),"Color","g");
            if caso == 0 || caso == 1
                if (circ(1) > stats(i).Circularity) && (stats(i).Circularity > circ(2))
                    valido = input(strcat("¿Elemento ",num2str(i)," es ", nombre, "? [Y/N]\n"),'s');
                    if valido == "N"
                        if variable ~= 2
                            caso = 2;
                            variable = 2;
                            break
                        end
                    elseif valido == "Y"
                        caso = 1;
                    end
                end
            end
            if caso == 2
                if ((circ(1) > stats(i).Circularity) && (stats(i).Circularity > circ(2)) && (area(1) > stats(i).Area) && (stats(i).Area > area(2)))
                    valido = input(strcat("¿Elemento ",num2str(i)," es ", nombre, "? [Y/N]\n"),'s');
                    if valido == "N" ||variable == 3
                        if variable ~= 3
                            caso = 3;
                            variable = 3;
                            break
                        end
                    end
                end
            end
            if caso == 3 || caso == 4
                if ((circ(1) > stats(i).Circularity) && (stats(i).Circularity > circ(2)) && (area(1) > stats(i).Area) && (stats(i).Area > area(2)) && (convex(1) > stats(i).ConvexArea) && (stats(i).ConvexArea > convex(2)))
                    valido = input(strcat("¿Elemento ",num2str(i)," es ", nombre, "? [Y/N]\n"),'s');
                    if valido == "N"
                        caso = 4;
                    end
                end
            end       
        end
        
        nuevoValor = input(strcat("¿Algun ",nombre," que no identificamos? (solo uno)\n"));
        
        if nuevoValor ~= 0
            if ~(circ(1) > stats(nuevoValor).Circularity && stats(nuevoValor).Circularity > circ(2))
                if stats(nuevoValor).Circularity > circ(1)
                    circ(1) = stats(nuevoValor).Circularity + .1;
                end
                if stats(nuevoValor).Circularity < circ(2)
                    circ(2) = stats(nuevoValor).Circularity - .1;
                end
            end
            if ~((area(1) > stats(i).Area) && (stats(i).Area > area(2)))
                if stats(nuevoValor).Area > area(1)
                    area(1) = stats(nuevoValor).Area + 100;
                end
                if stats(nuevoValor).Area < area(2)
                    area(2) = stats(nuevoValor).Area - 100;
                end
            end
            if ~((convex(1) > stats(i).ConvexArea) && (stats(i).ConvexArea > convex(2)))
                if stats(nuevoValor).ConvexArea > convex(1)
                    convex(1) = stats(nuevoValor).ConvexArea + 100;
                end
                if stats(nuevoValor).ConvexArea < convex(2)
                    convex(2) = stats(nuevoValor).ConvexArea - 100;
                end
            end
            valido = "N";
        end
        
        if caso~=0 
            if valido == "Y"
                avance = avance - 1;
            end
         end
        
        if avance == 0
            condicion = true;
        end
    end
end
function [circularidad, area, convexArea] = rangoElementosInit(elemento)
    circularidad = [0];
    circularidad(1) = round(elemento.Circularity+.1,2);
    circularidad(2) = round(elemento.Circularity-.1,2);
    area = [0];
    area(1) = round(elemento.Area+100);
    area(2) = round(elemento.Area-100);
    convexArea = [0];
    convexArea(1) = round(elemento.ConvexArea+100);
    convexArea(2) = round(elemento.ConvexArea-100);
end
