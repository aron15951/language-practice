import pandas as pd
import numpy as np

# Datos de entrada
# Coordenadas de los nudos (Nodo, X, Y, Z)
coordenadas = np.array([
    [1, 0, 0, 0],
    [2, 0, 14, 0],
    [3, 0, 7, 10],
    [4, 24, 7, 0]
])

# Conexiones de los elementos (Elemento, Nodo_Inicial, Nodo_Final)
conexion = np.array([
    [1, 1, 4],
    [2, 2, 4],
    [3, 1, 2],
    [4, 1, 3],
    [5, 3, 4],
    [6, 2, 3]
])

# Cargas puntuales (Nodo, Fx, Fy, Fz)
cargas_puntuales = np.array([
    [4, 12, -21, 6]
])

# Restricciones (Nodo, Ux, Uy, Uz)
restricciones = np.array([
    [1, 1, 1, 1],
    [2, 1, 1, 1],
    [3, 1, 1, 1]
])

# Propiedades del material y secciones transversales
E = 2e7
A = 0.03 * 0.02
propiedades = np.array([
    [A, E],
    [A, E],
    [A, E],
    [A, E],
    [A, E],
    [A, E]
])

# Masas nodales (Nodo, Masa)
masa_total = 100
masa_nodal = masa_total / len(coordenadas)
masas = np.array([
    [i+1, masa_nodal, masa_nodal, masa_nodal] for i in range(len(coordenadas))
])

# Convertir arrays a DataFrames
df_coordenadas = pd.DataFrame(coordenadas, columns=['Nodo', 'X', 'Y', 'Z'])
df_conexion = pd.DataFrame(conexion, columns=['Elemento', 'Nodo_Inicial', 'Nodo_Final'])
df_cargas_puntuales = pd.DataFrame(cargas_puntuales, columns=['Nodo', 'Fx', 'Fy', 'Fz'])
df_restricciones = pd.DataFrame(restricciones, columns=['Nodo', 'Ux', 'Uy', 'Uz'])
df_propiedades = pd.DataFrame(propiedades, columns=['Área', 'E'])
df_masas = pd.DataFrame(masas, columns=['Nodo', 'Mx', 'My', 'Mz'])

# Crear un archivo Excel con cada conjunto de datos en una hoja separada
with pd.ExcelWriter('datos_estructura.xlsx') as writer:
    df_coordenadas.to_excel(writer, sheet_name='Entrada_Coordenadas', index=False)
    df_conexion.to_excel(writer, sheet_name='Entrada_Conexion', index=False)
    df_cargas_puntuales.to_excel(writer, sheet_name='Entrada_Cargas_Puntuales', index=False)
    df_restricciones.to_excel(writer, sheet_name='Entrada_Restriguidos', index=False)
    df_propiedades.to_excel(writer, sheet_name='Entrada_Propiedades', index=False)
    df_masas.to_excel(writer, sheet_name='Entrada_Masas', index=False)

print("Archivo Excel 'datos_estructura.xlsx' creado exitosamente.")
