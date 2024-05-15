<%-- 
    Document   : proyectosWeb
    Created on : 30-abr-2024, 12:33:43
    Author     : Yohanna Gelo
--%>


<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>

<%@page import="clases.ProyectoWeb"%>
<%@page import="clases.Feedback"%>
<%@page import="java.time.LocalDateTime"%>
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
        <!-- Link para uso de bootstrap, pongo mi css debajo para que tome los colores de mi hoja de estilos -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="../cssGelo/cssGelo_Bootstrap.css">

        <link rel="icon" href="img/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Bad+Script&display=swap">

    </head>
    <body>
        <div class="container-fluid">

            <!-- Código para usos de alerts personalizados -->
            <jsp:include page="../codigoReutilizableJSP/alerts.jsp" />

            <!-- Título principal de la página -->
            <h1>Yohanna Gelo</h1>

            <!-- Menú de navegación responsivo (llamada a otro jsp donde está el código guardado -->
            <jsp:include page="../codigoReutilizableJSP/menu.jsp" />

            <!-- Ventana emergente para el Login -->
            <jsp:include page="../codigoReutilizableJSP/login.jsp" />


            <!-- CONTENIDO DE LA PÁGINA -->
            <center>
                <section id="proyectos">
                    <h2>Proyectos web</h2>
                    <div class="proyecto" id="paginas-web">
                        <%
                            // Usuario conectado
                            String username = (String) session.getAttribute("username");

                            Class.forName("com.mysql.cj.jdbc.Driver");  // Nuevo controlador
                            Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
                            Statement s = conexion.createStatement();

                            // Array para almacenar los proyectos con sus comentarios
                            ArrayList<ProyectoWeb> proyectos = new ArrayList<ProyectoWeb>();

                            // Ejecutar la consulta para obtener los datos de proyectos y comentarios
                            ResultSet listado = s.executeQuery(
                                    "SELECT p.url, p.nombreProyecto, p.img, c.id, c.username, c.comentario, c.fecha "
                                    + "FROM proyectosWeb p "
                                    + "LEFT JOIN comentarios c ON p.url = c.url"
                            );

                            while (listado.next()) {
                                String url = listado.getString("url");

                                // Buscar el proyecto correspondiente en la lista de proyectos
                                ProyectoWeb proyecto = null;
                                for (ProyectoWeb proy : proyectos) {
                                    if (proy.getUrl().equals(url)) {
                                        proyecto = proy;
                                        break;
                                    }
                                }

                                // Si no se encontró el proyecto, crea uno nuevo
                                if (proyecto == null) {
                                    String nombreProyecto = listado.getString("nombreProyecto");
                                    InputStream imagenStream = listado.getBinaryStream("img");
                                    proyecto = new ProyectoWeb(nombreProyecto, url, imagenStream);
                                    proyectos.add(proyecto);
                                }

                                // Si hay un feedback, agrégalo al proyecto correspondiente
                                if (listado.getObject("id") != null) {
                                    int id = listado.getInt("id");
                                    String usernameCons = listado.getString("username");
                                    String comentario = listado.getString("comentario");
                                    LocalDateTime fecha = listado.getTimestamp("fecha").toLocalDateTime();

                                    Feedback feedback = new Feedback(id, usernameCons, url, comentario, fecha);
                                    proyecto.getFeedbackPorProyecto().add(feedback);
                                }
                            }

                            // Recorre el array proyectos y va mostrando la información
                            for (ProyectoWeb proy : proyectos) {
                                // Crea un div para cada proyecto
                                out.println("<div class='project-container' style='width: 80%'>");

                                // Enlaces en el título del proyecto. Usa target blank para abrirse en una nueva pestaña
                                out.println("<a href='" + proy.getUrl() + "' class='link' target='_blank'>Pincha aquí o en la imágen para ver completo el proyecto " + proy.getNombre() + "</a>");

                                // Obtener la imagen de la base de datos como InputStream
                                InputStream imagenStream = proy.getImg();
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
                                out.println("<a href='" + proy.getUrl() + "' target='_blank'>");
                                out.println("<img src=\"data:image/jpeg;base64," + base64Image + "\" alt=\"Imagen del socio\" class=\"imgProyectWeb\" style='width: 75%; margin-top: 0.7em;'>");
                                out.println("</a>");

                                // Cerrar el InputStream y el ByteArrayOutputStream
                                imagenStream.close();
                                byteArrayOutputStream.close();

                                out.println("<br>");

                                if (username != null) {

                                    // Obtiene la lista de comentarios del proyecto
                                    ArrayList<Feedback> comentarios = proy.getFeedbackPorProyecto();


                        %>
                        
                        <!-- Dejar voto en el proyecto -->
                        
                        
                        
                        
                        <!-- Formulario para enviar comentarios -->
                        <div class="divComentarios">
                            <form action="../procesar_comentarios.jsp" method="POST" id="feedback">
                                <input type="hidden" name="proyecto_id" value="<%= proy.getUrl()%>">
                                <input type="hidden" name="proyecto_url" value="<%= proy.getUrl()%>">
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
                        </div>
                        <%

                            // Recupera el parámetro 'order' de la solicitud
                            String order = request.getParameter("order");

                            // Si el parámetro 'order' está presente, ordena la lista de comentarios
                            if (order != null && comentarios != null) {
                                if (order.equals("asc")) {
                                    Collections.sort(comentarios);
                                } else if (order.equals("desc")) {
                                    Collections.sort(comentarios, Collections.reverseOrder());
                                }
                            }

                            // Recorre la lista de comentarios de este proyecto
                            for (Feedback coment : comentarios) {

                                // Si hay comentario, lo muestra
                                if (comentarios != null && !comentarios.isEmpty()) {
                                    //if (listado.getString("username") != null && listado.getString("comentario") != null && listado.getString("fecha") != null) {
                                    // Título de la sección de comentarios
                                    out.println("<div class='divComentarios'>");

                                    // Crear un contenedor para cada comentario
                                    out.println("<div class='comentario'>");

                                    // Mostrar el comentario
                                    out.println("<p>" + coment.getComentario() + "</p>");

                                    // Mostrar el nombre de usuario
                                    out.println("<p><small><strong>Usuario:</strong> " + coment.getUsername());

                                    // Mostrar la fecha del comentario
                                    out.println(" <strong>Fecha de registro:</strong> " + coment.getFeedbackDate() + "</small></p>");

                                    // Si el comentario es del usuario registrado, podrá eliminarlo
                                    if (coment.getUsername() != null && coment.getUsername().equals(username)) {
                                        // Mostrar el formulario de eliminación
                                        out.println("<form action='../eliminarFeedback.jsp' method='POST'>");
                                        // Campo oculto para el identificador del comentario
                                        out.println("<input type='hidden' name='comentario_id' value='" + coment.getId() + "'>");
                                        // Botón de eliminación
                                        out.println("<button type='submit' class='deleteButton' ><img src='../img/papelera3.png' alt='Borrar Feedback' id='iconBorrarFeedback'/></button>");
                                        out.println("</form>");
                                    }

                                    out.println("</div>");
                                }
                                out.println("<hr>");

                        %> 

                    </div> 

                    <%                            }   // Fin for (comentarios)

                            }  // Fin if (usuario logueado)

                            out.println("</div>");  // Cierre div project-container

                        }  // Fin for (proyectos)

                        //conexion.close();
                        // Cierra los recursos
                        if (listado != null) {
                            try {
                                listado.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (s != null) {
                            try {
                                s.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (conexion != null) {
                            try {
                                conexion.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>


                    </div>
                </section>

            </center>

        </div>

        <!-- Botón para ir arriba -->
        <button class="btn-go-top" onclick="goToTop()"><img src="../img/arriba.png" alt="Volver arriba de la página" id="btnUp" /></button>

        <!-- Script para uso de bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <!-- Enlace al archivo que contiene el código de javascript -->
        <script src="../jsGelo/js_index.js"></script>


    </body>
</html>