/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

document.getElementById('login-form').addEventListener('submit', function (e) {
    e.preventDefault();
    alert('¡Inicio de sesión exitoso!');
});

// Ejemplo de evento al pasar el ratón por áreas
const projectContainers = document.querySelectorAll('.project-container');
projectContainers.forEach(container => {
    container.addEventListener('mouseenter', () => {
        container.style.backgroundColor = '#f0f0f0';
    });
    container.addEventListener('mouseleave', () => {
        container.style.backgroundColor = 'transparent';
    });
});

// Listener para mostrar y cerrar el login
document.addEventListener('DOMContentLoaded', function() {
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


function initializeLoginModal() {
    // Toma los elementos necesarios por su id o selector
    const loginModal = document.getElementById('login-modal');
    const loginLink = document.getElementById('log');
    const closeBtn = document.querySelector('.close-btn');

    // Muestra el modal al hacer clic en el enlace de inicio de sesión
    if (loginLink) {
        loginLink.addEventListener('click', function(event) {
            event.preventDefault();
            loginModal.style.display = 'block';
        });
    }

    // Cierra el login al hacer clic en el botón de cerrar
    if (closeBtn) {
        closeBtn.addEventListener('click', function() {
            loginModal.style.display = 'none';
        });
    }

    // Cierra el login al hacer clic fuera de la ventana
    window.addEventListener('click', function(event) {
        const modalContent = document.querySelector('.modal-content');
        if (event.target === loginModal && !modalContent.contains(event.target)) {
            loginModal.style.display = 'none';
        }
    });
}


// 
//document.addEventListener('DOMContentLoaded', function () {
//    // Obtiene los elementos
//    const loginModal = document.getElementById('login-modal');
//    const loginLink = document.getElementById('login-link');
//    const closeBtn = document.querySelector('.close-btn');
//
//    // Para saber si se ha visitado la página antes
//    const hasVisited = sessionStorage.getItem('hasVisited');
//    
//    // Si no se ha visitado
//    if (!hasVisited) {
//        loginModal.style.display = 'block';
//        // Marca que el usuario ha visitado la página
//        sessionStorage.setItem('hasVisited', 'true');
//    }
//
//    // Si loginLink y closeBtn existen, agregas los eventos
//    if (loginLink) {
//        // Muestra el login al pulsar en Login
//        loginLink.addEventListener('click', (event) => {
//            event.preventDefault();
//            loginModal.style.display = 'block';
//        });
//    }
//
//    if (closeBtn) {
//        // Cierra el login al pinchar en boton x
//        closeBtn.addEventListener('click', () => {
//            loginModal.style.display = 'none';
//        });
//    }
//
//    // También se cierra el login si pinchamos fuera de la ventana
//    window.addEventListener('click', (event) => {
//        const modalContent = document.querySelector('.modal-content');
//        if (event.target === loginModal && !modalContent.contains(event.target)) {
//            loginModal.style.display = 'none';
//        }
//    });
//
//
//    // Muestra el login al cargar la pagina
//    loginModal.style.display = 'block';
//});

