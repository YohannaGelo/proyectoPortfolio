<%-- 
    Document   : index
    Created on : 25-abr-2024, 10:14:37
    Author     : Yohanna Gelo
--%>

<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.HashMap"%>
<%@page import="clases.Proyecto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.ProyectoWeb"%>
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
        <div class="container-fluid">

            <!-- Código para usos de alerts personalizados -->
            <jsp:include page="codigoReutilizableJSP/alerts.jsp" />

            <!-- Título principal de la página -->
            <h1>Yohanna Gelo</h1>

            <!-- Menú de navegación responsivo (llamada a otro jsp donde está el código guardado -->
            <jsp:include page="codigoReutilizableJSP/menu.jsp" />

            <!-- Ventana emergente para el Login -->
            <jsp:include page="codigoReutilizableJSP/login.jsp" />


            <!-- CONTENIDO DE LA PÁGINA -->
            <!-- Sección de previsualizador -->
            <section id="previsualizador">
                <h2>Un vistazo a mis creaciones</h2>
                <div id="project-preview" >

                    <!-- proyectos de forma aleatoria -->
                    <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <!-- Código para usos de alerts personalizados -->
                                <jsp:include page="codigoReutilizableJSP/proyectoRandom.jsp" />   
                            </div>
                            <div class="carousel-item">
                                <!-- Código para usos de alerts personalizados -->
                                <jsp:include page="codigoReutilizableJSP/proyectoRandom.jsp" />
                            </div>
                            <div class="carousel-item">
                                <!-- Código para usos de alerts personalizados -->
                                <jsp:include page="codigoReutilizableJSP/proyectoRandom.jsp" />
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>

                </div>
            </section>

        </div>

        <!-- Botón para ir arriba -->
        <button class="btn-go-top" onclick="goToTop()"><img src="img/arriba.png" alt="Volver arriba de la página" id="btnUp" /></button>

        <!-- Script para uso de bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <!-- Enlace al archivo que contiene el código de javascript -->
        <script src="jsGelo/js_index.js"></script>
    </body>
</html>
