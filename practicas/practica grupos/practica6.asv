clc %Limpia la pantalla
clear all %limpia todas las variables
close all %cierra todo
warning off all %evita llamadas de atención
%Hacer grupos relacionando distancias
%Paso previo: pedir n, n puntos xy
%Primer paso: "Ubicar los puntos en una grafica cuadriculada"
%Segundo paso: "Hacer una tabla donde las filas y columnas sean los numeros
%de los puntos"
%Tercer paso: "Llenar la tabla calculando la distancia más corta entre los
%puntos de cada celda"
%Cuarto paso: "Buscar el primer grupo que tenga menor distancia entre algun
%punto, juntar y hacer nuevo punto de nombre n+1"
%Quinto paso: repetir los pasos del 2 al 4 quitando los puntos en grupo y
%agregando el nuevo punto
%Notas:


%variables
n = 0;
x = 0;
y = 0;
puntos = [0];
minimo = 1;

grupos = [0];
%Paso previo
n = input("Digite la cantidad de puntos");
cantidadPuntos = n;
for i = 1 : n
    x = input("Valor en x del punto "+i);
    y = input("Valor en y del punto "+i);
    puntos(i) = [x,y,i]; 
end

%Paso 1: no necesario hacer
%Paso 5
contador = 1;
puntosAux = puntos;
while cantidadPuntos ~= 1
    minimo = 1;
    puntoMinimo1 = 0;
    puntoMinimo2 = 0;
    %Paso 2: no es necesario hacer, solo requerimos la operación y el valor
    %resultante
    %Paso 3
    for i = 1 : cantidadPuntos
        puntoColumna = puntosAux(i);
        for j = 1 : cantidadPuntos
            puntoFila = puntosAux(j);
            distanciaX = puntoColumna(1)-puntoFila(1);
            distanciaY = puntoColumna(2)-puntoFila(2);
            if distanciaX < 0
                distanciaX = distanciaX * -1;
            end
            if distanciaY < 0
                distanciaY = distanciaY * -1;
            end
            distancia = distanciaX + distanciaY;
            if i == 1 && j == 2
                minimo = distancia;
                puntoMinimo1 = puntoColumna(3);
                puntoMinimo2 = puntoFila(3);
            else
                if distancia == 0
                    continue;
                elseif distancia <= minimo
                    minimo = distancia;
                    puntoMinimo1 = puntoColumna(3);
                    puntoMinimo2 = puntoFila(3);
                end
            end
        end
    end
    grupos(contador) = [puntoMinimo1,puntoMinimo2,distancia];
    contador = contador + 1;
    puntosAux = restablecerPuntos(puntosAux, puntoMinimo1, puntoMinimo2, cantidadPuntos);
end

function [puntosNuevos] = restablecerPuntos(puntos, punto1, punto2, n)
    for i = 1 : n
        if puntos(i) == punto1
            
        elseif puntos(i) == punto2
        
        end
    end
end
