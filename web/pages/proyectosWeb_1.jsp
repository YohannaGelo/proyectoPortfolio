<%-- 
    Document   : proyectosWeb
    Created on : 30-abr-2024, 12:33:43
    Author     : Yohanna Gelo
--%>


<%@page import="java.security.Timestamp"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Collections"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="clases.Feedback"%>
<%@page import="java.util.ArrayList"%>
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
        <link rel="stylesheet" type="text/css" href="../cssGelo/css_index.css">
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
                    // Consulta con Left Join para tomar toda la tabla de proyectos Web y solo los comentarios que tengan la url del proyecto
                    ResultSet listado = s.executeQuery(
                            //"SELECT * FROM proyectosWeb p LEFT JOIN comentarios c ON p.url = c.url"
                            "SELECT p.url, p.nombreProyecto, p.img, c.id, c.username, c.comentario, c.fecha "
                            + "FROM proyectosWeb p "
                            + "LEFT JOIN comentarios c ON p.url = c.url"
                    );

                    // Estructura para agrupar comentarios de proyectos
                    HashMap<String, ArrayList<Feedback>> comentariosPorProyecto = new HashMap<String, ArrayList<Feedback>>();

                    while (listado.next()) {

                        String url = listado.getString("url");

                        // Crea un nuevo objeto Feedback con los datos de la consulta
                        int id = listado.getInt("id");
                        String usernameCons = listado.getString("username");
                        String comentario = listado.getString("comentario");
                        LocalDateTime fecha = listado.getTimestamp("fecha").toLocalDateTime();


                        // Crea un objeto Feedback
                        Feedback feedback = new Feedback(usernameCons, url, comentario, fecha);

                        // Agrega el objeto Feedback a la lista de comentarios del proyecto, o crea la lista si no existe
                        ArrayList<Feedback> listaComentarios;
                        if (comentariosPorProyecto.containsKey(url)) {
                            listaComentarios = comentariosPorProyecto.get(url);
                        } else {
                            listaComentarios = new ArrayList<Feedback>();
                            comentariosPorProyecto.put(url, listaComentarios);
                        }

                        // Agrega el objeto Feedback a la lista de comentarios del proyecto
                        listaComentarios.add(feedback);

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

                        // Revisa si hay un usuario registrado, en caso de que lo haya muestra la zona de comentarios / feedbaks
                        if (username != null) {

                %>

                <div class="divComentarios">
                    <form action="../procesar_comentarios.jsp" method="POST" id="feedback">
                        <input type="hidden" name="proyecto_id" value="<%= listado.getInt("id")%>">
                        <input type="hidden" name="proyecto_url" value="<%= listado.getString("url")%>">
                        <textarea id="feedback_area" name="feedback" placeholder="Escribe tu feedback aquí..." required></textarea><br>
                        <button type="submit">Enviar feedback</button>
                    </form>
                    <hr>

                    <!-- Permite al usuario ordenar los comentarios por fecha asc o dsc -->
                    <form method="get" action="">
                        <label for="order">Ordenar comentarios por fecha:</label>
                        <select name="order" id="order">
                            <option value="asc">Ascendente</option>
                            <option value="desc">Descendente</option>
                        </select>
                        <input type="submit" value="Ordenar">
                    </form>
                    <%

                                // Recupera el parámetro 'order' de la solicitud
                                String order = request.getParameter("order");

                                // Recupera la lista de comentarios para el proyecto actual
                                ArrayList<Feedback> comentarios = comentariosPorProyecto.get(url);

                                // Si el parámetro 'order' está presente, ordena la lista de comentarios
                                if (order != null && comentarios != null) {
                                    if (order.equals("asc")) {
                                        Collections.sort(comentarios);
                                    } else if (order.equals("desc")) {
                                        Collections.sort(comentarios, Collections.reverseOrder());
                                    }
                                }
                                // Si hay comentarios, los irá mostrando, además lo hará desde el array de objetos Feedback para poder ordenarlos de foma ascendente / descendente
                                if (listado.getString("username") != null && listado.getString("comentario") != null && listado.getString("fecha") != null) {
                                    //ArrayList<Feedback> comentarios = comentariosPorProyecto.get(url);

                                    if (comentarios != null && !comentarios.isEmpty()) {
                                        // Muestra los comentarios ordenados
                                        for (Feedback f : comentarios) {
                                            out.println("<div class='comentario'>");

                                            // Muestra el comentario
                                            out.println("<p>" + f.getComentario() + "</p>");

                                            // Muestra el nombre de usuario
                                            out.println("<p><small><strong>Usuario:</strong> " + f.getUsername() + "</small></p>");

                                            // Muestra la fecha del comentario
                                            out.println("<p><small><strong>Fecha:</strong> " + f.getFeedbackDate() + "</small></p>");

                                            // Si el comentario es del usuario logueado, muestra el botón de eliminación
                                            if (f.getUsername().equals(username)) {
                                                out.println("<form action='../eliminarFeedback.jsp' method='POST'>");
                                                out.println("<input type='hidden' name='comentario_id' value='" + f.getId() + "'>");
                                                out.println("<button type='submit' class='deleteButton'><img src='../img/papelera3.png' alt='Borrar Feedback' id='iconBorrarFeedback' /></button>");
                                                out.println("</form>");
                                            }

                                            out.println("</div>");
                                        }
                                    }
                                }
                                out.println("<hr>");
                                out.println("</div>");
                            }

                            out.println("</div>");

                        }

                        conexion.close();
                    %>


                </div>
        </section>

    </center>
    <!-- Enlace al archivo que contiene el código de javascript -->
    <script src="../jsGelo/js_index.js"></script>
</body>
</html>
