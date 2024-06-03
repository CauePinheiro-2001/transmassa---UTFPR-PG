# Limpa a tela
clc;

#Limpa todos os vetores
clear all;

# Numero de pontos laterais do Grid
N=50;

# Range de varia??o da variavel 1 - dist?ncia da fonte (R)
Var1 = linspace (0.055, 1, N);

# Range de varia??o da variavel 2 - o coeficiente de difus?o (Dam)
Var2 = linspace (0.5*10^-4, 0.005, N);

# Formando a grid - a malha no ch?o, onde para cada ponto desta malha sera calculado um valor de z
[xx, yy] = meshgrid (Var1, Var2);

# Declarando o Colormap
colormap(jet);

%Vari?veis
Rg=0.082;
Rp0=0.05;
Rp=0.05;
T=300;
P=1;

nhz=1;
p=0.1; %press?o de vapor da esp?cie que sublima
pLim=1;
passoP=0.02;

while (p <= pLim)

    subplot(121);

    Na=(4).*(3.14).*yy.*P.*Rp./Rg./T.*log(P./(P-p));

    # Declarando a fun??o z = z(Var1, Var2, p) - Press?o parcial da esp?cie que sublima (Pa)
    a=((-1)./xx+(1)./Rp);                                 #Isolando o pressao parcial de A (Pa)
    b=(4).*(3.14).*yy.*P./Na./Rg./T;
    c=a./b;
    z = P-(P-p).*exp(c);

    # Comando para plotar superficie
    surf (xx, yy, z);

    colorbar("West");

    # Limite do eixo z
    zlim([0 1]);

    # Titulos dos eixos e do gr?fico
    xlabel ("dist?ncia da fonte (R)");
    ylabel ("coeficiente de difus?o (Dam)");
    zlabel ("Press?o parcial da esp?cie que sublima (Pa)");
    title ("Grafico 4D");

    # Pausa por 0.01 segundo
    pause(0.01);

    subplot(122);
    scatter(nhz,p,50,"filled"); hold on;
    xlabel("Horizonte");
    ylabel("Paramentro p");
    title("Horizonte de dados (grafico cubico) variando com paramentro p");
    nhz = nhz +1;

    p = p + passoP;

end

# La?o para montagem do Vetor de dados ordenados 4D, Vetor abc
k=1;
for p = 1:passoP:pLim
  for i = 1:N
    for j = 1:N
        % Declarar fun??o aqui de novo
        zz(i,j) = P-(P-p).*exp(((-1)./xx(i,j)+(1)./Rp)./((4).*(3.14).*yy(i,j).*P./Na./Rg./T));
        # Forma??o do Vetor de dados 4D. Vetor abc
        abc(k,1:4)=[xx(i,j), yy(i,j), zz(i,j), p];
        k = k + 1;
    end
  end
end

# Comandos para encontrar os valores m?ximo e minimo

 max(abc(:,3))
 min(abc(:,3))

