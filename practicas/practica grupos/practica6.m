clc %Limpia la pantalla
clear all %limpia todas las variables
close all %cierra todo
warning off all %evita llamadas de atención
%Hacer grupos relacionando distancias
%Notas: Al ocupar siempre los mismos puntos, las distancias nunca varian,
%por lo que no hay que solo hay que calcular distancias una vez y de ahí
%con los grupos, hacer comparativas y respetar jerarquias.
%Nuevos pasos

%Paso previo: calcular todas las distancias entre los puntos y hacer una tabla
%con distancias de menor a mayor desde cada punto.
%Nota paso previo: No nos interesa la distancia del punto entre si mismo.
%Paso 1: tomar el primer valor de cada tabla y obtener el primer grupo con
%la menor distancia entre ellos.


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
    %composición de puntos: [coordenada x, coordenada y, identificador]
    puntos(i) = [x,y,i]; 
end

%Paso previo
nuevoGrupo = 1;
for i = 1 : n
    puntoColumna = puntos(i);
    grupo = [];
    contador = 1;
    for j = 1 : n
        %Nota
        if i ~= j
            puntoFila = puntos(j);
            distanciaX = puntoColumna(1)-puntoFila(1);
            distanciaY = puntoColumna(2)-puntoFila(2);
            if distanciaX < 0
                distanciaX = distanciaX * -1;
            end
            if distanciaY < 0
                distanciaY = distanciaY * -1;
            end
            distancia = distanciaX + distanciaY;
            grupo(contador) = [puntoFila(3),distancia];
            contador = contador + 1;
        end
    end
    %Funcion para organizar los puntos

    %Agregamos el grupo a nuestro array de grupos
    
end


%Pasos vistos en clase
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
