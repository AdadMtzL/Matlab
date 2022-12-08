n=5; %número de lados
radio=3; %radio de la circunferencia 
x=radio*cos((0:n)*2*pi/n);
y=radio*sin((0:n)*2*pi/n);
%las coordenadas del último vértice son las del primer vértice
hold on
fill(x,y,'y')
plot(x,y,'-ro', 'markersize',4,'markeredgecolor','r','markerfacecolor','r')
hold off
xlabel('x')
ylabel('y')
axis equal
area=0;
for i=1:n
    area=area+(x(i+1)-x(i))*(y(i+1)+y(i))/2;
end
area=abs(area)
title (['Area del polígono regular: ' num2str(polyarea(x,y))]);