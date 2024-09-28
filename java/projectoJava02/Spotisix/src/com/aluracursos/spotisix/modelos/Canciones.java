package com.aluracursos.spotisix.modelos;

import com.aluracursos.spotisix.calculos.Clasificacion;

public class Canciones extends Audio implements Clasificacion {
    private String artista;
    private String album;
    private int anioLanzamiento;
    private String genero;

    public void setArtista(String artista) {
        this.artista = artista;
    }

    public void getArtista() {
        System.out.println(this.artista);
    }

    public void setAlbum(String album) {
        this.album = album;
    }

    public void getAlbum() {
        System.out.println(this.album);
    }

    public void setAnioLanzamiento(int anioLanzamiento) {
        this.anioLanzamiento = anioLanzamiento;
    }

    public void getAnioLanzamiento() {
        System.out.println(this.anioLanzamiento);
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public void getGenero() {
        System.out.println(this.genero);
    }
    
    @Override
    public int getClasificacion() {
        if ((getTotalDeReproducciones() >= 10000) || (getMeGusta() >= 1000)) {
            return 5;
        } else if ((getTotalDeReproducciones() >= 5000) || (getMeGusta() >= 500)) {
            return 4;
        } else if ((getTotalDeReproducciones() >= 1000) || (getMeGusta() >= 100)) {
            return 3;
        } else if ((getTotalDeReproducciones() >= 500) || (getMeGusta() >= 50)) {
            return 2;
        } else {
            return 1;
        }   
    }

}
