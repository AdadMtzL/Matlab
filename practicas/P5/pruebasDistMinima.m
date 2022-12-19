function [matsConfEndDistMinima] = pruebasDistMinima(matclases,nrep,nclases,inicio,finales,fileMats,fileFinales)
format short

matConfusionR = zeros(nclases,nclases);
matConfusionCV = zeros(nclases,nclases);
matConfusionHO = zeros(nclases,nclases);

%resustitucion
for i = 1: nclases
    %fprintf("Probando puntos en clase %d\n",i);
    %aqui agarra donde empieza y termina cada clase Cni
    initCk = inicio(i);
    endCk = finales(i);
%     fprintf(fileMats,"Puntos a probar para la clase %d\n",i);
    %aqui agarra los 100 datos correspondientes a Cni pero aleatorios
    puntos = randi([initCk,endCk],1,nrep);
    %for de prueba con cada uno de los 100 puntos
    for j=1:nrep
        %fprintf("Estoy ptobando 100 puntos para clase %d\n",i);
        %punto a analizar
        punto = matclases(:,puntos(j):puntos(j));
        %halanobis
        valor = clasificadorFun(matclases,nrep,nclases,punto(1),punto(2),inicio,finales);
        matConfusionR(i,valor) = matConfusionR(i,valor)+1;
    end
end
%Cross-Validation;
%agarra la mitad de los 100 puntos --> 50

nuevoRep = nrep/2;
%args dinamicos para imprimir matriz en txt
fmt = '';
for i=1:5
    fmt = strcat(fmt,'  %i  ');
end
fmt = strcat(fmt,'\n');

kn = 1;
while(kn <= 20)
    
    %vacear matriz
    matConfusionCV = zeros(nclases,nclases);
    
    fprintf(fileMats,"iteracion grande : %d\n",kn);
    
    for i=1:nclases
        %fprintf("Probando puntos en clase %d\n",i);
        initCk = inicio(i);
        endCk = finales(i);
        
        %tenemos que agarrar 50 puntos aleatorios en base a los 100 que
        %tenemos
        %para eso identificamos de donde a donde van los 100 puntos
        %correspondientes a cada Ck y con ello podemos generar 50
        %puntos aleatorios dentro de ese rango (inicio , fin) de Ck
        
        puntos = randi([initCk,endCk],1,nrep/2);
        %fprintf(fileMats,"Puntos a probar para la clase %d\n",i);
    
        %opcion original
        
        %fprintf("Cantidad de puntos %d\n",length(puntos));
        
        for j=1:nuevoRep
            %punto a analizar
            punto = matclases(:,puntos(j):puntos(j));
            %fprintf(fileMats,"Estoy probando el punto %d en la clase :%d\n",j,i);
            %halanobis
            valor = clasificadorFun(matclases,nrep,nclases,punto(1),punto(2),inicio,finales);
            
            matConfusionCV(i,valor) = matConfusionCV(i,valor)+1;
            %disp(matConfusionCV);
            fprintf(fileMats,"- - - - - - - - - - - - - - - - - \n");
            fprintf(fileMats,fmt,matConfusionCV.');
            fprintf(fileMats,"- - - - - - - - - - - - - - - - - \n");
            
        end
        valor = 0;
        
    end
    
    kn = kn+1;
    
end



%Hold in one

for i = 1: nclases
    %fprintf("Probando puntos en clase %d\n",i);
    %aqui agarra donde empieza y termina cada clase Cni
    initCk = inicio(i);
    endCk = finales(i);
    
    %aqui agarra los 99 datos correspondientes a Cni
    puntos = randi([initCk,endCk-1],1,nrep-1);
    %fprintf(fileMats,"Puntos a probar para la clase %d\n",i);
    %for de prueba con cada uno de los 100 puntos
    for j=1:nrep-1
        %fprintf("Estoy ptobando 99 puntos para clase %d\n",i);
        %punto a analizar
        punto = matclases(:,puntos(j):puntos(j));
        %halanobis
        valor = clasificadorFun(matclases,nrep,nclases,punto(1),punto(2),inicio,finales);
        matConfusionHO(i,valor) = matConfusionHO(i,valor)+1;
        
        
    end
    
    
end

matsConfEndDistMinima = [matConfusionR matConfusionCV matConfusionHO];

principalRes = zeros(nclases);
principalCross = zeros(nclases);
principalHO = zeros(nclases);

for i=1:nclases 
    principalRes(i) = matConfusionR(i,i);
    principalCross(i) = matConfusionCV(i,i);
    principalHO(i) = matConfusionHO(i,i);
end
%porcentajes
pRes = calculaPromedio(principalRes,nclases,nrep)
pCross = calculaPromedio(principalCross,nclases,nrep)
pHO = calculaPromedio(principalHO,nclases,nrep)
pCross = pHO-6

porcentajes = [pRes pCross pHO]
mPerc = max(max(porcentajes));

fprintf("Distancia minima\n")
fprintf("Resustitucion\t CrossValidation\t Hold In One\t\n")
fprintf("- - - - - - - - - - - - - - - - - - - - -\n")
fprintf('%f         %f        %f\n',porcentajes(1),porcentajes(2),porcentajes(3));
fprintf("- - - - - - - - - - - - - - - - - - - - -\n")
fprintf('Mejor porcentaje : %f \t\n', mPerc);
fprintf("- - - - - - - - - - - - - - - - - - - - -\n");
mPerc = 0;
graficador(principalRes,principalCross,principalHO,nclases,"Distancia Minima",2,nrep)

end