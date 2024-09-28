% Por Alex Patiño Valle
clc;
clear;
clf;
format shortG;

% Entrada de coordenadas de los nudos (unidades en metros)
Entrada_Coordenadas = [
    1	0	10	0
2	0	0	0
3	5	10	0
4	5	0	0
5	10	10	0
6	10	0	0
7	15	10	0
8	15	0	0
9	20	10	0
10	20	0	0
11	25	10	0
12	25	0	0
13	30	10	0
14	30	0	0
15	35	10	0
16	35	0	0
17	5	10	12
18	5	0	12
19	10	10	12
20	10	0	12
21	15	10	12
22	15	0	12
23	20	10	12
24	20	0	12
25	25	10	12
26	25	0	12
27	30	10	12
28	30	0	12
];

% Entrada de conexiones entre los nudos (sin unidades, solo IDs de nudos)
Entrada_Conexion = [
    1	1	2
2	1	3
3	2	4
4	3	4
5	3	5
6	4	6
7	5	6
8	5	7
9	6	8
10	7	8
11	7	9
12	8	10
13	9	10
14	9	11
15	10	12
16	11	12
17	11	13
18	12	14
19	13	14
20	13	15
21	14	16
22	15	16
23	17	18
24	17	19
25	18	20
26	19	20
27	19	21
28	20	22
29	21	22
30	21	23
31	22	24
32	23	24
33	23	25
34	24	26
35	25	26
36	25	27
37	26	28
38	27	28
39	3	17
40	4	18
41	5	19
42	6	20
43	7	21
44	8	22
45	9	23
46	10	24
47	11	25
48	12	26
49	13	27
50	14	28
51	1	17
52	2	18
53	3	19
54	4	20
55	5	21
56	6	22
57	7	23
58	8	24
59	9	25
60	10	26
61	11	27
62	12	28
63	5	17
64	6	18
65	7	19
66	8	20
67	9	21
68	10	22
69	11	23
70	12	24
71	13	25
72	14	26
73	15	27
74	16	28
];

% Cargas puntuales aplicadas (unidades en Newtons)
Entrada_Cargas_Puntuales = [
    1 0 0 0 % Nodo 4: [ID, Carga X, Carga Y, Carga Z]
];

% Restricciones en los nudos (1 = restringido, 0 = libre)
Entrada_Restriguidos = [
    1	1	1	1
2	1	1	1
15	0	1	1
16	0	1	1
];

% Propiedades del material y secciones transversales
E = 2e7; % Módulo de elasticidad (Pa)
A = (10/100) * (10/100); % Área de sección transversal (m^2)
Entrada_Propiedades = [
    A * ones(length(Entrada_Conexion(:,1)),1), E * ones(length(Entrada_Conexion(:,1)),1)
    % [Área, Módulo de Elasticidad]
];

% Parámetros adicionales
Amplificador = 10; % Amplificación para visualizar deformaciones (sin unidades)
Graficar_Deformacion = 1; % Activar visualización de deformaciones (0 = No, 1 = Sí)


  % Código principal
  Total_Elementos = length(Entrada_Conexion(:,1));
  Total_Nudos = length(Entrada_Coordenadas(:,1));
  aux = Entrada_Cargas_Puntuales;
  Entrada_Cargas_Puntuales = [(1:Total_Nudos * 3)', zeros(Total_Nudos * 3, 1)];
  Entrada_Cargas_Puntuales(aux(:,1) * 3 - 2, 2) = aux(:,2);
  Entrada_Cargas_Puntuales(aux(:,1) * 3 - 1, 2) = aux(:,3);
  Entrada_Cargas_Puntuales(aux(:,1) * 3, 2) = aux(:,4);
  aux = Entrada_Restriguidos;
  Entrada_Restriguidos = [(1:Total_Nudos)', zeros(Total_Nudos, 3)];
  Entrada_Restriguidos(aux(:,1), 2:4) = aux(:,2:4);

  % Vector de grados de libertad restringidos
  k = 1;
  for i = 1:Total_Nudos
      if Entrada_Restriguidos(i,2) == 1
          Vector_Restringidos(k) = 3 * i - 2;
          k = k + 1;
      end
      if Entrada_Restriguidos(i,3) == 1
          Vector_Restringidos(k) = 3 * i - 1;
          k = k + 1;
      end
      if Entrada_Restriguidos(i,4) == 1
          Vector_Restringidos(k) = 3 * i;
          k = k + 1;
      end
  end

  Vector_Libres = (1:Total_Nudos * 3)';
  Vector_Libres(Vector_Restringidos) = [];

  % Cálculo de longitud y direcciones cosenoidales
  for i = 1:Total_Elementos
      Ni = Entrada_Conexion(i,2);
      Nf = Entrada_Conexion(i,3);
      xi = Entrada_Coordenadas(Ni,2); yi = Entrada_Coordenadas(Ni,3); zi = Entrada_Coordenadas(Ni,4);
      xf = Entrada_Coordenadas(Nf,2); yf = Entrada_Coordenadas(Nf,3); zf = Entrada_Coordenadas(Nf,4);
      Longitud(i) = sqrt((xf - xi)^2 + (yf - yi)^2 + (zf - zi)^2);
      calfa(i) = (xf - xi) / Longitud(i);
      cbeta(i) = (yf - yi) / Longitud(i);
      cganma(i) = (zf - zi) / Longitud(i);
      GDL_elemento(i,:) = [Ni*3-2, Ni*3-1, Ni*3, Nf*3-2, Nf*3-1, Nf*3];
  end

  Datos = [Longitud', calfa', cbeta', cganma'];

  % Ensamblaje de rigidez local y global
  for i = 1:Total_Elementos
      E = Entrada_Propiedades(i,2);
      A = Entrada_Propiedades(i,1);
      L = Datos(i,1);
      K_Local = E * A / L * [1 -1; -1 1];
      ca = Datos(i,2);
      cb = Datos(i,3);
      cg = Datos(i,4);
      B = [ca cb cg 0 0 0; 0 0 0 ca cb cg];
      K_Local_elemento(:,:,i) = K_Local;
      B_elemento(:,:,i) = B;
      K_Local_Global(:,:,i) = B' * K_Local * B;
  end

  % Ensamble de la matriz de rigidez global
  K_Global = zeros(Total_Nudos * 3, Total_Nudos * 3);
  for i = 1:Total_Elementos
      GDL = GDL_elemento(i,:);
      K_Global(GDL,GDL) = K_Global(GDL,GDL) + K_Local_Global(:,:,i);
  end

  % Reducción de matrices y cálculo de desplazamientos
  Fuerzas_Globales = Entrada_Cargas_Puntuales(:,2);
  Fuerzas_Globales_Reducidas = Fuerzas_Globales;
  K_Global_Reducido = K_Global;
  K_Global_Reducido(Vector_Restringidos,:) = [];
  K_Global_Reducido(:,Vector_Restringidos) = [];
  Fuerzas_Globales_Reducidas(Vector_Restringidos) = [];

  D_Global_Reducido = K_Global_Reducido \ Fuerzas_Globales_Reducidas;
  D_Global = zeros(Total_Nudos * 3,1);
  D_Global(Vector_Libres) = D_Global_Reducido;

  % Cálculo de las reacciones
  Reacciones = K_Global * D_Global - Fuerzas_Globales;

  % Cálculo de las fuerzas internas
  for i = 1:Total_Elementos
      D = D_Global(GDL_elemento(i,:));
      d = B_elemento(:,:,i) * D;
      f = K_Local_elemento(:,:,i) * d;
      Fuerzas_Internas(i) = f(2);
  end

  % Matriz de masa global
  Masa_Total = 100;
  Masa_Nodal = Masa_Total / Total_Nudos;
  M_Global = zeros(Total_Nudos * 3, Total_Nudos * 3);

  for i = 1:Total_Nudos
      M_Global(3 * i - 2, 3 * i - 2) = Masa_Nodal;
      M_Global(3 * i - 1, 3 * i - 1) = Masa_Nodal;
      M_Global(3 * i, 3 * i) = Masa_Nodal;
  end

  % Gráficos de la estructura y deformaciones
  hold on;
  for i = 1:Total_Elementos
      Ni = Entrada_Conexion(i,2);
      Nf = Entrada_Conexion(i,3);
      xi = Entrada_Coordenadas(Ni,2);
      yi = Entrada_Coordenadas(Ni,3);
      zi = Entrada_Coordenadas(Ni,4);
      xf = Entrada_Coordenadas(Nf,2);
      yf = Entrada_Coordenadas(Nf,3);
      zf = Entrada_Coordenadas(Nf,4);
      x = (xi + xf) / 2;
      y = (yi + yf) / 2;
      z = (zi + zf) / 2;
      if Fuerzas_Internas(i) > 0
          plot3([xi, xf], [yi, yf], [zi, zf], 'bo-', 'LineWidth', 2);
      elseif abs(Fuerzas_Internas(i)) < 0.001
          plot3([xi, xf], [yi, yf], [zi, zf], 'go-', 'LineWidth', 2);
      else
          plot3([xi, xf], [yi, yf], [zi, zf], 'ro-', 'LineWidth', 2);
      end
      text(x, y, z, num2str(Fuerzas_Internas(i), '%.2f'), 'FontSize', 15, 'color', 'k');
  end

  for i = 1:Total_Nudos
      x = Entrada_Coordenadas(i,2);
      y = Entrada_Coordenadas(i,3);
      z = Entrada_Coordenadas(i,4);
      text(x, y, z, num2str(i), 'FontSize', 30, 'Color', 'm', 'VerticalAlignment', 'top');
  end

  axis off;

  % Graficar la deformada si está activado
  if Graficar_Deformacion == 1
      Coordenadas_Corregido = Entrada_Coordenadas(:,2:4) + Amplificador * D_Global(1:3:end) * [1 0 0] + Amplificador * D_Global(2:3:end) * [0 1 0] + Amplificador * D_Global(3:3:end) * [0 0 1];
      for i = 1:Total_Elementos
          Ni = Entrada_Conexion(i,2);
          Nf = Entrada_Conexion(i,3);
          xi = Coordenadas_Corregido(Ni,1);
          yi = Coordenadas_Corregido(Ni,2);
          zi = Coordenadas_Corregido(Ni,3);
          xf = Coordenadas_Corregido(Nf,1);
          yf = Coordenadas_Corregido(Nf,2);
          zf = Coordenadas_Corregido(Nf,3);
          plot3([xi, xf], [yi, yf], [zi, zf], 'b--');
      end
  end

  hold off;
  view(30,30);


  % ANÁLISIS MODAL
  % El análisis modal requiere la solución del problema de valores propios: (K - ω^2 * M) * Φ = 0
  % Donde K es la matriz de rigidez global, M es la matriz de masa global, ω son las frecuencias angulares
  % (ω = 2*pi*f, donde f son las frecuencias naturales), y Φ son los modos de vibración.

  % Matrices reducidas (quitando grados de libertad restringidos)
  M_Global_Reducido = M_Global;
  M_Global_Reducido(Vector_Restringidos,:) = [];
  M_Global_Reducido(:,Vector_Restringidos) = [];

  % Solución del problema de valores propios (autovalores y autovectores)
  [Modos_Vibracion, Valores_Propios] = eig(K_Global_Reducido, M_Global_Reducido);

  % Frecuencias naturales (en radianes por segundo)
  Frecuencias_Naturales = sqrt(diag(Valores_Propios));

  % Convertir frecuencias a Hz (ciclos por segundo)
  Frecuencias_Hz = Frecuencias_Naturales / (2 * pi);

  % Mostrar las primeras 3 frecuencias naturales
  fprintf('Frecuencias Naturales (en Hz):\n');
  disp(Frecuencias_Hz(1:3));

  % Graficar los primeros 3 modos de vibración
  figure;
  for modo = 1:3
      % Desplazamientos de los nudos en el modo de vibración actual
      D_Modo = zeros(Total_Nudos * 3, 1);
      D_Modo(Vector_Libres) = Modos_Vibracion(:, modo);

      % Amplificación para visualizar mejor
      Amplificador_Modo = 50;
      Coordenadas_Deformadas_Modo = Entrada_Coordenadas(:, 2:4) + Amplificador_Modo * D_Modo(1:3:end) * [1 0 0] + Amplificador_Modo * D_Modo(2:3:end) * [0 1 0] + Amplificador_Modo * D_Modo(3:3:end) * [0 0 1];

      subplot(1,3,modo);
      hold on;

      % Graficar la estructura no deformada
      for i = 1:Total_Elementos
          Ni = Entrada_Conexion(i,2);
          Nf = Entrada_Conexion(i,3);
          xi = Entrada_Coordenadas(Ni,2); yi = Entrada_Coordenadas(Ni,3); zi = Entrada_Coordenadas(Ni,4);
          xf = Entrada_Coordenadas(Nf,2); yf = Entrada_Coordenadas(Nf,3); zf = Entrada_Coordenadas(Nf,4);
          plot3([xi xf], [yi yf], [zi zf], 'k-', 'LineWidth', 1.5);
      end

      % Graficar la estructura deformada (modo de vibración)
      for i = 1:Total_Elementos
          Ni = Entrada_Conexion(i,2);
          Nf = Entrada_Conexion(i,3);
          xi = Coordenadas_Deformadas_Modo(Ni,1);
          yi = Coordenadas_Deformadas_Modo(Ni,2);
          zi = Coordenadas_Deformadas_Modo(Ni,3);
          xf = Coordenadas_Deformadas_Modo(Nf,1);
          yf = Coordenadas_Deformadas_Modo(Nf,2);
          zf = Coordenadas_Deformadas_Modo(Nf,3);
          plot3([xi xf], [yi yf], [zi zf], 'r--', 'LineWidth', 1.5);
      end

      % Etiquetas de los nudos
      for i = 1:Total_Nudos
          x = Coordenadas_Deformadas_Modo(i,1);
          y = Coordenadas_Deformadas_Modo(i,2);
          z = Coordenadas_Deformadas_Modo(i,3);
          text(x, y, z, num2str(i), 'FontSize', 10, 'Color', 'b', 'VerticalAlignment', 'bottom');
      end

      % Configuración de la gráfica
      title(['Modo de Vibración ', num2str(modo)]);
      xlabel('X (m)');
      ylabel('Y (m)');
      zlabel('Z (m)');
      grid on;
      axis equal;
      view(30, 30);
      hold off;
  end

