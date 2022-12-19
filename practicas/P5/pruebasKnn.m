function [matsConfEndKnn] = pruebasKnn(matclases,nrep,nclases,inicio,finales,fileMats,k,fileFinales)

matConfusionR = zeros(nclases,nclases);
matConfusionCV = zeros(nclases,nclases);
matConfusionHO = zeros(nclases,nclases);


for i = 1: nclases
    %fprintf("Probando puntos en clase %d\n",i);
    %aqui agarra donde empieza y termina cada clase Cni
    initCk = inicio(i);
    endCk = finales(i);
    
    %aqui agarra los 100 datos correspondientes a Cni
    puntos = randi([initCk,endCk],1,nrep);
    
    %for de prueba con cada uno de los 100 puntos
    for j=1:nrep
        %fprintf("Estoy ptobando 100 puntos para clase %d\n",i);
        %punto a analizar
        punto = matclases(:,puntos(j):puntos(j));
        %halanobis
        valor = vecinosFunc(matclases,nrep,nclases,punto(1),punto(2),inicio,finales,k);
        matConfusionR(i,valor) = matConfusionR(i,valor)+1;
        
        
    end
    
    valor = 0;
    puntos = [];
    
    
end

%fprintf("Cross-Validation\n\n");

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
        
        for j=1:nuevoRep
            %punto a analizar
            punto = matclases(:,puntos(j):puntos(j));
            fprintf(fileMats,"Estoy probando el punto %d en la clase :%d\n",j,i);
            %halanobis
            valor = vecinosFunc(matclases,nrep,nclases,punto(1),punto(2),inicio,finales,k);
            
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
    
    %for de prueba con cada uno de los 100 puntos
    for j=1:nrep-1
        %fprintf("Estoy ptobando 99 puntos para clase %d\n",i);
        %punto a analizar
        punto = matclases(:,puntos(j):puntos(j));
        %halanobis
        valor = vecinosFunc(matclases,nrep,nclases,punto(1),punto(2),inicio,finales,k);
        matConfusionHO(i,valor) = matConfusionHO(i,valor)+1;   
    end
   
end
%end Hold in one
matsConfEndKnn = [matConfusionR matConfusionCV matConfusionHO];

principalRes = zeros(nclases);
principalCross = zeros(nclases);
principalHO = zeros(nclases);

for i=1:nclases 
    principalRes(i) = matConfusionR(i,i);
    principalCross(i) = matConfusionCV(i,i);
    principalHO(i) = matConfusionHO(i,i);
end
%porcentajes
pRes = calculaPromedio(principalRes);
pCross = calculaPromedio(principalCross);
pHO = calculaPromedio(principalHO);

porcentajes = [pRes pCross pHO];

fprintf(fileFinales,"KNN \n");
fprintf(fileFinales,"Resustitucion\t CrossValidation\t Hold In One\t\n");
fprintf(fileFinales,"- - - - - - - - - - - - - - - - - - - - -\n");
fprintf(fileFinales,'%i\t %i\t %i\t\n',porcentajes(1),porcentajes(2),porcentajes(3));
fprintf(fileFinales,'Mejor porcentaje : %i \t\n',max(porcentajes));
fprintf(fileFinales,"- - - - - - - - - - - - - - - - - - - - -\n");

graficador(principalRes,principalCross,principalHO,nclases,"KNN",5);

end