<%-- 
    Document   : procesar_login
    Created on : 25-abr-2024, 10:44:14
    Author     : Yohanna Gelo
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
        <!-- Link para uso de bootstrap, pongo mi css debajo para que tome los colores de mi hoja de estilos -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="cssGelo/cssGelo_Bootstrap.css">
    </head>
    <body>

        <!-- Código para usos de alerts personalizados -->
        <jsp:include page="codigoReutilizableJSP/alerts.jsp" />

        <%
            // Obtenemos los datos del formulario
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Definimos variables para manejar la conexión y consulta
            Connection conexion = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {

                // Obtener la URL de la página anterior
                String referer = request.getHeader("Referer");

                // Conexión a la base de datos
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");

                // Consulta SQL para verificar las credenciales
                String sql = "SELECT * FROM usuarios WHERE username = ?";
                stmt = conexion.prepareStatement(sql);
                stmt.setString(1, username);

                // Ejecutar la consulta
                rs = stmt.executeQuery();

                // Verificar si hay un registro que coincida con las credenciales
                if (rs.next()) {
                    // Recupera la contraseña encriptada de la base de datos
                    String passEncriptBBDD = rs.getString("password");

                    // Desencripta la contraseña recuperada de la base de datos
                    String passDesencBBDD = clases.metodosAuxiliares.desencriptando(passEncriptBBDD);

                    // Compara la contraseña desencriptada con la proporcionada por el usuario
                    if (password.equals(passDesencBBDD)) {

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

                        // Las credenciales son válidas, muestra mensaje
                        session.setAttribute("alertMessage", "Bienvenid@ a mi portfolio " + username + ", espero que disfrutes.");
                        session.setAttribute("alertType", "success");

                        // Verificar si la URL de referencia está disponible
                        if (referer != null) {
                            // Redirigir al usuario a la página anterior
                            response.sendRedirect(referer);
                        } else {
                            // Si hay error redirige al inicio
                            response.sendRedirect("../../../PORTFOLIO/index.jsp");
                        }

                        //out.println("<script>");
                        //out.println("window.location.href = 'index.jsp';");
                        //out.println("</script>");
                    } else {
                        // La contraseña es incorrecta no son válidas
                        session.setAttribute("alertMessage", "Contraseña incorrecta.");
                        session.setAttribute("alertType", "error");

                        // Verificar si la URL de referencia está disponible
                        if (referer != null) {
                            // Redirigir al usuario a la página anterior
                            response.sendRedirect(referer);
                        } else {
                            // Si hay error redirige al inicio
                            response.sendRedirect("../../../PORTFOLIO/index.jsp");
                        }

                    }
                } else {
                    // Las credenciales no son válidas
                    session.setAttribute("alertMessage", "El usuario no existe.");
                    session.setAttribute("alertType", "error");

                    // Verificar si la URL de referencia está disponible
                    if (referer != null) {
                        // Redirigir al usuario a la página anterior
                        response.sendRedirect(referer);
                    } else {
                        // Si hay error redirige al inicio
                        response.sendRedirect("../../../PORTFOLIO/index.jsp");
                    }
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


        <!-- Script para uso de bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <!-- Enlace al archivo que contiene el código de javascript -->
        <script src="jsGelo/js_index.js"></script>

    </body>
</html>
