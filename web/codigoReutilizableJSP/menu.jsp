<%-- 
    Document   : menu.jsp
    Created on : 10-may-2024, 19:15:35
    Author     : Yohanna Gelo
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yohanna Gelo</title>

    </head>
    <body>
        <%
            // Obtener la sesión HTTP
            session = request.getSession();

            // Verificar si un usuario ha iniciado sesión
            String username = (String) session.getAttribute("username");
            

            // Las rutas las pongo así, para que esté donde esté podamos volver a la raiz y seguir la ruta absoluta
        %>
        <nav class="navbar navbar-expand-lg navbar-light ">
            <div class="container-fluid">

                <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav justify-content-center">
                        <li class="nav-item">
                            <a class="nav-link" href="../../../PORTFOLIO/index.jsp">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../../../PORTFOLIO/pages/">Diseños Gráficos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../../../PORTFOLIO/pages/proyectosWeb.jsp">Proyectos Web</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../../../PORTFOLIO/pages/">Documentos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../../../PORTFOLIO/pages/codigo.jsp">Códigos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../../../PORTFOLIO/pages/contacto.jsp">Contacto</a>
                        </li>
                        <li class="nav-item userLogin">
                            <%
                                if (username != null) {
                                    // Si el usuario ha iniciado sesión, muestra su nombre
                                    out.print("<div class='sesion'><a href='' id='cuentaUsuario'><img src='../../../PORTFOLIO/img/usuario.png' alt='USuario conectado' id='iconUsuario' /><font id='usernameMenu'> " + username + "</font></a>");
                                    out.print("<a href='../../../PORTFOLIO/logout.jsp' id='close'><img src='../../../PORTFOLIO/img/cerrarSesion.png' alt='Cerrar sesión' id='iconCerrar' /></a>");
                                } else {
                                    // Si el usuario no ha iniciado sesión, muestra el enlace de "Login"
                                    out.print("<a class='nav-link' href='' id='log'>Login</a></div>");
                                }
                            %>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        


    </body>
</html>
