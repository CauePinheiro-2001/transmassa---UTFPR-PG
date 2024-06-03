clc;
clear all;

L = 10;
Dam = 0.0001;
Pa = 130000;
Rg = 8.314;
T = 298;

%Variação de R1
yinf=0.1;
ysup=0.5;
py=0.2;

%Espessura
zinf=0.1;
zsup=0.5;
pz=0.2;

%Volume
xinf = 0.2;
xsup = 1;
px = 0.2;

pxs=0.01;
pys=0.01;
pzs=0.01;

Nx = (xsup-xinf)/px;
Ny = (ysup-yinf)/py;
Nz = (zsup-zinf)/pz;

[x,y,z] = meshgrid(xinf:px:xsup,yinf:py:ysup,zinf:pz:zsup);
xslice = xinf:pxs:xsup;
yslice = yinf:pys:ysup;
zslice = zinf:pzs:zsup;

colormap(jet);

#Equação de Fração vazia
# E= 1000*R + 0,21

#Equação de Tortuosidade
# T= (4*10**7)*(R**2) -27714*(R) +6,6

w = 40000.*(y +(y+z))-40000.*y-36.114.*(log(1000*(y+(y+z))+0.21)-log(1000.*y+0.21))-31.42857.*(log(9524.93271.*(y+(z+y))+2.00011)-log(9524.93271.*(y+(z+y))-9524.93271*y+2.00011)+log(9524.93271.*y+0.00011));
%w = 20;
v = (2.*3.14.*(x./(3.14.*((z+y).^2-y.^2))).*Pa.*Dam)./(Rg.*T.*w);
s1=slice(x,y,z,v,xslice,yslice,zslice);
set(s1,'facealpha',0.05);
shading interp;
view(-45,30);
colorbar;

xlabel("Volume disponivel");
ylabel("Valor de R1");
zlabel("Valor da Espessura do leito: R1 + Espessura = R2");
title("Color Bar: Vazão da espécie A (Na)");


%k=1;
%for c = 1:Nz+1
%  for i = 1:Ny+1
%|    for j = 1:Nx+1
%        w(i,j,c) = 40000.*(y(i,j,c) +(y(i,j,c)+z(i,j,c)))-40000.*y(i,j,c)-36.114.*(log(1000*(y(i,j,c)+(y(i,j,c)+z(i,j,c)))+0.21)-log(1000.*y(i,j,c)+0.21))-31.42857.*(log(9524.93271.*(y(i,j,c)+(z(i,j,c)+y(i,j,c)))+2.00011)-log(9524.93271.*(y(i,j,c)+(z(i,j,c)+y(i,j,c)))-9524.93271*y(i,j,c)+2.00011)+log(9524.93271.*y(i,j,c)+0.00011));
%        v(i,j,c) = (2.*3.14.*(x(i,j,c)./(3.14.*(((z(i,j,c)+y(i,j,c)).^2)-(y(i,j,c).^2))).*Dam.*Pa)./(Rg.*T.*w(i,j,c)));
%        abc(k,1:5)=[x(i,j,c), y(i,j,c), z(i,j,c), w(i,j,c),  v(i,j,c)];
%        k = k + 1;
%    end
%  end
%end
