clc 
close all 
clear all 
warning off all 
disp('Welcome to pattern recognition')

continuar = 1;
while continuar ~= 0
    opc =  menu('Menú de practicas seleccione la opción que desea:','1. Clasificador de distancia Euclidiana','2. Clasificador de distancia de Mahalanobis','3.Salir');
    switch opc
        case 1
            disp('Clasificador por distancia euclidiana con 6 clases')

            %Clasificador con distancia euclidiana

            %declaracion de clases
            c1 = [134 148 114 187 150 ; 77 116 116 103 72];
            c2 = [133 87 65 32 99; 36 35 15 42 51];
            c3 = [-34 -28 -64 -47 -70; -57 -16 -16 -43 -42];
            c4 = [34 28 44 37 50; 186 165 135 92 171];
            c5 = [134 128 160 137 100; -37 -16 -36 -63 -22];
            c6 = [-110 -17 -54 -107 -50;47 96 56 93 22];
            limsupy=500;
            limsupx=500;
            liminfx=-500;
            liminfy=-500;
            %vector desconocido
            vectorx=input('Indique lac coordenada x del vector no clasificado ');
            vectory=input('Indique la coordenada y del vector no clasificado ');
            vector=[vectorx;vectory];
            
            %calculo de las medias de cada clase
            media1=mean(c1,2);
            media2=mean(c2,2);
            media3=mean(c3,2);
            media4=mean(c4,2);
            media5=mean(c5,2);
            media6=mean(c6,2);
            
            %graficación de las clases y el vector desconocido
             figure(1)
             plot(c1(1,:),c1(2,:),'ro','MarkerFaceColor','r','MarkerSize',10)
             grid on
             hold on
             plot(c2(1,:),c2(2,:),'b+','MarkerFaceColor','b','MarkerSize',10)
             plot(c3(1,:),c3(2,:),'k*','MarkerFaceColor','k','MarkerSize',10)
             plot(c4(1,:),c4(2,:),'c+','MarkerFaceColor','c','MarkerSize',10)
             plot(c5(1,:),c5(2,:),'gd','MarkerFaceColor','g','MarkerSize',10)
             plot(c6(1,:),c6(2,:),'mh','MarkerFaceColor','m','MarkerSize',10)
             plot(vector(1,:),vector(2,:),'y^','MarkerFaceColor','y','MarkerSize',5)
             legend('Clase 1','Clase 2','Clase 3','Clase 4','Clase 5','Clase 6','vector no clasificado');
            
            %clasificación del vector
            distancia1=norm(vector-media1);
            distancia2=norm(vector-media2);
            distancia3=norm(vector-media3);
            distancia4=norm(vector-media4);
            distancia5=norm(vector-media5);
            distancia6=norm(vector-media6);
            
            %almacenamiento de las distancias
            Distancias=[distancia1,distancia2,distancia3,distancia4,distancia5,distancia6];
            
            %comprobación de los limites
             if vectorx > limsupx
                fprintf('Vector fuera de los limites, no se puede clasificar\n');
                elseif vectorx < liminfx
                    fprintf('Vector fuera de los limites, no se puede clasificar\n');
                    elseif vectory > limsupy
                        fprintf('Vector fuera de los limites, no se puede clasificar\n');
                        elseif vectory < liminfy
                            fprintf('Vector fuera de los limites, no se puede clasificar\n');
                            else
                                %deteminación de la distancia más corta
                                dint_min=min(min(Distancias));
                                clase=find(Distancias==dint_min);
            
                                %clasificación
                                fprintf('El vector desconocido pertenece a la clase %d \n',clase);
                            end

            continuar = input('Desea regresar al menú? 0.No, 1.Si ');
        case 2
            disp('Clasificador de distancia de Mahalanobis')
            c1 = [134 148 114 187 150 ; 77 116 116 103 72];
            c2 = [133 87 65 32 99; 36 35 15 42 51];
            c3 = [-34 -28 -64 -47 -70; -57 -16 -16 -43 -42];
            c4 = [34 28 44 37 50; 186 165 135 92 171];
            c5 = [134 128 160 137 100; -37 -16 -36 -63 -22];
            c6 = [-110 -17 -54 -107 -50;47 96 56 93 22];
            %vector no clasificado
            vectorx=input('Indique la coordenada x del vector no clasificado ');
            vectory=input('Indique la coordenada y del vector no clasificado ');
            vector=[vectorx;vectory];

            %graficando las clases
            figure(1)
            plot (c1(1,:),c1(2,:),'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10) 
            grid on 
            hold on 
            plot (c2(1,:),c2(2,:),'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10)
            plot (c3(1,:),c3(2,:),'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
            plot (c4(1,:),c4(2,:),'co', 'MarkerFaceColor', 'c', 'MarkerSize', 10)
            plot (c5(1,:),c5(2,:),'mo', 'MarkerFaceColor', 'm', 'MarkerSize', 10)
            plot (c6(1,:),c6(2,:),'yo', 'MarkerFaceColor', 'y', 'MarkerSize', 10)
            plot(vector(1,:),vector(2,:),'gs','MarkerFaceColor','g','MarkerSize', 10)
            legend('Clase 1', 'Clase 2', 'Clase 3', 'Clase 4', 'Clase 5', 'Clase 6','vector')

            
            %calculo de medias
            media1 = mean(c1,2);
            media2 = mean(c2,2);
            media3 = mean(c3,2);
            media4=mean(c4,2);
            media5=mean(c5,2);
            media6=mean(c6,2);
            
            %calculo de matrices
            %---------------------------------clase 3----------------------------------
            difvecmed1=vector-media1;%a1
            transdifvecmed1=transpose(difvecmed1); %a2
            
            mat1b=c1-media1;
            b1=mat1b*transpose(mat1b);
            matinvb1=inv(b1);
            
            distancia1=transdifvecmed1*matinvb1*difvecmed1; % ya da la distancia corecta
            %deberia ser 12.56
            
            %---------------------------------clase 2----------------------------------
            difvecmed2=vector-media2;%a1
            transdifvecmed2=transpose(difvecmed2); %a2
            
            mat2b=c2-media2;
            b2=mat2b*transpose(mat2b);
            matinvb2=inv(b2);
            
            distancia2=transdifvecmed2*matinvb2*difvecmed2; % ya da la distancia corecta
            
            
            %---------------------------------clase 3----------------------------------
            difvecmed3=vector-media3;%a1
            transdifvecmed3=transpose(difvecmed3); %a2
            
            mat3b=c3-media3;
            b3=mat3b*transpose(mat3b);
            matinvb3=inv(b3);
            
            distancia3=transdifvecmed3*matinvb3*difvecmed3; % ya da la distancia corecta
            
            %---------------------------------clase 4----------------------------------
            difvecmed4=vector-media4;%a1
            transdifvecmed4=transpose(difvecmed4); %a2
            
            mat4b=c4-media4;
            b4=mat4b*transpose(mat4b);
            matinvb4=inv(b4);
            
            distancia4=transdifvecmed4*matinvb4*difvecmed4; % ya da la distancia corecta
            
            %---------------------------------clase 5----------------------------------
            difvecmed5=vector-media5;%a1
            transdifvecmed5=transpose(difvecmed5); %a2
            
            mat5b=c5-media5;
            b5=mat5b*transpose(mat5b);
            matinvb5=inv(b5);
            
            distancia5=transdifvecmed5*matinvb5*difvecmed5; % ya da la distancia corecta
            
            %---------------------------------clase 6----------------------------------
            difvecmed6=vector-media6;%a1
            transdifvecmed6=transpose(difvecmed6); %a2
            
            mat6b=c6-media6;
            b6=mat6b*transpose(mat6b);
            matinvb6=inv(b6);
            
            distancia6=transdifvecmed6*matinvb6*difvecmed6; % ya da la distancia corecta
            
            %deteminación de la menor distancia
            distancias=[distancia1 distancia2 distancia3 distancia4 distancia5 distancia6];
            
            dist_min=min(min(distancias));
            
            clase = find(distancias==dist_min);
            
            fprintf('El vector pertenece a la clase %d\n',clase);

            continuar = input('Desea regresar al menú? 0.No, 1.Si ');
        case 3
            disp('Hasta luego')
            exit
        otherwise
            disp('Seleccione una opción valida, presione una tecla para continuar')
            pause
    end 
end