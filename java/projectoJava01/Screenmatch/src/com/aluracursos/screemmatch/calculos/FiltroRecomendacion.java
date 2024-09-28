package com.aluracursos.screemmatch.calculos;

public class FiltroRecomendacion {
    public void filtra(Clasificacion clasificacion) {
      if (clasificacion.getClasificacion() >= 4){
          System.out.println("Recomendado");
      } else if (clasificacion.getClasificacion() == 2) {
          System.out.println("Recomendable");
      } else {
          System.out.println("Para despues");
      } 
    }

}
