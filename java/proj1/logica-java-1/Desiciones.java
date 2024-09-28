public class Desiciones {
    public static void main(String[] args) {
        int fechaDeLanzamiento = 1999;
        boolean incluidoEnPlan = true;
        double notaDeLaPelicula = 9.8;
        String tipoDePlan = "plus";


        if (fechaDeLanzamiento >= 2022) {
            System.out.println("Peliculas mas populares");
        } else {
            System.out.println("Peliculas retro que vale la pena aun ver");
        }

        if (incluidoEnPlan && tipoDePlan.equals("plus") ){
            System.out.println("Disfrute de su pelicula");
        } else {
            System.out.println("Compre el plan plus para disfrutar de este contenido");
        }
    }
}

