//que es cout? => C=console OUT=Salida(imprimir)
//cin => c = Console, INPUT = Entrada
//cout => c = Console, OUTPUT = Salida
//endl => salto de linea = salto de linea en la impresion de console

#include <iostream>  // Librería estándar para entrada/salida en C++
using namespace std;


void convertirNumeroAHorasMinutosSegundos() {
    int numero;
    char unidad;
    cout << "Ingrese un número: ";
    cin >> numero;
    cout << "¿En qué unidad está el número? (h para horas, m para minutos, s para segundos): ";
    cin >> unidad;

    int horas, minutos, segundos;

    switch(unidad) {
        case 'h':
        case 'H':
            horas = numero;
            minutos = horas * 60;
            segundos = minutos * 60;
            break;
        case 'm':
        case 'M':
            minutos = numero;
            horas = minutos / 60;
            segundos = minutos * 60;
            break;
        case 's':
        case 'S':
            segundos = numero;
            minutos = segundos / 60;
            horas = minutos / 60;
            break;
        default:
            cout << "Unidad no válida. Por favor, use h, m o s." << endl;
            return;
    }

    cout << numero << " ";
    switch(unidad) {
        case 'h':
        case 'H':
            cout << "horas";
            break;
        case 'm':
        case 'M':
            cout << "minutos";
            break;
        case 's':
        case 'S':
            cout << "segundos";
            break;
    }
    cout << " son equivalentes a: " << endl;
    cout << horas << " horas, " << minutos % 60 << " minutos y " << segundos % 60 << " segundos." << endl;
}

void convertirAnosAMesesDiasHoras() {
    int anos;
    cout << "Ingrese un número de años: ";
    cin >> anos;

    int meses = anos * 12;
    int dias = anos * 365; // Asumiendo años no bisiestos
    int horas = dias * 24*365;

    cout << anos << " años son equivalentes a: " << endl;
    cout << meses << " meses, " << dias << " días y " << horas << " horas." << endl;
}

void calcularSumaAreasCuadrados() {
    float lado;
    cout << "Ingrese la longitud del lado del cuadrado original: ";
    cin >> lado;

    float areaOriginal = lado * lado;
    float areaMedio = (lado / 2) * (lado / 2);
    float sumaAreas = areaOriginal + 4 * areaMedio;

    cout << "La suma de las áreas de los cuadrados formados es: " << sumaAreas << endl;
}

void calcularPromedioNumeros() {
    int n, numero;
    float suma = 0, promedio;
    cout << "Ingrese la cantidad de números: ";
    cin >> n;

    for(int i = 0; i < n; i++) {
        cout << "Ingrese el número " << i+1 << ": ";
        cin >> numero;
        suma += numero;
    }

    promedio = suma / n;
    cout << "El promedio de los números ingresados es: " << promedio << endl;
}

void calcularSalarioSemanal() {
    float horasTrabajadas, salarioPorHora, salarioSemanal;
    cout << "Ingrese el número de horas trabajadas: ";
    cin >> horasTrabajadas;
    cout << "Ingrese el salario por hora: ";
    cin >> salarioPorHora;

    salarioSemanal = horasTrabajadas * salarioPorHora;
    cout << "El salario semanal es: $" << salarioSemanal << endl;
}

void cuentaRegresiva() { //solo realizara la tarea sin retornar un resultado
    int n=0; //declaras la variable
    cout << "Ingrese el número para la cuenta regresiva: "; //console int
    cin >> n;

    for (int i = n; i >= 0; i--) {
        cout << i << endl;
    }

    cout <<"Cuenta regresica terminada"<< endl;
}

void arbolNavidad() {
    int altura = 0;
    cout<<"Introduce la altura de nuestro arbolito"<<endl;
    cin >> altura;
    for (int i = 0; i < altura; i++) {
        // Espacios antes de los asteriscos
        for (int j = 0; j < altura - i - 1; j++) { //genera numero un strimg con numero de espacios iguala (i="numero de espacios"" - 1)
            cout << " ";
        }
        // Asteriscos(Por cada iteracion adicionara 2 asteriscos la primera siempre sera un "*"
        for (int k = 0; k < 2 * i + 1; k++) {
            cout << "*";
        }
        cout << endl;
    }
    // Tronco del árbol (El tronco sera 1/3 de la altura y de ser menor no tendra tronco)
    for (int i = 0; i < altura / 3; i++) {
        for (int j = 0; j < altura - 1; j++) {
            cout << " ";
        }
        cout << "*" << endl;
    }
}

void sumaRestaCocienteModulo() {
    int a = 12;
    int b = 3;
    int suma = a + b;
    int resta = a - b;
    float cociente = (float)a / b;
    int modulo = a % b;

    // Uso correcto del operador de inserción <<
    cout << "Si el primer número es: " << a << " y el segundo número es: " << b << endl;
    cout << "Entonces la suma será: " << suma << endl;
    cout << "La resta será: " << resta << endl;
    cout << "El cociente será: " << cociente << endl;
    cout << "El módulo será: " << modulo << endl;
}

void asignacionSumaRestaMultiplicacionDivisionModulo() {
    int primerNumero = 0;
    int segundoNumero = 0;

    // Solicitar al usuario que introduzca los números
    cout << "Introduce el primer número: " << endl;
    cin >> primerNumero;

    cout << "Introduce el segundo número: " << endl;
    cin >> segundoNumero;

    // Hacer copias de los valores originales para aplicar las operaciones
    int copiaNumero1 = primerNumero;
    int copiaNumero2 = primerNumero;
    int copiaNumero3 = primerNumero;
    int copiaNumero4 = primerNumero;
    int copiaNumero5 = primerNumero;

    // Operaciones con operadores de asignación
    copiaNumero1 += segundoNumero;
    cout << "Resultado de la asignación con suma (primerNumero += segundoNumero): " << copiaNumero1 << endl;

    copiaNumero2 -= segundoNumero;
    cout << "Resultado de la asignación con resta (primerNumero -= segundoNumero): " << copiaNumero2 << endl;

    copiaNumero3 *= segundoNumero;
    cout << "Resultado de la asignación con multiplicación (primerNumero *= segundoNumero): " << copiaNumero3 << endl;

    // Evitar división por cero
    if (segundoNumero != 0) {
        copiaNumero4 /= segundoNumero;
        cout << "Resultado de la asignación con división (primerNumero /= segundoNumero): " << copiaNumero4 << endl;

        copiaNumero5 %= segundoNumero;
        cout << "Resultado de la asignación con módulo (primerNumero %= segundoNumero): " << copiaNumero5 << endl;
    } else {
        cout << "No se puede dividir ni calcular el módulo por 0." << endl;
    }

    // Mostrar los valores originales para confirmar que no han sido modificados
    cout << "Valores originales - primerNumero: " << primerNumero << ", segundoNumero: " << segundoNumero << endl;
}

void comparacion() {
    int primerNumero = 0;
    int segundoNumero = 0;

    cout << "Introduce el primer número: ";
    cin >> primerNumero;

    cout << "Introduce el segundo número: ";
    cin >> segundoNumero;

    bool igual = (primerNumero == segundoNumero);
    bool mayor = (primerNumero > segundoNumero);
    bool menor = (primerNumero < segundoNumero);

    cout << "¿Son iguales? " << (igual ? "Sí" : "No") << endl;
    cout << "¿El primer número es mayor que el segundo? " << (mayor ? "Sí" : "No") << endl;
    cout << "¿El primer número es menor que el segundo? " << (menor ? "Sí" : "No") << endl;
}

void comparacioBoleanos() {
    int primerBooleano = 0;
    int segundoBooleano = 0;

    cout << "Introduce el primer booleano (0 o 1): ";
    cin >> primerBooleano;

    cout << "Introduce el segundo booleano (0 o 1): ";
    cin >> segundoBooleano;

    bool iguales = (primerBooleano == segundoBooleano);
    bool oLogico = (primerBooleano || segundoBooleano);
    bool yLogico = (primerBooleano && segundoBooleano);
    bool noPrimer = (!primerBooleano);
    bool noSegundo = (!segundoBooleano);

    cout << "¿Al menos uno es verdadero (OR lógico)? " << (oLogico ? "Sí" : "No") << endl;
    cout << "¿Ambos son verdaderos (AND lógico)? " << (yLogico ? "Sí" : "No") << endl;
    cout << "¿El primer booleano es falso? " << (noPrimer ? "Sí" : "No") << endl;
    cout << "¿El segundo booleano es falso? " << (noSegundo ? "Sí" : "No") << endl;
}

void comparacionDeEdades(){
    int primerEdad = 0;
    int segundoEdad = 0;


    cout << "Introduce el primera edad: ";
    cin >> primerEdad;

    cout << "Introduce el segunda edad: ";
    cin >> segundoEdad;

    bool igual = (primerEdad == segundoEdad);
    bool mayor = (primerEdad > segundoEdad);

    cout <<"Tienen la misma edad"<<(igual ? "Sí" : "No") << endl;
    cout << (mayor ? "La primera edad es mayor" : "La segunda edad es mayor") << endl;

}

void booleanoCOntrario() {
    bool booleano = 0;


    cout << "Introduce el primer booleano (0 o 1): ";
    cin >> booleano;

    bool contrario = !booleano;
    cout<<"El valor contrario del booleano introducido es: "<< contrario<<endl;
}

void comparacioNumeros() {
    int primerNumero = 0;
    int segundoNumero= 0;

    cout << "Introduce el primer numero: ";
    cin >> primerNumero;

    cout << "Introduce el segundo nuemero: ";
    cin >> segundoNumero;

    bool iguales = ((primerNumero>=0) && (segundoNumero>=0));
    cout<<(iguales?"Ambos son positivos":"Al menos uno es negativo")<<endl;
}

void operacionesAsignacion() {
    int numero;
    int valorAumentar;

    // Solicitar al usuario que introduzca un número
    cout << "Introduce un número: " << endl;
    cin >> numero;

    // Solicitar el valor para aumentar
    cout << "Introduce el valor que deseas aumentar al número: " << endl;
    cin >> valorAumentar;

    // Realizar la operación de asignación (aumentar)
    numero += valorAumentar;

    // Mostrar el resultado de la operación
    cout << "El número después de aumentar " << valorAumentar << " es: " << numero << endl;
}

void mayoriaDeEdad(){
    int edad = 0;

    cout << "Introduzca su edad: " <<endl;
    cin >> edad;

    if (edad >=18){
        cout << "Usted es mayor de edad" << endl;
    } else {
        cout << "Usted es menor de edad" << endl;
    }

}

#include <iostream>
using namespace std;

void temperaturaCiudad() {
    float temperatura = 0;

    cout << "Ingrese la temperatura actual de su ciudad: ";
    cin >> temperatura;


    if (temperatura < 10) {
        cout << "El clima actual es frío" << endl;
    } else if (temperatura >= 10 && temperatura <= 25) {
        cout << "El clima actual es templado" << endl;
    } else {
        cout << "El clima actual es caliente" << endl;
    }
}



void comparacionDosNumeros(){
    int primerNumero = 0;
    int segundoNumero= 0;

    cout << "Introduce el primer numero: ";
    cin >> primerNumero;

    cout << "Introduce el segundo nuemero: ";
    cin >> segundoNumero;

    if (primerNumero == segundoNumero){
        cout << "Los numeros son iguales" << endl;
    } else if (primerNumero > segundoNumero) {
        cout << "El primer nuemro es mayor que el segundo" << endl;
    } else {
        cout << "El segundo nuemro es mayor que el primero" << endl;
    }
}

void mayorDeTresNumeros(){
    int primerNumero = 0;
    int segundoNumero = 0;
    int tercerNumero = 0;

    cout << "Introduce el primer numero: ";
    cin >> primerNumero;

    cout << "Introduce el segundo nuemero: ";
    cin >> segundoNumero;

    cout << "Introduce el tercer nuemero: ";
    cin >> tercerNumero;

    int mayor;

    if (primerNumero >= segundoNumero && primerNumero >= tercerNumero) {
            mayor = primerNumero;
        } else if (segundoNumero >= primerNumero && segundoNumero >= tercerNumero) {
            mayor = segundoNumero;
        } else {
            mayor = tercerNumero;
        }

        cout << "El mayor de los tres números es: " << mayor << endl;
}





int main() {
    //calcularPromedioNumeros(); //01
    //calcularSalarioSemanal(); //02
    convertirNumeroAHorasMinutosSegundos(); //03
    //convertirAnosAMesesDiasHoras(); //04
    //calcularSumaAreasCuadrados(); //05
    //cuentaRegresiva();//06
    //arbolNavidad();//07//line:127
    //sumaRestaCocienteModulo();//08
    //asignacionSumaRestaMultiplicacionDivisionModulo();//09
    //comparacion();//10
    //comparacioBoleanos();//11
    //comparacionDeEdades();//12
    //booleanoCOntrario();//13
    //comparacioNumeros();//14
    //operacionesAsignacion();//15//line:295
    //mayoriaDeEdad();
    //temperaturaCiudad();
    //comparacionDosNumeros();
    //mayorDeTresNumeros();



    return 0;
}
