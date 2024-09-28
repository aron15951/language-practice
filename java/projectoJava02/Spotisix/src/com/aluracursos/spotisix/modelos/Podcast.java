package com.aluracursos.spotisix.modelos;

import com.aluracursos.spotisix.calculos.Clasificacion;

public class Podcast extends Audio implements Clasificacion {
    private String nombreDelPodcast;
    private String anfitriones;
    private String temas;
    private int duracionMinima;

    public String getNombreDelPodcast() {
        return nombreDelPodcast;
    }

    public void setNombreDelPodcast(String nombreDelPodcast) {
        this.nombreDelPodcast = nombreDelPodcast;
    }

    public String getAnfitriones() {
        return anfitriones;
    }

    public void setAnfitriones(String anfitriones) {
        this.anfitriones = anfitriones;
    }

    public String getTemas() {
        return temas;
    }

    public void setTemas(String temas) {
        this.temas = temas;
    }

    public int getDuracionMinima() {
        return duracionMinima;
    }

    public void setDuracionMinima(int duracionMinima) {
        this.duracionMinima = duracionMinima;
    }


    @Override
    public int getClasificacion() {
        if ((getTotalDeReproducciones() >= 1000) || (getMeGusta() >= 100)) {
            return 5;
        } else if ((getTotalDeReproducciones() >= 500) || (getMeGusta() >= 50)) {
            return 4;
        } else if ((getTotalDeReproducciones() >= 100) || (getMeGusta() >= 10)) {
            return 3;
        } else if ((getTotalDeReproducciones() >= 50) || (getMeGusta() >= 5)) {
            return 2;
        } else {
            return 1;
        } 
    }

}

