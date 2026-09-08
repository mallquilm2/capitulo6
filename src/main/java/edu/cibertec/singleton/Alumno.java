package edu.cibertec.singleton;

public class Alumno {

    private String nombre;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Alumno() {
    }

    public Alumno(String nombre) {
        this.nombre = nombre;
    }

    private StringBuilder getPizarra(){
        StringBuilder sb = Pizarra.getInstance().getPizarra();
        return sb;
    }

    public void setPizarra(String texto){
        getPizarra().append(getNombre()).append(":");
        getPizarra().append(texto).append("\r\n");
    }

    @Override
    public String toString() {
        return "Alumno{" +
                "nombre='" + nombre + '\'' +
                '}';
    }
}
