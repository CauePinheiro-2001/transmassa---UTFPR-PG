clc;
clear all;

#X = Pressao no ponto inicial
#Y = Pressao no ponto final
#Z = Deslocamento
#P = Pressao de A

xinf=0; %limite m?nimo no eixo x
xsup=1; %limite m?ximo no eixo x
px=0.1; %passo no eixo x

yinf=0; %limite m?nimo no eixo y
ysup=1; %limite m?ximo no eixo y
py=0.1; %passo no eixo y

zinf=0; %limite m?nimo no eixo z
zsup=8; %limite m?ximo no eixo z
pz=0.2; %passo no eixo z

pxs=0.1; %passo em x do gr?fico em fatias
pys=0.1; %passo em y do gr?fico em fatias
pzs=0.2; %passo em z do gr?fico em fatias

Nx = (xsup-xinf)/px;
Ny = (ysup-yinf)/py;
Nz = (zsup-zinf)/pz;

[x,y,z] = meshgrid(xinf:px:xsup,yinf:py:ysup,zinf:pz:zsup);
xslice = xinf:pxs:xsup;
yslice = yinf:pys:ysup;
zslice = zinf:pzs:zsup;

colormap(jet);

L=8; %comprimento do tubo

v = (x-((x-y).*z/L));
s1=slice(x,y,z,v,xslice,yslice,zslice);
set(s1,'facealpha',0.05);
shading interp;
view(-45,30);
colorbar;

xlabel("Pressao inicial");
ylabel("Pressao final");
zlabel("Deslocamento");
title("Pressao de A");

k=1;
for c = 1:Nz+1
  for i = 1:Ny+1
    for j = 1:Nx+1
        v(i,j,c) = (x(i,j,c)-((x(i,j,c)-y(i,j,c)).*z(i,j,c)/L));
        abc(k,1:4)=[x(i,j,c), y(i,j,c), z(i,j,c), v(i,j,c)];
        k = k + 1;
    end
  end
end

# La?o para encontrar a regi?o onde o maximo valor da quarta dimems?o eh 3
figure(2)
colormap(jet);
zt=0.5;
for k = 1:1:(Nx+1)*(Ny+1)*(Nz+1)
    if abc(k,4) < zt
         scatter3( abc(k,1), abc(k,2), abc(k,3), 100, abc(k,4), "filled" ); hold on;
        vmin=k;
    end
end
%colorbar ("west");

xlabel("Pressao inicial");
ylabel("Pressao final");
zlabel("Deslocamento");
title("Pressao de A");
