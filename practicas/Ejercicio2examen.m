clc 
clear all 
close all
warning off all

rango_inf = input('Indique el valor inferior del rango  ');


rango_sup = input('Indique el valor superior del rango  ');
no_primos=0;
primos=0;
for i =rango_inf:1:rango_sup
    if (isprime(i))
        primos= primos + 1;
    else
        no_primos=no_primos+1;
    end
end
clase_p_x={1,primos};
clase_p_y={1,primos};


clase_np_x={1,no_primos};
clase_np_y={1,no_primos};



for ind = 1:1:primos
    clase_p_x{ind}=ind;
    clase_np_x{ind}=ind+10;
end

for i =rango_inf:1:rango_sup
    if (isprime(i))
        clase_p_y{i}=i;
    else
        clase_np_y{i}=i;
    end
end

clase_p= [cell2mat(clase_p_x);cell2mat(clase_p_y)];
clase_np= [cell2mat(clase_np_x);cell2mat(clase_np_y)];
vec_x=input('Indique la coordenada x del vector desconocido  ');
vec_y=input('Indique la coordenada y del vector desconocido  ');
vector = [vec_x;vec_y];
if vec_x > rango_sup || vec_x < rango_inf
    fprintf("Fuera de los limites \n");
elseif vec_y > rango_sup || vec_y < rango_inf
    fprintf("Fuera de los limites \n");
else
    mediap=mean(clase_p);
    distancia1 = norm(vector-mediap);
    medianp = mean(clase_np);
    distancia2 = norm(vector-medianp);

    if (distancia1<distancia2)
       fprintf("Pertenece a al clase de los primos \n") ;
    else
       fprintf("Pertenece a al clase de los no primos \n") ; 
    end
    plot(vector(1,:),vector(2,:),'kh','MarkerFaceColor','g','MarkerSize',15);
    hold on
    grid on
    for ind =1:1:4
        plot(clase_p(1,:),clase_p(2,:),'r*','MarkerFaceColor','r','MarkerSize',15);
    end
    for ind =1:1:4
        plot(clase_np(1,:),clase_np(2,:),'g+','MarkerFaceColor','g','MarkerSize',15);
    end
    legend('desconocido','primos','no primos');
end
