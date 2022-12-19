function [inicio,finales] = generaInicioFin(nrep,matclases)

inicio = [];
finales = [];

j = 1;
for i=nrep:nrep:length(matclases) 
    finales(j) = i;
    j = j+1; 
end

%generamos una coleccion de puntos nos indica en donde inicia la matriz de
%la clase ck
for k = 1: length(finales)
    
    if(k == 1) 
        inicio(k) = 1;
        
    else
        if(k >= 2)
            inicio(k) = finales(k-1) + 1;
        end
    end
    
end


end