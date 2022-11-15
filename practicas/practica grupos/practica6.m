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
puntos = [];

grupos = [];
%Paso previo
n = input("Digite la cantidad de puntos");
cantidadPuntos = n;
for i = 1 : n
    x = input("Valor en x del punto "+i);
    y = input("Valor en y del punto "+i);
    puntos(i) = [x,y]; 
end

%Paso 1: no necesario hacer
%Paso 5
while cantidadPuntos ~= 1
    %Paso 2

end
