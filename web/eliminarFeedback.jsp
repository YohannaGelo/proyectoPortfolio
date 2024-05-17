<%-- 
    Document   : eliminarFeedback
    Created on : 01-may-2024, 19:13:24
    Author     : Yohanna Gelo
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

            // Obtener el identificador del comentario del formulario
            String comentario_id = request.getParameter("comentario_id");

            // Conectar a la base de datos
            Connection conexion = null;
            PreparedStatement stmt = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");

                // Eliminar el comentario de la base de datos
                String sql = "DELETE FROM comentarios WHERE id = ?";
                stmt = conexion.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(comentario_id));
                stmt.executeUpdate();

                // Obtener la URL de la página anterior
                String referer = request.getHeader("Referer");

                
                // Verificar si la URL de referencia está disponible
                if (referer != null) {
                    // Redirigir al usuario a la página anterior
                    response.sendRedirect(referer);
                } else {
                    // Si hay error redirige al inicio
                    response.sendRedirect("pages/index.jsp");
                }
                
                
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Hubo un error al eliminar el comentario. Por favor, inténtelo de nuevo.</p>");
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
