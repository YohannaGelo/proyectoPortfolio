<%-- 
    Document   : codigo
    Created on : 06-may-2024, 19:09:46
    Author     : Yohanna Gelo
--%>

<%@page import="clases.Codigo"%>
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

            <!-- Botón con instrucciones para ver código en Replit -->
            <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBothOptions" aria-controls="offcanvasWithBothOptions">Ejecuta el código</button>

            <div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="offcanvasWithBothOptions" aria-labelledby="offcanvasWithBothOptionsLabel">
                <div class="offcanvas-header">
                    <h6 class="offcanvas-title" id="offcanvasWithBothOptionsLabel">Cómo abrir y ejecutar el código con Replit</h6>
                    <button id="cierreCanvas" type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <h3></h3>
                    <ol>
                        <li><b>Acceder al enlace compartido:</b> <br>Pincha sobre el proyecto que quieras ejecutar y se te abrirá una nueva pestaña en el navegador</li><br>
                        <li><b>Iniciar sesión (si es necesario):</b> <br>Si no has iniciado sesión en Replit, es posible que te solicite que lo hagas antes de continuar. 
                            Puedes iniciar sesión utilizando tu cuenta de Google u otras opciones disponibles.</li><br>
                        <li><b>Abrir el código en Replit:</b> <br>Una vez iniciada la sesión, el enlace te llevará al código en Replit. 
                            Aquí puedes ver el código y su descripción.</li><br>
                        <li><b>Fork & Run:</b> <br>Para ejecutar el código, busca el botón "Fork & Run" en la parte superior derecha de la pantalla. 
                            Haz clic en este botón para crear una copia del código en tu propia cuenta de Replit y ejecutarlo.</li><br>
                        <li><b>Esperar a que se cargue el entorno:</b> <br>Dependiendo del tamaño del código y la configuración del entorno, puede tomar 
                            unos momentos para que Replit configure todo y ejecute el código.</li><br>
                        <li><b>Interactuar con el código:</b> <br>Una vez que el código se haya ejecutado correctamente, podrás interactuar con él según lo diseñado 
                            por el autor. Esto puede incluir entrada de usuario, visualización de resultados, etc.</li><br>
                        <li><b>Cerrar la ventana de Replit:</b> <br>Una vez que hayas terminado de interactuar con el código, puedes cerrar la ventana de 
                            Replit si lo deseas. Tu copia del código seguirá estando disponible en tu cuenta de Replit para futuras referencias o modificaciones.</li>
                    </ol>
                </div>
            </div>

            <center>
                <section id="proyectos">
                    <h2>Códigos</h2>
                    <div class="proyecto" id="paginas-web">
                        <%
                            // Usuario conectado
                            String username = (String) session.getAttribute("username");

                            Class.forName("com.mysql.cj.jdbc.Driver");  // Nuevo controlador
                            Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
                            Statement s = conexion.createStatement();

                            // Array para almacenar los proyectos con sus comentarios
                            ArrayList<Codigo> codigos = new ArrayList<Codigo>();

                            // Ejecutar la consulta para obtener los datos de proyectos y comentarios
                            ResultSet listado = s.executeQuery(
                                    "SELECT cod.url, cod.nombreCodigo, cod.img, c.id, c.username, c.comentario, c.fecha "
                                    + "FROM codigos cod "
                                    + "LEFT JOIN comentarios c ON cod.url = c.url"
                            );

                            while (listado.next()) {
                                String url = listado.getString("url");

                                // Buscar el proyecto correspondiente en la lista de proyectos
                                Codigo codigo = null;
                                for (Codigo cod : codigos) {
                                    if (cod.getUrl().equals(url)) {
                                        codigo = cod;
                                        break;
                                    }
                                }

                                // Si no se encontró el proyecto, crea uno nuevo
                                if (codigo == null) {
                                    String nombreCodigo = listado.getString("nombreCodigo");
                                    InputStream imagenStream = listado.getBinaryStream("img");
                                    codigo = new Codigo(nombreCodigo, url, imagenStream);
                                    codigos.add(codigo);
                                }

                                // Si hay un feedback, agrégalo al proyecto correspondiente
                                if (listado.getObject("id") != null) {
                                    int id = listado.getInt("id");
                                    String usernameCons = listado.getString("username");
                                    String comentario = listado.getString("comentario");
                                    LocalDateTime fecha = listado.getTimestamp("fecha").toLocalDateTime();

                                    Feedback feedback = new Feedback(id, usernameCons, url, comentario, fecha);
                                    codigo.getFeedbackPorCodigo().add(feedback);
                                }
                            }

                            // Recorre el array proyectos y va mostrando la información
                            for (Codigo cod : codigos) {
                                // Crea un div para cada proyecto
                                out.println("<div class='project-container' style='width: 80%'>");

                                // Enlaces en el título del proyecto. Usa target blank para abrirse en una nueva pestaña
                                out.println("<a href='" + cod.getUrl() + "' class='link' target='_blank'>Pincha aquí o en la imágen para ver completo el proyecto " + cod.getNombre() + "</a>");
                                out.println("<br><br>");

                                // Crea un div contenedor para el iframe y la imagen
                                out.println("<div class='iframe-img-container'>");
                                out.println("<div class='iframe-container'>");
                                out.println("<iframe style='border: 1px solid white; border-radius: 10px; height: 400px; width: 90%;' src='" + cod.getUrl() + "?embed=true' scrolling='no' frameborder='no' allowtransparency='true' allowfullscreen='true' sandbox='allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals'></iframe>");
                                out.println("</div>");

                                out.println("<div class='img-container'>");
                                // Obtener la imagen de la base de datos como InputStream
                                InputStream imagenStream = cod.getImg();
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
                                //out.println("<br>");
                                out.println("<a href='" + cod.getUrl() + "' target='_blank'>");
                                out.println("<img style='border: 1px solid white; border-radius: 10px; width: 90%; max-height: 400px;  min-height: 250px;' src=\"data:image/jpeg;base64," + base64Image + "\" height='auto' width='27%' alt=\"Imagen del socio\" class=\"imgCodigo\">");
                                out.println("</a>");
                                out.println("</div>");

                                // Cerrar el InputStream y el ByteArrayOutputStream
                                imagenStream.close();
                                byteArrayOutputStream.close();

                                out.println("</div>");  // Cerrar el div del iframe e img

                                out.println("<br>");

                                if (username != null) {

                                    // Obtiene la lista de comentarios del proyecto
                                    ArrayList<Feedback> comentarios = cod.getFeedbackPorCodigo();


                        %>
                        <div class="divComentarios">
                            <form action="../procesar_comentarios.jsp" method="POST" id="feedback">
                                <input type="hidden" name="proyecto_id" value="<%= cod.getUrl()%>">
                                <input type="hidden" name="proyecto_url" value="<%= cod.getUrl()%>">
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
