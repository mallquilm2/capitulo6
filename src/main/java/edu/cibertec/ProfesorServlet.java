package edu.cibertec;

import edu.cibertec.dao.ConectaBD;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/ProfesorServlet")
public class ProfesorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        try {
            Connection cn = ConectaBD.getInstance().getConexion();

            String accion = req.getParameter("accion");
            if (accion.equals("INS")) {
                StringBuilder sql = new StringBuilder("INSERT INTO profesor(");
                sql.append("appaterno, apmaterno, nombres, nacimiento, direccion, referencia, genero, estado) ");
                sql.append("values(?,?,?,?,?,?,?,?)");

                PreparedStatement ps = cn.prepareStatement(sql.toString());
                ps.setString(1, req.getParameter("appaterno"));
                ps.setString(2, req.getParameter("apmaterno"));
                ps.setString(3, req.getParameter("nombres"));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                ps.setDate(4, new Date(sdf.parse(req.getParameter("nacimiento")).getTime()));
                ps.setString(5, req.getParameter("direccion"));
                ps.setString(6, req.getParameter("referencia"));
                ps.setString(7, req.getParameter("genero"));
                ps.setString(8, "1");

                boolean graboOK = false;
                int ctos = ps.executeUpdate();
                cn.close();
                if (ctos > 0) {
                    graboOK = true;
                }

                if (graboOK) {
                    resp.sendRedirect("profesores.jsp");
                } else {
                    req.setAttribute("msnError", "No se pudo grabar...ver el log!");
                    RequestDispatcher view = req.getRequestDispatcher("profesorIns.jsp");
                    view.forward(req, resp);
                }

            } else if (accion.equals("DEL")) {
                String ids = req.getParameter("ids");
                String sql = "DELETE FROM profesor WHERE idprofesor in (" + ids + ")";
                Statement st = cn.createStatement();
                st.executeUpdate(sql);
                cn.close();
                resp.sendRedirect("profesores.jsp");
            } else if(accion.equals("MOD")){
                StringBuilder sql = new StringBuilder("UPDATE profesor ");
                sql.append("SET appaterno=?, apmaterno=?, nombres=?, ");
                sql.append("nacimiento=?, direccion=?, referencia=?, genero=?, estado=? ");
                sql.append("WHERE idprofesor=?");
                PreparedStatement ps = cn.prepareStatement(sql.toString());
                ps.setString(1, req.getParameter("appaterno"));
                ps.setString(2,  req.getParameter("apmaterno"));
                ps.setString(3, req.getParameter("nombres"));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                ps.setDate(4, new Date(sdf.parse(req.getParameter("nacimiento")).getTime()));
                ps.setString(5,req.getParameter("direccion"));
                ps.setString(6, req.getParameter("referencia"));
                ps.setString(7, req.getParameter("genero"));
                ps.setString(8, req.getParameter("estado"));
                ps.setInt(9,Integer.parseInt(req.getParameter("id")));

                boolean graboOk=false;
                int ctos = ps.executeUpdate();
                cn.close();
                if(ctos>0){
                    graboOk=true;
                }
                if(graboOk){
                    resp.sendRedirect("profesores.jsp");
                }else{
                    req.setAttribute("msnError", "No se puedo grabar...ver el log!");
                    RequestDispatcher view = req.getRequestDispatcher("profesoresMod.jsp");
                    view.forward(req,resp);
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
