#importación de lo necesario
import random as rd
from statistics import median
import numpy as np
from tokenize import Double

#declaración de las variables globales
global vector

#Asignación de los elementos propios de la clase
class Conj:
    def __init__(self,cant, dispx, dispy, cenx, ceny, vecx, vecy):
        self.cant=cant
        self.dispx=dispx
        self.dispy=dispy
        self.cenx=cenx
        self.ceny=ceny
        self.vecx=vecx
        self.vecy=vecy
    

##Declaración de los vectores que guardaran la información necesaria
creadas = []
vec_x = []
vec_y = []


'''
Función encargada de crear las n clases con n elementos

parametros int

return list

'''
def crear_clases(cantidad_clases):
    cantidad_elem=int(input("indique la cantidad de elementos por clase \n"))
    for i in range(0,cantidad_clases):
        np.random.seed(rd.random()*(rd.random())*35+i)
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

'''
Función encargada de ver todas las clases generadas

parametros none

return none
'''
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

'''
Función encargada de obtener la coordenada x,y del vector a clasificar

Parametros none

return list
'''
def declarar_vector():
    vx=input("indique la coordenada x del vector \n")
    vy=input("indique la coordenada x del vector \n")
    vector=[int(vx),int(vy)]
    return vector

'''
Función encargada de obtener la distancia euclidiana

parametros list, list

return list
'''
def euclidiana():
    distancia_euc= []
    for no_clase in range(0,len(creadas)):
        media_x = np.mean(creadas[no_clase].vecx)
        media_y = np.mean(creadas[no_clase].vecy)
        r1 = vector[0]-media_x
        r2 = vector[0]-media_x
        distancia_euc.append(np.sqrt(np.power(r1)+np.power(r2)))

'''
Función encargada de obtener la distancia de mahalahobis

parametros list, list

return list
'''
def mahalahobis():
    distancia_mah = []

'''
Función encargada de obtener la probabilidad de pertenencia (maxima probabilidad)

parametros list, list

return list
'''
def max_prob():
    probs = []
    #e = np.exp()

'''
FUnción que permite ver una clase en especifico

parametros int

return none
'''
def ver_clase(no_clase):
    clase = no_clase-1
    print("------------------------------------------")
    print("clase ",no_clase+1)
    print("cantidad de elementos: ",creadas[clase].cant)
    print("disperson eje x: ",creadas[clase].dispx)
    print("dispersion eje y: ",creadas[clase].dispy)
    print("centroide eje x: ",creadas[clase].cenx)
    print("centroide eje y: ",creadas[clase].ceny)
    print("vectores en x: ",creadas[clase].vecx)
    print("vectores en y: ",creadas[clase].vecy)
    print("------------------------------------------")

def menu():
    print("Bienvenido al menu, las opciones a elegir son las siguientes: \n")
    print("0 - salir\n 1 - Definir el vector desconocido \n 2 - definir las clases \n 3 - ver todas las clases \n")
    print("4 - ver una clase en especifico\n 5 - distancia euclidiana \n 6 - distancia mahalahobis \n 7 - maxima probabilidad \n")
    opc = int(input("Indique a opcion a realizar \t"))
    while (opc != 0):
        if(opc == 1):
            vector = declarar_vector()
            menu()
        elif( opc == 2):
            cant_clases=int(input("inidique la cantidad de clases a generar \n"))
            cls = crear_clases(cant_clases)
            menu()
        elif( opc == 3):
            ver_instancias()
            menu()
        elif( opc == 4):
            no_clase = input("Indique la clase a ver")
            ver_clase(no_clase) 
            menu()           
        elif( opc == 5):
            euclidiana()
            menu()
        elif( opc == 6):
            mahalahobis()
            menu()                        
        elif( opc == 7):
            max_prob()
            menu()
        elif(opc<0 or opc >7):
            menu()

'''
Segmento de código necesario para iniciaizar el programa
'''
if __name__ != '__clases__':
    print("iniciando programa")
    menu()
