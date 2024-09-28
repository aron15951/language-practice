% Por Alex Patiño Valle
clc
clear
clf
format shortG

Entrada_Coordenadas=[
1 0 0 0
2 0 14 0
3 0 7 10
4 24 7 0
]
Entrada_Conexion=[
1 1 4
2 2 4
3 1 2
4 1 3
5 3 4
6 2 3
]
Entrada_Cargas_Puntuales=[
4 12 -21 6
]
Entrada_Restriguidos=[
1 1 1 1
2 1 1 1
3 1 1 1
]
E=2e7;
A=0.03*0.02;
Entrada_Propiedades=[
A*ones(length(Entrada_Conexion(:,1)),1) E*ones(length(Entrada_Conexion(:,1)),1)
]
% Graficar Deformada
Amplificador=10
Graficar_Deformacion=1

% Inicio de Codigo
Total_Elementos=length(Entrada_Conexion(:,1))
Total_Nudos=length(Entrada_Coordenadas(:,1))
aux=Entrada_Cargas_Puntuales
Entrada_Cargas_Puntuales=[(1:Total_Nudos*3)' zeros(Total_Nudos*3,1)]
Entrada_Cargas_Puntuales(aux(:,1)*3-2,2)=aux(:,2);
Entrada_Cargas_Puntuales(aux(:,1)*3-1,2)=aux(:,3);
Entrada_Cargas_Puntuales(aux(:,1)*3,2)=aux(:,4)
aux=Entrada_Restriguidos;
Entrada_Restriguidos=[(1:Total_Nudos)' zeros(Total_Nudos,3)];
Entrada_Restriguidos(aux(:,1),2)=aux(:,2);
Entrada_Restriguidos(aux(:,1),3)=aux(:,3);
Entrada_Restriguidos(aux(:,1),4)=aux(:,4)

k=1;
for i=1:Total_Nudos
  if Entrada_Restriguidos(i,2)==1
    Vector_Restringidos(k)=3*i-2;
    k=k+1;
  end
  if Entrada_Restriguidos(i,3)==1
    Vector_Restringidos(k)=3*i-1;
    k=k+1;
  end
  if Entrada_Restriguidos(i,4)==1
    Vector_Restringidos(k)=3*i;
    k=k+1;
  end
end
Vector_Restringidos
Vector_Libres=[1:Total_Nudos*3]'
Vector_Libres(Vector_Restringidos)=[];
% Codigo de Programa
for i=1:Total_Elementos
  Ni=Entrada_Conexion(i,2);
  Nf=Entrada_Conexion(i,3);
  xi=Entrada_Coordenadas(Ni,2);
  yi=Entrada_Coordenadas(Ni,3);
  zi=Entrada_Coordenadas(Ni,4);
  xf=Entrada_Coordenadas(Nf,2);
  yf=Entrada_Coordenadas(Nf,3);
  zf=Entrada_Coordenadas(Nf,4);
  Longitud(i)=sqrt((xf-xi)^2+(yf-yi)^2+(zf-zi)^2);
  calfa(i)=(xf-xi)/Longitud(i);
  cbeta(i)=(yf-yi)/Longitud(i);
  cganma(i)=(zf-zi)/Longitud(i);
  GDL_elemento(i,:)=[Ni*3-2 Ni*3-1 Ni*3 Nf*3-2 Nf*3-1 Nf*3];
end
Datos=[Longitud' calfa' cbeta' cganma']
for i=1:Total_Elementos
  E=Entrada_Propiedades(i,2);
  A=Entrada_Propiedades(i,1);
  L=Datos(i,1);
  K_Local=E*A/L*[1 -1
                -1 1]
  ca=Datos(i,2);
  cb=Datos(i,3);
  cg=Datos(i,4);
  B=[ca cb cg 0 0 0
     0 0 0 ca cb cg]
  K_Local_elemento(:,:,i)=K_Local;
  B_elemento(:,:,i)=B;
  K_Local_Global(:,:,i)=B'*K_Local*B;
end
K_Local_Global
% Ensamble
K_Global=zeros(Total_Nudos*3,Total_Nudos*3);
for i=1:Total_Elementos
  GDL=GDL_elemento(i,:);
  K_Global(GDL,GDL)=K_Global(GDL,GDL)+K_Local_Global(:,:,i);
end
K_Global

Fuerzas_Globales=Entrada_Cargas_Puntuales(:,2);
Fuerzas_Globales_Reducidas=Fuerzas_Globales;
K_Global_Reducido=K_Global
K_Global_Reducido(Vector_Restringidos,:)=[];
K_Global_Reducido(:,Vector_Restringidos)=[]
Fuerzas_Globales_Reducidas(Vector_Restringidos)=[]

D_Global_Reducido=K_Global_Reducido^-1*Fuerzas_Globales_Reducidas
D_Global=zeros(Total_Nudos*3,1);
D_Global(Vector_Libres)=D_Global_Reducido
Reacciones=K_Global*D_Global-Fuerzas_Globales


for i=1:Total_Elementos
  D=D_Global(GDL_elemento(i,:));
  d=B_elemento(:,:,i)*D;
  f=K_Local_elemento(:,:,i)*d
  Fuerzas_Internas(i)=f(2);
end





% GRAFICOS
hold on
for i=1:Total_Elementos
  Ni=Entrada_Conexion(i,2);
  Nf=Entrada_Conexion(i,3);
  xi=Entrada_Coordenadas(Ni,2);
  yi=Entrada_Coordenadas(Ni,3);
  zi=Entrada_Coordenadas(Ni,4);
  xf=Entrada_Coordenadas(Nf,2);
  yf=Entrada_Coordenadas(Nf,3);
  zf=Entrada_Coordenadas(Nf,4);
  x=(xi+xf)/2;
  y=(yi+yf)/2;
  z=(zi+zf)/2;
  if Fuerzas_Internas(i)>0
  plot3([xi, xf], [yi, yf], [zi, zf], 'bo-', 'LineWidth', 2);
  elseif abs(Fuerzas_Internas(i))<0.001
  plot3([xi, xf], [yi, yf], [zi, zf], 'go-', 'LineWidth', 2);
  else
  plot3([xi, xf], [yi, yf], [zi, zf], 'ro-', 'LineWidth', 2);
  end
  text(x,y,z,num2str(Fuerzas_Internas(i),'%.2f'),'FontSize',15,'color','k')
end
for i=1:Total_Nudos
  x=Entrada_Coordenadas(i,2);
  y=Entrada_Coordenadas(i,3);
  z=Entrada_Coordenadas(i,4);
  text(x, y, z, num2str(i), 'FontSize', 30, 'Color', 'm','VerticalAlignment', 'top')
end
axis off


for i=1:Total_Nudos
  x=Entrada_Coordenadas(i,2);
  y=Entrada_Coordenadas(i,3);
  z=Entrada_Coordenadas(i,4);
  xc=D_Global(i*3-2)*Amplificador+x;
  yc=D_Global(i*3-1)*Amplificador+y;
  zc=D_Global(i*3)*Amplificador+z;
  Coordenadas_Corregido(i,:)=[xc yc zc];
end
Coordenadas_Corregido;

if Graficar_Deformacion==1
  for i=1:Total_Elementos
    Ni=Entrada_Conexion(i,2);
    Nf=Entrada_Conexion(i,3);
    xi=Coordenadas_Corregido(Ni,1);
    yi=Coordenadas_Corregido(Ni,2);
    zi=Coordenadas_Corregido(Ni,3);
    xf=Coordenadas_Corregido(Nf,1);
    yf=Coordenadas_Corregido(Nf,2);
    zf=Coordenadas_Corregido(Nf,3);
    plot3([xi, xf], [yi, yf], [zi, zf], 'bo--', 'LineWidth', 1);
  end
end
