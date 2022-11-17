clc 
clear all 
close all
warning off all

%Declaración de clases

clas1_x=[0,1,1,1];
clas1_y=[0,0,0,1];
clas1_z=[0,0,1,0];


clas2_x=[0,0,0,1];
clas2_y=[0,1,1,1];
clas2_z=[1,1,0,1];

clas1 = [clas1_x;clas1_y;clas1_z];

clas2 = [clas2_x;clas2_y;clas2_z];
%--------------------------------------------------------------------------------------------------------------------
%calculo de las x,y

iteraciones_xy=1; 
x0_xy=1;
w0_xy=1;
r_xy=6;
w1_xy=1;
w2_xy=1;
cambios_xy=[1,1,1,1,1,1,1,1];
ind_xy=1;

%fprintf("*-----------------------XY----------------------------*\n");
%fprintf("X \n");
%fprintf("c1 \n");
%las1(1,:)
%fprintf("c2 \n");
%clas2(1,:)
%fprintf("Y \n");
%fprintf("c2 \n");
%clas2(2,:)
%fprintf("c1 \n");
%clas1(2,:)

while (cambios_xy(1)==1 || cambios_xy(2)==1 || cambios_xy(3)==1 || cambios_xy(4)==1) || ind_xy~=9
    %X_n^T W>=0 => X_n in C_1 --> Wn+1 = Wn-rXn
    %X_n^T W<=0 => X_n in C_2 --> Wn+rXn
    %r>0
    %fprintf("\nIteración %d \n",iteraciones_xy);
    if ind_xy < 5 && iteraciones_xy == 1
        fprintf("******\n[%d , %d]\n",clas1(1,ind_xy),clas1(2,ind_xy));
        X_xy=[clas1(1,ind_xy),clas1(2,ind_xy),x0_xy];%x
        W_xy=[w1_xy,w2_xy,w0_xy];%w
        Wt_xy=W_xy';%trans w
        fsal_xy=X_xy*Wt_xy;
        Xt_xy=X_xy';
        if fsal_xy >=0
            fprintf("\nMala clasificación \n");
            Wt_xy=Wt_xy-(r_xy*Xt_xy);
            W_xy=Wt_xy';%w
            cambios_xy(ind_xy)=1;
            c_xy = cambios_xy(ind_xy);
            if ind_xy == 3
                temp=W_xy;
                f_temp = fsal_xy;
                vecx=X_xy;
            end
        else
            cambios_xy(ind_xy)=0;
            c_xy = cambios_xy(ind_xy);
        end
    elseif ind_xy < 5 && iteraciones_xy > 1
        fprintf("******\n[%d , %d]\n",clas1(1,ind_xy),clas1(2,ind_xy));
        X_xy=[clas1(1,ind_xy),clas1(2,ind_xy),x0_xy];%x
        fsal_xy=X_xy*Wt_xy;
        Xt_xy=X_xy';
        W_xy;
        if fsal_xy >=0
            fprintf("\nMala clasificación \n");
            Wt_xy=Wt_xy-(r_xy*Xt_xy);
            W_xy=Wt_xy';%w
            cambios_xy(ind_xy)=1;
            c_xy = cambios_xy(ind_xy);
        else
            cambios_xy(ind_xy)=0;
            c_xy = cambios_xy(ind_xy);
        end
    else
        if ind_xy > 8
            ind_xy=8;
        end
        x1=clas2(1,ind_xy-4);
        x2=clas2(2,ind_xy-4);
        fprintf("\n    ----------------------------------------    \n");
        fprintf("******\n[%d , %d]\n",x1,x2);
        X_xy=[x1,x2,x0_xy];%x
        W_xy;
        Wt_xy=W_xy';
        fsal_xy=X_xy*Wt_xy;
        if fsal_xy <=0
            fprintf("\nMala clasificación \n");
            Xt_xy=X_xy';
            Wt_xy=Wt_xy+(r_xy*Xt_xy);
            W_xy=Wt_xy';%w
            cambios_xy(ind_xy)=1;
            if ind_xy == 5
                temp2=W_xy;
                f_temp2 = fsal_xy;
                vecx2=X_xy;
            end
        else
            cambios_xy(ind_xy)=0;
            c_xy = cambios_xy(ind_xy);
            if ind_xy == 8 && (cambios_xy(1)==1 || cambios_xy(2)==1 || cambios_xy(3)==1 || cambios_xy(4)==1)
                ind_xy=0;
                iteraciones_xy = iteraciones_xy +1;
                W_xy
                Wt_xy
                temp
                f_temp
                vecx

                temp2
                f_temp2
                vecx2

                cambios_xy
                fprintf("\n******------------------------------------******\n")
                pausa = input('Hola     ');
                fprintf("\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n")
            end
        end
    end
        
ind_xy = ind_xy+1;
        
end
fprintf("Iteraciones: %d\n%f x1 + %f x2 -1 =0\n",iteraciones_xy,Wt_xy(1),Wt_xy(2));
Wtt_xy=-1*Wt_xy(2);
M_xy=Wt_xy(1)/Wtt_xy;
B_xy=-1/Wtt_xy;
fprintf("Ecuación: x2 = %f X %f \n",M_xy,B_xy);

%--------------------------------------------------------------------------------------------------------------------
%calculo de las y,z

iteraciones_yz=1; 
x0_yz=1;
w0_yz=1;
r_yz=5;
w1_yz=1;
w2_yz=1;
cambios_yz=[1,1,1,1,1,1,1,1];
ind_yz=1;

fprintf("\n*-----------------------YZ----------------------------*\n");


while (cambios_yz(1)==1 || cambios_yz(2)==1 || cambios_yz(3)==1 || cambios_yz(4)==1) || ind_yz~=9
    %X_n^T W>=0 => X_n in C_1 --> Wn+1 = Wn-rXn
    %X_n^T W<=0 => X_n in C_2 --> Wn+rXn
    %r>0
    fprintf("Iteración %d \n",iteraciones_yz);
    if ind_yz < 5 && iteraciones_yz == 1
        fprintf("[%d , %d]\n",clas1(1,ind_yz),clas1(2,ind_yz));
        X_yz=[clas1(2,ind_yz),clas1(3,ind_yz),x0_yz];%x
        W_yz=[w1_yz,w2_yz,w0_yz];%w
        Wt_yz=W_yz';%trans w
        fsal_yz=X_yz*Wt_yz;
        Xt_yz=X_yz';
        if fsal_yz >=0
            fprintf("\nMala clasificación \n");
            Wt_yz=Wt_yz-(r_yz*Xt_yz);
            W_yz=Wt_yz';%w
            cambios_yz(ind_yz)=1;
            c_xz = cambios_yz(ind_yz);
        else
            cambios_yz(ind_yz)=0;
            c_xz = cambios_yz(ind_yz);
        end
    elseif ind_yz < 5 && iteraciones_yz > 1
        fprintf("[%d , %d]\n",clas1(1,ind_yz),clas1(2,ind_yz));
        X_yz=[clas1(2,ind_yz),clas1(3,ind_yz),x0_yz];%x
        fsal_yz=X_yz*Wt_yz;
        Xt_yz=X_yz';
        W_yz;
        if fsal_yz >=0
            fprintf("\nMala clasificación \n");
            Wt_yz=Wt_yz-(r_yz*Xt_yz);
            W_yz=Wt_yz';%w
            cambios_yz(ind_yz)=1;
            c_xz = cambios_yz(ind_yz);
        else
            cambios_yz(ind_yz)=0;
            c_xz = cambios_yz(ind_yz);
        end
    else
        if ind_yz > 8
            ind_yz=8;
        end
        x1=clas2(2,ind_yz-4);
        x2=clas2(3,ind_yz-4);
        fprintf("\n    ----------------------------------------    \n");
        fprintf("[%d , %d]\n",x1,x2);
        X_yz=[x1,x2,x0_yz];%x
        W_yz;
        Wt_yz=W_yz';
        fsal_yz=X_yz*Wt_yz;
        if fsal_yz <=0
            fprintf("\nMala clasificación \n");
            Xt_yz=X_yz';
            Wt_yz=Wt_yz+(r_yz*Xt_yz);
            W_yz=Wt_yz';%w
            cambios_yz(ind_yz)=1;
        else
            cambios_yz(ind_yz)=0;
            c_xz = cambios_yz(ind_yz);
            if ind_yz == 8 && (cambios_yz(1)==1 || cambios_yz(2)==1 || cambios_yz(3)==1 || cambios_yz(4)==1)
                ind_yz=0;
                iteraciones_yz = iteraciones_yz +1;
                fprintf("\n******------------------------------------******\n")
            end
        end
    end
        
ind_yz = ind_yz+1;
        
end
fprintf("Iteraciones: %d\n%f x1 + %f x2 -1 =0\n",iteraciones_yz,Wt_yz(1),Wt_yz(2));
Wtt_yz=-1*Wt_yz(2);
M_yz=Wt_yz(1)/Wtt_yz;
B_yz=-1/Wtt_yz;
fprintf("Ecuación: x2 = %f X %f \n",M_yz,B_yz);


%--------------------------------------------------------------------------------------------------------------------
%calculo de las x,z

iteraciones_xz=1; 
x0_xz=1;
w0_xz=1;
r_xz=8;
w1_xz=1;
w2_xz=1;
cambios_xz=[1,1,1,1,1,1,1,1];
ind_xz=1;

fprintf("\n*-----------------------XZ----------------------------*\n");

while (cambios_xz(1)==1 || cambios_xz(2)==1 || cambios_xz(3)==1 || cambios_xz(4)==1) || ind_xz~=9
    %X_n^T W>=0 => X_n in C_1 --> Wn+1 = Wn-rXn
    %X_n^T W<=0 => X_n in C_2 --> Wn+rXn
    %r>0
    fprintf("Iteración %d \n",iteraciones_xz);
    if ind_xz < 5 && iteraciones_xz == 1
        fprintf("[%d , %d]",clas1(1,ind_xz),clas1(2,ind_xz));
        X_xz=[clas1(1,ind_xz),clas1(3,ind_xz),x0_xz];%x
        W_xz=[w1_xz,w2_xz,w0_xz];%w
        Wt_xz=W_xz';%trans w
        fsal_xz=X_xz*Wt_xz;
        Xt_xz=X_xz';
        if fsal_xz >=0
            fprintf("\nMala clasificación \n");
            Wt_xz=Wt_xz-(r_xz*Xt_xz);
            W_xz=Wt_xz';%w
            cambios_xz(ind_xz)=1;
            c_xz = cambios_xz(ind_xz);
        else
            cambios_xz(ind_xz)=0;
            c_xz = cambios_xz(ind_xz);
        end
    elseif ind_xz < 5 && iteraciones_xz > 1
        fprintf("[%d , %d] \n",clas1(1,ind_xz),clas1(2,ind_xz));
        X_xz=[clas1(1,ind_xz),clas1(3,ind_xz),x0_xz];%x
        fsal_xz=X_xz*Wt_xz;
        Xt_xz=X_xz';
        W_xz;
        if fsal_xz >=0
            fprintf("\nMala clasificación \n");
            Wt_xz=Wt_xz-(r_xz*Xt_xz);
            W_xz=Wt_xz';%w
            cambios_xz(ind_xz)=1;
            c_xz = cambios_xz(ind_xz);
        else
            cambios_xz(ind_xz)=0;
            c_xz = cambios_xz(ind_xz);
        end
    else
        if ind_xz > 8
            ind_xz=8;
        end
        x1=clas2(1,ind_xz-4);
        x2=clas2(3,ind_xz-4);
        fprintf("\n    ----------------------------------------    \n");
        fprintf("[%d , %d]\n",x1,x2);
        X_xz=[x1,x2,x0_xz];%x
        W_xz;
        Wt_xz=W_xz';
        fsal_xz=X_xz*Wt_xz;
        if fsal_xz <=0
            fprintf("\nMala clasificación \n");
            Xt_xz=X_xz';
            Wt_xz=Wt_xz+(r_xz*Xt_xz);
            W_xz=Wt_xz';%w
            cambios_xz(ind_xz)=1;
        else
            cambios_xz(ind_xz)=0;
            c_xz = cambios_xz(ind_xz);
            if ind_xz == 8 && (cambios_xz(1)==1 || cambios_xz(2)==1 || cambios_xz(3)==1 || cambios_xz(4)==1)
                ind_xz=0;
                iteraciones_xz = iteraciones_xz +1;
                fprintf("\n******------------------------------------******\n")
            end
        end
    end
        
ind_xz = ind_xz+1;
        
end
fprintf("Iteraciones: %d\n%f x1 + %f x2 -1 =0\n",iteraciones_xz,Wt_xz(1),Wt_xz(2));
Wtt_xz=-1*Wt_xz(2);
M_xz=Wt_xz(1)/Wtt_xz;
B_xz=-1/Wtt_xz;
fprintf("Ecuación: x2 = %f X %f \n",M_xz,B_xz);


%----------------------------------------------------------------------------------------
%ploteo
plot3(c1(1,:),c1(2,:),c1(3,:),'r*','MarkerFaceColor','r','MarkerSize',15);
hold on
grid on
plot3(c2(1,:),c2(2,:),c2(3,:),'g+','MarkerFaceColor','g','MarkerSize',15);
legend('Clase 1','Clase 2');
    