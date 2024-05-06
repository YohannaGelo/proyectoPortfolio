<%-- 
    Document   : codigo
    Created on : 06-may-2024, 19:09:46
    Author     : Yohanna Gelo
--%>

<%@page import="clases.Codigo"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.Portfolio"%>
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
            <h2>Códigos</h2>
            <div class="proyecto" id="paginas-web">
                <%
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
                        out.println("<div class='project-container'>");

                        

                        // Enlaces en el título del proyecto. Usa target blank para abrirse en una nueva pestaña
                        out.println("<a href='" + cod.getUrl() + "' class='link' target='_blank'>Pincha aquí o en la imágen para ver completo el proyecto " + cod.getNombreCodigo() + "</a>");
                        out.println("<br><br>");
                        // Crea un div contenedor para el iframe y la imagen
                        out.println("<div class='iframe-img-container'>");
                        
                        out.println("<iframe style='border: 1px solid white; border-radius: 10px;' height='550px' width='60%' src='" + cod.getUrl() + "?embed=true' scrolling='no' frameborder='no' allowtransparency='true' allowfullscreen='true' sandbox='allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals'></iframe>");

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
                        out.println("<img style='border: 1px solid white; border-radius: 10px;' src=\"data:image/jpeg;base64," + base64Image + "\" height='auto' width='27%' alt=\"Imagen del socio\" class=\"imgCodigo\">");
                        out.println("</a>");

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
    <!-- Enlace al archivo que contiene el código de javascript -->
    <script src="../js/js_index.js"></script>
</body>
</html>
