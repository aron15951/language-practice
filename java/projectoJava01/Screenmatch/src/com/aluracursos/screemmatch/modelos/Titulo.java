package com.aluracursos.screemmatch.modelos;

public class Titulo implements Comparable<Titulo> {
    private  String nombre;
    private int fechaDeLanzamiento;
    private int duracionEnMinutos;
    private boolean incluidoEnElPlan;
    private double sumaDeLasEvaluaciones;
    private int cantidadDeEvaluaciones;

    public Titulo(String nombre, int fechaDeLanzamiento) {
        this.nombre = nombre;
        this.fechaDeLanzamiento = fechaDeLanzamiento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setFechaDeLanzamiento(int fechaDeLanzamiento) {
        this.fechaDeLanzamiento = fechaDeLanzamiento;
    }

    public int getFechaDeLanzamiento() {
        return fechaDeLanzamiento;  
    }

    public void setDuracionEnMinutos(int duracionEnMinutos) {
        this.duracionEnMinutos = duracionEnMinutos;
    }

    public int getDuracionEnMinutos() {
        return duracionEnMinutos;
    }
    
    public void setIncluidoEnElPlan(boolean incluidoEnElPlan) {
        this.incluidoEnElPlan = incluidoEnElPlan;
    }   
    

    public int getTotalDeLasEvaluaciones() {
        return cantidadDeEvaluaciones;
    }

    public double getSumaDeLasEvaluaciones() {
        return sumaDeLasEvaluaciones;
    }

    public void muestraFichaTecnica() {
        System.out.println("Nombre: " + nombre);
        System.out.println("Fecha; de lanzamiento: " + fechaDeLanzamiento);
        System.out.println("Duracion en minutos: " + duracionEnMinutos);
        System.out.println("Incluido en el plan: " + incluidoEnElPlan);
    }

    public void evalua (double nota) {
        sumaDeLasEvaluaciones += nota;
        cantidadDeEvaluaciones++;
    }

    public double mediaDeLasEvaluaciones() {
        return sumaDeLasEvaluaciones/cantidadDeEvaluaciones;
    }

    @Override
    public int compareTo(Titulo otroTitulo) {
        return this.getNombre().compareTo(otroTitulo.getNombre());
        
    }

}
