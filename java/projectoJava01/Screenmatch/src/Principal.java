import com.aluracursos.screemmatch.calculos.CalculadoraDeTiempo;
import com.aluracursos.screemmatch.calculos.FiltroRecomendacion;
import com.aluracursos.screemmatch.modelos.Episodio;
import com.aluracursos.screemmatch.modelos.Pelicula;
import com.aluracursos.screemmatch.modelos.Serie;
import java.util.ArrayList; 
public class Principal {
    public static void main(String[] args) {
        Pelicula miPelicula = new Pelicula();
        miPelicula.setNombre("Batman");
        miPelicula.setFechaDeLanzamiento(2022);
        miPelicula.setDuracionEnMinutos(120);
        miPelicula.setIncluidoEnElPlan(true);

        miPelicula.muestraFichaTecnica();
        miPelicula.evalua(8);
        miPelicula.evalua(9);
        miPelicula.evalua(7);

        System.out.println("El total de las evaluaciones es: " + miPelicula.getTotalDeLasEvaluaciones());
        System.out.println("La suma de las evaluaciones es: " + miPelicula.getSumaDeLasEvaluaciones());
        System.out.println("La media de las evaluaciones es: " + miPelicula.mediaDeLasEvaluaciones());

        Serie miSerie = new Serie();
        
        miSerie.setNombre("La casa de papel");
        miSerie.setFechaDeLanzamiento(2017);
        miSerie.setDuracionEnMinutos(120);
        miSerie.setIncluidoEnElPlan(true);
        miSerie.setTemporadas(5);
        miSerie.setEpisodiosPorTemporada(10);
        miSerie.setDuracionEnMinutos(120);

        miSerie.muestraFichaTecnica();
        miSerie.evalua(8);
        miSerie.evalua(9);
        miSerie.evalua(7);

        System.out.println("La serie se llama: " + miSerie.getNombre());
        System.out.println("El total de las evaluaciones es: " + miSerie.getTotalDeLasEvaluaciones());
        System.out.println("La suma de las evaluaciones es: " + miSerie.getSumaDeLasEvaluaciones());
        System.out.println("La media de las evaluaciones es: " + miSerie.mediaDeLasEvaluaciones());
        System.out.println("La duracion de la serie es: " + miSerie.getDuracionEnMinutos());
        

        CalculadoraDeTiempo calculadora = new CalculadoraDeTiempo();
        calculadora.incluye(miPelicula);
        System.out.println("El tiempo total es: " + calculadora.getTiempoTotal());


        FiltroRecomendacion filtroRecomendacion = new FiltroRecomendacion();
        filtroRecomendacion.filtra(miPelicula);

        Episodio episodio = new Episodio();
        episodio.setSerie(miSerie);
        episodio.setNumero(1);
        episodio.setNombre("Episodio 1");
        episodio.setNumeroTotalDeReproducciones(1000);


        filtroRecomendacion.filtra(episodio);
    
        var peliculaDeAron = new Pelicula();
        peliculaDeAron.setNombre("Senior de los anillos");
        peliculaDeAron.setDuracionEnMinutos( 240);
        peliculaDeAron.setFechaDeLanzamiento(2001);
        
    
        ArrayList<Pelicula> listaDePeliculas = new ArrayList<>();
        listaDePeliculas.add(miPelicula);
        listaDePeliculas.add(peliculaDeAron);
        System.out.println("Tamanio de la lista: " + listaDePeliculas.size());
        System.out.println("La primer pelicula es "+ listaDePeliculas.get(0).getNombre());

        System.out.println(listaDePeliculas);
        System.out.println("toString de" + listaDePeliculas.get(0).toString());

    }
}
