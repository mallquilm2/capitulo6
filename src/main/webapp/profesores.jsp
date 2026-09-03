<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Listado de profesores</title>
</head>
<body>
  <style type="text/css">
    body{
      font-size:.7em
    }
  </style>
<link href="css/table.css" type="text/css" rel="stylesheet"/>

<center>
  <h1>Lista de profesores de Cibertec</h1>

    <%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection cn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/escuela?serverTimezone=UTC","root","root");
        StringBuilder sql = new StringBuilder("SELECT ");
        sql.append("idprofesor,appaterno,apmaterno,nombres,");
        sql.append("nacimiento, direccion, referencia,genero,estado ");
        sql.append("FROM profesor ");
        sql.append("ORDER BY appaterno, apmaterno, nombres");
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sql.toString());
        %>

  <div id="caja" style="margin:auto;width:760px">
    <table class="navy">
      <caption>Lista de profesores</caption>
      <thead>
        <tr>
          <td>Profesor</td>
          <td>Nacimiento</td>
          <td>Direccion</td>
          <td>Referencia</td>
          <td>Genero</td>
          <td>Activo</td>
          <th style="width:26px">
            <img src="images/ins.png" alt="Nuevo"/>
          </th>
          <th style="width:26px">
            <img src="images/del.png" alt="Eliminar"/>
          </th>
          <th style="width:26px">
            <img src="images/upd.png" alt="Actualizar"/>
          </th>
        </tr>
      </thead>

      <tbody>
        <%
            while(rs.next()){
        %>

        <tr>
            <td><%= rs.getString(2)%> <%= rs.getString(3)%>,<%=rs.getString(4)%></td>
            <td><%= rs.getDate(5) %></td>
            <td><%= rs.getString(6) %></td>
            <td><%= rs.getString(7) %></td>
            <td><%= rs.getString(8) %></td>
            <td><%=rs.getString(9) %></td>
            <th>
                <input type="checkbox" value="<%= rs.getInt(1) %>" name="chk_del"/>
            </th>
            <th>
                 <input type="radio" value="<%= rs.getInt(1) %>" name="rad_upd"/>
            </th>
        </tr>
        <%
            }
        %>
      </tbody>

      <tfoot>
        <tr>
          <th colspan="9">CIBERTEC - DAT</th>
        </tr>
      </tfoot>
    </table>
  </div>

  <%
    rs.close();
    cn.close();
    }catch(Exception e){
        e.printStackTrace();
    }
  %>

</center>

</body>
</html>