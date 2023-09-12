function [valor] = HalanobisFun(matClases,nrep,nclases,x,y,inicio,fin)
%UNTITLED6 Summary of this function goes here

% Si se qiere usar el ejemplo de clase
% c1 = [0 1 1 1; 0 0 1 0;0 0 0 1];
% c2 = [0 1 0 0;0 1 1 1; 1 1 1 0];

% las medias deben ir de 1:3 , las varianzas 1:3 , y las matrices igual 1:3
%modificar las respecticas funciones(calcularMedias() ) y secciones de este codigo
%como e = 3 y filas de algunamatriz(1:3)
%como vamos a trabajar con 2D, no mover nada, ya funciona



%calculamos las medias de cada Ck de forma 2 x 1 (dos filas una col)
mediasMat = calcularMedias(matClases,inicio,fin);
%matriz contenedora de varianzas de tamaño 2x2(matrices)
varianzasMat = [];
%vector para guardar las distancias finales su tamaño depende del numero de
%clases
distancias = [];

vectorPlot = [x;y];

%las varianzas quedan como submatrices de 2x2 y se concatenan a la matriz
%varianzasMat
for i=1:length(inicio)
    valor = calculaVarianza(nrep,matClases(1:2,inicio(i):fin(i)),mediasMat(1:2,i:i));
    varianzasMat = [varianzasMat valor];
end

% %para sacar submatrices de 2x2
s = 1;
e = 2;
%calculamos las distancias
for i=1:length(inicio)
    
    vector = vectorPlot';
    vectormed = vector - mediasMat(1:1,i:i);
    vectornormal = vectorPlot - mediasMat(1:1,i:i);
    var = varianzasMat(1:2,s:e);
    inversa = inv(var);

    if(isinf(inversa))
        disp('detectado');
        inversa = [0 0; 0 0];
    end;
    
    resul = vectormed * inversa * vectornormal;
    
    distancias(i) = resul;
    
    s = e+1;
    e = s+1;
    
end

%  2 x 4  *  4 x2   = 2 x 2
minimo = min(min(distancias));
valor = find(minimo == distancias);
%fprintf("( Mahalanobis ): El vector  [%d , %d] pertenece a la clase %d\n",x,y,valor);


end