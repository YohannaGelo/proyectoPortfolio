<?php

// ESTE ARCHIVO DEBE COPIARSE EN http://localhost/enviar_correo.php PARA PODER PROCESAR EL ENVÍO
// y tener configurado php para ello

error_reporting(E_ALL);
ini_set('display_errors', 1);
$metodo_peticion = filter_input(INPUT_SERVER, 'REQUEST_METHOD', FILTER_SANITIZE_STRING);
if ($metodo_peticion === "POST") {

    $nombre = filter_input(INPUT_POST, 'nombre', FILTER_SANITIZE_STRING);
    $correo = filter_input(INPUT_POST, 'correo', FILTER_SANITIZE_EMAIL);
    $mensaje = filter_input(INPUT_POST, 'mensaje', FILTER_SANITIZE_STRING);

    $destinatario = "yohannagelo@gmail.com";
    $asunto = "Nuevo mensaje de contacto desde tu Portfolio";
    $cuerpo = "Nombre: $nombre\nCorreo: $correo\nMensaje: $mensaje";

    // Iniciar sesión si aún no está iniciada
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }


// Enviar el correo y establecer el mensaje de sesión correspondiente
    if (mail($destinatario, $asunto, $cuerpo)) {
        http_response_code(200); // Envía un código de estado HTTP 200
        echo "El mensaje ha sido enviado correctamente.";
    } else {
        http_response_code(500); // Envía un código de estado HTTP 500
        echo "Ha ocurrido un error al enviar el mensaje.";
    }
}
?>