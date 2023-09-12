function [matclases,nrep,nclases] = generarClases()

%Esta funcion lee la informacion y genera una matriz grandota donde estna
%contenidas todas las otras matrices correspondientes, a las cuales
%después vamos a acceder como submatrices,

%retona : matclases(matriz contenedora) , numero de representantes por
%clase , y numero de clases.

cx = [];

cy = [];
disper = [];
matclases = [];

nclases = input("¿Cuantas clases quieres?\n");
nrep = input("Ingresa el numero de representantes por clase\n");

%leer centroide y dispersion de cada clase
fprintf("Ingresa el centroide y dispersion para cada clase\n");

clc;
%agregamos centroides y dispersion correspondientes de las n clases
for i=1:nclases 
    cx(1,i) = input("centroide clase "+i+" x: ");
    cy(2,i) = input("centroide clase "+i+" y: ");
    disper(i) = input("dispersion clase "+i+" x: \n");
end

%generamos cada matriz (correspondiente a cada clase ck) y 
%la agregamos a una matriz contenedora de todas las clases ck1 .... ckn
for i = 1:nclases
    if(disper(i) ~= 0)
        x = randn(2,nrep)
        %x = x + centroides(i)
        for k = 1:nrep
            x(1,k) = (x(1,k)+cx(i)) * disper(i);
            x(2,k) = (x(2,k)+cy(i)) * disper(i);
        end
    else
        x = randn(2,nrep);
        for k = 1:nrep
            for j = 1:2
                x(j,k) = x(j,k) * 1;
            end
        end 
    end
   
    matclases = [matclases x];
    x = [];
    
end

end