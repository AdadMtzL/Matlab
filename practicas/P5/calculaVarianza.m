function [respuesta] = calculaVarianza(nrep,claseCk,media)

    frac = 1 / nrep;
    varianza = claseCk - media;
    trans = varianza';
    respuesta = (frac * varianza) * trans;

end
