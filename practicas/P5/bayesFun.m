function [valor] = bayesFun(matclases,nrep,nclases,x,y,inicio,finales)


vector = [x y];
vectorplot = [x;y];
respuesta = 1;

[mediasmat] = calcularMedias(matclases,inicio,finales);
varianzas = [];
partA = [];
partB = [];
subFinal = [];


%part A of operation  
for i=1:length(mediasmat)
    resta = vector - transpose(mediasmat(1:2,i));

    %saco su transpuesta de una vez
    transResta = transpose(resta);
    %calculamos la varianza para ck recibe ck,#representantes,media ck
    varianza = calculaVarianza(nrep,matclases(1:2,inicio(i):finales(i)),mediasmat(1:2,i));
    %despues utilizo un aux para agarrar la transpuesta de la actual varian
    %za de ck
    invvarianzack = inv(varianza);
    %guardo la varianza original de ck en varianzas para ocuparla mas
    %adelante
    varianzas = [varianzas varianza];
    %caculo la parte A de todo el choro matematico para cada Ck
    partA(i) = exp(-0.5 * resta * invvarianzack * transResta);
   
end

%parte B de cada Ck

defaultb = (1/ (2 * pi)); 
init = 1;
endd = 2;
%varianzas son submatrices de 2x2 para cada Ck
for i=1:length(mediasmat)
    partB(i) = defaultb * det(varianzas(1:2,init:endd) ^ -0.5);
    init = endd + 1;
    endd = init +1;
    
end

%por ultimo calculo los resultados de multiplicar la parte A por la parte B
%de todo el choro matematico
for i=1:length(mediasmat)
        aux  = partA(i) * partB(i);
        subFinal = [subFinal aux];
end

%calcular las ps
ps =[ ];
%sumatoria de probabilidades
sumaProb = 0;
for i=1:length(subFinal)
    sumaProb = sumaProb + subFinal(1);
end

for i=1:length(subFinal)
    ps(i) = (subFinal(i) / sumaProb)*100;
end

prob_total = ps;
maximo = max(max(prob_total));
valor = find(prob_total == maximo);

%fprintf("(Clasificador de Bayes) : El vector [%d , %d ] pertenece a la clase %d\n",x,y,valor);

 end