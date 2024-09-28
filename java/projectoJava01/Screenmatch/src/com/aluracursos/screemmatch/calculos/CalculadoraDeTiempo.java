// Source code is decompiled from a .class file using FernFlower decompiler.
package com.aluracursos.screemmatch.calculos;
import com.aluracursos.screemmatch.modelos.Titulo;
   
public class CalculadoraDeTiempo {
   private int tiempoTotal;

   public CalculadoraDeTiempo() {
   }

   public int getTiempoTotal() {
      return this.tiempoTotal;
   }

   public void incluye(Titulo titulo) {
      this.tiempoTotal += titulo.getDuracionEnMinutos();
   }
}
