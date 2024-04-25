<%-- 
    Document   : procesar_registro.jsp
    Created on : 25-abr-2024, 10:21:55
    Author     : Yohanna Gelo
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Procesar Registro</title>
    </head>
    <body>
        <%
            // Obtenemos los datos del formulario
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");

            // Aquí debes agregar la lógica para almacenar los datos en la base de datos
            // Por ejemplo:
            try {
                // Conexión a la base de datos (deberás proporcionar los detalles de conexión)
                //Connection conn = DriverManager.getConnection("jdbc:tuBaseDeDatos", "usuario", "contraseña");

                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
                //Statement s = conexion.createStatement();

                // Consulta SQL para insertar datos
                String sql = "INSERT INTO usuarios (username, password, email) VALUES (?, ?, ?)";
                PreparedStatement stmt = conexion.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);
                stmt.setString(3, email);

                // Ejecutar la consulta
                int filasAfectadas = stmt.executeUpdate();

                if (filasAfectadas > 0) {
                    // Si el registro es exitoso, redirigir a index.jsp y mostrar un mensaje de alerta
                    out.println("<script>");
                    out.println("alert('Registro exitoso. ¡Bienvenido!');");
                    out.println("window.location.href = 'index.jsp';");
                    out.println("</script>");
                } else {
                    out.println("<p>No se pudo completar el registro. Por favor, inténtelo de nuevo.</p>");
                }

                // Cerrar recursos
                stmt.close();
                conexion.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Hubo un error al procesar el registro. Por favor, inténtelo de nuevo.</p>");
            }
        %>
    </body>
</html>
