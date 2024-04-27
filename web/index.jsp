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
        <link rel="stylesheet" type="text/css" href="css/cssIndex.css">
        <link rel="icon" href="img/favicon.png" type="image/x-icon">
    </head>
    <body>
        
    <!-- Título principal de la página -->
    <h1>Portfolio</h1>
    
    <!-- Menú de navegación -->
    <nav>
        <ul>
            <li><a href="">Diseños Gráficos</a></li>
            <li><a href="">Páginas Web</a></li>
            <li><a href="">Documentos</a></li>
            <li><a href="">Códigos</a></li>
            <li><a href="">Contacto</a></li>
            <li><a id="log" href="">Login</a></li>
        </ul>
    </nav>

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
            </div>
        </div>
    </section>

    <!-- Ventana emergente para el login -->
    <div id="login-modal" class="modal">
        <div class="modal-content">
            <span class="close-btn">&times;</span>
            <h2>Login</h2>
            <form id="login-form">
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

    <!-- Enlace al archivo que contiene el código de javascript -->
    <script src="js/index.js"></script>
    </body>
</html>
