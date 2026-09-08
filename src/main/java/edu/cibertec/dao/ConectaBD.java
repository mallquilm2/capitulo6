package edu.cibertec.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConectaBD {

    private static ConectaBD instancia;

    public ConectaBD() {
    }

    public static ConectaBD getInstance(){
        if(instancia==null){
            instancia = new ConectaBD();
        }
        return instancia;
    }

    public Connection getConexion() throws Exception{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection cn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/escuela?serverTimezone=UTC","root","root");
        return cn;
    }
}
