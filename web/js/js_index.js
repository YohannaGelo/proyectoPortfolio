
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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


// Función para iniciar el modal
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

// Función para cerrar el modal
function closeModal() {
    $('#myModal').modal('hide'); // Cierra el modal usando Bootstrap
}




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

