
import java.util.Scanner;

public class Loops {
    public static void main(String[] args) {
            Scanner teclado = new Scanner(System.in);
            double nota = 0;
            double mediaEvaluacion = 0;
            for (int i = 0; i < 3; i++) {
                System.out.println("Ingresa la nota que le darias a la pelicula Matrix");
                nota = teclado.nextDouble();
                mediaEvaluacion = mediaEvaluacion + nota;
            }
            
            System.out.println("La puntuacion media de la pelicula Matrix es: " + mediaEvaluacion / 3);


    }
}
