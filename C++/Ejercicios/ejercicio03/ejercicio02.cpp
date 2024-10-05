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
        for (int j = 0; j < altura - i - 1; j++) {
            cout << " ";
        }
        // Asteriscos
        for (int k = 0; k < 2 * i + 1; k++) {
            cout << "*";
        }
        cout << endl;
    }
    // Tronco del árbol
    for (int i = 0; i < altura / 3; i++) {
        for (int j = 0; j < altura - 1; j++) {
            cout << " ";
        }
        cout << "*" << endl;
    }
}



int main() {
    //calcularPromedioNumeros(); //01
    //calcularSalarioSemanal(); //02
    //convertirNumeroAHorasMinutosSegundos(); //03
    //convertirAnosAMesesDiasHoras(); //04
    //calcularSumaAreasCuadrados(); //05
    //cuentaRegresiva();//06
    arbolNavidad();//07
    
    return 0;
}

