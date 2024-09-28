import random
numero_secreto = random.randint(1, 10)

numero = int(input("Ingrese un numero: "))
if numero == numero_secreto:
    print("Encontraste el numero secreto")
else:
    print(f"El numero secreto era {numero_secreto}")
