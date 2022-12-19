
function plotear(matClases,vectorPlot,inicio,fin)
colors = ['b','g','r','c','m','y','k','w'];
color = 1;

figure(1)
for i=1:length(inicio)
    
    ck = matClases(1:2,inicio(i):fin(i));
    plot(ck(1,:),ck(2,:),'ro','MarkerSize',10,'MarkerFaceColor',colors(color));
   
    color = color+1;
   
    grid on;
    hold on;
  
   
end

 hold on;
 plot(vectorPlot(1,:),vectorPlot(2,:),'ro','MarkerSize',15,'MarkerFaceColor','k');
 title('Grafica','FontSize',24);
 legend();

end