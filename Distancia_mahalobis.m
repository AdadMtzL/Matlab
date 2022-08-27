clc
close all
clear all
warning off all

c1 = [1 2 3 2 3; 2 2 4 7 9];
c2 = [3 4 7 8 9; 5 6 -1 2 3];
c3 = [10 10 11 12 13; 1 7 4 -2 9];
vector=[7; 5];

m1 = mean(c1,2);
m2 = mean(c2,2);
m3 = mean(c3,2);

mat1=c1-m1;
transm1=transpose(m1);
temp1=m1*transm1;
m1inversa=inv(temp1);
d1=transm1*m1inversa*vector
%deberia ser 12.56

mat2=c2-m2;
transm2=transpose(m2);
temp2=m2*transm2;
m2inversa=inv(temp2);
d2=transm2*m2inversa*vector
%deberia ser 0.3833

mat3=c3-m3;
transm3=transpose(m3);
temp3=m3*transm3;
m3inversa=inv(temp3); %debe de ser cuadrada la matriz para invertir
d3=transm3*m3inversa*vector
%deberia ser 2.7830
