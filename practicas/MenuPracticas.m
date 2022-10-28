clc 
close all 
clear all 
warning off all 
disp('Welcome to pattern recognition')

continuar = 1;
while continuar ~= 0
    opc =  menu('Menú de practicas seleccione la opción que desea:','1. Clasificador de distancia Euclidiana','2. Clasificador de distancia de Mahalanobis','3.-maxima probabilidad','4.Salir');
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
            disp('Clasificador de maxima probabilidad')
            %clases para el clasificador de maxima probabilidad
            c1 = [134 148 114 120 150 ; 77 116 116 60 72];
            c2 = [110 87 67 62 99; 36 35 15 45 51];
            c3 = [34 40 64 47 70; 57 20 16 43 42];
            c4 = [34 28 44 37 50; 120 165 135 92 171];
            c5 = [138 128 100 125 115; 37 16 36 70 65];
            c6 = [40 35 54 40 50;95 100 56 80 35];
            %calculo de medias
            media1=mean(c1,2);
            media2=mean(c2,2);
            media3=mean(c3,2);
            media4=mean(c4,2);
            media5=mean(c5,2);
            media6=mean(c6,2);
            %calculo de las matrices de varianza_covarianza
            matriz_var_cov_clase_1=(c1-media1)*transpose(c1-media1);
            matriz_var_cov_clase_2=(c2-media2)*transpose(c2-media2);
            matriz_var_cov_clase_3=(c3-media3)*transpose(c3-media3);
            matriz_var_cov_clase_4=(c4-media4)*transpose(c4-media4);
            matriz_var_cov_clase_5=(c5-media5)*transpose(c5-media5);
            matriz_var_cov_clase_6=(c6-media6)*transpose(c6-media6);

            %calculo de la mat1
            mat1_1=vector-media1;
            mat1_2=vector-media2;
            mat1_3=vector-media3;
            mat1_4=vector-media4;
            mat1_5=vector-media5;
            mat1_6=vector-media6;

            %calculo de la mat2
            mat1_trans=transpose(mat1_1);
            mat2_trans=transpose(mat1_2);
            mat3_trans=transpose(mat1_3);
            mat4_trans=transpose(mat1_4);
            mat5_trans=transpose(mat1_5);
            mat6_trans=transpose(mat1_6);

            %calculo de distancias de mahalobis
            dist1=mat1_trans*inv(matriz_var_cov_clase_1)*mat1_1;
            dist2=mat2_trans*inv(matriz_var_cov_clase_2)*mat1_2;
            dist3=mat3_trans*inv(matriz_var_cov_clase_3)*mat1_3;
            dist4=mat4_trans*inv(matriz_var_cov_clase_4)*mat1_4;
            dist5=mat5_trans*inv(matriz_var_cov_clase_5)*mat1_5;
            dist6=mat6_trans*inv(matriz_var_cov_clase_6)*mat1_6;

            %calculo de la parte superior de la fracción
            sup1=exp(-0.5*(dist1));
            sup2=exp(-0.5*(dist2));
            sup3=exp(-0.5*(dist3));
            sup4=exp(-0.5*(dist4));
            sup5=exp(-0.5*(dist5));
            sup6=exp(-0.5*(dist6));

            %calculo de la parte inferior de la fracción
            inf1=(2*pi)*det(matriz_var_cov_clase_1)^(0.5);
            inf2=(2*pi)*det(matriz_var_cov_clase_2)^(0.5);
            inf3=(2*pi)*det(matriz_var_cov_clase_3)^(0.5);
            inf4=(2*pi)*det(matriz_var_cov_clase_4)^(0.5);
            inf5=(2*pi)*det(matriz_var_cov_clase_5)^(0.5);
            inf6=(2*pi)*det(matriz_var_cov_clase_6)^(0.5);

            %calculo de las probabilidades
            probabilidad_1=sup1/inf1;
            probabilidad_2=sup2/inf2;
            probabilidad_3=sup3/inf3;
            probabilidad_4=sup4/inf4;
            probabilidad_5=sup5/inf5;
            probabilidad_6=sup6/inf6;

            sumatoria_probabilidades = probabilidad_1+probabilidad_2+probabilidad_3+probabilidad_4+probabilidad_5+probabilidad_6;
    
            probabilidad_total_1 = (probabilidad_1/sumatoria_probabilidades)*100;
            probabilidad_total_2=(probabilidad_2/sumatoria_probabilidades)*100;
            probabilidad_total_3=(probabilidad_3/sumatoria_probabilidades)*100;
            probabilidad_total_4=(probabilidad_4/sumatoria_probabilidades)*100;
            probabilidad_total_5=(probabilidad_5/sumatoria_probabilidades)*100;
            probabilidad_total_6=(probabilidad_6/sumatoria_probabilidades)*100;

            probabilidades=[probabilidad_total_1, probabilidad_total_2,probabilidad_total_3,probabilidad_total_4,probabilidad_total_5,probabilidad_total_6];

            probabilida_maxima=max(max(probabilidades));

            clase_pert=find(probabilidades == probabilida_maxima);

            fprintf("El vector tiene una probabilidad del %f pertenecer a la clase %d\n",probabilida_maxima,clase_pert);

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

             continuar = input('Desea regresar al menú? 0.No, 1.Si ');

        case 4
            disp('Hasta luego')
            exit
        otherwise
            disp('Seleccione una opción valida, presione una tecla para continuar')
            pause
    end 
end
