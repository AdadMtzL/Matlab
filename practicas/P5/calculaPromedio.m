function [resultado] = calculaPromedio(diagonalPrincipal, nclases,nrep)

suma = 0;
for i=1:nclases
    suma = suma + diagonalPrincipal(i);

end

promedio = suma/nclases;
resultado = (promedio * 100)/nrep;