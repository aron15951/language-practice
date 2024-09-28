import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Coordenadas de los nodos (ajustadas para una estructura simple)
Coordenadas = np.array([
    [1, 0, 0, 0], [2, 3, 0, 0], [3, 0, 0, 3]
])

# Conexiones entre nodos (estructura simple de 3 barras)
Conexion = np.array([
    [1, 1, 2], [2, 1, 3], [3, 2, 3]
])

# Cargas puntuales (aplicada en el nodo superior)
Cargas_Puntuales = np.array([
    [3, 20, -10, 5]
])

# Restricciones (base fija)
Restricciones = np.array([
    [1, 1, 1, 1], [2, 1, 1, 1]
])

E = 2.1e11  # Módulo de elasticidad del acero (Pa)
A = 0.01  # Área transversal (m^2)
Amplificador = 10
Graficar_Deformacion = 1

# El resto del código permanece igual

# Propiedades de los elementos
Total_Elementos = len(Conexion)
Total_Nudos = len(Coordenadas)

Propiedades = np.column_stack([A * np.ones(Total_Elementos), E * np.ones(Total_Elementos)])

# Asignar cargas puntuales
Cargas = np.zeros((Total_Nudos * 3, 1))
for carga in Cargas_Puntuales:
    nodo, fx, fy, fz = carga
    Cargas[int(nodo * 3) - 3] = fx
    Cargas[int(nodo * 3) - 2] = fy
    Cargas[int(nodo * 3) - 1] = fz

# Asignar restricciones
Restringidos = np.zeros((Total_Nudos, 3))
for restriccion in Restricciones:
    nodo, rx, ry, rz = restriccion
    Restringidos[int(nodo) - 1, :] = [rx, ry, rz]

# Grados de libertad restringidos y libres
Vector_Restringidos = []
for i in range(Total_Nudos):
    if Restringidos[i, 0] == 1:
        Vector_Restringidos.append(3 * i)
    if Restringidos[i, 1] == 1:
        Vector_Restringidos.append(3 * i + 1)
    if Restringidos[i, 2] == 1:
        Vector_Restringidos.append(3 * i + 2)

Vector_Libres = list(set(range(Total_Nudos * 3)) - set(Vector_Restringidos))

# Calculo de Longitudes y Direcciones Cosenoidales
Longitudes = np.zeros(Total_Elementos)
calfa = np.zeros(Total_Elementos)
cbeta = np.zeros(Total_Elementos)
cganma = np.zeros(Total_Elementos)

for i in range(Total_Elementos):
    Ni = int(Conexion[i, 1]) - 1
    Nf = int(Conexion[i, 2]) - 1
    xi, yi, zi = Coordenadas[Ni, 1:]
    xf, yf, zf = Coordenadas[Nf, 1:]

    Longitudes[i] = np.sqrt((xf - xi) ** 2 + (yf - yi) ** 2 + (zf - zi) ** 2)
    calfa[i] = (xf - xi) / Longitudes[i]
    cbeta[i] = (yf - yi) / Longitudes[i]
    cganma[i] = (zf - zi) / Longitudes[i]

# Matriz de Rigidez Local y Global
K_Global = np.zeros((Total_Nudos * 3, Total_Nudos * 3))
print(K_Global)

for i in range(Total_Elementos):
    E = Propiedades[i, 1]
    A = Propiedades[i, 0]
    L = Longitudes[i]
    K_Local = (E * A / L) * np.array([[1, -1], [-1, 1]])

    ca, cb, cg = calfa[i], cbeta[i], cganma[i]
    B = np.array([[ca, cb, cg, 0, 0, 0],
                  [0, 0, 0, ca, cb, cg]])

    K_Local_Global = B.T @ K_Local @ B

    Ni = int(Conexion[i, 1]) - 1
    Nf = int(Conexion[i, 2]) - 1

    GDL = [Ni * 3, Ni * 3 + 1, Ni * 3 + 2, Nf * 3, Nf * 3 + 1, Nf * 3 + 2]

    for m in range(6):
        for n in range(6):
            K_Global[GDL[m], GDL[n]] += K_Local_Global[m, n]

# Reducción de Matriz y Fuerzas
K_Global_Reducido = np.delete(K_Global, Vector_Restringidos, axis=0)
K_Global_Reducido = np.delete(K_Global_Reducido, Vector_Restringidos, axis=1)

Fuerzas_Reducidas = np.delete(Cargas, Vector_Restringidos, axis=0)

# Resolución del sistema para desplazamientos
try:
    D_Global_Reducido = np.linalg.solve(K_Global_Reducido, Fuerzas_Reducidas)
except np.linalg.LinAlgError:
    print("La matriz es singular. Intentando resolver con mínimos cuadrados.")
    D_Global_Reducido, residuals, rank, s = np.linalg.lstsq(K_Global_Reducido, Fuerzas_Reducidas, rcond=None)

D_Global = np.zeros((Total_Nudos * 3, 1))
D_Global[Vector_Libres] = D_Global_Reducido

# Cálculo de reacciones
Reacciones = K_Global @ D_Global - Cargas

# Cálculo de fuerzas internas
Fuerzas_Internas = np.zeros(Total_Elementos)
for i in range(Total_Elementos):
    Ni = int(Conexion[i, 1]) - 1
    Nf = int(Conexion[i, 2]) - 1
    GDL = [Ni * 3, Ni * 3 + 1, Ni * 3 + 2, Nf * 3, Nf * 3 + 1, Nf * 3 + 2]

    D = D_Global[GDL]
    B = np.array([[calfa[i], cbeta[i], cganma[i], 0, 0, 0],
                  [0, 0, 0, calfa[i], cbeta[i], cganma[i]]])

    d = B @ D
    K_Local = (Propiedades[i, 1] * Propiedades[i, 0] / Longitudes[i]) * np.array([[1, -1], [-1, 1]])
    f = K_Local @ d
    Fuerzas_Internas[i] = f[0]

# Gráficos
fig = plt.figure(figsize=(10, 10))
ax = fig.add_subplot(111, projection='3d')

for i in range(Total_Elementos):
    Ni = int(Conexion[i, 1]) - 1
    Nf = int(Conexion[i, 2]) - 1
    xi, yi, zi = Coordenadas[Ni, 1:]
    xf, yf, zf = Coordenadas[Nf, 1:]

    if Fuerzas_Internas[i] > 0:
        ax.plot([xi, xf], [yi, yf], [zi, zf], 'b-', linewidth=2, label='Compresión' if i == 0 else "")
    elif abs(Fuerzas_Internas[i]) < 0.001:
        ax.plot([xi, xf], [yi, yf], [zi, zf], 'g-', linewidth=2, label='Sin fuerza' if i == 0 else "")
    else:
        ax.plot([xi, xf], [yi, yf], [zi, zf], 'r-', linewidth=2, label='Tracción' if i == 0 else "")

# Visualizar deformación si está habilitado
if Graficar_Deformacion == 1:
    for i in range(Total_Elementos):
        Ni = int(Conexion[i, 1]) - 1
        Nf = int(Conexion[i, 2]) - 1
        xi, yi, zi = Coordenadas[Ni, 1:]
        xf, yf, zf = Coordenadas[Nf, 1:]

        xi_deform = xi + Amplificador * D_Global[Ni * 3]
        yi_deform = yi + Amplificador * D_Global[Ni * 3 + 1]
        zi_deform = zi + Amplificador * D_Global[Ni * 3 + 2]

        xf_deform = xf + Amplificador * D_Global[Nf * 3]
        yf_deform = yf + Amplificador * D_Global[Nf * 3 + 1]
        zf_deform = zf + Amplificador * D_Global[Nf * 3 + 2]

        ax.plot([xi_deform, xf_deform], [yi_deform, yf_deform], [zi_deform, zf_deform], 'k--', linewidth=1, label='Deformación' if i == 0 else "")

ax.set_title("Estructura Simple 3D con Fuerzas Internas y Deformaciones")
ax.set_xlabel("X [m]")
ax.set_ylabel("Y [m]")
ax.set_zlabel("Z [m]")

# Agregar la leyenda
handles, labels = ax.get_legend_handles_labels()
by_label = dict(zip(labels, handles))
ax.legend(by_label.values(), by_label.keys())

plt.show()
