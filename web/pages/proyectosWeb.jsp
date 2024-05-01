<%-- 
    Document   : proyectosWeb
    Created on : 30-abr-2024, 12:33:43
    Author     : Yohanna Gelo
--%>


<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yohanna Gelo</title>
        <link rel="stylesheet" type="text/css" href="../css/css_index.css">
        <link rel="icon" href="img/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Bad+Script&display=swap">

    </head>
    <body>
        <!-- Título principal de la página -->
        <h1>Yohanna Gelo</h1>

        <%
            // Obtener la sesión HTTP
            session = request.getSession();

            // Verificar si un usuario ha iniciado sesión
            String username = (String) session.getAttribute("username");
        %>

        <!-- Menú de navegación -->
        <nav>
            <ul>
                <li><a href="../index.jsp">Inicio</a></li>
                <li><a href="">Diseños Gráficos</a></li>
                <li><a href="">Proyectos Web</a></li>
                <li><a href="">Documentos</a></li>
                <li><a href="">Códigos</a></li>
                <li><a href="">Contacto</a></li>
                <li class="userLogin">
                    <%
                        if (username != null) {
                            // Si el usuario ha iniciado sesión, muestra su nombre
                            out.print("¡Bienvenid@, " + username + "!");
                            out.print("<a href='../logout.jsp' id='close'><img src='../img/cerrarSesion.png' alt='Cerrar sesión' id='iconCerrar' /></a>");
                        } else {
                            // Si el usuario no ha iniciado sesión, muestra el enlace de "Login"
                            out.print("<a href='' id='log'>Login</a>");
                        }
                    %>
                </li>
            </ul>
        </nav>

        <!-- Ventana emergente para el login -->
        <div id="login-modal" class="modal">
            <div class="modal-content">
                <span class="close-btn">&times;</span>
                <h2>Login</h2>
                <form id="login-form" action="../procesar_login.jsp" method="post">
                    <label for="username">Nombre de usuario:</label>
                    <input type="text" id="username" name="username">

                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" name="password">

                    <!-- Enlace a formulario de registro -->
                    <a id="reg" href="../registro.jsp">¿Aún no tienes cuenta? Regístrate aquí.</a><br><br>

                    <button type="submit">Iniciar sesión</button>
                </form>
            </div>
        </div>


        <!-- CONTENIDO DE LA PÁGINA -->
    <center>
        <section id="proyectos">
            <h2>Proyectos web</h2>
            <div class="proyecto" id="paginas-web">
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
                    Statement s = conexion.createStatement();
                    //ResultSet listado = s.executeQuery("SELECT * FROM proyectosWeb");
                    ResultSet listado = s.executeQuery(
                            "SELECT * FROM proyectosWeb p LEFT JOIN comentarios c ON p.url = c.url"
                    );

                    while (listado.next()) {
                        // Crea un div para cada proyecto
                        out.println("<div class='project-container'>");

                        // Enlaces en el título del proyecto. Usa target blank para abrirse en una nueva pestaña
                        out.println("<a href='" + listado.getString("url") + "' class='link' target='_blank'>Pincha aquí o en la imágen para ver completo el proyecto " + listado.getString("nombreProyecto") + "</a>");

                        // Obtener la imagen de la base de datos como InputStream
                        InputStream imagenStream = listado.getBinaryStream("img");

                        // Leer el contenido de la imagen y codificarla en base64
                        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = imagenStream.read(buffer)) != -1) {
                            byteArrayOutputStream.write(buffer, 0, bytesRead);
                        }

                        byte[] imageBytes = byteArrayOutputStream.toByteArray();
                        String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);

                        // Renderizar la imagen en HTML como un elemento <img>
                        out.println("<br>");
                        out.println("<a href='" + listado.getString("url") + "' target='_blank'>");
                        out.println("<img src=\"data:image/jpeg;base64," + base64Image + "\" alt=\"Imagen del socio\" class=\"imgProyectWeb\">");
                        out.println("</a>");

                        // Cerrar el InputStream y el ByteArrayOutputStream
                        imagenStream.close();
                        byteArrayOutputStream.close();

                        out.println("<br>");

                        if (username != null) {

                %>
                <h4>Comentarios:</h4>
                <form action="procesar_comentarios.jsp" method="POST" id="feedback">
                    <label for="comentario">Deja tu feedback: </label>
                    <input type="text" id="comentario" name="comentario" required>

                    <button type="submit">Registrar</button>
                </form>
                <%                    
                    if (listado.getString("username") != null && listado.getString("comentario") != null && listado.getString("fecha") != null) {
                        out.println("<font> · Usuario: " + listado.getString("username") + "<br> · Comentario: " + listado.getString("comentario") + "<br> · Fecha de registro: " + listado.getString("fecha") + "</font><br>");
                    }

                %>






                <%                        }

                        out.println("</div>");

                    }

                    conexion.close();
                %>

            </div>
        </section>

    </center>
    <!-- Enlace al archivo que contiene el código de javascript -->
    <script src="../js/js_index.js"></script>
</body>
</html>
