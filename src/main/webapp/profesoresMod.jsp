<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="css/main.css" type="text/css" rel="stylesheet" />
  <link href="css/form.css" type="text/css" rel="stylesheet" />
    <title>Insersión de profesor</title>
</head>
<body>
  <div id="caja" style="margin:auto; width:280px">
    <form class="navy" action="ProfesorServlet" method="post">
    <input type="hidden" name="accion" value="MOD"/>
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>

       <%
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection cn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/escuela?serverTimezone=UTC","root","root");
            StringBuilder sql = new StringBuilder("SELECT ");
            sql.append("idprofesor,appaterno,apmaterno,nombres,");
            sql.append("nacimiento, direccion, referencia,genero,estado ");
            sql.append("FROM profesor ");
            sql.append("WHERE idprofesor=");
            sql.append(request.getParameter("id"));
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql.toString());
            rs.next();
            %>

      <fieldset>
        <legend>Datos modificación profesor</legend>
        <label style="width:60px">Ap.Paterno</label>
        <input type="text" name="appaterno" required style="width:170px" maxlength="50"
        value="<%=rs.getString("appaterno")%>"/>

        <label style="width:60px">Ap.Materno</label>
        <input type="text" name="apmaterno" required style="width:170px" maxlength="50"
        value="<%=rs.getString("apmaterno")%>"/>

        <label style="width:60px">Nombres</label>
        <input type="text" name="nombres" required style="width:170px" maxlength="50"
        value="<%=rs.getString("nombres")%>"/>

        <label style="width:60px">Nacimiento</label>
        <input type="date" name="nacimiento" required style="width:140px" maxlength="50"
        value="<%=rs.getString("nacimiento")%>"/>

        <label style="width:60px">Género</label>
        <input type="radio" name="genero" checked="checked" value="1">Masculino
        <input type="radio" name="genero" value="0">Femenino

        <label style="width:60px">Direccion</label>
        <textarea name="direccion" required style="width:170px; height:40px"><%=rs.getString("direccion")%></textarea>

        <label style="width:60px">Referencia</label>
        <textarea name="referencia" required style="width:170px; height:40px"><%=rs.getString("referencia")%></textarea>

        <label style="width:60px">Estado</label>
        <span>
          <input type="radio" name="estado" value="1" checked="checked">Activo
          <input type="radio" name="estado" value="0">No Activo
        </span>

        <div class="submit">
          <input type="submit" value="Enviar datos">
        </div>
      </fieldset>

      <%
          rs.close();
          cn.close();
          }catch(Exception e){
              e.printStackTrace();
          }
        %>

    </form>

    <p style="text-align:center">
      <a class="simple" href="profesores.jsp">Cancelar</a>
    </p>

    <%
        if(request.getAttribute("msnError")!=null)
            out.print(request.getAttribute("msnError"));
    %>

  </div>
</body>
</html>