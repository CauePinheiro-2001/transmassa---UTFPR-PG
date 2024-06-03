# Limpa a tela
clc;

#Limpa todos os vetores
clear all;

ro=1162; %kg/m3
Rg=8.314;
Rp=0.05;
T=25;
P=10^5;

# Numero de pontos laterais do Grid
N=50;

%Eixo x: a press?o de vapor da esp?cie que sublima
%Eixo y: o coeficiente de difus?o (Dam)
%Eixo z: tempo para evapora??o de uma camada da esp?cie

# Range de varia??o da variavel 1
Var1 = linspace (120, 150, N);

# Range de varia??o da variavel 2
Var2 = linspace (0.00005, 0.0001, N);

# Formando a grid - a malha no ch?o, onde para cada ponto desta malha sera calculado um valor de z
[xx, yy] = meshgrid (Var1, Var2);

# Declarando o Colormap
colormap(jet);

Na=((4.*(3.14).*yy.*P.*Rp)./(Rg.*T)).*(log(P./(P-xx)));

    # Declarando a fun??o z = z(Var1, Var2, p)
    z = (((ro.*Rg.*(Rp.^2).*T))./  ( (2.*yy.*xx.*Na).*(1./(log((P)./(P-xx))))));

    # Comando para plotar superficie
    surf (xx, yy, z);
    shading interp;

    # Limite do eixo z
    %zlim([0 70]);

    # Titulos dos eixos e do gr?fico
    xlabel ("Press?o de Vapor");
    ylabel ("Dam");
    zlabel ("Tempo de Evapora??o de uma camada da esp?cie");
    title ("Grafico 3D");
    colorbar;

# La?o para montagem do Vetor de dados ordenados 4D, Vetor abc
k=1;

  for i = 1:N
    for j = 1:N
        % Declarar fun??o aqui de novo
        %zz(i,j)=(((ro.*rg.*(Rp.^2).*T))./  ( (2.*yy(i,j).*xx(i,j).*na).*(1./(log((xx(i,j)-Pa2)./(xx(i,j)-Pa1))))));
        zz = (((ro.*Rg.*(Rp.^2).*T))./  ( (2.*yy(i,j).*xx(i,j).*Na).*(1./(log((P)./(P-xx(i,j)))))));
        # Formato do Vetor de dados 4D. Vetor abc
        abc(k,1:3)=[xx(i,j), yy(i,j), zz(i,j)];
        k = k + 1;
    end
  end


# Comandos para encontrar os valores m?ximo e minimo

 max(abc(:,3))
 min(abc(:,3))

