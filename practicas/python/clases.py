import random as rd
import numpy as np
from tokenize import Double

class Conj:
    def __init__(self,cant, dispx, dispy, cenx, ceny, vecx, vecy):
        self.cant=cant
        self.dispx=dispx
        self.dispy=dispy
        self.cenx=cenx
        self.ceny=ceny
        self.vecx=vecx
        self.vecy=vecy
    
creadas = []
vec_x = []
vec_y = []

def crear_clases(cantidad_clases):
    cantidad_elem=int(input("indique la cantidad de elementos por clase \n"))
    for i in range(0,cantidad_clases):
        np.random.seed(rd.random()*(rd.random())*35)
        print("clase ",i+1)
        disp_x = int(input("indique la dispersion en x de la clase \n"))
        disp_y = int(input("indique la dispersion en y de la clase \n"))
        cen_x = int(input("indique la coordenada en x del centroide de la clase \n"))
        cen_y = int(input("indique la coordenada en y del centroide de la clase \n"))
        for nm in range(0,cantidad_elem):
            vec_x.append(int((np.random.rand()+cen_x)*disp_x))
            vec_y.append(int((np.random.rand()+cen_y)*disp_y))
        creadas.append(Conj(cantidad_elem,disp_x,disp_y,cen_x,cen_y,vec_x,vec_y))
    return creadas

def ver_instancias():
    for j in range(0,len(creadas)):  
        print("------------------------------------------")
        print("clase ",j+1)
        print("cantidad de elementos: ",creadas[j].cant)
        print("disperson eje x: ",creadas[j].dispx)
        print("dispersion eje y: ",creadas[j].dispy)
        print("centroide eje x: ",creadas[j].cenx)
        print("centroide eje y: ",creadas[j].ceny)
        print("vectores en x: ",creadas[j].vecx)
        print("vectores en y: ",creadas[j].vecy)
        print("------------------------------------------")

def declarar_vector():
    vx=input("indique la coordenada x del vector \n")
    vy=input("indique la coordenada x del vector \n")
    vector=[int(vx),int(vy)]
    return vector

def iniciar():
    vector=declarar_vector()
    cant_clases=int(input("inidique la cantidad de clases a generar \n"))
    cls = crear_clases(cant_clases)
    ver_instancias()
    print("vector a clasfificar: ",vector)

if __name__ != '__clases__':
    print("iniciando programa")
    iniciar()
