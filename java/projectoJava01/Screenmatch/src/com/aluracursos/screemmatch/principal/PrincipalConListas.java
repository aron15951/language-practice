package com.aluracursos.screemmatch.principal;
import com.aluracursos.screemmatch.modelos.Pelicula;
import com.aluracursos.screemmatch.modelos.Serie;
import com.aluracursos.screemmatch.modelos.Titulo;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;


public class PrincipalConListas {
    public static void main(String[] args) {
        Pelicula miPelicula = new Pelicula("Batman", 2022);
        miPelicula.evalua(8);
        Serie miSerie = new Serie("casa de papel", 2017);
        miSerie.evalua(9);
        var peliculaDeAron = new Pelicula("Senior de los anillos", 2001);
        peliculaDeAron.evalua(10);
        
        ArrayList<Titulo> lista = new ArrayList<>();
        lista.add(miSerie);
        lista.add(miPelicula);
        lista.add(peliculaDeAron);

        for (Titulo item: lista) {
            System.out.println(item.getNombre());
            if (item instanceof Pelicula pelicula) {
                System.out.println(pelicula.getClasificacion());
            }
        }

        ArrayList<String> listaDeArtistas = new ArrayList<>();
        listaDeArtistas.add("Maria becerro");
        listaDeArtistas.add("Bruno Decker");
        listaDeArtistas.add("Aron Banderas");
        System.out.println("Lista de artistas" + listaDeArtistas);

        Collections.sort(listaDeArtistas);
        System.out.println("Lista de artistas ordenada" + listaDeArtistas);
        
        Collections.sort(lista);
        System.out.println("Lista ordenada" + lista);

        lista.sort(Comparator.comparing(Titulo::getFechaDeLanzamiento));
        System.out.println("Lista ordenada por fecha: "+lista);

    }

}
