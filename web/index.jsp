<%-- 
    Document   : index
    Created on : 25-abr-2024, 10:14:37
    Author     : Yohanna Gelo
--%>

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
        <link rel="stylesheet" type="text/css" href="css/css_index.css">
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
            <div class="proyecto" id="paginas-web">
                <h3>Páginas Web</h3>
                <div class="project-container">
                    <!-- páginas web -->
                    <iframe src="https://yohannagelo.github.io/ProyBancoLM/?embed=true" style="width: 100%; height: 56.25vw;"></iframe>

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
                    <!--<iframe height="400px" width="100%" src="https://replit.com/@yohannagelo/Sorteo?embed=true" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals">
                    </iframe>-->
                    
                    <br>
                    <div data-pym-src="https://www.jdoodle.com/embed/v1/8de489f0facd05ba"></div>
                    <script src="https://www.jdoodle.com/assets/jdoodle-pym.min.js" type="text/javascript"> </script>

                </div>
            </div>
        </section>



        <!-- Enlace al archivo que contiene el código de javascript -->
        <script src="js/js_index.js"></script>
    </body>
</html>
