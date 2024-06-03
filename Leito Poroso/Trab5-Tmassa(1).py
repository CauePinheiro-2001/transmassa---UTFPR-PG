import numpy as np
import pyomo.environ as pyo
from numpy import pi
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

#variaveis
L=0.5
Dam=10**-4
P=1.3*10**5
Patm=10**5
Rg=8.314
T=1273

#Equação de Fração vazia
# E= 1000*R + 0,21

#Equação de Tortuosidade
# T= (4*10**7)*(R**2) -27714*(R) +6,6

#Variação da de R1
yinf = 0.0001
ysup = 0.0005
py = 0.000025

# Variação de espessura
zinf = 0.0001
zsup = 0.0005
pz = 0.000025

# Variação de Volume
xinf = pi*((yinf+zinf)**2-yinf**2)*L
xsup = pi*((ysup+zsup)**2-ysup**2)*L
px = 5.655*(10**-8)

pxs = 0.01
pys = 0.01
pzs = 0.01

Nx = int((xsup - xinf) / px) + 1
Ny = int((ysup - yinf) / py) + 1
Nz = int((zsup - zinf) / pz) + 1

x = np.linspace(xinf, xsup, Nx)
y = np.linspace(yinf, ysup, Ny)
z = np.linspace(zinf, zsup, Nz)

xfatia = np.arange(xinf, xsup + pxs, pxs)
yfatia = np.arange(yinf, ysup + pys, pys)
zfatia = np.arange(zinf, zsup + pzs, pzs)

V, R1, Espessura = np.meshgrid(x, y, z)

# Equação integrando as equações de tortuosidade e Fração vazia por R1 até R2
I = 40000 * (R1 + Espessura) - 40000 * R1 - 36.114 * (np.log(1000 * (R1 + Espessura) + 0.21) - np.log(1000 * R1 + 0.21)) - 31.42857 * (np.log(9524.93271 * (R1 + Espessura) + 2.00011) - np.log(9524.93271 * (R1 + Espessura) - 9524.93271 * R1 + 2.00011) + np.log(9524.93271 * R1 + 0.00011))

#Equação final de Na
Na = (-2 * pi * Dam * V * P * np.log(P / (P - Patm))) / (Rg * T * pyo.value(I)*pi*((R1+Espessura)**2+(R1)**2))

def fatia(x, y, z, Na, xfatia, yfatia, zfatia):
    s = []
    for xi in xfatia:
        for yi in yfatia:
            for zi in zfatia:
                indices = np.where((x == xi) & (y == yi) & (z == zi))
                if len(indices[0]) > 0:
                    xi_array = np.full_like(indices, xi)
                    yi_array = np.full_like(indices, yi)
                    zi_array = np.full_like(indices, zi)
                    s.append(ax.plot_surface(xi_array, yi_array, zi_array, alpha=0.01))
    return s

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

s1 = fatia(V, R1, Espessura, Na, xfatia, yfatia, zfatia)

# Define uma superfície mapeável para a barra de cores
sm = plt.cm.ScalarMappable(cmap='jet')
sm.set_array(Na)

ax.scatter(V, R1, Espessura, c=Na, cmap='jet')
plt.colorbar(sm)

plt.xlabel("Volume disponível")
plt.ylabel("Valor de R1")
ax.set_zlabel("Valor da Espessura do leito: R1 + Espessura = R2")
plt.title("Barra de cores: Vazão da espécie A (Na)")

plt.show()
