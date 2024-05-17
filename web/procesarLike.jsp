<%-- 
    Document   : procesarLike
    Created on : 16-may-2024, 9:45:04
    Author     : Yohanna Gelo
--%>

<%@page import="clases.Favorito"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Obtener los datos del formulario
    //int counter = Integer.parseInt(request.getParameter("counter"));
    String proyecto_url = request.getParameter("url");
    String username = (String) session.getAttribute("username");

    // Crea un nuevo objeto favorito
    Favorito nuevoFavorito = new Favorito(proyecto_url, username);

    // LLama al método para registar el voto
    boolean votoRegistrado = nuevoFavorito.comprobarLike(); // Método para verificar si el voto ya existe

 
    if (votoRegistrado) {
        out.print("false");
        nuevoFavorito.eliminarVoto(); // Método para eliminar el voto existente
    } else {
        out.print("true");
        nuevoFavorito.agregarFavorito(); // Método para agregar un nuevo voto
    }


%>

