
function openModal(type) {
    document.getElementById(type + 'Modal').classList.add('active');
}

function closeModal(type) {
    document.getElementById(type + 'Modal').classList.remove('active');
}

function openModalModifier(id, date, heure) {
    document.getElementById('modifierConsultationId').value = id;
    document.getElementById('modifierDate').value = date;
    document.getElementById('modifierHeure').value = heure;
    openModal('modifier');
}

function openModalAnnuler(id) {
    document.getElementById('annulerConsultationId').value = id;
    openModal('annuler');
}

// Fermer en cliquant à l'extérieur
window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        event.target.classList.remove('active');
    }
}

// Fermer avec la touche Escape
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        const modals = document.querySelectorAll('.modal.active');
        modals.forEach(modal => modal.classList.remove('active'));
    }
});