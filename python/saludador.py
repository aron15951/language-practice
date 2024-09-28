#PROGRAMA 1:  SALUDA AL USUARIO/A
nombre = input("Por favor ingrese su nombre: ")
mensaje = input("Selecciona tu genero (m/f): ").lower()
if mensaje == "m":
    print("Bienvenido pe causita")
elif mensaje == "f":
   print("Habla ps, Que fue mana?")
#else:
   print("Respuesta no válida. Por favor, ingresa 'm' o 'f'.")
print(f"Hola, {nombre}! {mensaje}")
