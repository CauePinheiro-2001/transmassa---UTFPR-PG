import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import quad
import sympy as sp


# Função a ser integrada
def integrand(x):
    return (1 / (((a*x) + b)**2))

#Função a ser integrada de Ca
def integrand_Ca(Cax):
    return 1 / (Ct - Cax)


# Intervalo de x de 0 a 2 metros
x1 = 0
x2 = 2

# Número de pontos para avaliação
num_points = 21

# Definição das variáveis fornecidas
Ca1 = 10
Ca2 = 3
Ct = 1000
Dam = 10e-4
r1 = 0.1
r2 = 0.35

# Lista para armazenar os resultados de Ca
Ca_values = []

#Declarando a e b
a = (r2-r1)/(x2-x1)
b = (r1)-(((r2-r1)/(x2-x1))*x1)

#Calculando integrais:

# Calcular a integral de Ca de Ca1 a Ca2
IntCa, _ = quad(integrand_Ca, Ca1, Ca2)

#Integral calculada de x:
IntX = 57.14612

#Calculando Na

Na = (-np.pi)*Dam*Ct*(IntCa/IntX)

# Calcular Ca para diferentes valores de x
for x in np.linspace(x1, x2, num_points):
    # Calcular a integral
    integral, _ = quad(integrand, x1, x)



    # Calcular Ca usando a equação fornecida
    Ca = (Ct - ((Ct - Ca1) * (np.exp((Na * integral) / (np.pi * Dam * Ct)))))
    #Ca_values.append(Ca)

    #Ca = Ct-((np.exp(((-integral*IntCa)/IntX)))*(Ct-Ca1))
    #Ca = np.maximum(0, Ct - ((np.exp(((-integral * IntCa) / IntX))) * (Ct - Ca1)))
    #Ca = np.maximum(0, Ca)
    Ca_values.append(Ca)



# Gerar o gráfico
plt.plot(np.linspace(x1, x2, num_points), Ca_values, label='Ca')
plt.xlabel('x (metros)')
plt.ylabel('Ca (Kg/m^3)')
plt.title('Concentração de A (Ca) ao longo de x')
plt.legend()
#plt.grid(True)
plt.show()
