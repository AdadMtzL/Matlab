function [valor] = vecinosFunc(matClases,nrep,nclases,x,y,inicio,fin,k)

%pertenece a clase 2 con euclidiano
% c1 = [0 0 1 0 2; 0 1 1 1 1];
% c2 = [5 5 4 6 6; 5 6 5 5 4];
% c3 = [9 10 11 10 9; 10 11 9 12 12];

%vector desconocido
% [x,y] = leerVector();
vector = [x;y];
vectorplot = vector;

%vector para distancias, distancias por numero de representantes
%en el ejemplo 5 distancias por que son 5 representantes
distancias = [];

%matriz de clases
% matClases = [c1 c2 c3];

%numero de representantes
% nrep = 5;

%numero de clases
% nclases = 3;

%inicio - fin de cada clase en la matriz matClases
[inicio , fin] = generaInicioFin(nrep,matClases);


%fila aux
fila = [];

for i=1:nclases     
    data = vecnorm(vector - matClases(:,inicio(i):fin(i)));
    data = sort(data);
    distancias = [distancias; data];

end

[f,c] = size(distancias);

%numero de vecinos
%k = input("Dame el numero de vecinos\n"); 

%aqui estan los valores minimos revueltos
minimos = min(distancias);

minimos = minimos(1:k);

%cantidad de datos pertenecientes a cada clase
cantidades = zeros(1,nrep);

%conocemos el numero de filas entonces vamos a ir buscando cada n de el
for i=1:f
    dataFila = distancias(i:i,:);
    
    for j=1: length(minimos)
        dato = minimos(j);
        if(length(find(abs(dataFila - dato) < 0.001)) >= 1)
            cantidades(i) = cantidades(i) + 1;
        end
    end
   
end


maxNum = max(cantidades);
valor = find(cantidades == maxNum);

%fprintf("(Clasificador por vecinos : )El vector [%d , %d] pertenece a la clase %d \n",x,y,valor);
end