/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.Favorito;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Yohanna Gelo
 */
public class AgregarFavoritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener los parámetros de la solicitud
        String proyecto_url = request.getParameter("proyecto_url");
        String username = (String) request.getSession().getAttribute("username");

        // Crear un nuevo objeto Favorito y llamar al método agregarFavorito
        Favorito nuevoFavorito = new Favorito(proyecto_url, username);
        boolean votoRegistrado = nuevoFavorito.agregarFavorito();
        System.out.println(votoRegistrado);
        // Enviar la respuesta de vuelta al cliente (JavaScript)
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.println(votoRegistrado); // Enviar el resultado de agregarFavorito al cliente
        
    }

}
