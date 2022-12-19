function [valor] = clasificadorFun(matclases,nrep,nclases,x,y,inicio,finales)

medias = [];
distancias = [];

%calculamos las medias y vamos añadiendo a una matriz contenedora de todas
%las medias  para cada matriz de clase ckn
for i=1:length(inicio)
    media = mean(matclases(:,inicio(i):finales(i)),2);
    medias = [medias media];
end

% [data_x, data_y] = leerVector();
% vector = [data_x;data_y];
%  data_x = input("ingresa x \n");
%  data_y = input("ingresa y \n");
% 
 vector = [x;y];
  
 for i=1:nclases 
     distancias(i) = norm(vector- medias(:,i));
 end



 dist_total= distancias;
 minimo = min(min(dist_total));
 valor = find(dist_total==minimo);
%  fprintf("La distancias obtenidas son\n");
%  disp(distancias);
 %fprintf('Clasificador Euclidiano : el vector [%d , %d] pertenece a la clase = %d\n',x,y,valor);
