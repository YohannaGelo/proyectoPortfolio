<%-- 
    Document   : procesar_comentarios
    Created on : 01-may-2024, 13:29:39
    Author     : yohan
--%>

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
            String username = (String) session.getAttribute("username");
            String proyecto_id = request.getParameter("proyecto_id");
            String comentario = request.getParameter("comentario");

// Conectar a la base de datos
            Connection conexion = null;
            PreparedStatement stmt = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");

                // Insertar el comentario en la base de datos
                String sql = "INSERT INTO comentarios (username, proyecto_id, comentario) VALUES (?, ?, ?)";
                stmt = conexion.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setInt(2, Integer.parseInt(proyecto_id));
                stmt.setString(3, comentario);
                stmt.executeUpdate();

                // Redirigir a la página del proyecto
                response.sendRedirect("proyectosWeb.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Hubo un error al procesar el comentario. Por favor, inténtelo de nuevo.</p>");
            } finally {
                try {
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conexion != null) {
                        conexion.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>
