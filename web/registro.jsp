<%-- 
    Document   : registro
    Created on : 25-abr-2024, 10:20:28
    Author     : Yohanna Gelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registro de Usuario</title>

        <!-- link para uso de bootstrap, pongo mi css debajo para que tome los colores de mi hoja de estilos -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="cssGelo/cssGelo_Bootstrap.css">
        <link rel="icon" href="img/favicon.png" type="image/x-icon">
    </head>
    <body>
        <div class="container-fluid">
            <!-- Código para usos de alerts personalizados -->
            <jsp:include page="codigoReutilizableJSP/alerts.jsp" />

            <!-- Título principal de la página -->
            <h1 class="miH1">Yohanna Gelo</h1>

            <%
                // Obtener la sesión HTTP
                session = request.getSession();

                // Verificar si un usuario ha iniciado sesión
                String username = (String) session.getAttribute("username");
            %>

            <!-- Menú de navegación responsivo (llamada a otro jsp donde está el código guardado -->
            <jsp:include page="codigoReutilizableJSP/menu.jsp" />

            <!-- Ventana emergente para el Login -->
            <jsp:include page="codigoReutilizableJSP/login.jsp" />

            <!-- CONTENIDO DE LA PÁGINA -->
            <div class="project-container" id="registroDiv">
                <div class="container mt-5">

                    <br><h2 class="text-center mb-4">Registro de Usuario</h2><br>
                    <form action="procesar_registro.jsp" method="POST" class="mx-auto" style="max-width: 500px;">
                        <div class="mb-3">
                            <label for="username" class="form-label">Nombre de usuario:</label>
                            <input type="text" id="username" name="username" class="form-control" minlength="3"
                                   title="El nombre de usuario debe ser único y tener al menos 3 caracteres." required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña:</label>
                            <!-- Esta linea permite dar los siguientes requisitos a la contraseña, además de hacerlo obligatorio:
                            - Longitud mínima de 8 caracteres
                            - Al menos 1 letra mayúscula
                            - Al menos 1 letra minúscula
                            - Al menos 1 número 
                            - Al menos 1 carácter especial -->
                            <input type="password" id="password" name="password" class="form-control" minlength="8" 
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{8,}" 
                                   title="La contraseña debe tener al menos 8 caracteres, incluyendo una letra mayúscula, 
                                   una letra minúscula, un número y un carácter especial." aria-label="Contraseña segura" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Correo electrónico:</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>
                        <br><button id="miButton" type="submit" class="btn btn-primary w-100">Registrar</button>
                    </form>
                </div>
            </div>

            <br><br><br>

        </div>
        <!-- Script para uso de bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <!-- Enlace al archivo que contiene el código de javascript -->
        <script src="jsGelo/js_index.js"></script>
    </body>
</html>
