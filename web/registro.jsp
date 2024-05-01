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
    <link rel="stylesheet" type="text/css" href="css/css_index.css">
    <link rel="icon" href="img/favicon.png" type="image/x-icon">
</head>
<body>
    <h1>Registro de Usuario</h1>
    <form action="procesar_registro.jsp" method="POST">
        <label for="username">Nombre de usuario:</label>
        <input type="text" id="username" name="username" minlength="3" 
               title="El nombre de usuario debe ser único y tener al menos 3 carácteres." required>

        <label for="password">Contraseña:</label>
        <!-- Esta linea permite dar los siguientes requisitos a la contraseña, además de hacerlo obligatorio:
                - Longitud mínima de 8 caracteres
                - Al menos 1 letra mayúscula
                - Al menos 1 letra minúscula
                - Al menos 1 número 
                - Al menos 1 carácter especial -->
        <input type="password" id="password" name="password" minlength="8" 
               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{8,}" 
               title="La contraseña debe tener al menos 8 caracteres, incluyendo una letra mayúscula, 
               una letra minúscula, un número y un carácter especial." aria-label="Contraseña segura" 
            required>


        <label for="email">Correo electrónico:</label>
        <input type="email" id="email" name="email" required>

        <button type="submit">Registrar</button>
    </form>
    </body>
</html>
