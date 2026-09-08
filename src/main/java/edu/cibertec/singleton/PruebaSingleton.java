package edu.cibertec.singleton;

public class PruebaSingleton {

    public static void main(String[] args) {
        Alumno jorge = new Alumno("Jorge");
        Alumno claudia = new Alumno("Claudia");
        Alumno ana = new Alumno("Ana");

        jorge.setPizarra("Observen --> Pizarra.getInstance().getPizarra();");
        ana.setPizarra("Estas iniciando un singleton");
        claudia.setPizarra("La misma pizarra para los 3");

        StringBuilder enPizarraHay = Pizarra.getInstance().getPizarra();
        System.out.println(enPizarraHay);
    }

}
