% Leer datos desde el archivo Excel
filename = 'datos_estructura.xlsx';

% Coordenadas de los nudos
Entrada_Coordenadas = readmatrix(filename, 'Sheet', 'Entrada_Coordenadas');
% Conexiones de los elementos
Entrada_Conexion = readmatrix(filename, 'Sheet', 'Entrada_Conexion');
% Cargas puntuales aplicadas
Entrada_Cargas_Puntuales = readmatrix(filename, 'Sheet', 'Entrada_Cargas_Puntuales');
% Restricciones en los nudos
Entrada_Restriguidos = readmatrix(filename, 'Sheet', 'Entrada_Restriguidos');
% Propiedades del material y secciones transversales
Entrada_Propiedades = readmatrix(filename, 'Sheet', 'Entrada_Propiedades');
% Masas nodales
Entrada_Masas = readmatrix(filename, 'Sheet', 'Entrada_Masas');

% Parámetros adicionales
Amplificador = 10;
Graficar_Deformacion = 1;

% Extraer propiedades
E = Entrada_Propiedades(1,2); % Ejemplo para módulo de elasticidad (supone que todos los elementos tienen el mismo E)
A = Entrada_Propiedades(1,1); % Ejemplo para área de sección transversal

% Cálculo de la rigidez
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
Masa_Total = Entrada_Masas(1,2) * Total_Nudos;  % Usar masa total del archivo
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
    hold on;
    for i = 1:Total_Elementos
        Ni = Entrada_Conexion(i,2);
        Nf = Entrada_Conexion(i,3);
        xi = Coordenadas_Corregido(Ni,1);
        yi = Coordenadas_Corregido(Ni,2);
        zi = Coordenadas_Corregido(Ni,3);
        xf = Coordenadas_Corregido(Nf,1);
        yf = Coordenadas_Corregido(Nf,2);
        zf = Coordenadas_Corregido(Nf,3);
        plot3([xi, xf], [yi, yf], [zi, zf], 'r--', 'LineWidth', 2);
    end
end

% Análisis Modal
[Modo_Forma, Valor_Eigen] = eig(K_Global, M_Global);
Frecuencias = sqrt(diag(Valor_Eigen)) / (2 * pi);

% Resultados de frecuencia
disp('Frecuencias naturales (Hz):');
disp(Frecuencias);

% Resultados de deformaciones
disp('Desplazamientos nodales:');
disp(D_Global);

% Resultados de fuerzas internas
disp('Fuerzas internas en los elementos:');
disp(Fuerzas_Internas);

