<%-- 
    Document   : proyectoRandom
    Created on : 11-may-2024, 10:43:02
    Author     : yohan
--%>



<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.HashMap"%>
<%@page import="clases.Proyecto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.ProyectoWeb"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link rel="stylesheet" type="text/css" href="../cssGelo/cssGelo_Bootstrap.css">
    </head>
    <body>
        <%
            HashMap<Proyecto, Integer> proyectos = new HashMap<Proyecto, Integer>();
            proyectos = Proyecto.proyectosY_comentarios(proyectos);
            Proyecto proyectoRandom = Proyecto.proyectoAleatorio(proyectos);

            String nombreProyecto = proyectoRandom.getNombre();
            
            // Obtener la imagen de la base de datos como InputStream
            InputStream imagenStream = proyectoRandom.getImg();
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
            out.println("<a href='" + proyectoRandom.getUrl() + "' target='_blank'>");
            out.println("<img src=\"data:image/jpeg;base64," + base64Image + "\" alt=\"Imagen del proyecto\" class=\"d-block mx-auto max-width-65\" style='max-height: 400px; border-radius: 5px'>");
            out.println("</a>");

            // Cerrar el InputStream y el ByteArrayOutputStream
            imagenStream.close();
            byteArrayOutputStream.close();

        %>
        <div class="carousel-caption d-none d-md-block" style="background-color: #2a2a2abb; height: 5em; width: 100%; margin-left: -15%">
            <h5 style="color: #f48fb1; font-weight: bold;"><%= nombreProyecto %></h5>
            <p>Pinche sobre la imagen para abrirlo en una pestaña nueva.</p>
        </div>
    </body>
</html>
