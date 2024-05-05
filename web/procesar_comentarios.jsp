<%-- 
    Document   : procesar_comentarios
    Created on : 01-may-2024, 13:29:39
    Author     : Yohanna Gelo
--%>

<%@page import="clases.Feedback"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Obtener los datos del formulario
            //String proyecto_id = request.getParameter("proyecto_id");
            String username = (String) session.getAttribute("username");
            String proyecto_url = request.getParameter("proyecto_url");
            String comentario = request.getParameter("feedback");

            // Crear una instancia de Feedback con los datos del formulario
            Feedback feedback = new Feedback(username, proyecto_url, comentario);

            // Conectar a la base de datos
            Connection conexion = null;
            PreparedStatement stmt = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");

                // Insertar el comentario en la base de datos
                String sql = "INSERT INTO comentarios (id, username, url, comentario, fecha) VALUES (NULL, ?, ?, ?, ?)";
                stmt = conexion.prepareStatement(sql);
                //stmt.setInt(1, Integer.parseInt(proyecto_id));
                stmt.setString(1, username);
                stmt.setString(2, proyecto_url);
                stmt.setString(3, comentario);
                // Usa feedbackDate como un valor de Timestamp para la fecha
                stmt.setTimestamp(4, Timestamp.valueOf(feedback.getFeedbackDate()));

                // Ejecutar la sentencia de inserción
                int filasAfectadas = stmt.executeUpdate();

                if (filasAfectadas > 0) {
                    // Redirigir a la página del proyecto
                    response.sendRedirect("pages/proyectosWeb.jsp");
                } else {
                    out.println("<p>Hubo un problema al guardar el comentario. Inténtalo de nuevo.</p>");
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                out.println("<p>Error al cargar el driver JDBC.</p>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error en la base de datos: " + e.getMessage() + "</p>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Hubo un error al procesar el comentario. Por favor, inténtalo de nuevo.</p>");
            } finally {
                // Cerrar recursos
                try {
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conexion != null) {
                        conexion.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>
