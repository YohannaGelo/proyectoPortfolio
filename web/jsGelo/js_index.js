/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

// Ejemplo de evento al pasar el ratón por áreas
const cajaProyectos = document.querySelectorAll('.project-container');
cajaProyectos.forEach(container => {

    // Selecciona el enlace dentro del contenedor
    const link = container.querySelector('.link');

    container.addEventListener('mouseenter', () => {
        container.style.backgroundColor = '#f0f0f0';
        container.style.color = '#2a2a2a';
        link.style.textShadow = '2px 2px 4px rgba(0, 0, 0, 0.5)';
        link.style.webkitTextStroke = '1px black';
        link.style.webkitTextFillColor = 'white';
        link.style.width = "50%";
    });
    container.addEventListener('mouseleave', () => {
        container.style.backgroundColor = '#2a2a2a';
        container.style.color = '#f0f0f0';
        link.style.textShadow = '';
        link.style.webkitTextStroke = '';
        link.style.webkitTextFillColor = '';
        link.style.width = "50%";
    });
});


// Función para iniciar el modal
function initializeLoginModal() {
    // Toma los elementos necesarios por su id o selector
    const loginModal = document.getElementById('login-modal');
    const loginLink = document.getElementById('log');
    const closeBtn = document.querySelector('.close-btn');

    // Muestra el modal al hacer clic en el enlace de inicio de sesión
    if (loginLink) {
        loginLink.addEventListener('click', function (event) {
            event.preventDefault();
            loginModal.style.display = 'block';
        });
    }

    // Cierra el login al hacer clic en el botón de cerrar
    if (closeBtn) {
        closeBtn.addEventListener('click', function () {
            loginModal.style.display = 'none';
        });
    }

    // Cierra el login al hacer clic fuera de la ventana
    window.addEventListener('click', function (event) {
        const modalContent = document.querySelector('.modal-content');
        if (event.target === loginModal && !modalContent.contains(event.target)) {
            loginModal.style.display = 'none';
        }
    });
}

// Función para cerrar el modal
function closeModal() {
    $('#myModal').modal('hide'); // Cierra el modal usando Bootstrap
}


// Listener para mostrar y cerrar el login
document.addEventListener('DOMContentLoaded', function () {
    // Inicializa el modal de inicio de sesión
    initializeLoginModal();

    // Verifica si el usuario ha visitado la página antes
    const hasVisited = sessionStorage.getItem('hasVisited');
    const loginModal = document.getElementById('login-modal');

    // Si el usuario no ha visitado antes, muestra el login
    if (!hasVisited) {
        loginModal.style.display = 'block';
        // Marca que el usuario ha visitado la página
        sessionStorage.setItem('hasVisited', 'true');
    }
});


// Función para desplazarse suavemente hacia arriba
function goToTop() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
}


async function votarFavorito(url, counter) {
    try {
        const response = await fetch(`../procesarLike.jsp?url=${url}`);
        const votoRegistrado = await response.text();
        console.log('Longitud de votoRegistrado:', votoRegistrado.length);
        console.log('Respuesta desde Java:', votoRegistrado + counter);

        if (votoRegistrado.trim() === 'true') {
            darLike(counter);
            //console.log(votoRegistrado + counter);
        } else {
            
            quitarLike(counter);
            //console.log(votoRegistrado + counter);

        }

        // Aquí puedes realizar las acciones necesarias en tu página JSP basadas en la respuesta recibida.
    } catch (error) {
        console.error('Error al llamar al método Java:', error);
    }
}


//Función para cambiar el aspecto del botón Favorito
function darLike(counter) {

    console.log("Estoy en LIKE" + counter);
    // Selecciona el enlace dentro del contenedor
    const divId = 'fondoBtnFavorito' + counter;
    const div = document.getElementById(divId);
    console.log(div);
    // Cambia la opacidad del div y la imagen del botón
    if (div) {
        div.style.opacity = '100%';
        const imgID = 'imgFavorito' + counter;
        console.log(imgID);
        const img = document.getElementById(imgID);
        if (img) {
            img.src = '../img/likeOn.png';
        }
    }

}

function quitarLike(counter) {
    console.log("Estoy en dislike" + counter);
    // Selecciona el enlace dentro del contenedor
    const divId = 'fondoBtnFavorito' + counter;
    const div = document.getElementById(divId);
    // Cambia la opacidad del div y la imagen del botón
    if (div) {
        div.style.opacity = '40%';
        const imgID = 'imgFavorito' + counter;
        const img = document.getElementById(imgID);
        if (img) {
            img.src = '../img/likeOff.png';
        }
    }
}

// Procesar el envio de correo a través de php, de forma asíncrona
function enviarCorreo(e) {
    e.preventDefault(); // Evita que el formulario se envíe de la manera tradicional

    // Mostrar mensaje de "enviando..."
    document.getElementById('estadoEnvio').innerHTML = "<div class='spinner-border' role='status'><span class='visually-hidden'>Loading...</span></div>Enviando...";

    // Aquí recogemos los valores del formulario
    var nombre = document.getElementById('nombre').value;
    var correo = document.getElementById('correo').value;
    var mensaje = document.getElementById('mensaje').value;

    // Configuramos la solicitud AJAX
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            //if (this.status === 200) {
            // Mostrar el mensaje de respuesta del servidor
            //document.getElementById('estadoEnvio').innerHTML = this.responseText;
            document.getElementById('estadoEnvio').innerHTML = 'Mensaje enviado.';
            vaciarCampos();
            //} else {
            //document.getElementById('estadoEnvio').innerHTML = 'Error al enviar el mensaje.';
            //}
        }
    };

    // Aquí abrimos la solicitud con el método POST y la URL a la que queremos enviar los datos
    xhttp.open("POST", "http://localhost/enviar_correo.php", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("nombre=" + encodeURIComponent(nombre) + "&correo=" + encodeURIComponent(correo) + "&mensaje=" + encodeURIComponent(mensaje));



}

// Listener para vaciar los campos del correo 
function vaciarCampos() {
    document.getElementById('correo').value = '';
    document.getElementById('mensaje').value = '';
}