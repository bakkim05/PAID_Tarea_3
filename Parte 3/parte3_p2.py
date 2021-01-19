import numpy as np
import matplotlib.pyplot as plt
from PIL import Image, ImageOps
# from scipy.signal import convolve2d
# from scipy.ndimage import gaussian_filter, sobel
# from scipy.ndimage.morphology import binary_erosion
# from canny_edge_detector import cannyEdgeDetector as ced
import cv2

#Cargar Imagen
# A = Image.open("images/imagen1.png")

#Grayscale
# A = ImageOps.grayscale(A)
# A = np.asarray(A).astype("float64")/255

# #Gausiano
# A = gaussian_filter(A, sigma= 0.5)

# #Sobel
# Cx = sobel(A,axis=0, mode="constant")
# Cy = sobel(A,axis=1, mode="constant")
# C = np.sqrt(np.square(Cx) + np.square(Cy))
# T = 0.5
# C[C<T] = 0
# C[C>=T] = 1
# C = binary_erosion(C,structure=np.ones((2,2)))
# plt.imshow(C, cmap =plt.cm.gray)
# plt.show()

#Canny
A = cv2.imread("images/imagen1.png")
plt.imshow(A, cmap = plt.cm.gray)
A = cv2.GaussianBlur(A,(3,3),0)
C = cv2.Canny(A,240,255)


# plt.show()

C = np.asarray(C).astype("float64")/255

#Dimensiones
m,n = np.shape(C)

#---------------------------------------HOUGH---------------------------------------
#Encontrar los puntos de la imagen
x_borde,y_borde = np.where(C==1)

#Matriz de Acumulacion
step = 1
p = np.sqrt(m**2 + n**2)

a_rango = np.arange(0,m,step)
b_rango = np.arange(0,n,step)
r_rango = np.arange(0,p,step)

acumulador = np.zeros((len(a_rango),len(b_rango),len(r_rango)))
for i in range(len(x_borde)):
    print(str(i) + " of " + str(len(x_borde)))
    for a_indice in range(len(a_rango)):
        for b_indice in range(len(b_rango)):
            a = a_rango[a_indice]
            b = b_rango[b_indice]

            x = x_borde[i]
            y = y_borde[i]

            r = np.sqrt(np.square(x-a) + np.square(y-b))
            if r != 0:
                r_indice = np.argmin(np.abs(r_rango - r))
                # acumulador[a_indice,b_indice,r_indice] += 1 #prueba
                acumulador[a_indice,b_indice,r_indice] += 1/(2*np.pi*r)

#----------------------------------------------------------------------------------

#Dibujar circulos
x_circulo, y_circulo, r_circulo = np.where(acumulador >= 0.50) #INDICES DONDE SE CUMPLEN LA CONDICION
# print(x_circulo)
# print(y_circulo)
# print(r_circulo)


for i in range(len(x_circulo)):
    x = a_rango[x_circulo[i]]
    y = b_rango[y_circulo[i]]
    r = r_rango[r_circulo[i]]
    plt.gca().add_patch(plt.Circle((y,x),r,color = "r", fill=False))


# for i in range(len(x_circulo)):
#     plt.gca().add_patch(plt.Circle((y_circulo[i],x_circulo[i]),r_circulo[i],color = "r", fill=False))

#plot
plt.xlim([0,n])
plt.ylim([m,0])
plt.show()