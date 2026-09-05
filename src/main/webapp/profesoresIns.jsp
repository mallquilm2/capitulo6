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
    <input type="hidden" name="accion" value="INS"/>
      <fieldset>
        <legend>Datos de nuevo profesor</legend>
        <label style="width:60px">Ap.Paterno</label>
        <input type="text" name="appaterno" required style="width:170px" maxlength="50">

        <label style="width:60px">Ap.Materno</label>
        <input type="text" name="apmaterno" required style="width:170px" maxlength="50">

        <label style="width:60px">Nombres</label>
        <input type="text" name="nombres" required style="width:170px" maxlength="50">

        <label style="width:60px">Nacimiento</label>
        <input type="date" name="nacimiento" required style="width:140px" maxlength="50">

        <label style="width:60px">Género</label>
        <input type="radio" name="genero" checked="checked" value="1">Masculino
        <input type="radio" name="genero" checked="checked" value="0">Femenino

        <label style="width:60px">Direccion</label>
        <textarea name="direccion" required style="width:170px; height:40px"></textarea>

        <label style="width:60px">Referencia</label>
        <textarea name="referencia" required style="width:170px; height:40px"></textarea>

        <label style="width:60px">Estado</label>
        <span>
          <input type="radio" name="estado" value="1" checked="checked">Activo
          <input type="radio" name="estado" value="0" checked="checked">No Activo
        </span>

        <div class="submit">
          <input type="submit" value="Enviar datos">
        </div>
      </fieldset>
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