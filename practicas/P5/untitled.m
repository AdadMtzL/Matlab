%centroides = [1 2 3; 4 5 6 ]
centroides = []
disper = []
for i=1:2 
    for h = 1:2
        if h == 1
            centroides(h,i) = input("centroide clase "+i+" x: \t");
            continue
        end
        if h == 2
            centroides(h,i) = input("centroide clase "+i+" y: \t");
        end
    end
    disper(i) = input("dispersion clase "+i+" x: \n");
end

x = randn(2,100)

 for i = 1:100
     for j = 1:2
         x(j,i) = x(j,i) * disper(i);%10 es disp
     end
 end
 x