import com.aluracursos.spotisix.calculos.FiltroRecomendacion;
import com.aluracursos.spotisix.modelos.Canciones;

public class Principal {
    public static void main(String[] args) {

        Canciones canciones = new Canciones();
        canciones.setDuracion(3*60);
        canciones.setGenero("Rock");
        canciones.setArtista("Linkin Park");
        canciones.setAlbum("Hybrid Theory");
        canciones.setAnioLanzamiento(2000);
        canciones.setMeGusta(1000);

        canciones.meGusta();
        canciones.meGusta();
        canciones.reproducir();

        FiltroRecomendacion filtro = new FiltroRecomendacion();

        filtro.filtra(canciones); 
        int likes = canciones.getMeGusta();
        System.out.println("Likes: " + likes);

        int totalDeReproducciones = canciones.getTotalDeReproducciones();
        System.out.println("Total de reproducciones: " + totalDeReproducciones);

    }
}

