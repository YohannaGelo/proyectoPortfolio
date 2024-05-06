<%-- 
    Document   : index
    Created on : 25-abr-2024, 10:14:37
    Author     : Yohanna Gelo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="clases.ProyectoWeb"%>
<%@page import="clases.Portfolio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yohanna Gelo</title>
        <!-- Link para uso de bootstrap, pongo mi css debajo para que tome los colores de mi hoja de estilos -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="cssGelo/cssGelo_Bootstrap.css">
        <link rel="icon" href="img/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Bad+Script&display=swap">

    </head>
    <body>
        <!-- Personalizar los alerts de la página. Muestra el mensaje de alerta si existe -->
        <%
            String alertMessage = (String) session.getAttribute("alertMessage");
            if (alertMessage != null) {
        %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <strong>¡Éxito!</strong> <%= alertMessage%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
        </div>
        <%
                // Eliminar el mensaje de alerta de la sesión
                session.removeAttribute("alertMessage");
            }
        %>

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
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="">Diseños Gráficos</a></li>
                <li><a href="pages/proyectosWeb.jsp">Proyectos Web</a></li>
                <li><a href="">Documentos</a></li>
                <li><a href="">Códigos</a></li>
                <li><a href="">Contacto</a></li>
                <li class="userLogin">
                    <%
                        if (username != null) {
                            // Si el usuario ha iniciado sesión, muestra su nombre
                            out.print("¡Bienvenid@, " + username + "!");
                            out.print("<a href='logout.jsp' id='close'><img src='img/cerrarSesion.png' alt='Cerrar sesión' id='iconCerrar' /></a>");
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
                <br><br><br> <!-- Solo para page con bootstrap  -->
                <form id="login-form" action="procesar_login.jsp" method="post">
                    <label for="username">Nombre de usuario:</label>
                    <input type="text" id="username" name="username">

                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" name="password">

                    <!-- Enlace a formulario de registro -->
                    <a id="reg" href="registro.jsp">¿Aún no tienes cuenta? Regístrate aquí.</a><br><br>

                    <button type="submit">Iniciar sesión</button>
                </form>
            </div>
        </div>

        <!-- CONTENIDO DE LA PÁGINA -->

        <%



        %>

        <!-- Sección de previsualizador -->
        <section id="previsualizador">
            <h2>Previsualizador de Proyectos</h2>
            <div id="project-preview">
                <!-- proyectos de forma aleatoria -->
            </div>
        </section>

        <!-- Sección de proyectos -->
        <section id="proyectos">
            <h2>Mis Proyectos</h2>
            <div class="proyecto" id="diseno-grafico">
                <h3>Diseños Gráficos</h3>
                <div class="project-container">
                    <!-- diseños gráficos -->
                </div>
            </div>

            <div class="proyecto" id="documentos-trabajos">
                <h3>Documentos/Trabajos</h3>
                <div class="project-container">
                    <!-- documentos y trabajos -->
                </div>
            </div>
            <div class="proyecto" id="codigo">
                <h3>Código</h3>
                <div class="project-container">
                    <!-- código -->
                    <iframe height="400px" width="100%" src="https://replit.com/@yohannagelo/Sorteo?embed=true" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals">
                    </iframe>

                    <br>
                    <!--<div data-pym-src="https://www.jdoodle.com/embed/v1/8de489f0facd05ba"></div>-->
                    <script src="https://www.jdoodle.com/assets/jdoodle-pym.min.js" type="text/javascript"></script>

                </div>
            </div>
        </section>

        <!-- Script para uso de bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <!-- Enlace al archivo que contiene el código de javascript -->
        <script src="jsGelo/js_index.js"></script>
    </body>
</html>
