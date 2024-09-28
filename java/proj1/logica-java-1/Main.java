    public class Main {

    public static void main(String[] args) {
        System.out.println("Bienvenido a Screen Match");
        System.out.println("El senor de los anillos: La comunidad del anillo");

        int fechaDeLanzamiento = 1999;
        boolean incluidoEnPlan = true;
        double notaDeLaPelicula = 9.8;

        double media = (8.2 + 7.8 + 9.0) / 3;
        System.out.println("La media es: " + media);

        String sinopsis = """
        La comunidad del anillo es una película de fantasía épica y la mejor de sus generos.
        """ + "Fue lanzada en " + fechaDeLanzamiento;
        System.out.println(sinopsis);

        int clasificacion =  (int) media/2;
        System.out.println(clasificacion);
    }
}
