package com.aluracursos.screemmatch.modelos;
import com.aluracursos.screemmatch.calculos.Clasificacion;

public class Episodio implements Clasificacion {
    private int numero;
    private String nombre;
    private Serie serie;
    private int numeroTotalDeReproducciones;

    // Getter and setter for numero
    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    // Getter and setter for nombre
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    // Getter and setter for serie
    public Serie getSerie() {
        return serie;
    }

    public void setSerie(Serie serie) {
        this.serie = serie;
    }


    public void setNumeroTotalDeReproducciones(int numeroTotalDeReproducciones) {
        this.numeroTotalDeReproducciones = numeroTotalDeReproducciones;
    }

    public int getNumeroTotalDeReproducciones() {
        return numeroTotalDeReproducciones;
    }


    @Override
    public int getClasificacion() {
        if (numeroTotalDeReproducciones>=1000) {
            return 4;
        } else if (numeroTotalDeReproducciones>50) {
            return 2;
        } else {
            return 1;
        }   
    }


}


