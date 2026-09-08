<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Listado de Alumnos</title>
</head>
<body>
  <style type="text/css">
    body{
      font-size:.7em
    }
  </style>
<link href="css/table.css" type="text/css" rel="stylesheet"/>

<center>
  <h1>Lista de Alumnos Cibertec</h1>

    <%
    try{
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection cn = DriverManager.getConnection(
            "jdbc:sqlserver://localhost:1433;databaseName=DemoJSP;encrypt=false;","sa","SqlServer12345#");
            StringBuilder sql = new StringBuilder("SELECT ");
            sql.append("id,nombre,edad ");
            sql.append("FROM personas ");
            sql.append("ORDER BY nombre");
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql.toString());
        %>

  <div id="caja" style="margin:auto;width:760px">
    <table class="navy">
      <caption>Lista de alumnos</caption>
      <thead>
        <tr>
          <td>Id</td>
          <td>Nombre</td>
          <td>Edad</td>
          <th style="width:26px">
            <a href="#">
                <img src="images/ins.png" alt="Nuevo"/>
            </a>
          </th>
          <th style="width:26px">
            <a href="j#">
                <img src="images/del.png" alt="Eliminar"/>
            </a>
          </th>
          <th style="width:26px">
            <a href="#">
                <img src="images/upd.png" alt="Actualizar"/>
            </a>
          </th>
        </tr>
      </thead>

      <tbody>
        <%
            while(rs.next()){
        %>

        <tr>
            <td><%= rs.getInt(1) %></td>
            <td><%= rs.getString(2) %></td>
            <td><%= rs.getString(3) %></td>
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