<%-- 
    Document   : contacto.jsp
    Created on : 14-may-2024, 12:42:25
    Author     : Yohanna Gelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yohanna Gelo</title>
        <!-- Link para uso de bootstrap, pongo mi css debajo para que tome los colores de mi hoja de estilos -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="../cssGelo/cssGelo_Bootstrap.css">

        <link rel="icon" href="img/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Bad+Script&display=swap">

    </head>
    <body>
        <div class="container-fluid">

            <!-- Código para usos de alerts personalizados -->
            <jsp:include page="../codigoReutilizableJSP/alerts.jsp" />

            <!-- Título principal de la página -->
            <h1>Yohanna Gelo</h1>

            <!-- Menú de navegación responsivo (llamada a otro jsp donde está el código guardado -->
            <jsp:include page="../codigoReutilizableJSP/menu.jsp" />

            <!-- Ventana emergente para el Login -->
            <jsp:include page="../codigoReutilizableJSP/login.jsp" />

            <center>
                <h2>Información de Contacto</h2>
                <div class='project-container' style='width: 80%'>
                    <div class="container">
                        <br>
                        <p>Si deseas ponerte en contacto conmigo, aquí encontrarás mi información de contacto:</p>
                        <br>
                        <!-- Información personal -->
                        <p><strong>Nombre:</strong> Yohanna Mª Gelo Coline</p>
                        <p><strong>Correo electrónico:</strong> yohannagelo@gmail.com</p>

                        <br><br>
                        <!-- Enlace a tu currículum en LinkedIn -->
                        <p><strong>Mi curriculum en Linkedin:</strong></p>
                        <div class="badge-base LI-profile-badge" data-locale="es_ES" data-size="large" data-theme="dark" data-type="HORIZONTAL" data-vanity="yohannagelo" data-version="v1"><a class="badge-base__link LI-simple-link" href="https://es.linkedin.com/in/yohannagelo?trk=profile-badge"></a></div>


                        <br><br>
                        <%
                            // Obtener la sesión HTTP
                            session = request.getSession();

                            // Verificar si un usuario ha iniciado sesión
                            String username = (String) session.getAttribute("username");

                            if (username != null) {
                        %>
                        <!-- Escribir un mail directo -->
                        <p>¿Quieres escribirme desde aquí?</p>
                        <form id="interactuar" onsubmit="enviarCorreo(event)">
                            <!-- Campo oculto para pasar el nombre de usuario -->
                            <input type="hidden" id="nombre" name="nombre" value="<%= username%>">
                            <div class="mb-3">
                                <label for="correo" class="form-label">Tu email:</label>
                                <input type="email" class="form-control" id="correo" name="correo" placeholder="name@example.com" required>
                            </div>
                            <div class="mb-3">
                                <label for="mensaje" class="form-label">Escribe tu mensaje:</label>
                                <textarea class="form-control" id="mensaje" name="mensaje" rows="5" required></textarea>
                            </div>

                            <input type="submit" value="Enviar">
                        </form>
                        <br><p id="estadoEnvio"></p>

                        <br><br>
                        <!-- Enlace de WhatsApp -->
                        <p>¿Prefieres enviar un mensaje por WhatsApp?</p>
                        <p><a href="https://wa.me/655494824" target="_blank">
                                <img class="redesSociales" src="../img/whatsapp.png" alt="Acceso a Whatsapp"/></a></p>

                        <%
                            }
                        %>

                        <br><br>
                        <!-- Enlaces a redes sociales -->
                        <p><strong>Redes Sociales:</strong></p>
                        <div class="row" id="containerRedes">
                            <div class="col">
                                <a href="https://www.linkedin.com/in/yohannagelo" target="_blank" rel="noopener noreferrer">
                                    <img class="redesSociales img-fluid" src="../img/linkedin.png" alt="Acceso a Linkedin"/>
                                </a>
                            </div>
                            <div class="col">
                                <a href="https://www.linkedin.com/in/yohannagelo" target="_blank" rel="noopener noreferrer">
                                    <img class="redesSociales img-fluid" src="../img/instagram.png" alt="Acceso a Instagram"/>
                                </a>
                            </div>
                            <div class="col">
                                <a href="https://www.instagram.com/yohannagelo/" target="_blank" rel="noopener noreferrer">
                                    <img class="redesSociales img-fluid" src="../img/facebook.png" alt="Acceso a Facebook"/>
                                </a>
                            </div>
                        </div>

                        <br><br>
                        <p>¡Gracias por visitar mi página web!</p>
                        <br>

                    </div>

                </div>

            </center>

        </div> 

        <!-- Botón para ir arriba -->
        <button class="btn-go-top" onclick="goToTop()"><img src="../img/arriba.png" alt="Volver arriba de la página" id="btnUp" /></button>

        <!-- Script para enlazar mi Linkedin-->
        <script src="https://platform.linkedin.com/badges/js/profile.js" async defer type="text/javascript"></script>

        <!-- Script para uso de bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <!-- Enlace al archivo que contiene el código de javascript -->
        <script src="../jsGelo/js_index.js"></script>

    </body>
</html>
