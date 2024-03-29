clc %Limpia la pantalla
clear all %limpia todas las variables
close all %cierra todo
warning off all %evita llamadas de atención

usuario = input("Indique quien esta haciendo uso del software en este monento \n1.-Johan\n2.-Adad\n3.-Chema\n");

if (usuario == 1)
        nombre = "C:\Users\Johan\Documents\GitHub\Matlab\Proyecto\Imagenes\IMG";
        nombreInicialArchivo = "IMG";
        extension = ".BMP";
        nombreFinal = "C:\Users\Johan\Documents\GitHub\Matlab\Proyecto\Imagenes\IMG066.bmp";
        imagen = imread(nombreFinal);
        imagen = im2gray(imagen);
        imagen = imbinarize(imagen);
        figure(1)
        imagen = bwareaopen(imagen,30);
        imagen = imfill(imagen,'holes');
        imshow(imagen);
        stats = regionprops(imagen,"Perimeter","Area","Centroid","BoundingBox","Circularity",'Extrema',"ConvexArea");
        for i =1 : length(stats)
            x = stats(i).BoundingBox;
            rectangle("Position",[x(1),x(2),x(3),x(4)],"EdgeColor","r","LineWidth",2);
            text(stats(i).Centroid(1),stats(i).Centroid(2),num2str(i),"Color","g");
        end

        %totalImagenes = 39;
        %nombres = gtr(nombreInicialArchivo,extension,totalImagenes,nombre);
        %for imag = 1:1:length(nombres)
        %    ver_imagenes(nombres(imag));
        %    pausa = input("Cotinuar?  ");
        %end
elseif (usuario == 2)
        nombre = "C:\Users\19286463\Desktop\Escom\semestre actual\pattern\github\Matlab\Proyecto\Imagenes\IMG";
        nombreInicialArchivo = "IMG";
        extension = ".bmp";
        totalImagenes = 55;
        nombres = gtr(nombreInicialArchivo,extension,totalImagenes,nombre);
        for imag = 1:1:length(nombres)
            ver_imagenes(nombres(imag));
            imag
            pausa = input("Cotinuar?  ");
        end
elseif (usuario == 3)
        nombre = "C:\Users\19286463\Desktop\Escom\semestre actual\pattern\proyecto\base_2\bmp\IMG";
        nombreInicialArchivo = "IMG";
        extension = ".bmp";
        totalImagenes = 55;
        nombres = gtr(nombreInicialArchivo,extension,totalImagenes,nombre);
        for imag = 1:1:length(nombres)
            ver_imagenes(nombres(imag));
            pausa = input("Cotinuar?  ");
        end
end
%funcones utiles para el futuro:
% imagen_jpg = imread("C:\Users\19286463\Desktop\Escom\semestre actual\pattern\proyecto\jpg\IMG001.jpg");
%imwrite(imagen_jpg,"C:\Users\19286463\Desktop\Escom\semestre actual\pattern\proyecto\bmp\IMG001.bmp");
%imwrite(imagen_jpg,"C:\Users\19286463\Desktop\Escom\semestre actual\pattern\proyecto\bmp\IMG999.bmp");
%F = imread("C:\Users\19286463\Desktop\Escom\semestre actual\pattern\proyecto\bmp\IMG999.bmp")
%[IND,map] = rgb2ind(imagen_jpg,64);
%imagesc(IND)
%colormap(map)

function get_rts = gtr(nombreInicialArchivo,extension,totalImagenes,nombre)
    numero = "";
    imagenes = [""];
    %Lectura de las imagenes
    contador = 1;
    for i=1:+1:totalImagenes
         if i<10
            numero = "00";
        elseif i<100
            numero = "0";
        else
            numero = "";
        end
        texto = strcat(nombre,numero,num2str(i),extension);
        imagenes(contador) = texto;
        contador = contador + 1;
    end
   get_rts = imagenes; 
end

function imgs = ver_imagenes(ruta_imagen)
    objetosGuardados = 0;
    imagen = imread(ruta_imagen);
    imagen = im2gray(imagen);
    imagen = imresize(imagen,[1700,1700]);
    imagen = imbinarize(imagen);
    imagen = bwareaopen(imagen,30);
    imagen = imfill(imagen,'holes');
    imshow(imagen);
    stats = regionprops(imagen,"Area","Centroid","Circularity","ConvexArea");
    stats_1 = regionprops(imagen,"Perimeter","Area","Centroid","BoundingBox","Circularity",'Extrema',"ConvexArea");
    for i =1:1:length(stats)
            ttmmp = stats_1(i).BoundingBox;
            rectangle("Position",[ttmmp(1),ttmmp(2),ttmmp(3),ttmmp(4)],"EdgeColor","r","LineWidth",2);
            text(stats(i).Centroid(1),stats(i).Centroid(2),strcat("Objeto ",num2str(i)),"Color","g");
    end
    datos = split(ruta_imagen,'\');
    nombre = split(datos(length(datos)),'.');
    nombreInicialArchivo = nombre(1);
    extension = nombre(2);
    numero = "";
    for j = 1:1:length(stats)
        nombre = "obj";
        objetosGuardados = objetosGuardados + 1;
        nombre = strcat(nombre,num2str(j),nombreInicialArchivo,numero,extension);
        nombreObjeto(objetosGuardados,1) = nombre;
        area(objetosGuardados,1) = stats(j).Area;
        circularidad(objetosGuardados,1) = stats(j).Circularity;
        convexArea(objetosGuardados,1) = stats(j).ConvexArea;
    end
end