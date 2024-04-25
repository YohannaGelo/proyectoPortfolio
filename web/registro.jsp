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
    <link rel="stylesheet" type="text/css" href="css/cssIndex.css">
    <link rel="icon" href="img/favicon.png" type="image/x-icon">
</head>
<body>
    <h1>Registro de Usuario</h1>
    <form action="procesar_registro.jsp" method="POST">
        <label for="username">Nombre de usuario:</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Contraseña:</label>
        <input type="password" id="password" name="password" required>

        <label for="email">Correo electrónico:</label>
        <input type="email" id="email" name="email" required>

        <button type="submit">Registrar</button>
    </form>
    </body>
</html>
