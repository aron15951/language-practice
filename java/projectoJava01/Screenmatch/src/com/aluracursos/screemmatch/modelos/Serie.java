package com.aluracursos.screemmatch.modelos;

public class Serie extends Titulo {
    private int temporadas;
    private int episodiosPorTemporada;
    private int duracionEnMinutos;

    public Serie(String nombre, int fechaDeLanzamiento){
        super(nombre, fechaDeLanzamiento);
    }
    

    public void setTemporadas(int temporadas) {
        this.temporadas = temporadas;
    }

    public void setEpisodiosPorTemporada(int episodiosPorTemporada) {
        this.episodiosPorTemporada = episodiosPorTemporada;
    }

    @Override
    public void setDuracionEnMinutos(int duracionEnMinutos) {
        this.duracionEnMinutos = duracionEnMinutos;
    }

    @Override
    public int getDuracionEnMinutos() {
        return temporadas * episodiosPorTemporada * duracionEnMinutos;
    }

    @Override
    public String toString() {
        return "Serie: "+ this.getNombre() + "(" + getFechaDeLanzamiento() + ")";    
    }
}
