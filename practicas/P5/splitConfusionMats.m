function splitConfusionMats(containerMatsConfusion,nrep)

[inicio,finales] = generaInicioFin(nrep,containerMatsConfusion);

for i=1:length(inicio)
    switch i 
        case 1
            disp("Resustitucion");
            disp(containerMatsConfusion(:,inicio(i):finales(i)));
        case 2
            disp("Cross Validation");
            disp(containerMatsConfusion(:,inicio(i):finales(i)));
            
        case 3
            disp("Hold in one");
            disp(containerMatsConfusion(:,inicio(i):finales(i)));
            
    end
    
    
end

end