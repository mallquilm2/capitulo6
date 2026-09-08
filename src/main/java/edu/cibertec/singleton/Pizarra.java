package edu.cibertec.singleton;

public class Pizarra {

    private static Pizarra instance = null;
    private StringBuilder stringBuilder;

    private Pizarra(){
        stringBuilder = new StringBuilder();
    }

    public static Pizarra getInstance() {
        if(instance==null){
            instance = new Pizarra();
        }
        return instance;
    }

    public static void setInstance(Pizarra instance) {
        Pizarra.instance = instance;
    }

    public StringBuilder getPizarra() {
        return  stringBuilder;
    }
}
