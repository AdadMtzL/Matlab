clc
clear all
close all
warning off all
%programa del perceptron 

%or             |  |and            |  |xor            |  |??             |
%---------------|--|---------------|--|---------------|--|---------------|
%  A  |  B  | f |  |  A  |  B  | f |  |  A  |  B  | f |  |  A  |  B  | f |
% --------------|--|---------------|--|---------------|--|---------------|
%  0  |  0  | 0 |c1|  0  |  0  | 0 |  |  0  |  0  | 0 |  |  0  |  0  | 0 |
% --------------|--|---------------|  |---------------|c1|---------------|
%  0  |  1  | 1 |  |  0  |  1  | 0 |c1|  1  |  1  | 0 |  |  0  |  1  | 1 |
% --------------|  |---------------|  |---------------|--|---------------|
%  1  |  0  | 1 |c2|  1  |  0  | 0 |  |  1  |  0  | 1 |  |  1  |  0  | 1 |
% --------------|  |---------------|--|---------------|c2|---------------|
%  1  |  1  | 1 |  |  1  |  1  | 1 |c2|  1  |  1  | 1 |  |  1  |  1  | 1 |
%-------------------------------------------------------------------------


%código principal
opc=1;
while(opc~=0)
    opc=menu();
    if opc == 1 %or
        clas1=[0;0];
        clas2A=[0,1,1];
        clas2B=[1,0,1];
        clas2=[clas2A;clas2B];

        x0=1;
        w0=1;

        ind=1;
        iteraciones=1; 
        cambios=[1,1,1,1];
        r=1;
        w1=1;
        w2=1;

        while (cambios(1)==1 || cambios(2)==1 || cambios(3)==1 || cambios(4)==1) || ind~=5
        %X_n^T W>=0 => X_n in C_1 --> Wn+1 = Wn-rXn
        %X_n^T W<=0 => X_n in C_2 --> Wn+rXn
        %r>0
        

            if ind == 1 && iteraciones == 1
                fprintf("Iteración %d\n[%d , %d]",iteraciones,clas1(1),clas1(2));
                X=[clas1(1),clas1(2),x0]%x
                W=[w1,w2,w0]%w
                Wt=W';%trans w
                fsal=X*Wt
                Xt=X';
                if fsal >=0
                    fprintf("\nMala clasificación \n");
                    Wt=Wt-Xt;
                    W=Wt';%w
                    cambios(ind)=1;
                    c = cambios(ind)
                else
                    cambios(ind)=0;
                    c = cambios(ind)
                end
            elseif ind == 1 && iteraciones > 1
                fprintf("Iteración %d\n[%d , %d]",iteraciones,clas1(1),clas1(2));
                X=[clas1(1),clas1(2),x0]%x
                fsal=X*Wt
                Xt=X';
                W
                if fsal >=0
                fprintf("\nMala clasificación \n");
                Wt=Wt-Xt;
                W=Wt';%w
                cambios(ind)=1;
                c = cambios(ind)
                else
                    cambios(ind)=0;
                    c = cambios(ind)
                end
            else
                x1=clas2(1,ind-1);
                x2=clas2(2,ind-1);
                fprintf("    ----------------------------------------    \n");
                fprintf("[%d , %d]",x1,x2);
                X=[x1,x2,x0]%x
                W
                Wt=W';
                fsal=X*Wt
                if fsal <=0
                    fprintf("\nMala clasificación \n");
                    Xt=X';
                    Wt=Wt+Xt;
                    W=Wt';%w
                    cambios(ind)=1;
                else
                    cambios(ind)=0;
                    c = cambios(ind)
                    if ind == 4 && (cambios(1)==1 || cambios(2)==1 || cambios(3)==1 || cambios(4)==1)
                    ind=0;
                    iteraciones = iteraciones +1;
                    fprintf("******------------------------------------******\n")
                    end
                end
            end
        
        ind = ind+1;
        
        end
        fprintf("Iteraciones: %d\n%d x1 + %d x2 -1 =0\n",iteraciones,Wt(1),Wt(2));
%------------------------------------------------------------------------------
    elseif opc == 2 %and
        clas2=[1;1];

        clas1A=[0,0,1];
        clas1B=[0,1,0];
        clas1=[clas1A;clas1B];
        
        x0=1;
        w0=0;
        
        ind=1;
        cambios=1;
        while cambios~=0

        end
    elseif opc == 3 %xor
        clas1A=[0,0];
        clas1B=[0,1];
        clas1=[clas1A;clas1B];

        clas2A=[1,1];
        clas2B=[0,1];
        clas2=[clas2A;clas2B];

        x0=1;
        w0=0;

        ind=1;
        cambios=1;
        while cambios~=0
    
        end
    elseif opc == 0
        break;
    elseif opc > 3|| opc<0 
        opc = menu();
    end
end
%funciones
function m = menu()
    fprintf("\nBienvenido a los perceptrones de pattern recognition \n");
    fprintf("Las operaciones disponibles son las siguientes: \n");
    fprintf("0.- salir\n1.- Perceptron or\n2.-Perceptron and\n");
    fprintf("3.-Perceptron xor\n-------------------------\n");
    m = input('Indique otra operación a realizar  ----->  ');
end