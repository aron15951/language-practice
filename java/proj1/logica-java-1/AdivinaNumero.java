import java.util.Random;
import java.util.Scanner;

public class AdivinaNumero {
    public static void main(String[] args) {
        
        int numeroSecreto = (int) new Random().nextDouble(100) + 1;
        int intentos = 0;
        int maxIntentos = 5;
        int numeroIngresado = 0;

        while (intentos < maxIntentos) {
            System.out.println("Ingresa un numero entre 1 y 100");
            Scanner teclado = new Scanner(System.in);
            numeroIngresado = teclado.nextInt();

            if (numeroIngresado == numeroSecreto) {
                System.out.println("Felicidades, adivinaste el numero");
                break;
            } else if (numeroIngresado < numeroSecreto) {
                System.out.println("El numero secreto es mayor");
            } else {
                System.out.println("El numero secreto es menor");}
            intentos++;
        }
        
    }
}
