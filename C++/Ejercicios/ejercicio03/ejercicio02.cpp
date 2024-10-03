//que es cout? => C=console OUT=Salida(imprimir)
//cin => c = Console, INPUT = Entrada
//cout => c = Console, OUTPUT = Salida
//endl => salto de linea = salto de linea en la impresion de console

#include <iostream>
using namespace std;


void convertirNumeroAHorasMinutosSegundos() {
    int numero;
    cout << "Ingrese un número en segundos: ";
    cin >> numero;

    int horas = numero / 3600;                     // Calcula las horas
    int minutos = (numero % 3600) / 60;            // Calcula los minutos restantes
    int segundos = numero % 60;                     // Calcula los segundos restantes

    cout << numero << " segundos son equivalentes a: " << endl;
    cout << horas << " horas, " << minutos << " minutos y " << segundos << " segundos." << endl;
}

void convertirAnosAMesesDiasHoras() {
    int anos;
    cout << "Ingrese un número de años: ";
    cin >> anos;

    int meses = anos * 12;
    int dias = anos * 365; // Asumiendo años no bisiestos
    int horas = dias * 24;

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

int main() {
    calcularPromedioNumeros(); //01
    calcularSalarioSemanal(); //02
    convertirNumeroAHorasMinutosSegundos(); //03
    convertirAnosAMesesDiasHoras(); //04
    calcularSumaAreasCuadrados(); //05
    
    return 0;
}