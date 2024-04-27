<%-- 
    Document   : procesar_login
    Created on : 25-abr-2024, 10:44:14
    Author     : yohan
--%>

<%@page import="clases.Visita"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Procesar Login</title>
    </head>
    <body>
        <%
            // Obtenemos los datos del formulario
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Definimos variables para manejar la conexión y consulta
            Connection conexion = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Conexión a la base de datos
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");

                // Consulta SQL para verificar las credenciales
                String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
                stmt = conexion.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);

                // Ejecutar la consulta
                rs = stmt.executeQuery();

                // Verificar si hay un registro que coincida con las credenciales
                if (rs.next()) {
                    // Almacenar el nombre de usuario en la sesión actual del navegador
                    session = request.getSession();
                    session.setAttribute("username", username);
                    
                    // Registra la visita
                    // Cargar el objeto Visita existente
                    Visita visita = new Visita(username);
                    visita.cargarDatos(); // Cargar datos del fichero

                    // Actualizar los datos de la visita
                    visita.registrarVisita();

                    // Guardar los datos actualizados
                    visita.guardarDatos();
                    
                    // Redirige a la página de inicio
                    response.sendRedirect("index.jsp");
                    // Las credenciales son válidas, muestra mensaje
                    out.println("<script>");
                    out.println("window.location.href = 'index.jsp';");
                    out.println("</script>");
                } else {
                    // Las credenciales no son válidas
                    out.println("<script>");
                    out.println("alert('Nombre de usuario o contraseña incorrectos.');");
                    out.println("window.location.href = 'index.jsp';");
                    out.println("</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Hubo un error al procesar el inicio de sesión. Por favor, inténtelo de nuevo.</p>");
            } finally {
                // Cerrar recursos
                try {
                    if (rs != null) {
                        rs.close();
                    }
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
