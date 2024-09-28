
import java.util.Scanner;

public class Lectura {
    public static void main(String[] args) {
        Scanner teclado = new Scanner(System.in);
        System.out.println("Ingresa el nombre  de tu pelicula favorita");
        String pelicula = teclado.nextLine();
        System.out.println("Ahora escribe la fecha de lanzamiento de la pelicula");
        int fechaDeLanzamiento = teclado.nextInt();
        System.out.println("Por ultimo dinos que nota le pondrias a la pelicula");
        double nota = teclado.nextDouble();
        System.out.println("Tu pelicula favorita es " + pelicula + " y fue lanzada en el " + fechaDeLanzamiento + " con una nota de " + nota);
    }
}
