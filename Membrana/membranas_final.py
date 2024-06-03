# Programa para encontrar minimo de função
import pyomo.environ as pyo
import numpy as np
from numpy import pi
import matplotlib.pyplot as plt

model = pyo.ConcreteModel()

model.x1 = pyo.Var(within=pyo.NonNegativeReals,
                   bounds=(0.00001, 0.00002))  # x1 > =0  Dam=Coeficiente de difusão da espécie A
model.x2 = pyo.Var(within=pyo.NonNegativeReals,
                   bounds=(0.5, 0.8))  # x2 > = 0 Ca= Ct*Xa, Concentração da espécie A no final do escoamento

# Dados referentes ao problema!

# Fluxo volumétrica(Mol/m2*s)
F = 0.2
# Concentração inicial(mol/m3)
Cao = 1
# Raio interno da membrana(m)
RIn = 0.1
# Raio Externo da membrana(m)
Rout = 0.2
# Constante termodinamica(kJ/mol)
δ1 = 8.314

# Função a ser minimizada
model.obj = pyo.Objective(expr=(F * (Cao - model.x2) * pyo.log((Rout / RIn))) / (2 * pi * model.x1 * Cao * δ1))

# Resolvendo pelo ipopt
opt = pyo.SolverFactory('ipopt')
results = opt.solve(model)

# Imprimindo os resultados
pyo.assert_optimal_termination(results)

# Declarando um vetor 1D de 2 componentes
Vars = [0, 0]

# Armazenando o valor de x1 em Var[0]
Vars[0] = model.x1.value

# Armazenando o valor de x2 em Var[1]
Vars[1] = model.x2.value

model.value = model.obj()

Val_min = 'Valor mínimo da função L = ' + str(model.value) + "(M)"

model.obj = pyo.Objective(expr=(F * (Cao - model.x2) * pyo.log(Rout / RIn)) / (2 * pi * model.x1 * Cao * δ1),
                          sense=pyo.maximize)

# Resolvendo pelo Ipopt
opt = pyo.SolverFactory('ipopt')
results = opt.solve(model)

# Imprimindo os resultados
pyo.assert_optimal_termination(results)

# Declarando um vetor 1D de 2 componentes
Vars = [0, 0]

# Armazenando o valor de x1 em Var[0]
Vars[0] = model.x1.value

# Armazenando o valor de x2 em Var[1]
Vars[1] = model.x2.value

model.value = model.obj()

Val_max = 'Valor máximo da função L = ' + str(model.value) + "(M)"

# Tamanho da figura
fig = plt.figure(figsize=(10, 10))

ax = plt.axes(projection='3d')

print("\n\n\n")
print(
    "o ponto mínimo e máximo da função L(Dam,Ca) são:")
print("\n")
print(Val_min)
print("\n")
print(Val_max)
print("\n\n\n")



# Definindo a função a ser plotada
def funcao_z(x, y):
    return ((F * (Cao - y) * pyo.log((Rout / RIn))) / (2 * pi * x * Cao * δ1))


# Definindo os limites dos eixos e o numero de pontos plotados entre os limites
x = np.linspace(0.00001, 0.00002, 40)
y = np.linspace(0.1, 0.2, 40)

# Formando amalha de plotagem
X, Y = np.meshgrid(x, y)

# Gerando os pontos para a variavel Z
Z = funcao_z(X, Y)

# Em caso de plotagem de linhas (rede de arame) serão azuis
ax.plot_wireframe(X, Y, Z, color='blue')

# Definindo nome dos eixos
ax.set_xlabel('Dam')
ax.set_ylabel('CA')
ax.set_zlabel('L')

# Mapa de cores da plotagem e caracteristicas do gráfico
ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap='jet', edgecolor='none')

# Titulo do gráfico
ax.set_title('Gráfico 3D - L(Dam,CA)');

# Plotando a superficie
plt.show()