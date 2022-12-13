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
%Paso 2: Hacer nuevo grupo de nombre total+1 que una ambos grupos con la
%distancia minima encontrada. 
%Nota: para guardar las posiciones, los grupos que esten hasta el maximo de
%n se agregan directamente, los que sean mas de n, se debe buscar entre los
%grupos guardados hasta que tenga 2 grupos menores a n, de ahi guardamos
%en la posicion el promedio de ambos grupos
%   Paso 2.1: Para unir los puntos de ambos grupos, buscamos del primer grupo,
%   el punto en el segundo grupo, si no hay, se agrega directamente, si hay,
%   se toma el de menor distancia, así hasta verificar que en el segundo grupo no
%   haya puntos.
%   Nota: tomamos desde el segundo punto de cada grupo, ya que, el primero
%   fue el que hizo el grupo ya descartado
%Paso 3: Eliminamos los grupos unidos y agregamos el nuevo grupo al final
%de nuestros grupos
%   Paso 3.1: Se debe cambiar los puntos encontrados en cada grupo por 
%Paso 4: Repetimos hasta que haya solo un grupo en nuestra tabla
%Paso 5: Mostrar los grupos encontrados en una grafica de barras

%variables
n = 10;
x = 0;
y = 0;
puntos = [];

grupos = [];
ban = [0];
aumentoBan = 1;
gruposAMostrar = [];
contadorGruposAMostrar = 1;
pts = [0,0;3,8;2,2;1,1;5,3;9,8;6,3;5,4;6,4;7,5];
%Paso previo
for i = 1:1 : n
    x=pts(i,1);
    y=pts(i,2);
    %composición de puntos: [coordenada x, coordenada y, identificador]
    puntos{i} = [x,y,i]; 
end

%Paso previo
nuevoGrupo = 1;
for i = 1 : n
    puntoColumna = puntos{i};
    grupo = [];
    contador = 1;
    for j = 1 :1: n
        %Nota
        if i ~= j
            puntoFila = puntos{j};
            distanciaX = puntoColumna(1)-puntoFila(1);
            distanciaY = puntoColumna(2)-puntoFila(2);
            if distanciaX < 0
                distanciaX = distanciaX * -1;
            end
            if distanciaY < 0
                distanciaY = distanciaY * -1;
            end
            distancia = distanciaX + distanciaY;
            %composicion de grupo: [punto destino, distancia entre el punto del grupo y el destino]
            grupo{contador} = [puntoFila(3),distancia];
            contador = contador + 1;
        end
    end
    %Funcion para organizar los puntos
    [grupo] = ordenarMenorMayor(grupo,contador-1);
    %Agregamos el grupo a nuestro array de grupos
    grupos{nuevoGrupo} = grupo;
    nuevoGrupo = nuevoGrupo + 1;
end

%Paso 4
while (nuevoGrupo-aumentoBan) ~= 1
    grupoNoBanneado = 1;
    for i = 1 : aumentoBan-1
        if ban(i) == grupoNoBanneado
            grupoNoBanneado = grupoNoBanneado + 1;
        end
    end
    %Paso 1
    minimo = grupos{grupoNoBanneado}{1};
    primerGrupo = grupoNoBanneado;
    for i=1 : nuevoGrupo-1
        validarBanneado = false;
        for j=1 : aumentoBan-1
            if ban(j) == i
                validarBanneado = true;
                break;
            end
        end
        if validarBanneado == false
            if  grupos{i}{1}(2) < minimo(2)
                minimo = grupos{i}{1};
                primerGrupo = i;
            end
        end
    end
    
    tamanoPrimerGrupo = size(grupos{primerGrupo});
    tamanoSegundoGrupo = size(grupos{minimo(1)});
    %Agregamos al arreglo final el grupo
    %Paso 2
    %composicion de gruposAMostrar: [punto inicio, punto final, distancia]
    %Nota
    %if primerGrupo <= n && minimo(1) <= n
        gruposAMostrar{contadorGruposAMostrar}=[primerGrupo,minimo(1),minimo(2)];
        contadorGruposAMostrar = contadorGruposAMostrar + 1;
    %else
    %    valorUno = primerGrupo;
    %    valorDos = minimo(1);
    %    if  valorUno > n
    %        grupo = gruposAMostrar{valorUno-n};
    %        valorUno = (grupo(1)+grupo(2))/2;
    %    end
    %    if  valorDos > n
    %        grupo = gruposAMostrar{valorDos-n};
    %        valorDos = (grupo(1)+grupo(2))/2;
    %    end
    %    gruposAMostrar{contadorGruposAMostrar}=[valorUno,valorDos,minimo(2)];
    %    contadorGruposAMostrar = contadorGruposAMostrar + 1;
    %end
    
    %Paso 2.1
    grupoNuevo = [];
    aumentoNuevo = 1;
    for i = 2 : tamanoPrimerGrupo(2)
        punto = grupos{primerGrupo}{i};
        validarPunto = false;
        for j = 2 : tamanoSegundoGrupo(2)
            puntoComparar = grupos{minimo(1)}{j};
            if punto(1) == puntoComparar(1)
                validarPunto = true;
                %Buscamos el de menor distancia
                if punto(2) <= puntoComparar(2)
                    grupoNuevo{aumentoNuevo} = punto;
                    aumentoNuevo = aumentoNuevo + 1;
                else
                    grupoNuevo{aumentoNuevo} = puntoComparar;
                    aumentoNuevo = aumentoNuevo + 1;
                end
                break;
            end
        end
        if validarPunto == false
            grupoNuevo{aumentoNuevo} = punto;
            aumentoNuevo = aumentoNuevo + 1;
        end
    end
    %Paso 3:
    ban(aumentoBan) = primerGrupo;
    aumentoBan = aumentoBan + 1;
    ban(aumentoBan) = minimo(1);
    aumentoBan = aumentoBan + 1;
    ban = sort(ban);
    %[grupoNuevo] = ordenarMenorMayor (grupoNuevo,aumentoNuevo-1);
    [grupos] = actualizarPuntosGrupo(grupos,nuevoGrupo-1,primerGrupo,minimo(1));
    grupos{nuevoGrupo} = grupoNuevo;
    nuevoGrupo = nuevoGrupo + 1;
end
%Paso 5

G = cell2mat(gruposAMostrar);
j = size(gruposAMostrar);

Final = reshape(G,[3 j(2)]);
Final = transpose(Final);
Final = ordenarSalida(Final,j(2));

X = linkage(Final,"average");
figure()
dendrogram(Final)



%Funcion para actualizar los puntos unidos por el nuevo grupo
function [grupoActualizado] = actualizarPuntosGrupo(grupos, total, puntoUnoCambio, puntoDosCambio)
    grupoActualizado = [];
    grupo = [];
    grupoNuevo = [];
    for i = 1 : total
        grupo = grupos{i};
        tamano = size(grupo);
        for j = 1 : tamano(2)
            punto = grupo{j};
            if punto(1) == puntoUnoCambio || punto(1) == puntoDosCambio
                punto(1) = total+1; 
            end
            grupoNuevo{j} = punto;
        end
        grupoActualizado{i} = grupoNuevo;
    end
end

%Funcion para organizar los puntos
function [grupoOrdenado] = ordenarMenorMayor(grupo,total)
%Declaracion de variables
    grupoOrdenado = [];
    aumento = 1;
    %tomamos los primeros dos puntos y hacemos una comparativa de cual es
    %el de menor distancia y organizamos de derecha a izquierda, derecha
    %siendo el menor
    puntoUno = grupo{1};
    puntoDos = grupo{2};
    if puntoUno(2)<puntoDos(2)
        grupoOrdenado{aumento} = puntoUno;
        aumento = aumento + 1;
        grupoOrdenado{aumento} = puntoDos;
    elseif puntoUno(2)>puntoDos(2)
        grupoOrdenado{aumento} = puntoDos;
        aumento = aumento + 1;
        grupoOrdenado{aumento} = puntoUno;
    elseif puntoUno(2)==puntoDos(2)
        if puntoUno(1)<puntoDos(1)
            grupoOrdenado{aumento} = puntoUno;
            aumento = aumento + 1;
            grupoOrdenado{aumento} = puntoDos;
        elseif puntoUno(1)>puntoDos(1)
            grupoOrdenado{aumento} = puntoDos;
            aumento = aumento + 1;
            grupoOrdenado{aumento} = puntoUno;
        end
    end
    %para los puntos restantes
    for i=3 : total
        %tomamos el punto siguiente
        punto = grupo{i};
        %recorremos nuestros puntos guardados y comparamos hasta que
        %encontremos que sea menor o igual a un punto
        posicion=0;
        for j=1 : aumento
            puntoOrdenado = grupoOrdenado{j};
            if punto(2)<=puntoOrdenado(2)
                posicion = j;
                break;
            end
        end
        
        if posicion ~= 0
            %se encontro que fue igual o menor a un punto ya guardado en el
            %ordenado
            auxOrdenado = grupoOrdenado;
            %guardamos el punto en la posicion encontrada
            grupoOrdenado{posicion} = punto; 
            %agregamos los demas puntos que teniamos despues de este punto
            %nuevo
            posicion = posicion + 1;
            aumento = aumento + 1;
            for k=posicion : aumento
                grupoOrdenado{k} = auxOrdenado{k-1};
            end
        elseif posicion == 0
            %Si no fue menor a ninguno ya guardado, se guarda al final
            aumento = aumento + 1;
            grupoOrdenado{aumento} = punto;
        end
    end
end

%Funcion para organizar la salida
function[arregloSort] = ordenarSalida(arreglo,dim)
    arregloSort = arreglo;
    for i=1 : dim
        if arreglo(i,1)>arreglo(i,2)
            arregloSort(i,1)=arreglo(i,2);
            arregloSort(i,2)=arreglo(i,1);
        end
    end
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
