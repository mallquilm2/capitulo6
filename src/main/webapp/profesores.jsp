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

<script type="text/javascript">
    function eliminar(){
        var del = document.getElementsByName("chk_del");
        var ids="";
        for(i=0; i<del.length;i++){
            if(del[i].checked){
                ids+=del[i].value+",";
            }
        }

        if(ids==""){
            alert("Seleccione registro para eliminar");
        }else{
            if(confirm("¿Eliminar registros?")){
                ids=ids.substring(0,ids.length-1);
                window.location = "ProfesorServlet?accion=DEL&ids="+ids;
            }
        }
    }

    function modificar(){
        var upd=document.getElementsByName("rad_upd");
        var id="";

        for(i=0;i<upd.length;i++){
            if(upd[i].checked){
                id=upd[i].value;
                break;
            }
        }

        if(id==""){
            alert("Seleccione registro a actualizar");
        }else{
            window.location="profesoresMod.jsp?id="+id;
        }
    }
</script>

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
            <a href="profesoresIns.jsp">
                <img src="images/ins.png" alt="Nuevo"/>
            </a>
          </th>
          <th style="width:26px">
            <a href="javascript:eliminar()">
                <img src="images/del.png" alt="Eliminar"/>
            </a>
          </th>
          <th style="width:26px">
            <a href="javascript:modificar()">
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
            <td><%= rs.getString(2)%> <%= rs.getString(3)%>,<%=rs.getString(4)%></td>
            <td><%= rs.getDate(5) %></td>
            <td><%= rs.getString(6) %></td>
            <td><%= rs.getString(7) %></td>
            <td><%= rs.getString(8) %></td>
            <td colspan="2"><%=rs.getString(9) %></td>
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