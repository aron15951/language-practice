package com.aluracursos.spotisix.calculos;

public class FiltroRecomendacion {
    public void filtra(Clasificacion clasificacion) {
        if (clasificacion.getClasificacion() == 5) {
            System.out.println("Contenido muy recomendado");
        } else if (clasificacion.getClasificacion() >= 4) {
            System.out.println("Contenido recomendado");
        } else if (clasificacion.getClasificacion() >= 3) {
            System.out.println("Contenido aceptable");
        } else if (clasificacion.getClasificacion() >= 2) {
            System.out.println("Contenido poco recomendado");
        } else {
            System.out.println("Contenido muy poco recomendado");
        }
    }

}
