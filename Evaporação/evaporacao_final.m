clc;
clear all;

%x = Dam (da especie no ar) (m2/s)
%y = Densidade do fluido que evapora (mol/m3)
%z = Press?o de vapor da esp?cie
%v = tempo

xinf = 0.00005;
xsup = 0.0001;
px=(xsup-xinf)/10;

yinf=1000;
ysup=1200;
py=(ysup-yinf)/10;

zinf=2.88;
zsup=3.52;
pz=(zsup-zinf)/10;

pxs=px/5;
pys=py/5;
pzs=pz/5;

Nx = (xsup-xinf)/px;
Ny = (ysup-yinf)/py;
Nz = (zsup-zinf)/pz;

[x,y,z] = meshgrid(xinf:px:xsup,yinf:py:ysup,zinf:pz:zsup);
xslice = xinf:pxs:xsup;
yslice = yinf:pys:ysup;
zslice = zinf:pzs:zsup;

colormap(jet);
nhz=1;

ht=5;
h0=2.5;
Rg=8.314;
T=298; %K

pontosp = 0;
p=4;
pLim=100;
passoP = 10;
while (p <= pLim)
  subplot(121);

    v = (((ht*h0)-((h0*h0)/2))./(((x*p)./(y*Rg*T)).*log(p./(p-z))));
    s1=slice(x,y,z,v,xslice,yslice,zslice);
    set(s1,'facealpha',0.08);
    shading interp;
    view(-45,25);
    colorbar("West");

    xlabel("Dam");
    ylabel("Densidade");
    zlabel("Press?o de vapor");
    title("Colorbar Var 4 (v) - Var 5 (p)");

    pause(0.0001);

  subplot(122);
    scatter(nhz,p,50,"filled"); hold on;
    xlabel("Horizonte");
    ylabel("Paramentro p");
    title("Horizonte de dados (grafico cubico) variando com paramentro p");
    nhz = nhz +1;

  p = p + passoP;
  pontosp = pontosp + 1;
endwhile

# La?o para montagem do Vetor de dados ordenados 4D, Vetor abc
k=1;
for p = 1:passoP:pLim
  for c = 1:Nz+1
    for i = 1:Ny+1
      for j = 1:Nx+1
          % Declarar fun??o aqui de novo
          v(i,j,c) = (((ht*h0)-((h0*h0)/2))./(((x(i,j,c)*p)./(y(i,j,c)*Rg*T)).*log(p./(p-z(i,j,c)))));
          # Forma??o do Vetor de dados 4D. Vetor abc
          abc(k,1:5)=[x(i,j,c), y(i,j,c), z(i,j,c), v(i,j,c), p];
          k = k + 1;
      end
    end
  end
end

# La?o para encontrar o Minimo
zt=1e12;
for k = 1:1:(Nx+1)*(Ny+1)*(Nz+1)*pontosp
    if abc(k,4) < zt
        zt=abc(k,4);
        vmin=k;
    end
end
printf(' \n Ponto de Minimo:  x = %.4f  y = %.4f  z = %.4f  v = %.4f  p = %.4f   ---  Indice Vetor = %.4f',abc(vmin,:),vmin)

# La?o para encontrar o Maximo
zp=-1e12;
for k = 1:1:(Nx+1)*(Ny+1)*(Nz+1)*pontosp
    if abc(k,4) > zp
        zp=abc(k,4);
        vmax=k;
    end
end
printf(' \n Ponto de Maximo:  x = %.4f  y = %.4f  z = %.4f  v = %.4f  p = %.4f   ---  Indice Vetor = %.4f',abc(vmax,:),vmax)

