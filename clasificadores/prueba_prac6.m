clc 
clear all 
close all
warning off all

%Autores:
%Martinez Luna Adad Marcel
%Johan Campos Ocampo
%Jose María (chema)
%fecha: 17/11/22

%este programa hace uso de un perceptron en 3 dimensiones, de tal manera
%que permite clasificar un cubo unitario que posee 2 clases con un plano
%tridimensional, se intento con combinaciones de ejes (xy,xz,yz) pero itera
%ba infinitamente.

%Declaración de clases

clas1_x=[0,1,1,1];
clas1_y=[0,0,0,1];
clas1_z=[0,0,1,0];


clas2_x=[0,0,0,1];
clas2_y=[0,1,1,1];
clas2_z=[1,1,0,1];

clas1 = [clas1_x;clas1_y;clas1_z];

clas2 = [clas2_x;clas2_y;clas2_z];

%perceptron de 3 dimensiones

iteraciones=1; %contador de iteraciones
x0=1; 
w0=1;
r=1; 
w1=1; 
w2=1;
w3=1;
cambios=[1,1,1,1,1,1,1,1]; %arreglo que detecta los cambios
ind=1; %contador de los elementos dentro de la clase

%calculos
%En este caso podria haberce hecho recursivamente, pero es más laborioso
while (cambios(1)==1 || cambios(2)==1 || cambios(3)==1 || cambios(4)==1) || ind~=9
    %X_n^T W>=0 => X_n in C_1 --> Wn+1 = Wn-rXn
    %X_n^T W<=0 => X_n in C_2 --> Wn+rXn
    %r>0
    %fprintf("\nIteración %d \n",iteraciones_xy);
    if ind == 1
        fprintf("\n+++++++++++++++++++++++++++++__%d__++++++++++++++++++++++++++++++++++\n",iteraciones);
    end
    if ind < 5 && iteraciones == 1
        fprintf("******\n[%d , %d]\n",clas1(1,ind),clas1(2,ind));
        X=[clas1(1,ind),clas1(2,ind),clas1(3,ind),x0]%x
        W=[w1,w2,w3,w0]%w
        Wt=W';%trans w
        fsal=X*Wt
        Xt=X';
        if fsal >=0
            fprintf("\nMala clasificación \n");
            Wt=Wt-(r*Xt);
            W=Wt';%w
            cambios(ind)=1;
        else
            cambios(ind)=0;
        end
    elseif ind < 5 && iteraciones > 1
        fprintf("******\n[%d , %d]\n",clas1(1,ind),clas1(2,ind));
        X=[clas1(1,ind),clas1(2,ind),clas1(3,ind),x0]%x
        fsal=X*Wt
        Xt=X';
        W
        if fsal >=0
            fprintf("\nMala clasificación \n");
            Wt=Wt-(r*Xt);
            W=Wt';%w
            cambios(ind)=1;
        else
            cambios(ind)=0;
        end
    else
        if ind > 8
            ind=8;
        end
        x1=clas2(1,ind-4);
        x2=clas2(2,ind-4);
        x3=clas2(3,ind-4);
        fprintf("\n    ----------------------------------------    \n");
        fprintf("******\n[%d , %d]\n",x1,x2);
        X=[x1,x2,x3,x0]%x
        W
        Wt=W';
        fsal=X*Wt
        if fsal <=0
            fprintf("\nMala clasificación \n");
            Xt=X';
            Wt=Wt+(r*Xt);
            W=Wt';%w
            cambios(ind)=1;
            if ind == 5
                temp2=W;
                f_temp2 = fsal;
                vecx2=X;
            end
        else
            cambios(ind)=0;
            c_xy = cambios(ind);
            if ind == 8 && (cambios(1)==1 || cambios(2)==1 || cambios(3)==1 || cambios(4)==1)
                ind=0;
                iteraciones = iteraciones +1;
                fprintf("\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
            end
        end
    end
        
ind = ind+1;
        
end
fprintf("Iteraciones: %d\n%f x1 + %f x2 + %f x3 = 1\n",iteraciones,Wt(1),Wt(2),Wt(3));


%Sección del ploteo tridimensional
plot3(clas1(1,:),clas1(2,:),clas1(3,:),'r*','MarkerFaceColor','r','MarkerSize',15);
hold on
grid on
plot3(clas2(1,:),clas2(2,:),clas2(3,:),'g+','MarkerFaceColor','g','MarkerSize',15);
[x,y]=meshgrid(-1:0.1:1.5);
z=(Wt(1)/-Wt(3))*x+(Wt(2)/-Wt(3))*y+0.5;
surf(x,y,z);

legend('Clase 1','Clase 2','Plano');