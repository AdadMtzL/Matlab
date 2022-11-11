clc 
clear all 
close all
warning off all

%Declaración de clases

c1_x=[0,1,1,1];
c1_y=[0,0,0,1];
c1_z=[0,0,1,0];


c2_x=[0,0,0,1];
c2_y=[0,1,1,1];
c2_z=[1,1,0,1];

c1 = [c1_x;c1_y;c1_z];

c2 = [c2_x;c2_y;c2_z];

vec_x = input('Indique la coordenada x del vector desconocido  ');
vec_y = input('Indique la coordenada y del vector desconocido  ');
vec_z = input('Indique la coordenada z del vector desconocido  ');

vector = [vec_x;vec_y;vec_z];

%comprobaciones de calculo
if (vec_x>1 || vec_x<0)
    fprintf("No se puede clasificar\n");
elseif (vec_y>1 || vec_y<0)
    fprintf("No se puede clasificar\n");
elseif (vec_z>1 || vec_z<0)
    fprintf("No se puede clasificar\n");
else
    %calculo de clasifiación
    media1 = mean(c1,4);
    media2 = mean(c2,4);

    %distancia 1
    matriz_covarianza=(c1-media1)*transpose((c1-media1));
    matriz_covarianza_inversa=inv(matriz_covarianza);
    diferenia_vector_clase=vector-media1;
    diferenia_vector_clase_transpuesta=transpose(diferenia_vector_clase);
    distancia_calculada_mahalobis=diferenia_vector_clase_transpuesta*matriz_covarianza_inversa*diferenia_vector_clase;

    %distancia 2
    matriz_covarianza2=(c1-media2)*transpose((c1-media2));
    matriz_covarianza_inversa2=inv(matriz_covarianza);
    diferenia_vector_clase2=vector-media2;
    diferenia_vector_clase_transpuesta2=transpose(diferenia_vector_clase);
    distancia_calculada_mahalobis2=diferenia_vector_clase_transpuesta2*matriz_covarianza_inversa2*diferenia_vector_clase2;

    if(distancia_calculada_mahalobis <= distancia_calculada_mahalobis2)
        fprintf("el vector pertenece a la clase 1 con una distancia de %f \n",distancia_calculada_mahalobis);
    else
        fprintf("el vector pertenece a la clase 1 con una distancia de %f",distancia_calculada_mahalobis2);
    end
    plot3(vector(1,:),vector(2,:),vector(3,:),'kh','MarkerFaceColor','g','MarkerSize',15);
    hold on
    grid on
    for ind =1:1:4
        plot3(c1(1,:),c1(2,:),c1(3,:),'r*','MarkerFaceColor','r','MarkerSize',15);
    end
    for ind =1:1:4
        plot3(c2(1,:),c2(2,:),c2(3,:),'g+','MarkerFaceColor','g','MarkerSize',15);
    end
    legend('Clase 1','Clase 2','Clase 3');

end