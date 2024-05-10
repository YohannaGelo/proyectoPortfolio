<%-- 
    Document   : alerts
    Created on : 10-may-2024, 20:51:57
    Author     : Yohanna Gelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>
        <%

            // Verificar si hay un mensaje de alerta en la sesión
            String alertMessage = (String) session.getAttribute("alertMessage");
            String alertType = (String) session.getAttribute("alertType"); // tipo de alerta: "success" o "error"

            if (alertMessage != null && alertType != null) {
                String alertClass = "";

                // Configurar la clase CSS según el tipo de alerta
                if (alertType.equals("success")) {
                    alertClass = "alert-success";
                } else if (alertType.equals("error")) {
                    alertClass = "alert-danger";
                }

        %>
        <!-- Mostrar la alerta -->
        <div class="alert <%= alertClass%> alert-dismissible fade show" role="alert">
            <strong><%= alertType.equals("success") ? "¡Éxito!" : "¡Error!"%></strong> <%= alertMessage%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
        </div>
        <%

                // Eliminar el mensaje y el tipo de alerta de la sesión
                session.removeAttribute("alertMessage");
                session.removeAttribute("alertType");
            }


        %>



    </body>
</html>
