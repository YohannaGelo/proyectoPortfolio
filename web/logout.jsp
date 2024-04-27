<%-- 
    Document   : logout
    Created on : 27-abr-2024, 10:02:27
    Author     : Yohanna Gelo
--%>

<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.IOException" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LogOut</title>
    </head>
    <body>

        <%
            // Obtener la sesión actual
            session = request.getSession(false);

            if (session != null) {
                // Definir en null
                session.invalidate();
            }

            // Vuelve a la página de inicio
            response.sendRedirect("index.jsp");
        %>
    </body>
</html>
