package com.aluracursos.screemmatch.modelos;

import com.aluracursos.screemmatch.calculos.Clasificacion;

public class Pelicula extends Titulo implements Clasificacion {
    private String director;

    public Pelicula(String nombre, int fechaDeLanzamiento){
        super(nombre, fechaDeLanzamiento);
    }

    public void setDirector(String director) {
        this.director = director;
    }
    public String getDirector() {
        return director;
    }

    @Override
    public int getClasificacion() {
        return (int) (mediaDeLasEvaluaciones()/2);
    }    

    @Override
    public String toString() {  
        return "Pelicula: "+ this.getNombre() + "("+ getFechaDeLanzamiento() +")";
    }

}

